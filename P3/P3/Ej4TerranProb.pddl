﻿(define (problem Terran)
    (:domain Terran)
    (:objects
        VCE1 VCE2 VCE3 VCE4 VCE5 - unidad
        Marine1 Marine2 Segador - unidad
        centroMando1 - edificio
        barracones1 barracones2 - edificio
        min1 min2 min3 - recurso
        gas1 gas2 - recurso
        extr - edificio

        loc1_1 loc1_2 loc1_3 loc1_4 loc1_5 loc2_1 loc2_2 loc2_3 loc2_4 loc2_5 loc3_1 loc3_2 loc3_3 loc3_4 loc3_5 loc4_1 loc4_2 loc4_3 loc4_4 loc4_5 loc5_1 loc5_2 loc5_3 loc5_4 loc5_5 - localizacion


    )
    (:init
        (conectado loc1_1 loc2_1)
        (conectado loc2_1 loc1_1)
        (conectado loc1_1 loc1_2)
        (conectado loc1_2 loc1_1)
        (conectado loc1_2 loc2_2)
        (conectado loc2_2 loc1_2)
        (conectado loc1_2 loc1_3)
        (conectado loc1_3 loc1_2)
        (conectado loc1_2 loc1_1)
        (conectado loc1_1 loc1_2)
        (conectado loc1_3 loc2_3)
        (conectado loc2_3 loc1_3)
        (conectado loc1_3 loc1_4)
        (conectado loc1_4 loc1_3)
        (conectado loc1_3 loc1_2)
        (conectado loc1_2 loc1_3)
        (conectado loc1_4 loc2_4)
        (conectado loc2_4 loc1_4)
        (conectado loc1_4 loc1_5)
        (conectado loc1_5 loc1_4)
        (conectado loc1_4 loc1_3)
        (conectado loc1_3 loc1_4)
        (conectado loc1_5 loc2_5)
        (conectado loc2_5 loc1_5)
        (conectado loc1_5 loc1_4)
        (conectado loc1_4 loc1_5)
        (conectado loc2_1 loc1_1)
        (conectado loc1_1 loc2_1)
        (conectado loc2_1 loc3_1)
        (conectado loc3_1 loc2_1)
        (conectado loc2_1 loc2_2)
        (conectado loc2_2 loc2_1)
        (conectado loc2_2 loc1_2)
        (conectado loc1_2 loc2_2)
        (conectado loc2_2 loc3_2)
        (conectado loc3_2 loc2_2)
        (conectado loc2_2 loc2_3)
        (conectado loc2_3 loc2_2)
        (conectado loc2_2 loc2_1)
        (conectado loc2_1 loc2_2)
        (conectado loc2_3 loc1_3)
        (conectado loc1_3 loc2_3)
        (conectado loc2_3 loc3_3)
        (conectado loc3_3 loc2_3)
        (conectado loc2_3 loc2_4)
        (conectado loc2_4 loc2_3)
        (conectado loc2_3 loc2_2)
        (conectado loc2_2 loc2_3)
        (conectado loc2_4 loc1_4)
        (conectado loc1_4 loc2_4)
        (conectado loc2_4 loc3_4)
        (conectado loc3_4 loc2_4)
        (conectado loc2_4 loc2_5)
        (conectado loc2_5 loc2_4)
        (conectado loc2_4 loc2_3)
        (conectado loc2_3 loc2_4)
        (conectado loc2_5 loc1_5)
        (conectado loc1_5 loc2_5)
        (conectado loc2_5 loc3_5)
        (conectado loc3_5 loc2_5)
        (conectado loc2_5 loc2_4)
        (conectado loc2_4 loc2_5)
        (conectado loc3_1 loc2_1)
        (conectado loc2_1 loc3_1)
        (conectado loc3_1 loc4_1)
        (conectado loc4_1 loc3_1)
        (conectado loc3_1 loc3_2)
        (conectado loc3_2 loc3_1)
        (conectado loc3_2 loc2_2)
        (conectado loc2_2 loc3_2)
        (conectado loc3_2 loc4_2)
        (conectado loc4_2 loc3_2)
        (conectado loc3_2 loc3_3)
        (conectado loc3_3 loc3_2)
        (conectado loc3_2 loc3_1)
        (conectado loc3_1 loc3_2)
        (conectado loc3_3 loc2_3)
        (conectado loc2_3 loc3_3)
        (conectado loc3_3 loc4_3)
        (conectado loc4_3 loc3_3)
        (conectado loc3_3 loc3_4)
        (conectado loc3_4 loc3_3)
        (conectado loc3_3 loc3_2)
        (conectado loc3_2 loc3_3)
        (conectado loc3_4 loc2_4)
        (conectado loc2_4 loc3_4)
        (conectado loc3_4 loc4_4)
        (conectado loc4_4 loc3_4)
        (conectado loc3_4 loc3_5)
        (conectado loc3_5 loc3_4)
        (conectado loc3_4 loc3_3)
        (conectado loc3_3 loc3_4)
        (conectado loc3_5 loc2_5)
        (conectado loc2_5 loc3_5)
        (conectado loc3_5 loc4_5)
        (conectado loc4_5 loc3_5)
        (conectado loc3_5 loc3_4)
        (conectado loc3_4 loc3_5)
        (conectado loc4_1 loc3_1)
        (conectado loc3_1 loc4_1)
        (conectado loc4_1 loc5_1)
        (conectado loc5_1 loc4_1)
        (conectado loc4_1 loc4_2)
        (conectado loc4_2 loc4_1)
        (conectado loc4_2 loc3_2)
        (conectado loc3_2 loc4_2)
        (conectado loc4_2 loc5_2)
        (conectado loc5_2 loc4_2)
        (conectado loc4_2 loc4_3)
        (conectado loc4_3 loc4_2)
        (conectado loc4_2 loc4_1)
        (conectado loc4_1 loc4_2)
        (conectado loc4_3 loc3_3)
        (conectado loc3_3 loc4_3)
        (conectado loc4_3 loc5_3)
        (conectado loc5_3 loc4_3)
        (conectado loc4_3 loc4_4)
        (conectado loc4_4 loc4_3)
        (conectado loc4_3 loc4_2)
        (conectado loc4_2 loc4_3)
        (conectado loc4_4 loc3_4)
        (conectado loc3_4 loc4_4)
        (conectado loc4_4 loc5_4)
        (conectado loc5_4 loc4_4)
        (conectado loc4_4 loc4_5)
        (conectado loc4_5 loc4_4)
        (conectado loc4_4 loc4_3)
        (conectado loc4_3 loc4_4)
        (conectado loc4_5 loc3_5)
        (conectado loc3_5 loc4_5)
        (conectado loc4_5 loc5_5)
        (conectado loc5_5 loc4_5)
        (conectado loc4_5 loc4_4)
        (conectado loc4_4 loc4_5)
        (conectado loc5_1 loc4_1)
        (conectado loc4_1 loc5_1)
        (conectado loc5_1 loc5_2)
        (conectado loc5_2 loc5_1)
        (conectado loc5_2 loc4_2)
        (conectado loc4_2 loc5_2)
        (conectado loc5_2 loc5_3)
        (conectado loc5_3 loc5_2)
        (conectado loc5_2 loc5_1)
        (conectado loc5_1 loc5_2)
        (conectado loc5_3 loc4_3)
        (conectado loc4_3 loc5_3)
        (conectado loc5_3 loc5_4)
        (conectado loc5_4 loc5_3)
        (conectado loc5_3 loc5_2)
        (conectado loc5_2 loc5_3)
        (conectado loc5_4 loc4_4)
        (conectado loc4_4 loc5_4)
        (conectado loc5_4 loc5_5)
        (conectado loc5_5 loc5_4)
        (conectado loc5_4 loc5_3)
        (conectado loc5_3 loc5_4)
        (conectado loc5_5 loc4_5)
        (conectado loc4_5 loc5_5)
        (conectado loc5_5 loc5_4)
        (conectado loc5_4 loc5_5)


        (en VCE1 loc5_5 )
        (en centroMando1 loc4_3 )
        

        (esRecurso min1 mineral)
        (esRecurso min2 mineral)
        (esRecurso min3 mineral)
        (esUnidad VCE1 VCE)
        (esUnidad Marine1 marines)
        (esUnidad Marine2 marines)
        (esUnidad Segador segadores)
        (esRecurso gas1 gas)
        (esRecurso gas2 gas)
        (esEdificio centroMando1 centroDeMando)
        (esEdificio barracones1 barracones)
        (esEdificio barracones2 barracones)
        (esEdificio extr extractor)

        (asignadoLoc gas1 loc2_3)
        (asignadoLoc gas2 loc4_1)
        (asignadoLoc min1 loc4_2)
        (asignadoLoc min2 loc2_2)
        (asignadoLoc min3 loc3_3)

        (necesita2 mineral gas barracones)
        (necesita mineral extractor)


        (unidadLibre VCE1)
        (esUnidad VCE2 VCE)
        (unidadLibre VCE2)
        (esUnidad VCE3 VCE)
        (unidadLibre VCE3)
        (esUnidad VCE4 VCE)
        (unidadLibre VCE4)
        (esUnidad VCE5 VCE)
        (unidadLibre VCE5)


        (locLibre loc1_1)
        (locLibre loc1_2)
        (locLibre loc1_3)
        (locLibre loc1_4)
        (locLibre loc1_5)
        (locLibre loc4_1)
        (locLibre loc4_2)
        (locLibre loc4_4)
        (locLibre loc4_5)
        (locLibre loc2_1)
        (locLibre loc2_2)
        (locLibre loc2_3)
        (locLibre loc2_4)
        (locLibre loc2_5)
        (locLibre loc3_1)
        (locLibre loc3_2)
        (locLibre loc3_3)
        (locLibre loc3_4)
        (locLibre loc3_5)
        (locLibre loc5_1)
        (locLibre loc5_2)
        (locLibre loc5_3)
        (locLibre loc5_4)
        (locLibre loc5_5)




    )
    (:goal
        (and 
        	(en Marine1 loc2_5)
        	(en Marine2 loc5_5)
            (en Segador loc5_5)
        )
    )
)