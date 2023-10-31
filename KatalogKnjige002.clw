

   MEMBER('KatalogKnjige.clw')                             ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABLPROPR.INC'),ONCE
   INCLUDE('ABLWINR.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('ablwman.inc'),ONCE

                     MAP
                       INCLUDE('KATALOGKNJIGE002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('KATALOGKNJIGE001.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeZanrova PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::Zan:Record  LIKE(Zan:RECORD),THREAD
FormWindow           WINDOW('Update Records...'),AT(,,289,159),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('Cancel'),AT(50,140,40,12),USE(?Cancel),FONT('Segoe Print'),COLOR(0060A4F4h)
                       STRING(@S40),AT(95,140),USE(ActionMessage),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       PROMPT('ID zanra:'),AT(18,13),USE(?Zan:ID_zanra:Prompt),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       ENTRY(@s19),AT(70,14,74,10),USE(Zan:ID_zanra),REQ
                       PROMPT('Naziv zanra:'),AT(18,38),USE(?Zan:Naziv_zanra:Prompt),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       ENTRY(@s39),AT(70,38,150,10),USE(Zan:Naziv_zanra),REQ
                       BUTTON('OK'),AT(5,140,40,12),USE(?OK),FONT('Segoe Print'),COLOR(0060A4F4h),DEFAULT,REQ
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:Zan:ID_zanra:Prompt CLASS(WbControlHtmlProperties)     ! Web Control Manager for ?Zan:ID_zanra:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Zan:ID_zanra     CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Zan:ID_zanra
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Zan:Naziv_zanra:Prompt CLASS(WbControlHtmlProperties)  ! Web Control Manager for ?Zan:Naziv_zanra:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Zan:Naziv_zanra  CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Zan:Naziv_zanra
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:OK               CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?OK
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeZanrova')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Cancel
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Zan:Record,History::Zan:Record)
  SELF.AddHistoryField(?Zan:ID_zanra,1)
  SELF.AddHistoryField(?Zan:Naziv_zanra,2)
  SELF.AddUpdateFile(Access:Zanr)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Zanr.Open()                                       ! File Zanr used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Zanr
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeZanrova)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  INIMgr.Fetch('AzuriranjeZanrova',FormWindow)             ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Zanr.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeZanrova',FormWindow)          ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?OK
      IF Zan:ID_zanra = '' THEN
          MESSAGE('Niste odabrali ID zanra!')
          DISPLAY()
      END
      
      IF Zan:Naziv_zanra = '' THEN
          MESSAGE('Niste odabrali Naziv zanra!')
          DISPLAY()
      END
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:Zan:ID_zanra:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Zan:ID_zanra.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Zan:Naziv_zanra:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Zan:Naziv_zanra.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '40')


