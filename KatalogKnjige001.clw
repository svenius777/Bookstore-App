

   MEMBER('KatalogKnjige.clw')                             ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABLPROPR.INC'),ONCE
   INCLUDE('ABLWINR.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE
   INCLUDE('WBFRAME.INC'),ONCE
   INCLUDE('ablwman.inc'),ONCE

                     MAP
                       INCLUDE('KATALOGKNJIGE001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('KATALOGKNJIGE002.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! </summary>
PocetniEkran PROCEDURE 

DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('Katalog Knjiga'),AT(,,639,368),RESIZE,MAX,STATUS(-1,80,120,45),SYSTEM,WALLPAPER('273752834_' & |
  '1048252439103065_6179527965328963700_n.jpg'),IMM
                       MENUBAR,USE(?MENUBAR1)
                         MENU('&Datoteka'),USE(?FileMenu)
                           ITEM('Postavke ispisa...'),USE(?PrintSetup),MSG('Setup Printer'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('Izlaz'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('&Uredi'),USE(?EditMenu)
                           ITEM('Izrezi'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('Kopiraj'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('Zalijepi'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
                         END
                         MENU('Prozor'),USE(?MENU1),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('Plocice'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('Kaskadno'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('Uredi ikone'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('Pomoc'),USE(?MENU2),MSG('Windows Help')
                           ITEM('Sadrzaj'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('Potrazi pomoc na...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('Kako koristiti pomoc'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                         MENU('Popis'),USE(?Popis)
                           ITEM('Prodavaca'),USE(?PopisProdavaca)
                           ITEM('Klijenata'),USE(?PopisKlijenata)
                           ITEM('Knjiga'),USE(?PopisKnjiga)
                           ITEM('Rangova'),USE(?PopisRangova)
                           ITEM('Zanrova'),USE(?PopisZanrova)
                         END
                       END
                       TOOLBAR,AT(0,0,639,50),USE(?TOOLBAR1),COLOR(00ADDEFFh)
                         BUTTON('Prodavaci'),AT(8,16,40,20),USE(?BUTTON1),FONT('Segoe Print',10),COLOR(0060A4F4h)
                         BUTTON('Knjige'),AT(120,16,40,20),USE(?BUTTON2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                         BUTTON('Klijenti'),AT(233,16,40,20),USE(?BUTTON3),FONT('Segoe Print',10),COLOR(0060A4F4h)
                         BUTTON('Rangovi'),AT(346,16,44,20),USE(?BUTTON4),FONT('Segoe Print',10),COLOR(0060A4F4h)
                         BUTTON('Zanrovi'),AT(462,16,40,20),USE(?BUTTON5),FONT('Segoe Print',10),COLOR(0060A4F4h)
                         BUTTON('Admin'),AT(590,16,40,20),USE(?AdminButton),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       END
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
                     END

WebFrame             CLASS(WbFrameClass)
TakeEvent              PROCEDURE(),SIGNED,PROC,DERIVED
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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
Menu::MENUBAR1 ROUTINE                                     ! Code for menu items on ?MENUBAR1
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::MENU1 ROUTINE                                        ! Code for menu items on ?MENU1
Menu::MENU2 ROUTINE                                        ! Code for menu items on ?MENU2
Menu::Popis ROUTINE                                        ! Code for menu items on ?Popis
  CASE ACCEPTED()
  OF ?PopisProdavaca
    START(PopisProdavaca, 50000)
  OF ?PopisKlijenata
    START(PopisKlijenata, 50000)
  OF ?PopisKnjiga
    START(PopisKnjiga, 50000)
  OF ?PopisRangova
    START(PopisRangova, 50000)
  OF ?PopisZanrova
    START(PopisZanrova, 50000)
  END

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{PROP:Timer},1,100)
    AppFrame{PROP:Timer} = 100
  END
    AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  Login()
  GlobalErrors.SetProcedureName('PocetniEkran')
  WebFrame.FrameWindow &= AppFrame
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PocetniEkran)')
    WebWindowManager.SetIsHome(TRUE)
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
    HIDE(?PrintSetup) !Added by hidding STD controls
    HIDE(?Exit) !Added by hidding STD controls
    HIDE(?Cut) !Added by hidding STD controls
    HIDE(?Copy) !Added by hidding STD controls
    HIDE(?Paste) !Added by hidding STD controls
    HIDE(?MENU1) !Added by hidding STD controls
    HIDE(?Tile) !Added by hidding STD controls
    HIDE(?Cascade) !Added by hidding STD controls
    HIDE(?Arrange) !Added by hidding STD controls
    HIDE(?Helpindex) !Added by hidding STD controls
    HIDE(?HelpSearch) !Added by hidding STD controls
    HIDE(?HelpOnHelp) !Added by hidding STD controls
  END
  HIDE(?FileMenu)
  HIDE(?PrintSetup)
  HIDE(?SEPARATOR1)
  HIDE(?Exit)
  
  IF GLO:LoggedIn=FALSE
      HIDE(?BUTTON4)
  	HIDE(?BUTTON5)
  	HIDE(?PopisRangova)
      HIDE(?PopisZanrova)
      HIDE(?AdminButton)
  ELSIF GLO:LoggedIn=TRUE
      UNHIDE(?BUTTON4)
  	UNHIDE(?BUTTON5)
  	UNHIDE(?PopisRangova)
      UNHIDE(?PopisZanrova)
      UNHIDE(?AdminButton)
  END
  
  GLO:MainThreadID = THREAD()
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PocetniEkran',AppFrame)                    ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('PocetniEkran',AppFrame)                 ! Save window data to non-volatile store
  END
  SetWebActiveFrame()
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
    ELSE
      DO Menu::MENUBAR1                                    ! Process menu items on ?MENUBAR1 menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::MENU1                                       ! Process menu items on ?MENU1 menu
      DO Menu::MENU2                                       ! Process menu items on ?MENU2 menu
      DO Menu::Popis                                       ! Process menu items on ?Popis menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON1
      START(PopisProdavaca, 50000)
    OF ?BUTTON2
      START(PopisKnjiga, 50000)
    OF ?BUTTON3
      START(PopisKlijenata, 50000)
    OF ?BUTTON4
      START(PopisRangova, 50000)
    OF ?BUTTON5
      START(PopisZanrova, 50000)
    OF ?AdminButton
      START(PopisAdmina, 25000)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Notify
      IF GLO:LoggedIn=FALSE
      	HIDE(?BUTTON4)
      	HIDE(?BUTTON5)
      	HIDE(?PopisRangova)
          HIDE(?PopisZanrova)
          HIDE(?AdminButton)
      	!?ITEM2:2{PROP:Text} = 'Unos najma'
      	
      ELSIF GLO:LoggedIn=TRUE
      	UNHIDE(?BUTTON4)
      	UNHIDE(?BUTTON5)
      	UNHIDE(?PopisRangova)
          UNHIDE(?PopisZanrova)
          UNHIDE(?AdminButton)
      	!?ITEM2:2{PROP:Text} = 'Najmovi'
      	
      END
      ! Refresha window
      DISPLAY()
    OF EVENT:Timer
      AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


WebWindowProperty.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-center ')
  END
  IF (name = 'InFrame')
     RETURN CreateBoolValue(true)
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
  SetWebActiveFrame(WebFrame)


WebWindow.Kill PROCEDURE

  CODE
  WebWindowProperty.Kill()
  PARENT.Kill


WebFrame.TakeEvent PROCEDURE

ReturnValue          SIGNED,AUTO

FirstIteration       SIGNED(1)
  CODE
  ReturnValue = PARENT.TakeEvent()
  LOOP
    RETURN REPLY:NONE
  END
  ReturnValue = REPLY:BREAK
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisProdavaca PROCEDURE 

NaruceneKnjige       LONG                                  ! 
PotrebneKnjige       LONG                                  ! 
TrenutniRang         LONG(1)                               ! 
ActionMessage        CSTRING(40)                           ! 
BRW1::View:Browse    VIEW(Prodavac)
                       PROJECT(Pro:ID_prodavaca)
                       PROJECT(Pro:Ime_prodavaca)
                       PROJECT(Pro:Prezime_prodavaca)
                       PROJECT(Pro:Broj_telefona)
                       PROJECT(Pro:Rang)
                       PROJECT(Pro:Email)
                       JOIN(Ran:PK_Rang_ID_Ranga,Pro:Rang)
                         PROJECT(Ran:ID_ranga)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Pro:ID_prodavaca       LIKE(Pro:ID_prodavaca)         !List box control field - type derived from field
Pro:Ime_prodavaca      LIKE(Pro:Ime_prodavaca)        !List box control field - type derived from field
Pro:Prezime_prodavaca  LIKE(Pro:Prezime_prodavaca)    !List box control field - type derived from field
Pro:Broj_telefona      LIKE(Pro:Broj_telefona)        !List box control field - type derived from field
Pro:Rang               LIKE(Pro:Rang)                 !List box control field - type derived from field
Pro:Email              LIKE(Pro:Email)                !List box control field - type derived from field
Ran:ID_ranga           LIKE(Ran:ID_ranga)             !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW7::View:Browse    VIEW(Prodaje)
                       PROJECT(Prd:ID_prodavaca)
                       PROJECT(Prd:Datum_prodaje)
                       PROJECT(Prd:Nacin_placanja)
                       PROJECT(Prd:Broj_racuna)
                       PROJECT(Prd:ID_kupca)
                       JOIN(Kup:PK_Kupac_ID_kupca,Prd:ID_kupca)
                         PROJECT(Kup:Ime_kupca)
                         PROJECT(Kup:Prezime_kupca)
                         PROJECT(Kup:ID_kupca)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
Prd:ID_prodavaca       LIKE(Prd:ID_prodavaca)         !List box control field - type derived from field
Kup:Ime_kupca          LIKE(Kup:Ime_kupca)            !List box control field - type derived from field
Kup:Prezime_kupca      LIKE(Kup:Prezime_kupca)        !List box control field - type derived from field
Prd:Datum_prodaje      LIKE(Prd:Datum_prodaje)        !List box control field - type derived from field
Prd:Nacin_placanja     LIKE(Prd:Nacin_placanja)       !List box control field - type derived from field
Prd:Broj_racuna        LIKE(Prd:Broj_racuna)          !List box control field - type derived from field
Prd:ID_kupca           LIKE(Prd:ID_kupca)             !Primary key field - type derived from field
Kup:ID_kupca           LIKE(Kup:ID_kupca)             !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW9::View:Browse    VIEW(Narucuje)
                       PROJECT(Nar:ID_Knjige)
                       PROJECT(Nar:ID_prodavaca)
                       JOIN(Knj:PK_Knjiga_ID_Knjige,Nar:ID_Knjige)
                         PROJECT(Knj:ID_Knjige)
                         PROJECT(Knj:Naziv_knjige)
                         PROJECT(Knj:Cijena_knjige)
                         PROJECT(Knj:Izdavac_knjige)
                         PROJECT(Knj:Autor_knjige)
                         PROJECT(Knj:Opis_knjige)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
Knj:ID_Knjige          LIKE(Knj:ID_Knjige)            !List box control field - type derived from field
Knj:Naziv_knjige       LIKE(Knj:Naziv_knjige)         !List box control field - type derived from field
Knj:Cijena_knjige      LIKE(Knj:Cijena_knjige)        !List box control field - type derived from field
Knj:Izdavac_knjige     LIKE(Knj:Izdavac_knjige)       !List box control field - type derived from field
Knj:Autor_knjige       LIKE(Knj:Autor_knjige)         !List box control field - type derived from field
Knj:Opis_knjige        LIKE(Knj:Opis_knjige)          !List box control field - type derived from field
Nar:ID_Knjige          LIKE(Nar:ID_Knjige)            !Primary key field - type derived from field
Nar:ID_prodavaca       LIKE(Nar:ID_prodavaca)         !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
BrowseWindow         WINDOW('Popis prodavaca'),AT(0,0,404,412),GRAY,MDI,SYSTEM,WALLPAPER('knj1.jpg')
                       ENTRY(@n-14),AT(90,380,60,10),USE(NaruceneKnjige),FONT(,,,FONT:regular+FONT:underline),RIGHT(1)
                       LIST,AT(5,5,390,108),USE(?List),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),FORMAT('48L(2)|M~I' & |
  'D prodavaca~L(0)@s19@65L(2)|M~Ime prodavaca~L(0)@s50@87L(2)|M~Prezime prodavaca~L(0)' & |
  '@s50@56L(2)|M~Broj telefona~L(0)@K###-###-###K@64L(2)|M~ID ranga~L(0)@s19@200L(2)|M~' & |
  'Email~L(0)@S50@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Insert'),AT(4,116,40,12),USE(?Insert),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(47,116,40,12),USE(?Change),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Delete'),AT(90,116,40,12),USE(?Delete),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Select'),AT(134,116,40,12),USE(?Select),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('Close'),AT(358,392,40,12),USE(?Close),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       LIST,AT(4,148,394,100),USE(?List:2),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),FORMAT('50L(2)|M~I' & |
  'D prodavaca~C(0)@s19@[100L(2)|M~Ime~C(0)@s50@100L(2)|M~Prezime~C(0)@s50@]|~Kupac~50L' & |
  '(2)|M~Datum prodaje~C(0)@D6@100L(2)|M~Nacin placanja~C(0)@s29@50L(2)|M~Broj racuna~C(0)@s19@'), |
  FROM(Queue:Browse:1),IMM,MSG('Browsing Records')
                       STRING('Popis racuna kupaca kojima izabrani prodavac prodaje'),AT(4,131),USE(?STRING1),FONT('Segoe Print', |
  10,,FONT:bold)
                       BUTTON('&Insert'),AT(4,252,42,12),USE(?Insert:2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(48,252,42,12),USE(?Change:2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Delete'),AT(94,252,42,12),USE(?Delete:2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       LIST,AT(5,284,394,72),USE(?List:3),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),FORMAT('50L(2)|M~I' & |
  'D Knjige~C(0)@s19@150L(2)|M~Naziv knjige~C(0)@s50@50L(2)|M~Cijena knjige~C(1)@n-14@1' & |
  '00L(2)|M~Izdavac knjige~C(0)@s40@150L(2)|M~Autor knjige~C(0)@s50@1000L(2)|M~Opis knj' & |
  'ige~C(0)@s254@'),FROM(Queue:Browse:2),IMM,MSG('Browsing Records')
                       STRING('Popis knjiga koje izabrani prodavac narucuje'),AT(4,267),USE(?STRING2),FONT('Segoe Print', |
  10,,FONT:bold)
                       BUTTON('&Insert'),AT(4,360,42,12),USE(?Insert:3),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(48,360,42,12),USE(?Change:3),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Delete'),AT(94,360,42,12),USE(?Delete:3),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       STRING('Naruceno knjiga'),AT(4,381),USE(?STRING3)
                       STRING('Preostalo knjiga za naruciti'),AT(4,397),USE(?STRING4)
                       ENTRY(@n-14),AT(90,396,60,10),USE(PotrebneKnjige),RIGHT(1)
                       BUTTON('Naruci'),AT(198,381),USE(?BUTTON1)
                     END
Web:CurFrame         &WbFrameClass

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
WebWindowManager     WbWindowManagerClass
WebWindow            CLASS(WbWindowClass)
Init                   PROCEDURE()
Kill                   PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Web:NaruceneKnjige   CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?NaruceneKnjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:List             CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:List:2           CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List:2
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:List:3           CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List:3
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:PotrebneKnjige   CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?PotrebneKnjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW7                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW7::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW9                 CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW9::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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
  IF NOT INRANGE(BrowseWindow{PROP:Timer},1,100)
    BrowseWindow{PROP:Timer} = 100
  END
    BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    BrowseWindow{PROP:StatusText,2} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisProdavaca')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?NaruceneKnjige
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
  Relate:Narucuje.SetOpenRelated()
  Relate:Narucuje.Open()                                   ! File Narucuje used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:Prodavac,SELF) ! Initialize the browse manager
  BRW7.Init(?List:2,Queue:Browse:1.ViewPosition,BRW7::View:Browse,Queue:Browse:1,Relate:Prodaje,SELF) ! Initialize the browse manager
  BRW9.Init(?List:3,Queue:Browse:2.ViewPosition,BRW9::View:Browse,Queue:Browse:2,Relate:Narucuje,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PopisProdavaca)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  DISABLE(?NaruceneKnjige)
  DISABLE(?PotrebneKnjige)
  
  
  PotrebneKnjige=10-NaruceneKnjige
  
  IF GLO:LoggedIn=FALSE
      HIDE(?Insert)
      HIDE(?Change)
      HIDE(?Delete)
      ?Change{PROP:Text} = 'Rankup!'
  ELSE GLO:LoggedIn=TRUE
      UNHIDE(?Change)
      UNHIDE(?Insert)
      UNHIDE(?Delete)
      ?Change{PROP:Text} = 'Change'
  END
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,Pro:PK_Prodavac_ID_prodavaca)         ! Add the sort order for Pro:PK_Prodavac_ID_prodavaca for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Pro:ID_prodavaca,1,BRW1)       ! Initialize the browse locator using  using key: Pro:PK_Prodavac_ID_prodavaca , Pro:ID_prodavaca
  BRW1.AddField(Pro:ID_prodavaca,BRW1.Q.Pro:ID_prodavaca)  ! Field Pro:ID_prodavaca is a hot field or requires assignment from browse
  BRW1.AddField(Pro:Ime_prodavaca,BRW1.Q.Pro:Ime_prodavaca) ! Field Pro:Ime_prodavaca is a hot field or requires assignment from browse
  BRW1.AddField(Pro:Prezime_prodavaca,BRW1.Q.Pro:Prezime_prodavaca) ! Field Pro:Prezime_prodavaca is a hot field or requires assignment from browse
  BRW1.AddField(Pro:Broj_telefona,BRW1.Q.Pro:Broj_telefona) ! Field Pro:Broj_telefona is a hot field or requires assignment from browse
  BRW1.AddField(Pro:Rang,BRW1.Q.Pro:Rang)                  ! Field Pro:Rang is a hot field or requires assignment from browse
  BRW1.AddField(Pro:Email,BRW1.Q.Pro:Email)                ! Field Pro:Email is a hot field or requires assignment from browse
  BRW1.AddField(Ran:ID_ranga,BRW1.Q.Ran:ID_ranga)          ! Field Ran:ID_ranga is a hot field or requires assignment from browse
  BRW7.Q &= Queue:Browse:1
  BRW7.AddSortOrder(,Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna) ! Add the sort order for Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna for sort order 1
  BRW7.AddRange(Prd:ID_prodavaca,Relate:Prodaje,Relate:Prodavac) ! Add file relationship range limit for sort order 1
  BRW7.AddLocator(BRW7::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW7::Sort0:Locator.Init(,Prd:ID_kupca,1,BRW7)           ! Initialize the browse locator using  using key: Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna , Prd:ID_kupca
  BRW7.AddField(Prd:ID_prodavaca,BRW7.Q.Prd:ID_prodavaca)  ! Field Prd:ID_prodavaca is a hot field or requires assignment from browse
  BRW7.AddField(Kup:Ime_kupca,BRW7.Q.Kup:Ime_kupca)        ! Field Kup:Ime_kupca is a hot field or requires assignment from browse
  BRW7.AddField(Kup:Prezime_kupca,BRW7.Q.Kup:Prezime_kupca) ! Field Kup:Prezime_kupca is a hot field or requires assignment from browse
  BRW7.AddField(Prd:Datum_prodaje,BRW7.Q.Prd:Datum_prodaje) ! Field Prd:Datum_prodaje is a hot field or requires assignment from browse
  BRW7.AddField(Prd:Nacin_placanja,BRW7.Q.Prd:Nacin_placanja) ! Field Prd:Nacin_placanja is a hot field or requires assignment from browse
  BRW7.AddField(Prd:Broj_racuna,BRW7.Q.Prd:Broj_racuna)    ! Field Prd:Broj_racuna is a hot field or requires assignment from browse
  BRW7.AddField(Prd:ID_kupca,BRW7.Q.Prd:ID_kupca)          ! Field Prd:ID_kupca is a hot field or requires assignment from browse
  BRW7.AddField(Kup:ID_kupca,BRW7.Q.Kup:ID_kupca)          ! Field Kup:ID_kupca is a hot field or requires assignment from browse
  BRW9.Q &= Queue:Browse:2
  BRW9.AddSortOrder(,Nar:RK_Narucuje_ID_prodavaca_ID_Knjige) ! Add the sort order for Nar:RK_Narucuje_ID_prodavaca_ID_Knjige for sort order 1
  BRW9.AddRange(Nar:ID_prodavaca,Relate:Narucuje,Relate:Prodavac) ! Add file relationship range limit for sort order 1
  BRW9.AddLocator(BRW9::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW9::Sort0:Locator.Init(,Nar:ID_Knjige,1,BRW9)          ! Initialize the browse locator using  using key: Nar:RK_Narucuje_ID_prodavaca_ID_Knjige , Nar:ID_Knjige
  BRW9.AddField(Knj:ID_Knjige,BRW9.Q.Knj:ID_Knjige)        ! Field Knj:ID_Knjige is a hot field or requires assignment from browse
  BRW9.AddField(Knj:Naziv_knjige,BRW9.Q.Knj:Naziv_knjige)  ! Field Knj:Naziv_knjige is a hot field or requires assignment from browse
  BRW9.AddField(Knj:Cijena_knjige,BRW9.Q.Knj:Cijena_knjige) ! Field Knj:Cijena_knjige is a hot field or requires assignment from browse
  BRW9.AddField(Knj:Izdavac_knjige,BRW9.Q.Knj:Izdavac_knjige) ! Field Knj:Izdavac_knjige is a hot field or requires assignment from browse
  BRW9.AddField(Knj:Autor_knjige,BRW9.Q.Knj:Autor_knjige)  ! Field Knj:Autor_knjige is a hot field or requires assignment from browse
  BRW9.AddField(Knj:Opis_knjige,BRW9.Q.Knj:Opis_knjige)    ! Field Knj:Opis_knjige is a hot field or requires assignment from browse
  BRW9.AddField(Nar:ID_Knjige,BRW9.Q.Nar:ID_Knjige)        ! Field Nar:ID_Knjige is a hot field or requires assignment from browse
  BRW9.AddField(Nar:ID_prodavaca,BRW9.Q.Nar:ID_prodavaca)  ! Field Nar:ID_prodavaca is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisProdavaca',BrowseWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeProdavaca
  BRW7.AskProcedure = 2                                    ! Will call: AzuriranjeProdaje
  BRW9.AskProcedure = 3                                    ! Will call: AzuriranjeNarucivanja
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW7.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW9.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  BRW1::SortHeader.UseSortColors = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Narucuje.Close()
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisProdavaca',BrowseWindow)           ! Save window data to non-volatile store
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
    EXECUTE Number
      AzuriranjeProdavaca
      AzuriranjeProdaje
      AzuriranjeNarucivanja
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


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
    OF ?Change
      ThisWindow.Update()
      IF GLO:LoggedIn=FALSE
      	HIDE(?Change)
      END
    OF ?Insert:3
      ThisWindow.Update()
      MESSAGE('Knjiga je u narudzbi!')
      UNHIDE(?Change)
      DISABLE(?Change)
      IF PotrebneKnjige=0
      	IF Pro:Rang<5
      		MESSAGE('Cestitamo! Ostvarili ste promaknuce!|Stisnite gumb Rankup ispod tablice prodavaca')
      		Enable(?Change)
      		UNHIDE(?Change)
      		PotrebneKnjige=10
      	ELSE
      		MESSAGE('Vec ste dosegnuli maksimalan rang!')
      	END
      END
      
      DISPLAY()
    OF ?BUTTON1
      ThisWindow.Update()
      MESSAGE('Knjiga je uspjesno narucena!')
      NaruceneKnjige=NaruceneKnjige+1
      PotrebneKnjige=PotrebneKnjige-1
      UNHIDE(?Change)
      DISABLE(?Change)
      IF PotrebneKnjige=0
      	IF Pro:Rang<5
      		MESSAGE('Cestitamo! Ostvarili ste promaknuce!|Stisnite gumb Rankup ispod tablice prodavaca')
      		Enable(?Change)
      		UNHIDE(?Change)
      		PotrebneKnjige=10
      	ELSE
      		MESSAGE('Vec ste dosegnuli maksimalan rang!')
      	END
      END
      
      DISPLAY()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?List
    CASE EVENT()
    OF EVENT:Selecting
      DISABLE(?Change)
      PotrebneKnjige = 10-NaruceneKnjige
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNewSelection PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE FIELD()
    OF ?List
      DISABLE(?Change)
      PotrebneKnjige = 10-NaruceneKnjige
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?List
      DISABLE(?Change)
      PotrebneKnjige = 10-NaruceneKnjige
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
    OF ?List
      DISABLE(?Change)
      PotrebneKnjige = 10-NaruceneKnjige
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      BrowseWindow{PROP:StatusText,2} = FORMAT(CLOCK(),@T1)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:NaruceneKnjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextAlign', 'right')


Web:List.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraBoolProperty('WrapText', true)
  SELF.SetExtraBoolProperty('responsive', false)


Web:List:2.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraBoolProperty('WrapText', true)
  SELF.SetExtraBoolProperty('responsive', false)


Web:List:3.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraBoolProperty('WrapText', true)
  SELF.SetExtraBoolProperty('responsive', false)


Web:PotrebneKnjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextAlign', 'right')


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
  Web:NaruceneKnjige.Init(?NaruceneKnjige, FEQ:Unknown)
  SELF.AddControl(Web:NaruceneKnjige)
  Web:List.Init(?List, FEQ:Unknown)
  SELF.AddControl(Web:List)
  Web:List:2.Init(?List:2, FEQ:Unknown)
  SELF.AddControl(Web:List:2)
  Web:List:3.Init(?List:3, FEQ:Unknown)
  SELF.AddControl(Web:List:3)
  Web:PotrebneKnjige.Init(?PotrebneKnjige, FEQ:Unknown)
  SELF.AddControl(Web:PotrebneKnjige)
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


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


BRW7.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW9.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


BRW9.ResetFromView PROCEDURE

NaruceneKnjige:Cnt   LONG                                  ! Count variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:Narucuje.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    NaruceneKnjige:Cnt += 1
  END
  SELF.View{PROP:IPRequestCount} = 0
  NaruceneKnjige = NaruceneKnjige:Cnt
  PARENT.ResetFromView
  Relate:Narucuje.SetQuickScan(0)
  SETCURSOR()


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisKnjiga PROCEDURE 

BRW1::View:Browse    VIEW(Knjiga)
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
BRW7::View:Browse    VIEW(Pripada)
                       PROJECT(Pri:ID_zanra)
                       PROJECT(Pri:ID_Knjige)
                       JOIN(Zan:PK_Zanr_ID_zanra,Pri:ID_zanra)
                         PROJECT(Zan:Naziv_zanra)
                         PROJECT(Zan:ID_zanra)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
Pri:ID_zanra           LIKE(Pri:ID_zanra)             !List box control field - type derived from field
Zan:Naziv_zanra        LIKE(Zan:Naziv_zanra)          !List box control field - type derived from field
Pri:ID_Knjige          LIKE(Pri:ID_Knjige)            !Primary key field - type derived from field
Zan:ID_zanra           LIKE(Zan:ID_zanra)             !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
BrowseWindow         WINDOW('Popis Knjiga u sustavu'),AT(0,0,476,231),GRAY,MDI,SYSTEM,WALLPAPER('knj2.jpg')
                       LIST,AT(5,5,458,92),USE(?List),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),GRID(0060A4F4h), |
  FORMAT('76L(2)|M~ID Knjige~C(0)@s19@200L(2)|M~Naziv knjige~C(0)@s50@60L(2)|M~Cijena k' & |
  'njige~C(1)@n-14@160L(2)|M~Izdavac knjige~C(0)@s40@200L(2)|M~Autor knjige~C(0)@s50@10' & |
  '16L(2)|M~Opis knjige~C(0)@s254@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Insert'),AT(4,100,40,12),USE(?Insert),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(48,100,40,12),USE(?Change),FONT('Segoe Print',10),COLOR(0060A4F4h),DEFAULT
                       BUTTON('&Delete'),AT(90,100,40,12),USE(?Delete),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Select'),AT(134,100,40,12),USE(?Select),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('Close'),AT(424,196,40,12),USE(?Close),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       LIST,AT(5,134,162,58),USE(?List:2),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),FORMAT('76L(2)|M~I' & |
  'D zanra~C(0)@s19@156L(2)|M~Naziv zanra~C(0)@s39@'),FROM(Queue:Browse:1),IMM
                       STRING('Zanr kojem pripada knjiga'),AT(4,116),USE(?STRING1),FONT('Segoe Print',10,,FONT:bold)
                       BUTTON('&Insert'),AT(4,196,42,12),USE(?Insert:2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(49,196,42,12),USE(?Change:2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Delete'),AT(94,196,42,12),USE(?Delete:2),FONT('Segoe Print',10),COLOR(0060A4F4h)
                     END
Web:CurFrame         &WbFrameClass

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
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

Web:List:2           CLASS(WbListControlHtmlProperties)    ! Web Control Manager for ?List:2
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

WebWindowProperty    CLASS(WbWindowHtmlProperties)
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
GetSkeletonAttr        PROCEDURE(SIGNED whichAttr),STRING,DERIVED
                     END

BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW7                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW7::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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
  IF NOT INRANGE(BrowseWindow{PROP:Timer},1,100)
    BrowseWindow{PROP:Timer} = 100
  END
    BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    BrowseWindow{PROP:StatusText,2} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisKnjiga')
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
  Relate:Knjiga.SetOpenRelated()
  Relate:Knjiga.Open()                                     ! File Knjiga used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:Knjiga,SELF) ! Initialize the browse manager
  BRW7.Init(?List:2,Queue:Browse:1.ViewPosition,BRW7::View:Browse,Queue:Browse:1,Relate:Pripada,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PopisKnjiga)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,Knj:PK_Knjiga_ID_Knjige)              ! Add the sort order for Knj:PK_Knjiga_ID_Knjige for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Knj:ID_Knjige,1,BRW1)          ! Initialize the browse locator using  using key: Knj:PK_Knjiga_ID_Knjige , Knj:ID_Knjige
  BRW1.AddField(Knj:ID_Knjige,BRW1.Q.Knj:ID_Knjige)        ! Field Knj:ID_Knjige is a hot field or requires assignment from browse
  BRW1.AddField(Knj:Naziv_knjige,BRW1.Q.Knj:Naziv_knjige)  ! Field Knj:Naziv_knjige is a hot field or requires assignment from browse
  BRW1.AddField(Knj:Cijena_knjige,BRW1.Q.Knj:Cijena_knjige) ! Field Knj:Cijena_knjige is a hot field or requires assignment from browse
  BRW1.AddField(Knj:Izdavac_knjige,BRW1.Q.Knj:Izdavac_knjige) ! Field Knj:Izdavac_knjige is a hot field or requires assignment from browse
  BRW1.AddField(Knj:Autor_knjige,BRW1.Q.Knj:Autor_knjige)  ! Field Knj:Autor_knjige is a hot field or requires assignment from browse
  BRW1.AddField(Knj:Opis_knjige,BRW1.Q.Knj:Opis_knjige)    ! Field Knj:Opis_knjige is a hot field or requires assignment from browse
  BRW7.Q &= Queue:Browse:1
  BRW7.AddSortOrder(,Pri:PK_Pripada_ID_Knjige_ID_zanra)    ! Add the sort order for Pri:PK_Pripada_ID_Knjige_ID_zanra for sort order 1
  BRW7.AddRange(Pri:ID_Knjige,Relate:Pripada,Relate:Knjiga) ! Add file relationship range limit for sort order 1
  BRW7.AddLocator(BRW7::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW7::Sort0:Locator.Init(,Pri:ID_zanra,1,BRW7)           ! Initialize the browse locator using  using key: Pri:PK_Pripada_ID_Knjige_ID_zanra , Pri:ID_zanra
  BRW7.AddField(Pri:ID_zanra,BRW7.Q.Pri:ID_zanra)          ! Field Pri:ID_zanra is a hot field or requires assignment from browse
  BRW7.AddField(Zan:Naziv_zanra,BRW7.Q.Zan:Naziv_zanra)    ! Field Zan:Naziv_zanra is a hot field or requires assignment from browse
  BRW7.AddField(Pri:ID_Knjige,BRW7.Q.Pri:ID_Knjige)        ! Field Pri:ID_Knjige is a hot field or requires assignment from browse
  BRW7.AddField(Zan:ID_zanra,BRW7.Q.Zan:ID_zanra)          ! Field Zan:ID_zanra is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisKnjiga',BrowseWindow)                 ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeKnjiga
  BRW7.AskProcedure = 2                                    ! Will call: AzuriranjePripadanja
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW7.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  BRW1::SortHeader.UseSortColors = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Knjiga.Close()
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisKnjiga',BrowseWindow)              ! Save window data to non-volatile store
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
    EXECUTE Number
      AzuriranjeKnjiga
      AzuriranjePripadanja
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      BrowseWindow{PROP:StatusText,2} = FORMAT(CLOCK(),@T1)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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


Web:List:2.Init PROCEDURE(SIGNED Feq,SIGNED Container)

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
  Web:List.Init(?List, FEQ:Unknown)
  SELF.AddControl(Web:List)
  Web:Change.Init(?Change, FEQ:Unknown)
  SELF.AddControl(Web:Change)
  Web:List:2.Init(?List:2, FEQ:Unknown)
  SELF.AddControl(Web:List:2)
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


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


BRW7.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisRangova PROCEDURE 

BRW1::View:Browse    VIEW(Rang)
                       PROJECT(Ran:ID_ranga)
                       PROJECT(Ran:Naziv_ranga)
                       PROJECT(Ran:Popust)
                       PROJECT(Ran:Opis_ranga)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Ran:ID_ranga           LIKE(Ran:ID_ranga)             !List box control field - type derived from field
Ran:Naziv_ranga        LIKE(Ran:Naziv_ranga)          !List box control field - type derived from field
Ran:Popust             LIKE(Ran:Popust)               !List box control field - type derived from field
Ran:Opis_ranga         LIKE(Ran:Opis_ranga)           !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
BrowseWindow         WINDOW('Popis rangova'),AT(0,0,487,268),GRAY,MDI,SYSTEM,WALLPAPER('knj2.jpg')
                       LIST,AT(5,5,458,189),USE(?List),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh),GRID(0060A4F4h), |
  FORMAT('76C(2)|M~ID ranga~C(0)@s19@132C(2)|M~Naziv ranga~C(0)@s40@100C(2)|M~Popust~C(' & |
  '0)@s25@700C(2)|M~Opis ranga~C(0)@s254@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Insert'),AT(17,218,40,12),USE(?Insert),FONT('Segoe Print'),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(62,218,40,12),USE(?Change),FONT('Segoe Print'),COLOR(0060A4F4h),DEFAULT
                       BUTTON('&Delete'),AT(107,218,40,12),USE(?Delete),FONT('Segoe Print'),COLOR(0060A4F4h)
                       BUTTON('&Select'),AT(157,218,40,12),USE(?Select),FONT('Segoe Print'),COLOR(0060A4F4h)
                       BUTTON('Close'),AT(424,218,40,12),USE(?Close),FONT('Segoe Print'),COLOR(0060A4F4h)
                     END
Web:CurFrame         &WbFrameClass

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
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
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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
  IF NOT INRANGE(BrowseWindow{PROP:Timer},1,100)
    BrowseWindow{PROP:Timer} = 100
  END
    BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisRangova')
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
  Relate:Rang.Open()                                       ! File Rang used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:Rang,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PopisRangova)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,Ran:PK_Rang_ID_Ranga)                 ! Add the sort order for Ran:PK_Rang_ID_Ranga for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Ran:ID_ranga,1,BRW1)           ! Initialize the browse locator using  using key: Ran:PK_Rang_ID_Ranga , Ran:ID_ranga
  BRW1.AddField(Ran:ID_ranga,BRW1.Q.Ran:ID_ranga)          ! Field Ran:ID_ranga is a hot field or requires assignment from browse
  BRW1.AddField(Ran:Naziv_ranga,BRW1.Q.Ran:Naziv_ranga)    ! Field Ran:Naziv_ranga is a hot field or requires assignment from browse
  BRW1.AddField(Ran:Popust,BRW1.Q.Ran:Popust)              ! Field Ran:Popust is a hot field or requires assignment from browse
  BRW1.AddField(Ran:Opis_ranga,BRW1.Q.Ran:Opis_ranga)      ! Field Ran:Opis_ranga is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisRangova',BrowseWindow)                ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeRangova
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  BRW1::SortHeader.UseSortColors = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Rang.Close()
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisRangova',BrowseWindow)             ! Save window data to non-volatile store
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
    AzuriranjeRangova
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisZanrova PROCEDURE 

BRW1::View:Browse    VIEW(Zanr)
                       PROJECT(Zan:ID_zanra)
                       PROJECT(Zan:Naziv_zanra)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Zan:ID_zanra           LIKE(Zan:ID_zanra)             !List box control field - type derived from field
Zan:Naziv_zanra        LIKE(Zan:Naziv_zanra)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
BrowseWindow         WINDOW('Browse Records'),AT(0,0,293,212),GRAY,MDI,SYSTEM,WALLPAPER('knj2.jpg')
                       LIST,AT(5,5,235,100),USE(?List),FONT('Segoe Print'),VSCROLL,COLOR(00ADDEFFh),GRID(0060A4F4h), |
  FORMAT('85C|M~ID zanra~@s19@60C|M~Naziv zanra~@s39@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Insert'),AT(6,186,40,12),USE(?Insert),FONT('Segoe Print'),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(50,186,40,12),USE(?Change),FONT('Segoe Print'),COLOR(0060A4F4h),DEFAULT
                       BUTTON('&Delete'),AT(96,186,40,12),USE(?Delete),FONT('Segoe Print'),COLOR(0060A4F4h)
                       BUTTON('&Select'),AT(146,186,40,12),USE(?Select),FONT('Segoe Print'),COLOR(0060A4F4h)
                       BUTTON('Close'),AT(200,186,40,12),USE(?Close),FONT('Segoe Print'),COLOR(0060A4F4h)
                     END
Web:CurFrame         &WbFrameClass

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
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
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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
  IF NOT INRANGE(BrowseWindow{PROP:Timer},1,100)
    BrowseWindow{PROP:Timer} = 100
  END
    BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisZanrova')
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
  Relate:Zanr.Open()                                       ! File Zanr used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:Zanr,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PopisZanrova)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,Zan:PK_Zanr_ID_zanra)                 ! Add the sort order for Zan:PK_Zanr_ID_zanra for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Zan:ID_zanra,1,BRW1)           ! Initialize the browse locator using  using key: Zan:PK_Zanr_ID_zanra , Zan:ID_zanra
  BRW1.AddField(Zan:ID_zanra,BRW1.Q.Zan:ID_zanra)          ! Field Zan:ID_zanra is a hot field or requires assignment from browse
  BRW1.AddField(Zan:Naziv_zanra,BRW1.Q.Zan:Naziv_zanra)    ! Field Zan:Naziv_zanra is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisZanrova',BrowseWindow)                ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeZanrova
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('PopisZanrova',BrowseWindow)             ! Save window data to non-volatile store
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
    AzuriranjeZanrova
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      BrowseWindow{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D4)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisKlijenata PROCEDURE 

