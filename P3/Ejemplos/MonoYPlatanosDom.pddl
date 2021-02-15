(define (domain Terran)
    (:requirements :strips :typing)
    (:types
        movible localizacion - object
        mono caja - movible
    )
    (:predicates
        (en ?obj - movible ?x - localizacion)
        (tienePlatano ?m - mono)
        (sobre ?m - mono ?c - caja)
        (platanoEn ?x - localizacion)
        (enSuelo ?m - mono)
    )
    
    (:action cogerPlatanos
        :parameters (?m - mono ?c - caja ?x - localizacion)
        :precondition
            (and
                (platanoEn ?x)
                (sobre ?m ?c)
                (en ?c ?x)
            )
        :effect
            (and
                (tienePlatano ?m)
            )
    )
    (:action subirCaja
        :parameters (?m - mono ?c - caja ?x - localizacion)
        :precondition
            (and
                (en ?m ?x)
                (en ?c ?x)
                (enSuelo ?m)
            )
        :effect
            (and
                (not (enSuelo ?m))
                (sobre ?m ?c)
            )
    )

    (:action moverCaja
        :parameters(?m - mono ?c - caja ?x - localizacion ?y - localizacion)
        :precondition
            (and
                (enSuelo ?m)
                (en ?c ?x)
                (en ?m ?x)
            )
        :effect
            (and
                (en ?c ?y) (en ?m ?y) 
                (not (en ?c ?x)) (not (en ?m ?x))
            )

    )

    (:action moverse
        :parameters(?m - mono ?x - localizacion ?y - localizacion)
        :precondition
            (and
                (enSuelo ?m)
                (en ?m ?x)
            )
        :effect
            (and
                (en ?m ?y)
                (not (en ?m ?x))
            )
    )
    
)