Web:OK.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('DoValidate', 'true')
  SELF.SetExtraProperty('btnStyle', 'default active')


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:Zan:ID_zanra:Prompt.Init(?Zan:ID_zanra:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Zan:ID_zanra:Prompt)
  Web:Zan:ID_zanra.Init(?Zan:ID_zanra, FEQ:Unknown)
  SELF.AddControl(Web:Zan:ID_zanra)
  Web:Zan:Naziv_zanra:Prompt.Init(?Zan:Naziv_zanra:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Zan:Naziv_zanra:Prompt)
  Web:Zan:Naziv_zanra.Init(?Zan:Naziv_zanra, FEQ:Unknown)
  SELF.AddControl(Web:Zan:Naziv_zanra)
  Web:OK.Init(?OK, FEQ:Unknown)
  SELF.AddControl(Web:OK)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE Web:CurFrame.TakeEvent()
  OF REPLY:NONE
     RETURN Level:Benign
  OF REPLY:CYCLE
     RETURN Level:Notify
  OF REPLY:BREAK
     RETURN Level:Fatal
  END
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeProdaje PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::Prd:Record  LIKE(Prd:RECORD),THREAD
FormWindow           WINDOW('Azuriranje Racuna'),AT(,,235,96),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('Cancel'),AT(44,76,40,12),USE(?Cancel),FONT('Segoe Print',10)
                       STRING(@S40),AT(88,78),USE(ActionMessage)
                       PROMPT('ID kupca:'),AT(22,8),USE(?Kup:ID_kupca:Prompt),FONT('Segoe Print',10)
                       ENTRY(@s19),AT(60,8,60,13),USE(Prd:ID_kupca),REQ
                       PROMPT('Datum prodaje:'),AT(4,50),USE(?Prd:Datum_prodaje:Prompt),FONT('Segoe Print',10)
                       ENTRY(@D6),AT(60,50,60,13),USE(Prd:Datum_prodaje),REQ
                       PROMPT('Broj racuna:'),AT(14,26),USE(?Prd:Broj_racuna:Prompt),FONT('Segoe Print',10)
                       ENTRY(@s19),AT(60,26,60,13),USE(Prd:Broj_racuna),REQ
                       BUTTON('OK'),AT(2,76,40,12),USE(?OK),FONT('Segoe Print',10),DEFAULT,REQ
                       OPTION('Nacin placanja:'),AT(126,6,105,54),USE(Prd:Nacin_placanja,,?Prd:Nacin_placanja:2), |
  FONT('Segoe Print',10),BOXED
                         RADIO('Kartica'),AT(130,18),USE(?Prd:Nacin_placanja:Radio1),FONT('Segoe Print',10),VALUE('Kartica')
                         RADIO('Gotovina'),AT(130,30),USE(?Prd:Nacin_placanja:Radio2),FONT('Segoe Print',10),VALUE('Gotovina')
                         RADIO('Kripto'),AT(189,32),USE(?Prd:Nacin_placanja:Radio3),FONT('Segoe Print',10),VALUE('Kripto')
                         RADIO('Cek'),AT(189,18),USE(?Prd:Nacin_placanja:Radio4),FONT('Segoe Print',10),VALUE('Cek')
                         RADIO('Ostalo'),AT(154,44),USE(?Prd:Nacin_placanja:Radio5),FONT('Segoe Print',10),VALUE('Ostalo')
                       END
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:Kup:ID_kupca:Prompt CLASS(WbControlHtmlProperties)     ! Web Control Manager for ?Kup:ID_kupca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Prd:ID_kupca     CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Prd:ID_kupca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Prd:Datum_prodaje:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Prd:Datum_prodaje:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Prd:Datum_prodaje CLASS(WbControlHtmlProperties)       ! Web Control Manager for ?Prd:Datum_prodaje
GetEmbedText           PROCEDURE(ASTRING embed),STRING,DERIVED
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Prd:Broj_racuna:Prompt CLASS(WbControlHtmlProperties)  ! Web Control Manager for ?Prd:Broj_racuna:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Prd:Broj_racuna  CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Prd:Broj_racuna
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:OK               CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?OK
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetEmbedText           PROCEDURE(ASTRING embed),STRING,DERIVED
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeProdaje')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Cancel
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Prd:Record,History::Prd:Record)
  SELF.AddHistoryField(?Prd:ID_kupca,2)
  SELF.AddHistoryField(?Prd:Datum_prodaje,3)
  SELF.AddHistoryField(?Prd:Broj_racuna,5)
  SELF.AddHistoryField(?Prd:Nacin_placanja:2,4)
  SELF.AddUpdateFile(Access:Prodaje)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:PI_POMOCNA.Open()                                 ! File PI_POMOCNA used by this procedure, so make sure it's RelationManager is open
  Relate:Prodaje.SetOpenRelated()
  Relate:Prodaje.Open()                                    ! File Prodaje used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Prodaje
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeProdaje)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AzuriranjeProdaje',FormWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PI_POMOCNA.Close()
    Relate:Prodaje.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeProdaje',FormWindow)          ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  Kup:ID_kupca = Prd:ID_kupca                              ! Assign linking field value
  Access:Kupac.Fetch(Kup:PK_Kupac_ID_kupca)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisKlijenata
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?Prd:ID_kupca
      Kup:ID_kupca = Prd:ID_kupca
      IF Access:Kupac.TryFetch(Kup:PK_Kupac_ID_kupca)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          Prd:ID_kupca = Kup:ID_kupca
        END
      END
      ThisWindow.Reset()
    OF ?OK
      IF Prd:Broj_racuna = '' THEN
          MESSAGE('Niste odabrali broj racuna!')
          DISPLAY()
      END
      
      IF Prd:Datum_prodaje = '' THEN
          MESSAGE('Niste odabrali datum prodaje!')
          DISPLAY()
      END
      
      IF Prd:ID_kupca = '' THEN
          MESSAGE('Niste odabrali ID kupca!')
          DISPLAY()
      END
      
      IF Prd:ID_prodavaca = '' THEN
          MESSAGE('Niste odabrali ID prodavaca!')
          DISPLAY()
      END
      
      IF Prd:Nacin_placanja = '' THEN
          MESSAGE('Niste odabrali nacin placanja!')
          DISPLAY()
      END
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:Kup:ID_kupca:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Prd:ID_kupca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Prd:Datum_prodaje:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Prd:Datum_prodaje.GetEmbedText PROCEDURE(ASTRING embed)

