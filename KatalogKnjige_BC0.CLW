  MEMBER('KatalogKnjige.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
KatalogKnjige_BC0:DctInit    PROCEDURE()
KatalogKnjige_BC0:DctKill    PROCEDURE()
KatalogKnjige_BC0:FilesInit  PROCEDURE()
  END

Hide:Access:Knjiga   CLASS(FileManager),TYPE               ! FileManager for Knjiga
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Knjiga   CLASS(RelationManager),TYPE           ! RelationManager for Knjiga
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Rang     CLASS(FileManager),TYPE               ! FileManager for Rang
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:Rang     CLASS(RelationManager),TYPE           ! RelationManager for Rang
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Prodavac CLASS(FileManager),TYPE               ! FileManager for Prodavac
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Prodavac CLASS(RelationManager),TYPE           ! RelationManager for Prodavac
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Kupac    CLASS(FileManager),TYPE               ! FileManager for Kupac
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Kupac    CLASS(RelationManager),TYPE           ! RelationManager for Kupac
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Zanr     CLASS(FileManager),TYPE               ! FileManager for Zanr
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Zanr     CLASS(RelationManager),TYPE           ! RelationManager for Zanr
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Narucuje CLASS(FileManager),TYPE               ! FileManager for Narucuje
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Narucuje CLASS(RelationManager),TYPE           ! RelationManager for Narucuje
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Prodaje  CLASS(FileManager),TYPE               ! FileManager for Prodaje
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:Prodaje  CLASS(RelationManager),TYPE           ! RelationManager for Prodaje
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Pripada  CLASS(FileManager),TYPE               ! FileManager for Pripada
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Pripada  CLASS(RelationManager),TYPE           ! RelationManager for Pripada
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PI_POMOCNA CLASS(FileManager),TYPE             ! FileManager for PI_POMOCNA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:PI_POMOCNA CLASS(RelationManager),TYPE         ! RelationManager for PI_POMOCNA
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ULAZ     CLASS(FileManager),TYPE               ! FileManager for ULAZ
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ULAZ     CLASS(RelationManager),TYPE           ! RelationManager for ULAZ
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:Knjiga  &Hide:Access:Knjiga,AUTO,THREAD
_Hide:Relate:Knjiga  &Hide:Relate:Knjiga,AUTO,THREAD
_Hide:Access:Rang    &Hide:Access:Rang,AUTO,THREAD
_Hide:Relate:Rang    &Hide:Relate:Rang,AUTO,THREAD
_Hide:Access:Prodavac &Hide:Access:Prodavac,AUTO,THREAD
_Hide:Relate:Prodavac &Hide:Relate:Prodavac,AUTO,THREAD
_Hide:Access:Kupac   &Hide:Access:Kupac,AUTO,THREAD
_Hide:Relate:Kupac   &Hide:Relate:Kupac,AUTO,THREAD
_Hide:Access:Zanr    &Hide:Access:Zanr,AUTO,THREAD
_Hide:Relate:Zanr    &Hide:Relate:Zanr,AUTO,THREAD
_Hide:Access:Narucuje &Hide:Access:Narucuje,AUTO,THREAD
_Hide:Relate:Narucuje &Hide:Relate:Narucuje,AUTO,THREAD
_Hide:Access:Prodaje &Hide:Access:Prodaje,AUTO,THREAD
_Hide:Relate:Prodaje &Hide:Relate:Prodaje,AUTO,THREAD
_Hide:Access:Pripada &Hide:Access:Pripada,AUTO,THREAD
_Hide:Relate:Pripada &Hide:Relate:Pripada,AUTO,THREAD
_Hide:Access:PI_POMOCNA &Hide:Access:PI_POMOCNA,AUTO,THREAD
_Hide:Relate:PI_POMOCNA &Hide:Relate:PI_POMOCNA,AUTO,THREAD
_Hide:Access:ULAZ    &Hide:Access:ULAZ,AUTO,THREAD
_Hide:Relate:ULAZ    &Hide:Relate:ULAZ,AUTO,THREAD


KatalogKnjige_BC0:DctInit PROCEDURE()
  CODE
  _Hide:Access:Knjiga &= NEW(Hide:Access:Knjiga)
  _Hide:Relate:Knjiga &= NEW(Hide:Relate:Knjiga)
  _Hide:Access:Rang &= NEW(Hide:Access:Rang)
  _Hide:Relate:Rang &= NEW(Hide:Relate:Rang)
  _Hide:Access:Prodavac &= NEW(Hide:Access:Prodavac)
  _Hide:Relate:Prodavac &= NEW(Hide:Relate:Prodavac)
  _Hide:Access:Kupac &= NEW(Hide:Access:Kupac)
  _Hide:Relate:Kupac &= NEW(Hide:Relate:Kupac)
  _Hide:Access:Zanr &= NEW(Hide:Access:Zanr)
  _Hide:Relate:Zanr &= NEW(Hide:Relate:Zanr)
  _Hide:Access:Narucuje &= NEW(Hide:Access:Narucuje)
  _Hide:Relate:Narucuje &= NEW(Hide:Relate:Narucuje)
  _Hide:Access:Prodaje &= NEW(Hide:Access:Prodaje)
  _Hide:Relate:Prodaje &= NEW(Hide:Relate:Prodaje)
  _Hide:Access:Pripada &= NEW(Hide:Access:Pripada)
  _Hide:Relate:Pripada &= NEW(Hide:Relate:Pripada)
  _Hide:Access:PI_POMOCNA &= NEW(Hide:Access:PI_POMOCNA)
  _Hide:Relate:PI_POMOCNA &= NEW(Hide:Relate:PI_POMOCNA)
  _Hide:Access:ULAZ &= NEW(Hide:Access:ULAZ)
  _Hide:Relate:ULAZ &= NEW(Hide:Relate:ULAZ)
  Relate:Knjiga &= _Hide:Relate:Knjiga
  Relate:Rang &= _Hide:Relate:Rang
  Relate:Prodavac &= _Hide:Relate:Prodavac
  Relate:Kupac &= _Hide:Relate:Kupac
  Relate:Zanr &= _Hide:Relate:Zanr
  Relate:Narucuje &= _Hide:Relate:Narucuje
  Relate:Prodaje &= _Hide:Relate:Prodaje
  Relate:Pripada &= _Hide:Relate:Pripada
  Relate:PI_POMOCNA &= _Hide:Relate:PI_POMOCNA
  Relate:ULAZ &= _Hide:Relate:ULAZ


KatalogKnjige_BC0:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:Knjiga.Init
  _Hide:Relate:Rang.Init
  _Hide:Relate:Prodavac.Init
  _Hide:Relate:Kupac.Init
  _Hide:Relate:Zanr.Init
  _Hide:Relate:Narucuje.Init
  _Hide:Relate:Prodaje.Init
  _Hide:Relate:Pripada.Init
  _Hide:Relate:PI_POMOCNA.Init
  _Hide:Relate:ULAZ.Init


KatalogKnjige_BC0:DctKill PROCEDURE()
  CODE
  _Hide:Relate:Knjiga.Kill
  DISPOSE(_Hide:Relate:Knjiga)
  _Hide:Relate:Rang.Kill
  DISPOSE(_Hide:Relate:Rang)
  _Hide:Relate:Prodavac.Kill
  DISPOSE(_Hide:Relate:Prodavac)
  _Hide:Relate:Kupac.Kill
  DISPOSE(_Hide:Relate:Kupac)
  _Hide:Relate:Zanr.Kill
  DISPOSE(_Hide:Relate:Zanr)
  _Hide:Relate:Narucuje.Kill
  DISPOSE(_Hide:Relate:Narucuje)
  _Hide:Relate:Prodaje.Kill
  DISPOSE(_Hide:Relate:Prodaje)
  _Hide:Relate:Pripada.Kill
  DISPOSE(_Hide:Relate:Pripada)
  _Hide:Relate:PI_POMOCNA.Kill
  DISPOSE(_Hide:Relate:PI_POMOCNA)
  _Hide:Relate:ULAZ.Kill
  DISPOSE(_Hide:Relate:ULAZ)


Hide:Relate:Knjiga.Init PROCEDURE()
  CODE
  _Hide:Access:Knjiga.Init
  SELF.Init(Access:Knjiga,1)


Hide:Access:Knjiga.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Knj:Record
  SELF.FileNameValue = 'Knjiga'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Knjiga
  PARENT.Init
  Access:Knjiga &= SELF


Hide:Access:Knjiga.Kill PROCEDURE

  CODE
  WebTableProperties:Knjiga.Kill()
  PARENT.Kill
  Access:Knjiga &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Knjiga.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Knjiga,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Knj:SK_Knjiga_Autor_knjige,'Knj:SK_Knjiga_Autor_knjige',0)
    SELF.AddKey(Knj:PK_Knjiga_ID_Knjige,'Knj:PK_Knjiga_ID_Knjige',0)
    SELF.AddKey(Knj:SK_Knjiga_Naziv_Knjige,'Knj:SK_Knjiga_Naziv_Knjige',0)
    SELF.AddKey(Knj:SK_Knjiga_Cijena_knjige,'Knj:SK_Knjiga_Cijena_knjige',0)
    SELF.AddKey(Knj:SK_Knjiga_Izdavac_knjige,'Knj:SK_Knjiga_Izdavac_knjige',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Knjiga.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Narucuje,RI:CASCADE,RI:CASCADE,Nar:PK_Narucuje_ID_Knjige_ID_prodavaca)
  SELF.AddRelationLink(Knj:ID_Knjige,Nar:ID_Knjige)

  SELF.AddRelation(Relate:Pripada,RI:CASCADE,RI:CASCADE,Pri:PK_Pripada_ID_Knjige_ID_zanra)
  SELF.AddRelationLink(Knj:ID_Knjige,Pri:ID_Knjige)