BRW1::View:Browse    VIEW(Kupac)
                       PROJECT(Kup:ID_kupca)
                       PROJECT(Kup:Ime_kupca)
                       PROJECT(Kup:Prezime_kupca)
                       PROJECT(Kup:Ostvaren_popust)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
Kup:ID_kupca           LIKE(Kup:ID_kupca)             !List box control field - type derived from field
Kup:Ime_kupca          LIKE(Kup:Ime_kupca)            !List box control field - type derived from field
Kup:Prezime_kupca      LIKE(Kup:Prezime_kupca)        !List box control field - type derived from field
Kup:Ostvaren_popust    LIKE(Kup:Ostvaren_popust)      !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
PopisKlijenata       WINDOW('Popis Klijenata'),AT(0,0,398,227),FONT('Microsoft Sans Serif',10),GRAY,MDI,SYSTEM, |
  WALLPAPER('knj1.jpg')
                       LIST,AT(5,5,384,168),USE(?List),FONT('Segoe Print',10),HVSCROLL,COLOR(00ADDEFFh,00F5F5F5h), |
  GRID(000B86B8h),FORMAT('60L(2)|M~ID kupca~C(0)@s19@150L(2)|M~Ime kupca~C(0)@s50@150L(' & |
  '2)|M~Prezime kupca~C(0)@s50@70L(2)|M~Ostvaren popust~C(0)@s4@'),FROM(Queue:Browse),IMM, |
  MSG('Browsing Records')
                       BUTTON('&Insert'),AT(6,198,40,12),USE(?Insert),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Change'),AT(50,198,40,12),USE(?Change),FONT('Segoe Print',10),COLOR(0060A4F4h),DEFAULT
                       BUTTON('&Delete'),AT(92,198,40,12),USE(?Delete),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('&Select'),AT(136,198,40,12),USE(?Select),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       BUTTON('Close'),AT(350,198,40,12),USE(?Close),FONT('Segoe Print',10),COLOR(0060A4F4h)
                     END
