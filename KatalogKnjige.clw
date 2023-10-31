   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABLSYM.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('LAYBUILD.INT'),ONCE
   INCLUDE('LAYHTML.INT'),ONCE
   INCLUDE('WBFILE.INC'),ONCE
   INCLUDE('WBFILE.INC'),ONCE
   INCLUDE('WBFRAME.INC'),ONCE
   INCLUDE('WBSTD.EQU'),ONCE
   INCLUDE('WBSTD.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('WBBROKER.INC'),ONCE
   INCLUDE('WBFILES.INC'),ONCE
   INCLUDE('WBHTML.INC'),ONCE
   INCLUDE('WBSERVER.INC'),ONCE
   INCLUDE('AnyScreen.INC'),ONCE

   MAP
     MODULE('KATALOGKNJIGE_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('KATALOGKNJIGE001.CLW')
PocetniEkran           PROCEDURE   !
     END
     Web:Initialise()
   END

GLO:LoggedIn         BYTE
GLO:MainThreadID     SIGNED
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
Knjiga               FILE,DRIVER('TOPSPEED'),PRE(Knj),CREATE,BINDABLE,THREAD !                     
SK_Knjiga_Autor_knjige   KEY(Knj:Autor_knjige),DUP,NOCASE  !                     
PK_Knjiga_ID_Knjige      KEY(Knj:ID_Knjige),NOCASE,PRIMARY !                     
SK_Knjiga_Naziv_Knjige   KEY(Knj:Naziv_knjige),DUP,NOCASE  !                     
SK_Knjiga_Cijena_knjige  KEY(Knj:Cijena_knjige),DUP,NOCASE !                     
SK_Knjiga_Izdavac_knjige KEY(Knj:Izdavac_knjige),DUP,NOCASE !                     
Record                   RECORD,PRE()
ID_Knjige                   CSTRING(20)                    !                     
Naziv_knjige                STRING(50)                     !                     
Cijena_knjige               LONG                           !                     
Izdavac_knjige              STRING(40)                     !                     
Autor_knjige                STRING(50)                     !                     
Opis_knjige                 CSTRING(255)                   !                     
                         END
                     END                       

Rang                 FILE,DRIVER('TOPSPEED'),PRE(Ran),CREATE,BINDABLE,THREAD !                     
PK_Rang_ID_Ranga         KEY(Ran:ID_ranga),NOCASE,PRIMARY  !                     
SK_Rang_Naziv_ranga      KEY(Ran:Naziv_ranga),DUP,NOCASE   !                     
SK_Rang_Popust           KEY(Ran:Popust),DUP,NOCASE        !                     
Record                   RECORD,PRE()
ID_ranga                    CSTRING(20)                    !                     
Naziv_ranga                 STRING(40)                     !                     
Popust                      CSTRING(26)                    !                     
Opis_ranga                  CSTRING(255)                   !                     
                         END
                     END                       

Prodavac             FILE,DRIVER('TOPSPEED'),PRE(Pro),CREATE,BINDABLE,THREAD !                     
PK_Prodavac_ID_prodavaca KEY(Pro:ID_prodavaca),NOCASE,PRIMARY !                     
VK_ProdavacRang_Rang     KEY(Pro:Rang),DUP,NOCASE          !                     
SK_Prodavac_Ime_prodavaca KEY(Pro:Ime_prodavaca),DUP,NOCASE !                     
SK_Prodavac_Prezime_prodavaca KEY(Pro:Prezime_prodavaca),DUP,NOCASE !                     
SK_Prodavac_Broj_telefona KEY(Pro:Broj_telefona),DUP,NOCASE !                     
SK_Prodavac_Email        KEY(Pro:Email),DUP,NOCASE         !                     
Record                   RECORD,PRE()
ID_prodavaca                CSTRING(20)                    !                     
Ime_prodavaca               STRING(50)                     !                     
Prezime_prodavaca           STRING(50)                     !                     
Broj_telefona               CSTRING(15)                    !                     
Rang                        CSTRING(20)                    !                     
Email                       CSTRING(50)                    !                     
                         END
                     END                       

Kupac                FILE,DRIVER('TOPSPEED'),PRE(Kup),CREATE,BINDABLE,THREAD !                     
PK_Kupac_ID_kupca        KEY(Kup:ID_kupca),NOCASE,PRIMARY  !                     
SK_Kupac_Ime_kupca       KEY(Kup:Ime_kupca),DUP,NOCASE     !                     
SK_Kupac_Prezime_kupca   KEY(Kup:Prezime_kupca),DUP,NOCASE !                     
SK_Kupac_Ostvaren_popust KEY(Kup:Ostvaren_popust),DUP,NOCASE !                     
Record                   RECORD,PRE()
ID_kupca                    CSTRING(20)                    !                     
Ime_kupca                   STRING(50)                     !                     
Prezime_kupca               STRING(50)                     !                     
Ostvaren_popust             CSTRING(5)                     !                     
                         END
                     END                       

Zanr                 FILE,DRIVER('TOPSPEED'),PRE(Zan),CREATE,BINDABLE,THREAD !                     
PK_Zanr_ID_zanra         KEY(Zan:ID_zanra),NOCASE,PRIMARY  !                     
SK_Zanr_Naziv_Zanra      KEY(Zan:Naziv_zanra),DUP,NOCASE   !                     
Record                   RECORD,PRE()
ID_zanra                    CSTRING(20)                    !                     
Naziv_zanra                 CSTRING(40)                    !                     
                         END
                     END                       

Narucuje             FILE,DRIVER('TOPSPEED'),PRE(Nar),CREATE,BINDABLE,THREAD !                     
PK_Narucuje_ID_Knjige_ID_prodavaca KEY(Nar:ID_Knjige,Nar:ID_prodavaca),NOCASE,PRIMARY !                     
RK_Narucuje_ID_prodavaca_ID_Knjige KEY(Nar:ID_prodavaca,Nar:ID_Knjige),NOCASE !                     
Record                   RECORD,PRE()
ID_Knjige                   CSTRING(20)                    !                     
ID_prodavaca                CSTRING(20)                    !                     
                         END
                     END                       

Prodaje              FILE,DRIVER('TOPSPEED'),PRE(Prd),CREATE,BINDABLE,THREAD ! Racun za kupca      
PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna KEY(Prd:ID_prodavaca,Prd:ID_kupca),NOCASE,PRIMARY !                     
RK_Prodaje_ID_kupca_ID_prodavaca_Broj_racuna KEY(Prd:ID_kupca,Prd:ID_prodavaca),NOCASE !                     
SK_Prodaje_Datum_prodaje KEY(Prd:Datum_prodaje),DUP,NOCASE !                     
SK_Prodaje_Nacin_placanja KEY(Prd:Nacin_placanja),DUP,NOCASE !                     
Record                   RECORD,PRE()
ID_prodavaca                CSTRING(20)                    !                     
ID_kupca                    CSTRING(20)                    !                     
Datum_prodaje               CSTRING(20)                    !                     
Nacin_placanja              CSTRING(30)                    !                     
Broj_racuna                 CSTRING(20)                    !                     
                         END
                     END                       

Pripada              FILE,DRIVER('TOPSPEED'),PRE(Pri),CREATE,BINDABLE,THREAD !                     
PK_Pripada_ID_Knjige_ID_zanra KEY(Pri:ID_Knjige,Pri:ID_zanra),NOCASE,PRIMARY !                     
RK_Pripada_ID_zanra_ID_Knjige KEY(Pri:ID_zanra,Pri:ID_Knjige),NOCASE !                     
Record                   RECORD,PRE()
ID_zanra                    CSTRING(20)                    !                     
ID_Knjige                   CSTRING(20)                    !                     
                         END
                     END                       

PI_POMOCNA           FILE,DRIVER('TOPSPEED'),PRE(POM),CREATE,BINDABLE,THREAD !                     
Record                   RECORD,PRE()
pomoc1                      CSTRING(255)                   !                     
pomoc2                      CSTRING(255)                   !                     
pomoc3                      CSTRING(255)                   !                     
pomoc4                      CSTRING(255)                   !                     
pomoc5                      CSTRING(255)                   !                     
pomoc6                      CSTRING(255)                   !                     
pomoc7                      CSTRING(255)                   !                     
pomoc8                      CSTRING(255)                   !                     
pomoc9                      CSTRING(255)                   !                     
pomoc10                     CSTRING(255)                   !                     
                         END
                     END                       

ULAZ                 FILE,DRIVER('TOPSPEED'),PRE(ULZ),CREATE,BINDABLE,THREAD !                     
KEY_ID                   KEY(ULZ:ID),NOCASE,OPT,PRIMARY    !                     
Key_Korisnicko           KEY(ULZ:Korisnicko_Ime),DUP,NOCASE,OPT !                     
Record                   RECORD,PRE()
ID                          LONG                           !                     
Korisnicko_Ime              STRING(20)                     !                     
Lozinka                     STRING(20)                     !                     
                         END
                     END                       

!endregion

Broker               WbBrokerClass                         ! Application broker
HtmlManager          WbHtmlClass
WebServer            WbServerClass
WebFilesManager      WbFilesClass
ShutDownManager      CLASS(WbShutDownClass)
Close                  PROCEDURE(),DERIVED
                     END

WebFileAccess        WbFileProperties
Access:Knjiga        &FileManager,THREAD                   ! FileManager for Knjiga
Relate:Knjiga        &RelationManager,THREAD               ! RelationManager for Knjiga

WebTableProperties:Knjiga WbTableProperties

Access:Rang          &FileManager,THREAD                   ! FileManager for Rang
Relate:Rang          &RelationManager,THREAD               ! RelationManager for Rang

WebTableProperties:Rang WbTableProperties

Access:Prodavac      &FileManager,THREAD                   ! FileManager for Prodavac
Relate:Prodavac      &RelationManager,THREAD               ! RelationManager for Prodavac

WebTableProperties:Prodavac WbTableProperties

Access:Kupac         &FileManager,THREAD                   ! FileManager for Kupac
Relate:Kupac         &RelationManager,THREAD               ! RelationManager for Kupac

WebTableProperties:Kupac WbTableProperties

Access:Zanr          &FileManager,THREAD                   ! FileManager for Zanr
Relate:Zanr          &RelationManager,THREAD               ! RelationManager for Zanr

WebTableProperties:Zanr WbTableProperties

Access:Narucuje      &FileManager,THREAD                   ! FileManager for Narucuje
Relate:Narucuje      &RelationManager,THREAD               ! RelationManager for Narucuje

WebTableProperties:Narucuje WbTableProperties

Access:Prodaje       &FileManager,THREAD                   ! FileManager for Prodaje
Relate:Prodaje       &RelationManager,THREAD               ! RelationManager for Prodaje

WebTableProperties:Prodaje WbTableProperties

Access:Pripada       &FileManager,THREAD                   ! FileManager for Pripada
Relate:Pripada       &RelationManager,THREAD               ! RelationManager for Pripada

WebTableProperties:Pripada WbTableProperties

Access:PI_POMOCNA    &FileManager,THREAD                   ! FileManager for PI_POMOCNA
Relate:PI_POMOCNA    &RelationManager,THREAD               ! RelationManager for PI_POMOCNA

WebTableProperties:PI_POMOCNA WbTableProperties

Access:ULAZ          &FileManager,THREAD                   ! FileManager for ULAZ
Relate:ULAZ          &RelationManager,THREAD               ! RelationManager for ULAZ

WebTableProperties:ULAZ WbTableProperties


FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\KatalogKnjige.INI', NVD_INI)              ! Configure INIManager to use INI file
  DctInit()
  ! Starting AnyScreen
  AnyScreen:Init()
  Web:Initialise()
  PocetniEkran
  INIMgr.Update
  AnyScreen:Kill()
  WebServer.Halt()
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher
    
Web:Initialise          PROCEDURE()
  CODE
  SetWebActiveFrame()
  WebFilesManager.Init(True, '')
  WebFilesManager.SetIconsSupport(2)
  WebFilesManager.SetIconsWidth(18)
  WbFilesClass::Set(WebFilesManager)
  Broker.Init('KatalogKnjige', WebFilesManager)
  SetSkeletonTheme('bootstrap')
  IF (Broker.GetEnabled())
    IF (IC:GetEnvironmentVariable('WEBPLATE'))
      AddSkeletonDirectory(IC:GetEnvironmentVariable('WEBPLATE'))
    END
    AddSkeletonDirectory(GetServerSkeletonsDirectory())
  END
  WbBrowserProperties.Init(Broker)
  RegisterGlobalProperties('Browser',WbBrowserProperties.IProperties)
  HtmlManager.Init(WebFilesManager)
  WebServer.Init(Broker, ShutDownManager, '', 600 , '', WebFilesManager)
  WebServer.SetCharset('utf-8')

ShutDownManager.Close PROCEDURE

  CODE
  PARENT.Close
  WebServer.Kill()
  HtmlManager.Kill()
  Broker.Kill()
  WebFilesManager.Kill()
  IC:UnloadBroker()



Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