Hide:Relate:Knjiga.Kill PROCEDURE

  CODE
  _Hide:Access:Knjiga.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:Knjiga &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Knjiga)                             ! destroy the file manager


Hide:Relate:Rang.Init PROCEDURE()
  CODE
  _Hide:Access:Rang.Init
  SELF.Init(Access:Rang,1)


Hide:Access:Rang.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Ran:Record
  SELF.FileNameValue = 'Rang'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Rang
  PARENT.Init
  Access:Rang &= SELF


Hide:Access:Rang.Kill PROCEDURE

  CODE
  WebTableProperties:Rang.Kill()
  PARENT.Kill
  Access:Rang &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Rang.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Rang,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Ran:PK_Rang_ID_Ranga,'Ran:PK_Rang_ID_Ranga',0)
    SELF.AddKey(Ran:SK_Rang_Naziv_ranga,'Ran:SK_Rang_Naziv_ranga',0)
    SELF.AddKey(Ran:SK_Rang_Popust,'Ran:SK_Rang_Popust',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:Rang.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('Ran:Popust')
    IF INSTRING(']' & Ran:Popust & '[', ']5[]10[]15[]20[]25[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Pocetnik'',''Prvostupnik'',''Intermediate'',''Senior'',''Profesionalac''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:Rang.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Prodavac,RI:CASCADE,RI:RESTRICT,Pro:VK_ProdavacRang_Rang)
  SELF.AddRelationLink(Ran:ID_ranga,Pro:Rang)


Hide:Relate:Rang.Kill PROCEDURE

  CODE
  _Hide:Access:Rang.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:Rang &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Rang)                               ! destroy the file manager


Hide:Relate:Prodavac.Init PROCEDURE()
  CODE
  _Hide:Access:Prodavac.Init
  SELF.Init(Access:Prodavac,1)


Hide:Access:Prodavac.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Pro:Record
  SELF.FileNameValue = 'Prodavac'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Prodavac
  PARENT.Init
  Access:Prodavac &= SELF


Hide:Access:Prodavac.Kill PROCEDURE

  CODE
  WebTableProperties:Prodavac.Kill()
  PARENT.Kill
  Access:Prodavac &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Prodavac.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Prodavac,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Pro:PK_Prodavac_ID_prodavaca,'Pro:PK_Prodavac_ID_prodavaca',0)
    SELF.AddKey(Pro:VK_ProdavacRang_Rang,'Pro:VK_ProdavacRang_Rang',0)
    SELF.AddKey(Pro:SK_Prodavac_Ime_prodavaca,'Pro:SK_Prodavac_Ime_prodavaca',0)
    SELF.AddKey(Pro:SK_Prodavac_Prezime_prodavaca,'Pro:SK_Prodavac_Prezime_prodavaca',0)
    SELF.AddKey(Pro:SK_Prodavac_Broj_telefona,'Pro:SK_Prodavac_Broj_telefona',0)
    SELF.AddKey(Pro:SK_Prodavac_Email,'Pro:SK_Prodavac_Email',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Prodavac.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Prodaje,RI:CASCADE,RI:CASCADE,Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna)
  SELF.AddRelationLink(Pro:ID_prodavaca,Prd:ID_prodavaca)

  SELF.AddRelation(Relate:Narucuje,RI:CASCADE,RI:CASCADE,Nar:PK_Narucuje_ID_Knjige_ID_prodavaca)
  SELF.AddRelationLink(Pro:ID_prodavaca,Nar:ID_prodavaca)

  SELF.AddRelation(Relate:Rang)


