﻿(define (domain Terran)
    (:requirements :strips :typing)
    (:types
        unidad localizacion edificio recurso - object
        
    )
    (:constants
        tipoEdificio - edificio
        tipoRecurso - recurso
        tipoUnidad - unidad
        centroDeMando barracones - tipoEdificio
        mineral gas - tipoRecurso
        VCE - tipoUnidad
        
    )
    (:predicates
        (en ?obj - object ?x - localizacion)
        (asignadoLoc ?r - recurso ?x - localizacion)
        (extrayendo ?u - unidad ?r - recurso)
        (recursoNecesario ?r - recurso ?e - edificio)
        (recursoObtenido ?r - recurso)
        (unidadLibre ?u - unidad)
        (locLibre ?x - localizacion) ;;Para construir edificio
        (conectado ?x - localizacion ?y - localizacion)
        (esRecurso ?r - recurso ?y - tipoRecurso)
        (esEdificio ?b - edificio ?y - tipoEdificio)
        (esUnidad ?v - unidad ?y - tipoUnidad)
    )
    
    
    (:action Navegar
        :parameters(?u - unidad ?x - localizacion ?y - localizacion)
        :precondition
            (and
                (en ?u ?x)
                (conectado ?x ?y)
                (unidadLibre ?u)
                (esUnidad ?u VCE)
            )
        :effect
            (and
                (en ?u ?y)
                (not (en ?u ?x))
            )
    )

    (:action Asignar
        :parameters (?u - unidad ?r - recurso ?y - localizacion)
        :precondition
            (and (unidadLibre ?u) (asignadoLoc ?r ?y) (en ?u ?y))
        :effect
            (and
                (extrayendo ?u ?r)
                (recursoObtenido ?r)
                (not (unidadLibre ?u))
            )
    )
    (:action Construir
        :parameters (?u - unidad ?e - edificio ?y - localizacion ?r - recurso)
        :precondition
            (and
                (locLibre ?y)
                (unidadLibre ?u)
                (recursoNecesario ?r ?e)
                (recursoObtenido ?r)
                (en ?u ?y)
            )
        :effect
            (and
                (en ?e ?y)
                (not (locLibre ?y))
            )
    )
    
    
)