ReturnValue          ANY

Target                  &IHtmlWriter,AUTO
  CODE
  Target &= IHtmlWriter:Create()
  CASE embed
  OF A:EmbedAfterControl
    Target.Writeln('<<script>$(function () {{$("#PRD_DATUM_PRODAJE-lookup").datetimepicker({{')
    Target.Writeln('format: ''DD/MM/YYYY''')
    Target.Writeln('});});')
    Target.Writeln('<</script>')
  END
  ReturnValue = PARENT.GetEmbedText(embed)
  ReturnValue = Target.GetText()
  Target.Release()
  RETURN ReturnValue


Web:Prd:Datum_prodaje.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' date ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Prd:Datum_prodaje.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')
  SELF.SetExtraProperty('AltText', 'glyphicon glyphicon-calendar')
  SELF.SetExtraBoolProperty('IsDateLookup',true)


Web:Prd:Broj_racuna:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Prd:Broj_racuna.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:OK.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('DoValidate', 'true')
  SELF.SetExtraProperty('btnStyle', 'default active')


WebWindowProperty.GetEmbedText PROCEDURE(ASTRING embed)

ReturnValue          ANY

Target                  &IHtmlWriter,AUTO
  CODE
  Target &= IHtmlWriter:Create()
  CASE embed
  OF A:EmbedCSSAssets
    Target.Writeln('<<link href="../assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">')
  OF A:EmbedJSAssets
    Target.Writeln('<<script type="text/javascript" src="../assets/js/plugins/moment/moment-with-locales.min.js"><</script>')
    Target.Writeln('<<script type="text/javascript" src="../assets/js/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"><</script>')
  END
  ReturnValue = PARENT.GetEmbedText(embed)
  ReturnValue = Target.GetText()
  Target.Release()
  RETURN ReturnValue


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:Kup:ID_kupca:Prompt.Init(?Kup:ID_kupca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Kup:ID_kupca:Prompt)
  Web:Prd:ID_kupca.Init(?Prd:ID_kupca, FEQ:Unknown)
  SELF.AddControl(Web:Prd:ID_kupca)
  Web:Prd:Datum_prodaje:Prompt.Init(?Prd:Datum_prodaje:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Prd:Datum_prodaje:Prompt)
  Web:Prd:Datum_prodaje.Init(?Prd:Datum_prodaje, FEQ:Unknown)
  SELF.AddControl(Web:Prd:Datum_prodaje)
  Web:Prd:Broj_racuna:Prompt.Init(?Prd:Broj_racuna:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Prd:Broj_racuna:Prompt)
  Web:Prd:Broj_racuna.Init(?Prd:Broj_racuna, FEQ:Unknown)
  SELF.AddControl(Web:Prd:Broj_racuna)
  Web:OK.Init(?OK, FEQ:Unknown)
  SELF.AddControl(Web:OK)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE Web:CurFrame.TakeEvent()
  OF REPLY:NONE
     RETURN Level:Benign
  OF REPLY:CYCLE
     RETURN Level:Notify
  OF REPLY:BREAK
     RETURN Level:Fatal
  END
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeNarucivanja PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
BRW6::View:Browse    VIEW(Knjiga)
                       PROJECT(Knj:ID_Knjige)
                       PROJECT(Knj:Naziv_knjige)
                       PROJECT(Knj:Cijena_knjige)
                       PROJECT(Knj:Izdavac_knjige)
                       PROJECT(Knj:Autor_knjige)
                       PROJECT(Knj:Opis_knjige)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Knj:ID_Knjige          LIKE(Knj:ID_Knjige)            !List box control field - type derived from field