Web:CurFrame         &WbFrameClass

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
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
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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
  IF NOT INRANGE(PopisKlijenata{PROP:Timer},1,100)
    PopisKlijenata{PROP:Timer} = 100
  END
    PopisKlijenata{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    PopisKlijenata{PROP:StatusText,2} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisKlijenata')
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
  Relate:Kupac.SetOpenRelated()
  Relate:Kupac.Open()                                      ! File Kupac used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:Kupac,SELF) ! Initialize the browse manager
  SELF.Open(PopisKlijenata)                                ! Open window
  Do DefineListboxStyle
  IF (WebServer.IsEnabled())
    WebWindow.Init()
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (PopisKlijenata)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,Kup:PK_Kupac_ID_kupca)                ! Add the sort order for Kup:PK_Kupac_ID_kupca for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Kup:ID_kupca,1,BRW1)           ! Initialize the browse locator using  using key: Kup:PK_Kupac_ID_kupca , Kup:ID_kupca
  BRW1.AddField(Kup:ID_kupca,BRW1.Q.Kup:ID_kupca)          ! Field Kup:ID_kupca is a hot field or requires assignment from browse
  BRW1.AddField(Kup:Ime_kupca,BRW1.Q.Kup:Ime_kupca)        ! Field Kup:Ime_kupca is a hot field or requires assignment from browse
  BRW1.AddField(Kup:Prezime_kupca,BRW1.Q.Kup:Prezime_kupca) ! Field Kup:Prezime_kupca is a hot field or requires assignment from browse
  BRW1.AddField(Kup:Ostvaren_popust,BRW1.Q.Kup:Ostvaren_popust) ! Field Kup:Ostvaren_popust is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisKlijenata',PopisKlijenata)            ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeKlijenata
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  BRW1::SortHeader.UseSortColors = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Kupac.Close()
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisKlijenata',PopisKlijenata)         ! Save window data to non-volatile store
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
    AzuriranjeKlijenata
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      PopisKlijenata{Prop:StatusText,1} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      PopisKlijenata{PROP:StatusText,2} = FORMAT(CLOCK(),@T1)
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeKlijenata PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::Kup:Record  LIKE(Kup:RECORD),THREAD
FormWindow           WINDOW('Azuriranje klijenata'),AT(,,247,103),CENTER,GRAY,MDI,SYSTEM
                       PROMPT(' ID kupca:'),AT(5,10),USE(?Kup:ID_kupca:Prompt),FONT('Segoe Print',10,COLOR:Black, |
  ,CHARSET:EASTEUROPE),COLOR(00ADDEFFh)
                       ENTRY(@s19),AT(42,10,60,13),USE(Kup:ID_kupca),REQ
                       PROMPT(' Ime kupca:'),AT(5,28,40),USE(?Kup:Ime_kupca:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s50),AT(48,28,60,13),USE(Kup:Ime_kupca),REQ
                       PROMPT(' Prezime kupca:'),AT(5,46),USE(?Kup:Prezime_kupca:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s50),AT(62,46,60,13),USE(Kup:Prezime_kupca),REQ
                       CHECK(' Ostvaren popust:'),AT(134,10),USE(Kup:Ostvaren_popust),FONT('Segoe Print',10),COLOR(00ADDEFFh), |
  VALUE('Da','Ne')
                       BUTTON('OK'),AT(5,77,40,12),USE(?OK),FONT('Segoe Print',10),COLOR(0060A4F4h),DEFAULT,REQ
                       BUTTON('Cancel'),AT(55,77,40,12),USE(?Cancel),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       STRING(@S40),AT(102,79),USE(ActionMessage),COLOR(00ADDEFFh)
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

