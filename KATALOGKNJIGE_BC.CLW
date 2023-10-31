  MEMBER('KatalogKnjige.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('KatalogKnjige_BC0.CLW')
KatalogKnjige_BC0:DctInit             PROCEDURE()
KatalogKnjige_BC0:DctKill             PROCEDURE()
KatalogKnjige_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  KatalogKnjige_BC0:DctInit
  KatalogKnjige_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  KatalogKnjige_BC0:DctKill