Knj:Naziv_knjige       LIKE(Knj:Naziv_knjige)         !List box control field - type derived from field
Knj:Cijena_knjige      LIKE(Knj:Cijena_knjige)        !List box control field - type derived from field
Knj:Izdavac_knjige     LIKE(Knj:Izdavac_knjige)       !List box control field - type derived from field
Knj:Autor_knjige       LIKE(Knj:Autor_knjige)         !List box control field - type derived from field
Knj:Opis_knjige        LIKE(Knj:Opis_knjige)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::Nar:Record  LIKE(Nar:RECORD),THREAD
FormWindow           WINDOW('Azuriranje narudzbe'),AT(,,285,107),FONT('Microsoft Sans Serif',10,,,CHARSET:DEFAULT), |
  HVSCROLL,CENTER,GRAY,MDI,SYSTEM
                       BUTTON('OK'),AT(1,93,40,12),USE(?OK),FONT('Segoe Print',10,,,CHARSET:EASTEUROPE),COLOR(0060A4F4h), |
  DEFAULT,REQ
                       BUTTON('Cancel'),AT(44,93,40,12),USE(?Cancel),FONT('Segoe Print',10,,,CHARSET:EASTEUROPE), |
  COLOR(0060A4F4h)
                       STRING(@S40),AT(87,93),USE(ActionMessage)
                       PROMPT('ID Knjige:'),AT(2,9),USE(?Knj:ID_Knjige:Prompt),FONT('Segoe Print',10,,,CHARSET:EASTEUROPE)
                       ENTRY(@s19),AT(38,10,60,13),USE(Nar:ID_Knjige),REQ
                       LIST,AT(2,28,271,62),USE(?List),FONT('Segoe Print',10,,,CHARSET:EASTEUROPE),COLOR(00ADDEFFh), |
  FORMAT('40L(2)|M~ID Knjige~C(0)@s19@200L(2)|M~Naziv knjige~C(0)@s50@60L(2)|M~Cijena k' & |
  'njige~C(1)@n-14@160L(2)|M~Izdavac knjige~C(0)@s40@200L(2)|M~Autor knjige~C(0)@s50@10' & |
  '16L(2)|M~Opis knjige~C(0)@s254@'),FROM(Queue:Browse),IMM
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:OK               CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?OK
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Knj:ID_Knjige:Prompt CLASS(WbControlHtmlProperties)    ! Web Control Manager for ?Knj:ID_Knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Nar:ID_Knjige    CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Nar:ID_Knjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:List             CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

BRW6                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeNarucivanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Nar:Record,History::Nar:Record)
  SELF.AddHistoryField(?Nar:ID_Knjige,1)
  SELF.AddUpdateFile(Access:Narucuje)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Knjiga.SetOpenRelated()
  Relate:Knjiga.Open()                                     ! File Knjiga used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Narucuje
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  BRW6.Init(?List,Queue:Browse.ViewPosition,BRW6::View:Browse,Queue:Browse,Relate:Knjiga,SELF) ! Initialize the browse manager
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeNarucivanja)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW6.Q &= Queue:Browse
  BRW6.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW6.AddField(Knj:ID_Knjige,BRW6.Q.Knj:ID_Knjige)        ! Field Knj:ID_Knjige is a hot field or requires assignment from browse
  BRW6.AddField(Knj:Naziv_knjige,BRW6.Q.Knj:Naziv_knjige)  ! Field Knj:Naziv_knjige is a hot field or requires assignment from browse
  BRW6.AddField(Knj:Cijena_knjige,BRW6.Q.Knj:Cijena_knjige) ! Field Knj:Cijena_knjige is a hot field or requires assignment from browse
  BRW6.AddField(Knj:Izdavac_knjige,BRW6.Q.Knj:Izdavac_knjige) ! Field Knj:Izdavac_knjige is a hot field or requires assignment from browse
  BRW6.AddField(Knj:Autor_knjige,BRW6.Q.Knj:Autor_knjige)  ! Field Knj:Autor_knjige is a hot field or requires assignment from browse
  BRW6.AddField(Knj:Opis_knjige,BRW6.Q.Knj:Opis_knjige)    ! Field Knj:Opis_knjige is a hot field or requires assignment from browse
  INIMgr.Fetch('AzuriranjeNarucivanja',FormWindow)         ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.AddItem(ToolbarForm)
  BRW6.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Knjiga.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeNarucivanja',FormWindow)      ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  Knj:ID_Knjige = Nar:ID_Knjige                            ! Assign linking field value
  Access:Knjiga.Fetch(Knj:PK_Knjiga_ID_Knjige)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisKnjiga
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?Nar:ID_Knjige
      Knj:ID_Knjige = Nar:ID_Knjige
      IF Access:Knjiga.TryFetch(Knj:PK_Knjiga_ID_Knjige)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          Nar:ID_Knjige = Knj:ID_Knjige
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:OK.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('DoValidate', 'true')
  SELF.SetExtraProperty('btnStyle', 'default active')