Web:Kup:ID_kupca:Prompt CLASS(WbControlHtmlProperties)     ! Web Control Manager for ?Kup:ID_kupca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Kup:ID_kupca     CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Kup:ID_kupca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Kup:Ime_kupca:Prompt CLASS(WbControlHtmlProperties)    ! Web Control Manager for ?Kup:Ime_kupca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Kup:Ime_kupca    CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Kup:Ime_kupca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Kup:Prezime_kupca:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Kup:Prezime_kupca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Kup:Prezime_kupca CLASS(WbControlHtmlProperties)       ! Web Control Manager for ?Kup:Prezime_kupca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Kup:Ostvaren_popust CLASS(WbControlHtmlProperties)     ! Web Control Manager for ?Kup:Ostvaren_popust
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:OK               CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?OK
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
  GlobalErrors.SetProcedureName('AzuriranjeKlijenata')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Kup:ID_kupca:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Kup:Record,History::Kup:Record)
  SELF.AddHistoryField(?Kup:ID_kupca,1)
  SELF.AddHistoryField(?Kup:Ime_kupca,2)
  SELF.AddHistoryField(?Kup:Prezime_kupca,3)
  SELF.AddHistoryField(?Kup:Ostvaren_popust,4)
  SELF.AddUpdateFile(Access:Kupac)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Kupac.SetOpenRelated()
  Relate:Kupac.Open()                                      ! File Kupac used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Kupac
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
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeKlijenata)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AzuriranjeKlijenata',FormWindow)           ! Restore window settings from non-volatile store
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
    Relate:Kupac.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeKlijenata',FormWindow)        ! Save window data to non-volatile store
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
      IF Kup:ID_kupca = '' THEN
          MESSAGE('Niste odabrali ID kupca!')
          DISPLAY()
      END
      
      IF Kup:Ime_kupca = '' THEN
          MESSAGE('Niste odabrali ime kupca!')
          DISPLAY()
      END
      
      
      IF Kup:Prezime_kupca = '' THEN
          MESSAGE('Niste odabrali prezime kupca!')
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