Hide:Relate:Prodavac.Kill PROCEDURE

  CODE
  _Hide:Access:Prodavac.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:Prodavac &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Prodavac)                           ! destroy the file manager


Hide:Relate:Kupac.Init PROCEDURE()
  CODE
  _Hide:Access:Kupac.Init
  SELF.Init(Access:Kupac,1)


Hide:Access:Kupac.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Kup:Record
  SELF.FileNameValue = 'Kupac'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Kupac
  PARENT.Init
  Access:Kupac &= SELF


Hide:Access:Kupac.Kill PROCEDURE

  CODE
  WebTableProperties:Kupac.Kill()
  PARENT.Kill
  Access:Kupac &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Kupac.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Kupac,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Kup:PK_Kupac_ID_kupca,'Kup:PK_Kupac_ID_kupca',0)
    SELF.AddKey(Kup:SK_Kupac_Ime_kupca,'Kup:SK_Kupac_Ime_kupca',0)
    SELF.AddKey(Kup:SK_Kupac_Prezime_kupca,'Kup:SK_Kupac_Prezime_kupca',0)
    SELF.AddKey(Kup:SK_Kupac_Ostvaren_popust,'Kup:SK_Kupac_Ostvaren_popust',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Kupac.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Prodaje,RI:CASCADE,RI:CASCADE,Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna)
  SELF.AddRelationLink(Kup:ID_kupca,Prd:ID_kupca)