Web:Knj:ID_Knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Nar:ID_Knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:List.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraBoolProperty('WrapText', true)
  SELF.SetExtraBoolProperty('responsive', false)


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:OK.Init(?OK, FEQ:Unknown)
  SELF.AddControl(Web:OK)
  Web:Knj:ID_Knjige:Prompt.Init(?Knj:ID_Knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:ID_Knjige:Prompt)
  Web:Nar:ID_Knjige.Init(?Nar:ID_Knjige, FEQ:Unknown)
  SELF.AddControl(Web:Nar:ID_Knjige)
  Web:List.Init(?List, FEQ:Unknown)
  SELF.AddControl(Web:List)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE Web:CurFrame.TakeEvent()
  OF REPLY:NONE
     RETURN Level:Benign
  OF REPLY:CYCLE
     RETURN Level:Notify
  OF REPLY:BREAK
     RETURN Level:Fatal
  END
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePripadanja PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
BRW6::View:Browse    VIEW(Zanr)
                       PROJECT(Zan:ID_zanra)
                       PROJECT(Zan:Naziv_zanra)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Zan:ID_zanra           LIKE(Zan:ID_zanra)             !List box control field - type derived from field
Zan:Naziv_zanra        LIKE(Zan:Naziv_zanra)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::Pri:Record  LIKE(Pri:RECORD),THREAD
FormWindow           WINDOW('Azuriranje pripadnosti knjige zanru'),AT(,,214,128),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('OK'),AT(2,114,40,12),USE(?OK),FONT('Segoe Print',10),COLOR(0060A4F4h),DEFAULT,REQ
                       BUTTON('Cancel'),AT(44,114,40,12),USE(?Cancel),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       STRING(@S40),AT(88,116),USE(ActionMessage)
                       PROMPT('ID zanra:'),AT(2,7),USE(?Zan:ID_zanra:Prompt),FONT('Segoe Print',10)
                       ENTRY(@s19),AT(38,10,60,10),USE(Pri:ID_zanra),REQ
                       LIST,AT(2,28,150,83),USE(?List),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),FORMAT('76L(2)|M~I' & |
  'D zanra~C(0)@s19@156L(2)|M~Naziv zanra~C(0)@s39@'),FROM(Queue:Browse),IMM
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:OK               CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?OK
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Zan:ID_zanra:Prompt CLASS(WbControlHtmlProperties)     ! Web Control Manager for ?Zan:ID_zanra:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pri:ID_zanra     CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Pri:ID_zanra
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:List             CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