Web:Kup:ID_kupca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Kup:Ime_kupca:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Kup:Ime_kupca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


Web:Kup:Prezime_kupca:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Kup:Prezime_kupca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


Web:Kup:Ostvaren_popust.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


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
  Web:Kup:ID_kupca:Prompt.Init(?Kup:ID_kupca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Kup:ID_kupca:Prompt)
  Web:Kup:ID_kupca.Init(?Kup:ID_kupca, FEQ:Unknown)
  SELF.AddControl(Web:Kup:ID_kupca)
  Web:Kup:Ime_kupca:Prompt.Init(?Kup:Ime_kupca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Kup:Ime_kupca:Prompt)
  Web:Kup:Ime_kupca.Init(?Kup:Ime_kupca, FEQ:Unknown)
  SELF.AddControl(Web:Kup:Ime_kupca)
  Web:Kup:Prezime_kupca:Prompt.Init(?Kup:Prezime_kupca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Kup:Prezime_kupca:Prompt)
  Web:Kup:Prezime_kupca.Init(?Kup:Prezime_kupca, FEQ:Unknown)
  SELF.AddControl(Web:Kup:Prezime_kupca)
  Web:Kup:Ostvaren_popust.Init(?Kup:Ostvaren_popust, FEQ:Unknown)
  SELF.AddControl(Web:Kup:Ostvaren_popust)
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
AzuriranjeKnjiga PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::Knj:Record  LIKE(Knj:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o knjigama'),AT(,,246,225),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('Cancel'),AT(44,212,40,12),USE(?Cancel),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       STRING(@S40),AT(88,214),USE(ActionMessage),COLOR(00ADDEFFh)
                       PROMPT(' ID :'),AT(8,8,18),USE(?Knj:ID_Knjige:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s19),AT(58,8,74,13),USE(Knj:ID_Knjige),REQ
                       PROMPT(' Naziv :'),AT(8,32,29),USE(?Knj:Naziv_knjige:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s50),AT(58,32,74,13),USE(Knj:Naziv_knjige),REQ
                       PROMPT(' Cijena :'),AT(8,49,29),USE(?Knj:Cijena_knjige:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@n-14),AT(58,50,74,13),USE(Knj:Cijena_knjige),RIGHT(1),REQ
                       PROMPT(' Izdavac :'),AT(8,70,37),USE(?Knj:Izdavac_knjige:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s40),AT(58,70,74,13),USE(Knj:Izdavac_knjige),REQ
                       PROMPT(' Autor :'),AT(8,90,29),USE(?Knj:Autor_knjige:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s50),AT(58,90,74,13),USE(Knj:Autor_knjige),REQ
                       PROMPT(' Opis :'),AT(8,110,24),USE(?Knj:Opis_knjige:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s254),AT(8,128,213,73),USE(Knj:Opis_knjige)
                       BUTTON('OK'),AT(2,212,40,12),USE(?OK),FONT('Segoe Print',10),COLOR(0060A4F4h),DEFAULT,REQ
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

Web:Knj:ID_Knjige:Prompt CLASS(WbControlHtmlProperties)    ! Web Control Manager for ?Knj:ID_Knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Knj:ID_Knjige    CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Knj:ID_Knjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Knj:Naziv_knjige:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Knj:Naziv_knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Knj:Naziv_knjige CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Knj:Naziv_knjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Knj:Cijena_knjige:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Knj:Cijena_knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Knj:Cijena_knjige CLASS(WbControlHtmlProperties)       ! Web Control Manager for ?Knj:Cijena_knjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Knj:Izdavac_knjige:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Knj:Izdavac_knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Knj:Izdavac_knjige CLASS(WbControlHtmlProperties)      ! Web Control Manager for ?Knj:Izdavac_knjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Knj:Autor_knjige:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Knj:Autor_knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Knj:Autor_knjige CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Knj:Autor_knjige
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Knj:Opis_knjige:Prompt CLASS(WbControlHtmlProperties)  ! Web Control Manager for ?Knj:Opis_knjige:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Knj:Opis_knjige  CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Knj:Opis_knjige
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
  GlobalErrors.SetProcedureName('AzuriranjeKnjiga')
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
  SELF.AddHistoryFile(Knj:Record,History::Knj:Record)
  SELF.AddHistoryField(?Knj:ID_Knjige,1)
  SELF.AddHistoryField(?Knj:Naziv_knjige,2)
  SELF.AddHistoryField(?Knj:Cijena_knjige,3)
  SELF.AddHistoryField(?Knj:Izdavac_knjige,4)
  SELF.AddHistoryField(?Knj:Autor_knjige,5)
  SELF.AddHistoryField(?Knj:Opis_knjige,6)
  SELF.AddUpdateFile(Access:Knjiga)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Knjiga.SetOpenRelated()
  Relate:Knjiga.Open()                                     ! File Knjiga used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Knjiga
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
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeKnjiga)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AzuriranjeKnjiga',FormWindow)              ! Restore window settings from non-volatile store
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
    Relate:Knjiga.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeKnjiga',FormWindow)           ! Save window data to non-volatile store
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
    CASE FIELD()
    OF ?OK
      IF Knj:ID_Knjige = '' THEN
          MESSAGE('Niste odabrali ID knjige!')
          DISPLAY()
      END
      
      IF Knj:Naziv_Knjige = '' THEN
          MESSAGE('Niste odabrali Naziv knjige!')
          DISPLAY()
      END
      
      IF Knj:Cijena_Knjige = '' THEN
          MESSAGE('Niste odabrali Cijenu knjige!')
          DISPLAY()
      END
      
      IF Knj:Izdavac_Knjige = '' THEN
          MESSAGE('Niste odabrali Izdavaca knjige!')
          DISPLAY()
      END
      
      IF Knj:Autor_Knjige = '' THEN
          MESSAGE('Niste odabrali Autora knjige!')
          DISPLAY()
      END
      
    END
  ReturnValue = PARENT.TakeSelected()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:Knj:ID_Knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Knj:ID_Knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Knj:Naziv_knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Knj:Naziv_knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