Hide:Relate:Kupac.Kill PROCEDURE

  CODE
  _Hide:Access:Kupac.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:Kupac &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Kupac)                              ! destroy the file manager


Hide:Relate:Zanr.Init PROCEDURE()
  CODE
  _Hide:Access:Zanr.Init
  SELF.Init(Access:Zanr,1)


Hide:Access:Zanr.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Zan:Record
  SELF.FileNameValue = 'Zanr'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Zanr
  PARENT.Init
  Access:Zanr &= SELF


Hide:Access:Zanr.Kill PROCEDURE

  CODE
  WebTableProperties:Zanr.Kill()
  PARENT.Kill
  Access:Zanr &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Zanr.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Zanr,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Zan:PK_Zanr_ID_zanra,'Zan:PK_Zanr_ID_zanra',0)
    SELF.AddKey(Zan:SK_Zanr_Naziv_Zanra,'Zan:SK_Zanr_Naziv_Zanra',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Zanr.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Pripada,RI:CASCADE,RI:CASCADE,Pri:PK_Pripada_ID_Knjige_ID_zanra)
  SELF.AddRelationLink(Zan:ID_zanra,Pri:ID_zanra)


Hide:Relate:Zanr.Kill PROCEDURE

  CODE
  _Hide:Access:Zanr.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:Zanr &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Zanr)                               ! destroy the file manager


Hide:Relate:Narucuje.Init PROCEDURE()
  CODE
  _Hide:Access:Narucuje.Init
  SELF.Init(Access:Narucuje,1)


Hide:Access:Narucuje.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Nar:Record
  SELF.FileNameValue = 'Narucuje'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Narucuje
  PARENT.Init
  Access:Narucuje &= SELF


Hide:Access:Narucuje.Kill PROCEDURE

  CODE
  WebTableProperties:Narucuje.Kill()
  PARENT.Kill
  Access:Narucuje &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Narucuje.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Narucuje,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Nar:PK_Narucuje_ID_Knjige_ID_prodavaca,'Nar:PK_Narucuje_ID_Knjige_ID_prodavaca',0)
    SELF.AddKey(Nar:RK_Narucuje_ID_prodavaca_ID_Knjige,'Nar:RK_Narucuje_ID_prodavaca_ID_Knjige',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Narucuje.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Knjiga)

  SELF.AddRelation(Relate:Prodavac)


Hide:Relate:Narucuje.Kill PROCEDURE

  CODE
  _Hide:Access:Narucuje.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:Narucuje &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Narucuje)                           ! destroy the file manager


Hide:Relate:Prodaje.Init PROCEDURE()
  CODE
  _Hide:Access:Prodaje.Init
  SELF.Init(Access:Prodaje,1)