BRW6                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjePripadanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Pri:Record,History::Pri:Record)
  SELF.AddHistoryField(?Pri:ID_zanra,1)
  SELF.AddUpdateFile(Access:Pripada)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Pripada.Open()                                    ! File Pripada used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Pripada
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  BRW6.Init(?List,Queue:Browse.ViewPosition,BRW6::View:Browse,Queue:Browse,Relate:Zanr,SELF) ! Initialize the browse manager
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjePripadanja)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW6.Q &= Queue:Browse
  BRW6.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW6.AddField(Zan:ID_zanra,BRW6.Q.Zan:ID_zanra)          ! Field Zan:ID_zanra is a hot field or requires assignment from browse
  BRW6.AddField(Zan:Naziv_zanra,BRW6.Q.Zan:Naziv_zanra)    ! Field Zan:Naziv_zanra is a hot field or requires assignment from browse
  INIMgr.Fetch('AzuriranjePripadanja',FormWindow)          ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.AddItem(ToolbarForm)
  BRW6.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Pripada.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjePripadanja',FormWindow)       ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  Zan:ID_zanra = Pri:ID_zanra                              ! Assign linking field value
  Access:Zanr.Fetch(Zan:PK_Zanr_ID_zanra)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisZanrova
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?Pri:ID_zanra
      Zan:ID_zanra = Pri:ID_zanra
      IF Access:Zanr.TryFetch(Zan:PK_Zanr_ID_zanra)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          Pri:ID_zanra = Zan:ID_zanra
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:OK.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('DoValidate', 'true')
  SELF.SetExtraProperty('btnStyle', 'default active')


Web:Zan:ID_zanra:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pri:ID_zanra.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:List.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraBoolProperty('WrapText', true)
  SELF.SetExtraBoolProperty('responsive', false)


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:OK.Init(?OK, FEQ:Unknown)
  SELF.AddControl(Web:OK)
  Web:Zan:ID_zanra:Prompt.Init(?Zan:ID_zanra:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Zan:ID_zanra:Prompt)
  Web:Pri:ID_zanra.Init(?Pri:ID_zanra, FEQ:Unknown)
  SELF.AddControl(Web:Pri:ID_zanra)
  Web:List.Init(?List, FEQ:Unknown)
  SELF.AddControl(Web:List)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE Web:CurFrame.TakeEvent()
  OF REPLY:NONE
     RETURN Level:Benign
  OF REPLY:CYCLE
     RETURN Level:Notify
  OF REPLY:BREAK
     RETURN Level:Fatal
  END
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
Login PROCEDURE 

LOC:Lozinka          STRING(20)                            ! 
Window               WINDOW('Login'),AT(,,357,170),FONT('Segoe UI',9),RESIZE,ICON(ICON:Application),GRAY,MAX,SYSTEM, |
  WALLPAPER('login.jpg'),IMM
                       ENTRY(@s20),AT(126,21),USE(ULZ:Korisnicko_Ime)
                       ENTRY(@s20),AT(126,46),USE(LOC:Lozinka),PASSWORD,REQ
                       BUTTON('Prijava'),AT(125,79),USE(?ButtonLogin)
                       BUTTON('Prijava kao korisnik'),AT(125,107),USE(?BUTTON3),FONT(,,,FONT:regular)
                       BUTTON('Close'),AT(270,107),USE(?Close:2)
                       STRING('Korisnicko ime:'),AT(57,21),USE(?STRING1)
                       STRING('Lozinka:'),AT(81,46,,12),USE(?STRING2)
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
                     END

Web:ULZ:Korisnicko_Ime CLASS(WbControlHtmlProperties)      ! Web Control Manager for ?ULZ:Korisnicko_Ime
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
CheckPassword ROUTINE

    GLO:LoggedIn = FALSE

    GET(ULAZ,ULZ:Key_Korisnicko)
    IF ~ERRORCODE()
        IF CLIP(ULZ:Lozinka) = CLIP(LOC:Lozinka)THEN
            GLO:LoggedIn = TRUE
            POST(Event:CloseWindow)
        END
    END
    EXIT

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Login')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ULZ:Korisnicko_Ime
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close:2,RequestCancelled)               ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close:2,RequestCompleted)               ! Add the close control to the window manger
  END
  Relate:ULAZ.Open()                                       ! File ULAZ used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (Login)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  INIMgr.Fetch('Login',Window)                             ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULAZ.Close()
  END
  IF SELF.Opened
    INIMgr.Update('Login',Window)                          ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?ButtonLogin
      Do CheckPassword
      ! Šalje poruku '1' na proces sa ID-jem GLO:MainThreadID (globalna varijabla u koju je spremljen ID min procesa)
      NOTIFY(1, GLO:MainThreadID)
    OF ?BUTTON3
       POST(EVENT:CloseWindow)
      GLO:LoggedIn=FALSE 
      ! Šalje poruku '1' na proces sa ID-jem GLO:MainThreadID (globalna varijabla u koju je spremljen ID min procesa)
      NOTIFY(1, GLO:MainThreadID)
    OF ?Close:2
       POST(EVENT:CloseWindow)
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:ULZ:Korisnicko_Ime.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:ULZ:Korisnicko_Ime.Init(?ULZ:Korisnicko_Ime, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:Korisnicko_Ime)


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
Login2 PROCEDURE 