Web:Knj:Cijena_knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Knj:Cijena_knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextAlign', 'right')
  SELF.SetExtraProperty('InputType','number')
  SELF.SetExtraProperty('ValidationPattern','^[1-9][0-9]*$')!Required can not be zero and must be a num


Web:Knj:Izdavac_knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Knj:Izdavac_knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '40')


Web:Knj:Autor_knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Knj:Autor_knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


Web:Knj:Opis_knjige:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Knj:Opis_knjige.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '255')


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
  Web:Knj:ID_Knjige:Prompt.Init(?Knj:ID_Knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:ID_Knjige:Prompt)
  Web:Knj:ID_Knjige.Init(?Knj:ID_Knjige, FEQ:Unknown)
  SELF.AddControl(Web:Knj:ID_Knjige)
  Web:Knj:Naziv_knjige:Prompt.Init(?Knj:Naziv_knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Naziv_knjige:Prompt)
  Web:Knj:Naziv_knjige.Init(?Knj:Naziv_knjige, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Naziv_knjige)
  Web:Knj:Cijena_knjige:Prompt.Init(?Knj:Cijena_knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Cijena_knjige:Prompt)
  Web:Knj:Cijena_knjige.Init(?Knj:Cijena_knjige, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Cijena_knjige)
  Web:Knj:Izdavac_knjige:Prompt.Init(?Knj:Izdavac_knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Izdavac_knjige:Prompt)
  Web:Knj:Izdavac_knjige.Init(?Knj:Izdavac_knjige, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Izdavac_knjige)
  Web:Knj:Autor_knjige:Prompt.Init(?Knj:Autor_knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Autor_knjige:Prompt)
  Web:Knj:Autor_knjige.Init(?Knj:Autor_knjige, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Autor_knjige)
  Web:Knj:Opis_knjige:Prompt.Init(?Knj:Opis_knjige:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Opis_knjige:Prompt)
  Web:Knj:Opis_knjige.Init(?Knj:Opis_knjige, FEQ:Unknown)
  SELF.AddControl(Web:Knj:Opis_knjige)
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
AzuriranjeProdavaca PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
i                    LONG                                  ! 
Temp                 LONG                                  ! 
History::Pro:Record  LIKE(Pro:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o prodavacu'),AT(,,231,159),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('OK'),AT(5,140,40,12),USE(?OK),FONT('Segoe Print',10),COLOR(0060A4F4h),DEFAULT,REQ
                       BUTTON('Cancel'),AT(50,140,40,12),USE(?Cancel),FONT('Segoe Print',10),COLOR(0060A4F4h)
                       STRING(@S40),AT(95,140),USE(ActionMessage),COLOR(00ADDEFFh)
                       PROMPT('ID prodavaca:'),AT(4,11),USE(?Pro:ID_prodavaca:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s19),AT(56,12,76,14),USE(Pro:ID_prodavaca),REQ
                       PROMPT('Ime :'),AT(4,32),USE(?Pro:Ime_prodavaca:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s50),AT(56,32,110,13),USE(Pro:Ime_prodavaca),REQ
                       PROMPT('Prezime :'),AT(4,50),USE(?Pro:Prezime_prodavaca:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s50),AT(56,50,110,13),USE(Pro:Prezime_prodavaca),REQ
                       PROMPT('Broj telefona:'),AT(4,71),USE(?Pro:Broj_telefona:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@K###-###-###K),AT(56,72,60,13),USE(Pro:Broj_telefona),RIGHT(1),REQ
                       PROMPT('Rang:'),AT(4,89),USE(?Pro:Rang:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@s29),AT(56,90,110,13),USE(Pro:Rang)
                       PROMPT('Email:'),AT(4,105),USE(?Pro:Email:Prompt),FONT('Segoe Print',10),COLOR(00ADDEFFh)
                       ENTRY(@S50),AT(56,108,110,10),USE(Pro:Email),REQ
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

Web:Pro:ID_prodavaca:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Pro:ID_prodavaca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pro:ID_prodavaca CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Pro:ID_prodavaca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Pro:Ime_prodavaca:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Pro:Ime_prodavaca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pro:Ime_prodavaca CLASS(WbControlHtmlProperties)       ! Web Control Manager for ?Pro:Ime_prodavaca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Pro:Prezime_prodavaca:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Pro:Prezime_prodavaca:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pro:Prezime_prodavaca CLASS(WbControlHtmlProperties)   ! Web Control Manager for ?Pro:Prezime_prodavaca
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Pro:Broj_telefona:Prompt CLASS(WbControlHtmlProperties) ! Web Control Manager for ?Pro:Broj_telefona:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pro:Broj_telefona CLASS(WbControlHtmlProperties)       ! Web Control Manager for ?Pro:Broj_telefona
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Pro:Rang:Prompt  CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Pro:Rang:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pro:Rang         CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Pro:Rang
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Pro:Email:Prompt CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Pro:Email:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Pro:Email        CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Pro:Email
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
  GlobalErrors.SetProcedureName('AzuriranjeProdavaca')
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
  SELF.AddHistoryFile(Pro:Record,History::Pro:Record)
  SELF.AddHistoryField(?Pro:ID_prodavaca,1)
  SELF.AddHistoryField(?Pro:Ime_prodavaca,2)
  SELF.AddHistoryField(?Pro:Prezime_prodavaca,3)
  SELF.AddHistoryField(?Pro:Broj_telefona,4)
  SELF.AddHistoryField(?Pro:Rang,5)
  SELF.AddHistoryField(?Pro:Email,6)
  SELF.AddUpdateFile(Access:Prodavac)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Prodavac.Open()                                   ! File Prodavac used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Prodavac
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
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeProdavaca)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  IF GLO:LoggedIn=FALSE
      HIDE(?Pro:ID_prodavaca:Prompt)
      HIDE(?Pro:ID_prodavaca)
      HIDE(?Pro:Ime_prodavaca:Prompt)
      HIDE(?Pro:Ime_prodavaca)
      HIDE(?Pro:Prezime_prodavaca:Prompt)
      HIDE(?Pro:Prezime_prodavaca)
      HIDE(?Pro:Broj_telefona:Prompt)
      HIDE(?Pro:Broj_telefona)
      HIDE(?Pro:Email:Prompt)
      HIDE(?Pro:Email)
      Temp = Pro:Rang
      Pro:Rang = Temp + 1
      DISABLE(?Pro:Rang)
      
      
  ELSE GLO:LoggedIn=TRUE
      UNHIDE(?Pro:ID_prodavaca:Prompt)
      UNHIDE(?Pro:ID_prodavaca)
      UNHIDE(?Pro:Ime_prodavaca:Prompt)
      UNHIDE(?Pro:Ime_prodavaca)
      UNHIDE(?Pro:Prezime_prodavaca:Prompt)
      UNHIDE(?Pro:Prezime_prodavaca)
      UNHIDE(?Pro:Broj_telefona:Prompt)
      UNHIDE(?Pro:Broj_telefona)
      UNHIDE(?Pro:Email:Prompt)
      UNHIDE(?Pro:Email)    
  END
  
      
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AzuriranjeProdavaca',FormWindow)           ! Restore window settings from non-volatile store
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
    Relate:Prodavac.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeProdavaca',FormWindow)        ! Save window data to non-volatile store
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
  Ran:ID_ranga = Pro:Rang                                  ! Assign linking field value
  Access:Rang.Fetch(Ran:PK_Rang_ID_Ranga)
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
    PopisRangova
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
    OF ?Pro:Email
      i=INSTRING('@gmail.com', Pro:Email, 1, 1)
      IF i=0
      	MESSAGE('Krivo ste unijeli email')
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
    OF ?Pro:Rang
      Ran:ID_ranga = Pro:Rang
      IF Access:Rang.TryFetch(Ran:PK_Rang_ID_Ranga)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          Pro:Rang = Ran:ID_ranga
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


Web:Pro:ID_prodavaca:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pro:ID_prodavaca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Pro:Ime_prodavaca:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pro:Ime_prodavaca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


Web:Pro:Prezime_prodavaca:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pro:Prezime_prodavaca.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


Web:Pro:Broj_telefona:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pro:Broj_telefona.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextAlign', 'right')
  SELF.SetExtraProperty('TextLen', '15')


Web:Pro:Rang:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pro:Rang.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Pro:Email:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Pro:Email.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '50')


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
  Web:Pro:ID_prodavaca:Prompt.Init(?Pro:ID_prodavaca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Pro:ID_prodavaca:Prompt)
  Web:Pro:ID_prodavaca.Init(?Pro:ID_prodavaca, FEQ:Unknown)
  SELF.AddControl(Web:Pro:ID_prodavaca)
  Web:Pro:Ime_prodavaca:Prompt.Init(?Pro:Ime_prodavaca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Ime_prodavaca:Prompt)
  Web:Pro:Ime_prodavaca.Init(?Pro:Ime_prodavaca, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Ime_prodavaca)
  Web:Pro:Prezime_prodavaca:Prompt.Init(?Pro:Prezime_prodavaca:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Prezime_prodavaca:Prompt)
  Web:Pro:Prezime_prodavaca.Init(?Pro:Prezime_prodavaca, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Prezime_prodavaca)
  Web:Pro:Broj_telefona:Prompt.Init(?Pro:Broj_telefona:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Broj_telefona:Prompt)
  Web:Pro:Broj_telefona.Init(?Pro:Broj_telefona, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Broj_telefona)
  Web:Pro:Rang:Prompt.Init(?Pro:Rang:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Rang:Prompt)
  Web:Pro:Rang.Init(?Pro:Rang, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Rang)
  Web:Pro:Email:Prompt.Init(?Pro:Email:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Email:Prompt)
  Web:Pro:Email.Init(?Pro:Email, FEQ:Unknown)
  SELF.AddControl(Web:Pro:Email)
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
AzuriranjeRangova PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::Ran:Record  LIKE(Ran:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o rangovima'),AT(,,361,218),CENTER,GRAY,MDI,SYSTEM
                       BUTTON('Cancel'),AT(95,176,40,12),USE(?Cancel),FONT('Segoe Print'),COLOR(0060A4F4h)
                       STRING(@S40),AT(190,176),USE(ActionMessage),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       PROMPT('ID ranga:'),AT(18,10),USE(?Ran:ID_ranga:Prompt),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       ENTRY(@s19),AT(86,10,90,10),USE(Ran:ID_ranga),REQ
                       PROMPT('Naziv ranga:'),AT(18,30),USE(?Ran:Naziv_ranga:Prompt),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       PROMPT('Opis ranga:'),AT(22,52),USE(?Ran:Opis_ranga:Prompt),FONT('Segoe Print'),COLOR(00ADDEFFh)
                       BUTTON('OK'),AT(18,176,40,12),USE(?OK),FONT('Segoe Print'),COLOR(0060A4F4h),DEFAULT,REQ
                       TEXT,AT(86,53,153),USE(Ran:Opis_ranga,,?Ran:Opis_ranga:2)
                       OPTION('Popust:'),AT(249,10,67,79),USE(Ran:Popust),BOXED
                         RADIO('Pocetnik'),AT(256,22),USE(?Ran:Popust:Radio1),VALUE('5')
                         RADIO('Prvostupnik'),AT(256,34),USE(?Ran:Popust:Radio2),VALUE('10')
                         RADIO('Intermediate'),AT(256,46),USE(?Ran:Popust:Radio3),VALUE('15')
                         RADIO('Senior'),AT(256,60),USE(?Ran:Popust:Radio4),VALUE('20')
                         RADIO('Profesionalac'),AT(256,72),USE(?Ran:Popust:Radio5),VALUE('25')
                       END
                       TEXT,AT(86,30,90,13),USE(Ran:Naziv_ranga)
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

Web:Ran:ID_ranga:Prompt CLASS(WbControlHtmlProperties)     ! Web Control Manager for ?Ran:ID_ranga:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Ran:ID_ranga     CLASS(WbControlHtmlProperties)        ! Web Control Manager for ?Ran:ID_ranga
Init                   PROCEDURE(SIGNED Feq,SIGNED Container)
                     END

Web:Ran:Naziv_ranga:Prompt CLASS(WbControlHtmlProperties)  ! Web Control Manager for ?Ran:Naziv_ranga:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
                     END

Web:Ran:Opis_ranga:Prompt CLASS(WbControlHtmlProperties)   ! Web Control Manager for ?Ran:Opis_ranga:Prompt
GetProperty            PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0),*IValue,DERIVED
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
  GlobalErrors.SetProcedureName('AzuriranjeRangova')
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
  SELF.AddHistoryFile(Ran:Record,History::Ran:Record)
  SELF.AddHistoryField(?Ran:ID_ranga,1)
  SELF.AddHistoryField(?Ran:Opis_ranga:2,4)
  SELF.AddHistoryField(?Ran:Popust,3)
  SELF.AddHistoryField(?Ran:Naziv_ranga,2)
  SELF.AddUpdateFile(Access:Rang)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Rang.Open()                                       ! File Rang used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:Rang
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
    WebWindowManager.Init(WebServer, WebWindow.IPageCreator, WebWindow.IWebResponseProcessor, 0{PROP:text} & ' (AzuriranjeRangova)')
    SELF.AddItem(WebWindow.WindowComponent)
    SELF.AddItem(WebWindowManager.WindowComponent)
  END
  INIMgr.Fetch('AzuriranjeRangova',FormWindow)             ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Rang.Close()
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeRangova',FormWindow)          ! Save window data to non-volatile store
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
      IF Ran:ID_ranga = '' THEN
          MESSAGE('Niste odabrali ID ranga!')
          DISPLAY()
      END
      
      IF Ran:Naziv_ranga = '' THEN
          MESSAGE('Niste odabrali Naziv ranga!')
          DISPLAY()
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Web:Ran:ID_ranga:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Ran:ID_ranga.Init PROCEDURE(SIGNED Feq,SIGNED Container)

  CODE
  PARENT.Init(Feq,Container)
  SELF.SetExtraProperty('TextLen', '20')


Web:Ran:Naziv_ranga:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


Web:Ran:Opis_ranga:Prompt.GetProperty PROCEDURE(ASTRING name,unsigned idx1=0,unsigned idx2=0)

ReturnValue          &IValue

  CODE
  IF (name = 'ExtraClassGP')
    RETURN CreateStringValue(' text-left ')
  END
  ReturnValue &= PARENT.GetProperty(name,idx1,idx2)
  RETURN ReturnValue


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
  Web:Ran:ID_ranga:Prompt.Init(?Ran:ID_ranga:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Ran:ID_ranga:Prompt)
  Web:Ran:ID_ranga.Init(?Ran:ID_ranga, FEQ:Unknown)
  SELF.AddControl(Web:Ran:ID_ranga)
  Web:Ran:Naziv_ranga:Prompt.Init(?Ran:Naziv_ranga:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Ran:Naziv_ranga:Prompt)
  Web:Ran:Opis_ranga:Prompt.Init(?Ran:Opis_ranga:Prompt, FEQ:Unknown)
  SELF.AddControl(Web:Ran:Opis_ranga:Prompt)
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