Hide:Access:Prodaje.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Prd:Record
  SELF.FileNameValue = 'Prodaje'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Prodaje
  PARENT.Init
  Access:Prodaje &= SELF


Hide:Access:Prodaje.Kill PROCEDURE

  CODE
  WebTableProperties:Prodaje.Kill()
  PARENT.Kill
  Access:Prodaje &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Prodaje.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Prodaje,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna,'Prd:PK_Prodaje_ID_prodavaca_ID_kupca_Broj_racuna',0)
    SELF.AddKey(Prd:RK_Prodaje_ID_kupca_ID_prodavaca_Broj_racuna,'Prd:RK_Prodaje_ID_kupca_ID_prodavaca_Broj_racuna',0)
    SELF.AddKey(Prd:SK_Prodaje_Datum_prodaje,'Prd:SK_Prodaje_Datum_prodaje',0)
    SELF.AddKey(Prd:SK_Prodaje_Nacin_placanja,'Prd:SK_Prodaje_Nacin_placanja',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:Prodaje.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 4
    GlobalErrors.SetField('Prd:Nacin_placanja')
    IF INSTRING(']' & Prd:Nacin_placanja & '[', ']Kartica[]Gotovina[]Kripto[]Cek[]Ostalo[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Kartica'',''Gotovina'',''Kripto'',''Cek'',''Ostalo''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:Prodaje.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Kupac)

  SELF.AddRelation(Relate:Prodavac)


Hide:Relate:Prodaje.Kill PROCEDURE

  CODE
  _Hide:Access:Prodaje.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:Prodaje &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Prodaje)                            ! destroy the file manager


Hide:Relate:Pripada.Init PROCEDURE()
  CODE
  _Hide:Access:Pripada.Init
  SELF.Init(Access:Pripada,1)


Hide:Access:Pripada.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= Pri:Record
  SELF.FileNameValue = 'Pripada'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Pripada
  PARENT.Init
  Access:Pripada &= SELF


Hide:Access:Pripada.Kill PROCEDURE

  CODE
  WebTableProperties:Pripada.Kill()
  PARENT.Kill
  Access:Pripada &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Pripada.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Pripada,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(Pri:PK_Pripada_ID_Knjige_ID_zanra,'Pri:PK_Pripada_ID_Knjige_ID_zanra',0)
    SELF.AddKey(Pri:RK_Pripada_ID_zanra_ID_Knjige,'Pri:RK_Pripada_ID_zanra_ID_Knjige',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Pripada.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Knjiga)

  SELF.AddRelation(Relate:Zanr)


Hide:Relate:Pripada.Kill PROCEDURE

  CODE
  _Hide:Access:Pripada.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:Pripada &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Pripada)                            ! destroy the file manager


Hide:Relate:PI_POMOCNA.Init PROCEDURE()
  CODE
  _Hide:Access:PI_POMOCNA.Init
  SELF.Init(Access:PI_POMOCNA,1)


Hide:Access:PI_POMOCNA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= POM:Record
  SELF.FileNameValue = 'PI_POMOCNA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PI_POMOCNA
  PARENT.Init
  Access:PI_POMOCNA &= SELF


Hide:Access:PI_POMOCNA.Kill PROCEDURE

  CODE
  WebTableProperties:PI_POMOCNA.Kill()
  PARENT.Kill
  Access:PI_POMOCNA &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PI_POMOCNA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PI_POMOCNA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PI_POMOCNA.Kill PROCEDURE

  CODE
  _Hide:Access:PI_POMOCNA.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:PI_POMOCNA &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PI_POMOCNA)                         ! destroy the file manager


Hide:Relate:ULAZ.Init PROCEDURE()
  CODE
  _Hide:Access:ULAZ.Init
  SELF.Init(Access:ULAZ,1)


Hide:Access:ULAZ.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ULZ:Record
  SELF.FileNameValue = 'ULAZ'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ULAZ
  PARENT.Init
  Access:ULAZ &= SELF


Hide:Access:ULAZ.Kill PROCEDURE

  CODE
  WebTableProperties:ULAZ.Kill()
  PARENT.Kill
  Access:ULAZ &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ULAZ.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ULAZ,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ULZ:KEY_ID,'ULZ:KEY_ID',1)
    SELF.AddKey(ULZ:Key_Korisnicko,'ULZ:Key_Korisnicko',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ULAZ.Kill PROCEDURE

  CODE
  _Hide:Access:ULAZ.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:ULAZ &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ULAZ)                               ! destroy the file manager