LOC:Lozinka          STRING(20)                            ! 
Window               WINDOW('Caption'),AT(,,348,228),FONT('Segoe UI',9),RESIZE,ICON(ICON:Application),GRAY,MAX, |
  SYSTEM,IMM
                       ENTRY(@s20),AT(132,60),USE(ULZ:Korisnicko_Ime)
                       ENTRY(@s20),AT(132,113),USE(LOC:Lozinka)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Login2')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ULZ:Korisnicko_Ime
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  Relate:ULAZ.Open()                                       ! File ULAZ used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('Login2',Window)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULAZ.Close()
  END
  IF SELF.Opened
    INIMgr.Update('Login2',Window)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisAdmina PROCEDURE 

BRW1::View:Browse    VIEW(ULAZ)
                       PROJECT(ULZ:ID)
                       PROJECT(ULZ:Korisnicko_Ime)
                       PROJECT(ULZ:Lozinka)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ULZ:ID                 LIKE(ULZ:ID)                   !List box control field - type derived from field
ULZ:Korisnicko_Ime     LIKE(ULZ:Korisnicko_Ime)       !List box control field - type derived from field
ULZ:Lozinka            LIKE(ULZ:Lozinka)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis Admina'),AT(0,0,247,140),GRAY,MDI,SYSTEM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,FORMAT('60L(2)|M~ID~L(1)@n-14@80L(2)|M~Korisni' & |
  'cko Ime~L(0)@s20@80L(2)|M~Lozinka~L(0)@s20@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Insert'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Change'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Delete'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Select'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Close'),AT(200,110,40,12),USE(?Close)
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:List             CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Change           CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Change
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisAdmina')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:ULAZ.Open()                                       ! File ULAZ used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ULAZ,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PopisAdmina)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,ULZ:KEY_ID)                           ! Add the sort order for ULZ:KEY_ID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,ULZ:ID,1,BRW1)                 ! Initialize the browse locator using  using key: ULZ:KEY_ID , ULZ:ID
  BRW1.AddField(ULZ:ID,BRW1.Q.ULZ:ID)                      ! Field ULZ:ID is a hot field or requires assignment from browse
  BRW1.AddField(ULZ:Korisnicko_Ime,BRW1.Q.ULZ:Korisnicko_Ime) ! Field ULZ:Korisnicko_Ime is a hot field or requires assignment from browse
  BRW1.AddField(ULZ:Lozinka,BRW1.Q.ULZ:Lozinka)            ! Field ULZ:Lozinka is a hot field or requires assignment from browse
  INIMgr.Fetch('PopisAdmina',BrowseWindow)                 ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeAdmina
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULAZ.Close()
  END
  IF SELF.Opened
    INIMgr.Update('PopisAdmina',BrowseWindow)              ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeAdmina
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


Web:List.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraBoolProperty('WrapText', true)
  SELF.SetExtraBoolProperty('responsive', false)


Web:Change.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('btnStyle', 'default active')


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:List.Init(?List, FEQ:Unknown)
  SELF.AddControl(Web:List)
  Web:Change.Init(?Change, FEQ:Unknown)
  SELF.AddControl(Web:Change)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE Web:CurFrame.TakeEvent()
  OF REPLY:NONE
     RETURN Level:Benign
  OF REPLY:CYCLE
     RETURN Level:Notify
  OF REPLY:BREAK
     RETURN Level:Fatal
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeAdmina PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ULZ:Record  LIKE(ULZ:RECORD),THREAD
FormWindow           WINDOW('Admin Forma'),AT(,,220,85),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('OK'),AT(2,68,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(44,68,40,12),USE(?Cancel)
                       STRING(@S40),AT(88,68),USE(ActionMessage)
                       PROMPT('Korisnicko Ime:'),AT(5,28),USE(?ULZ:Korisnicko_Ime:Prompt)
                       ENTRY(@s20),AT(54,28,60,10),USE(ULZ:Korisnicko_Ime)
                       PROMPT('Lozinka:'),AT(5,46),USE(?ULZ:Lozinka:Prompt)
                       ENTRY(@s20),AT(40,46,60,10),USE(ULZ:Lozinka)
                       PROMPT('ID:'),AT(5,10),USE(?ULZ:ID:Prompt)
                       ENTRY(@n-14),AT(18,9,60,10),USE(ULZ:ID),RIGHT(1)
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:OK               CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?OK
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:ULZ:Korisnicko_Ime:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?ULZ:Korisnicko_Ime:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:ULZ:Korisnicko_Ime CLASS(WbControlHtmlProperties)      ! Web Control Manager for ?ULZ:Korisnicko_Ime
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:ULZ:Lozinka:Prompt CLASS(WbControlHtmlProperties)      ! Web Control Manager for ?ULZ:Lozinka:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:ULZ:Lozinka      CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?ULZ:Lozinka
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:ULZ:ID:Prompt    CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?ULZ:ID:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:ULZ:ID           CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?ULZ:ID
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeAdmina')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ULZ:Record,History::ULZ:Record)
  SELF.AddHistoryField(?ULZ:Korisnicko_Ime,2)
  SELF.AddHistoryField(?ULZ:Lozinka,3)
  SELF.AddHistoryField(?ULZ:ID,1)
  SELF.AddUpdateFile(Access:ULAZ)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ULAZ.Open()                                       ! File ULAZ used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ULAZ
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeAdmina)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  INIMgr.Fetch('AzuriranjeAdmina',FormWindow)              ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ULAZ.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeAdmina',FormWindow)           ! Save window data to non-volatile store
  END
  IF (WebServer.IsEnabled())
    POST(EVENT:NewPage)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:OK.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('DoValidate', 'true')
  SELF.SetExtraProperty('btnStyle', 'default active')


Web:ULZ:Korisnicko_Ime:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:ULZ:Korisnicko_Ime.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:ULZ:Lozinka:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:ULZ:Lozinka.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:ULZ:ID:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:ULZ:ID.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextAlign', 'right')
  SELF.SetExtraProperty('InputType','number')


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'TextAlign')
     RETURN CreateStringValue('center')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


WebWindowProperty.GetSkeletonAttr PROCEDURE(SIGNED whichAttr)

ReturnValue          ANY

  CODE
  IF whichAttr = SkeletonAttr:RuntimeLayout
     IF Broker.Http.GetIsMobileBrowser()
        RETURN 'off'
     ELSE
        RETURN 'on'
     END
  END
  ReturnValue = PARENT.GetSkeletonAttr(whichAttr)
  CASE whichAttr
  END
  RETURN ReturnValue


WebWindow.Init PROCEDURE

  CODE
  PARENT.Init
  WebWindowProperty.Init()
  WebWindowProperty.SetSubmitOnCancel(TRUE)
  SELF.AddControl(WebWindowProperty)
  Web:OK.Init(?OK, FEQ:Unknown)
  SELF.AddControl(Web:OK)
  Web:ULZ:Korisnicko_Ime:Prompt.Init(?ULZ:Korisnicko_Ime:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:Korisnicko_Ime:Prompt)
  Web:ULZ:Korisnicko_Ime.Init(?ULZ:Korisnicko_Ime, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:Korisnicko_Ime)
  Web:ULZ:Lozinka:Prompt.Init(?ULZ:Lozinka:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:Lozinka:Prompt)
  Web:ULZ:Lozinka.Init(?ULZ:Lozinka, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:Lozinka)
  Web:ULZ:ID:Prompt.Init(?ULZ:ID:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:ID:Prompt)
  Web:ULZ:ID.Init(?ULZ:ID, FEQ:Unknown)
  SELF.AddControl(Web:ULZ:ID)
  IF (WebServer.IsEnabled())
    Web:CurFrame &= GetWebActiveFrame()
    Web:CurFrame.CopyControlsToWindow(TRUE, TRUE)
  END


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE Web:CurFrame.TakeEvent()
  OF REPLY:NONE
     RETURN Level:Benign
  OF REPLY:CYCLE
     RETURN Level:Notify
  OF REPLY:BREAK
     RETURN Level:Fatal
  END
  RETURN ReturnValue

