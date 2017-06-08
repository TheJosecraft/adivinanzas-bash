#!/bin/bash
NUMERO=$( ls adivinanza*.txt | wc -l)
FICHPUNT="puntuaciones.txt"

#Variables de las categorías
HIS=0
ART=0
GEO=0
CIE=0
PRO=0

for(( i = 1; i <= $NUMERO; i = i + 1))
do
    LINEA=$(head -n 1 adivinanza$i.txt)
    if [ "$LINEA" == "HISTORIA" ]; then
        HIS=$[ HIS + 1 ]
    fi

    if [ "$LINEA" == "ARTE" ]; then
        ART=$[ ART + 1 ]
    fi

    if [ "$LINEA" == "BIOLOGÍA" ]; then
        GEO=$[ GEO + 1 ]
    fi

    if [ "$LINEA" == "CIENCIAS" ]; then
        CIE=$[ CIE + 1 ]
    fi

    if [ "$LINEA" == "PROGRAMACIÓN" ]; then
        PRO=$[ PRO + 1 ]
    fi
done
echo $ALEATORIO
TERMINADO=0
echo "-------------------------------INSTRUCCIONES-----------------------------------"
echo "- 1. Asegúrate de introducir las respuestas en mayúsculas                     -"
echo "- 2. Las respuestas contienes acentos.                                        -"
echo "- 3. Al guardar el nombre para el ránking no introduzcas espacios             -"
echo "- 4. Diviértete                                                               -"
echo "-------------------------------------------------------------------------------"
echo "Selecciona una opción"
select OPCION in "Normal" "Categorías" "Aleatorio" "Dos Jugadores" "Ránking" "Salir"
do
    while [ "$OPCION" != "6" ]
    do
        case $OPCION in
            "Normal")
PUNTUACIONT=0
MODALIDAD="NORMAL"
CATEG="TODO"
for(( i = 1; i <= $NUMERO; i = i + 1))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    echo $LINEA

    CONTADOR=0
    PUNTUACION=10
    RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)

    echo ""

    PALABRA=""
    echo ""
    while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
    do

        CONTADOR=$[ $CONTADOR + 1 ] 


        PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
        echo $PISTA

        read -t 20 -p "Introduce la respuesta: " PAL

        PALABRA=$PAL
        echo ""

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            CONTADOR=10
        else
            PUNTUACION=$[ PUNTUACION  - 1 ]
        fi

    done

    if [ "$RESPUESTA" == "$PALABRA" ]; then
        echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
    else
        echo "La próxima vez será"
        echo -n "La respuesta correcta es : $RESPUESTA" 
    fi

    if [ $i == $NUMERO ]; then
        CONFIRMAR="N"
        echo "Lo sentimos, no hay más adivinanzas"
    else
        read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
    fi

    while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
    do
        read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
    done

    if [ "$CONFIRMAR" == "Y" ]; then
        PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
        echo "Buena suerte"
        echo ""
    elif [ "$CONFIRMAR" == "N" ]; then
        PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
        read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
        echo $NOMBRE "$PUNTUACIONT $MODALIDAD $CATEG" >> $FICHPUNT
        echo "Puntuación total: $PUNTUACIONT"
        i=$[ NUMERO + 1 ]
    else
        echo "ERROR, INTRODUCE UN VALOR CORRECTO"
    fi
echo ""
done
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;

"Categorías")
PUNTUACIONT=0
MODALIDAD="CATEGORÍAS"
echo "Selecciona una categoría"
select CATEGORIA in "Historia" "Arte" "Geografía" "Ciencias" "Programación"
do
    case $CATEGORIA in
        "Historia")
NUM=0
CATEG="HISTORIA"
for(( i = 1; i <= $NUMERO; i = i + 1 ))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    if [ "$LINEA" == "HISTORIA" ]; then
        echo $LINEA

        CONTADOR=0
        PUNTUACION=10
        RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)
        echo ""

        PALABRA=""
        echo ""
        while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
        do

            CONTADOR=$[ $CONTADOR + 1 ] 


            PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
            echo $PISTA

            read -t 20 -p "Introduce la respuesta: " PAL

            PALABRA=$PAL
            echo ""

            if [ "$RESPUESTA" == "$PALABRA" ]; then
                CONTADOR=10
            else
                PUNTUACION=$[ PUNTUACION  - 1 ]
            fi

        done

        NUM=$[ NUM + 1 ]


        if [ "$RESPUESTA" == "$PALABRA" ]; then
            echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
        else
            echo "La próxima vez será"
            echo -n "La respuesta correcta es: $RESPUESTA" 
        fi

        if [ $NUM == $HIS ]; then
            CONFIRMAR="N"
            echo "Lo sentimos, no hay más adivinanzas"
        else
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        fi

        while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
        do
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        done

        if [ "$CONFIRMAR" == "Y" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            echo "Buena suerte"
            echo ""
        elif [ "$CONFIRMAR" == "N" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
            echo $NOMBRE "$PUNTUACIONT $MODALIDAD $CATEG" >> $FICHPUNT
            echo "Puntuación total: $PUNTUACIONT"
            i=$[ NUMERO + 1 ]
        else
            echo "ERROR, INTRODUCE UN VALOR CORRECTO"
        fi
    fi

done
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;

"Arte")
NUM=0
CATEG="ARTE"
for(( i = 1; i <= $NUMERO; i = i + 1 ))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    if [ "$LINEA" == "ARTE" ]; then
        echo $LINEA

        CONTADOR=0
        PUNTUACION=10
        RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)
        echo ""

        PALABRA=""
        echo ""
        while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
        do

            CONTADOR=$[ $CONTADOR + 1 ] 


            PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
            echo $PISTA

            read -t 20 -p "Introduce la respuesta: " PAL

            PALABRA=$PAL
            echo ""

            if [ "$RESPUESTA" == "$PALABRA" ]; then
                CONTADOR=10
            else
                PUNTUACION=$[ PUNTUACION  - 1 ]
            fi

        done

        NUM=$[ NUM + 1 ]

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
        else
            echo "La próxima vez será" 
            echo -n "La respuesta correcta es: $RESPUESTA"
        fi

        if [ $NUM -ge $ART ]; then
            CONFIRMAR="N"
            echo "Lo sentimos, no hay más adivinanzas"
        else
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        fi

        while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
        do
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        done

        if [ "$CONFIRMAR" == "Y" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            echo "Buena suerte"
            echo ""
        elif [ "$CONFIRMAR" == "N" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
            echo $NOMBRE "$PUNTUACIONT $MODALIDAD $CATEG" >> $FICHPUNT
            echo "Puntuación total: $PUNTUACIONT"
            i=$[ NUMERO + 1 ]
        else
            echo "ERROR, INTRODUCE UN VALOR CORRECTO"
        fi
    fi
done
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;

"Geografía")
NUM=0
CATEG="BIOLOGÍA"
for(( i = 1; i <= $NUMERO; i = i + 1 ))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    if [ "$LINEA" == "BIOLOGÍA" ]; then
        echo $LINEA

        CONTADOR=0
        PUNTUACION=10
        RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)
        echo ""

        PALABRA=""
        echo ""
        while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
        do

            CONTADOR=$[ $CONTADOR + 1 ] 


            PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
            echo $PISTA

            read -p "Introduce la respuesta: " PAL

            PALABRA=$PAL
            echo ""

            if [ "$RESPUESTA" == "$PALABRA" ]; then
                CONTADOR=10
            else
                PUNTUACION=$[ PUNTUACION  - 1 ]
            fi

        done

        NUM=$[ NUM + 1 ]

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
        else
            echo "La próxima vez será" 
            echo -n "La respuesta correcta es: $RESPUESTA"
        fi

        if [ $NUM -ge $GEO ]; then
            CONFIRMAR="N"
            echo "Lo sentimos, no hay más adivinanzas"
        else
            read -t 20 -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        fi

        while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
        do
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        done

        if [ "$CONFIRMAR" == "Y" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            echo "Buena suerte"
            echo ""
        elif [ "$CONFIRMAR" == "N" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
            echo $NOMBRE "$PUNTUACIONT $MODALIDAD $CATEG" >> $FICHPUNT
            echo "Puntuación total: $PUNTUACIONT"
            i=$[ NUMERO + 1 ]
        else
            echo "ERROR, INTRODUCE UN VALOR CORRECTO"
        fi
    fi
done
echo ""
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;

"Ciencias")
NUM=0
CATEG="CIENCIAS"
for(( i = 1; i <= $NUMERO; i = i + 1 ))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    if [ "$LINEA" == "CIENCIAS" ]; then
        echo $LINEA

        CONTADOR=0
        PUNTUACION=10
        RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)
        echo ""

        PALABRA=""
        echo ""
        while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
        do

            CONTADOR=$[ $CONTADOR + 1 ] 


            PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
            echo $PISTA

            read -t 20 -p "Introduce la respuesta: " PAL

            PALABRA=$PAL
            echo ""

            if [ "$RESPUESTA" == "$PALABRA" ]; then
                CONTADOR=10
            else
                PUNTUACION=$[ PUNTUACION  - 1 ]
            fi

        done

        NUM=$[ NUM + 1 ]

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
        else
            echo "La próxima vez será" 
            echo -n "La respuesta correcta es: $RESPUESTA"
        fi

        if [ $i -ge $CIE ]; then
            CONFIRMAR="N"
            echo "Lo sentimos, no hay más adivinanzas"
        else
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        fi

        while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
        do
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        done

        if [ "$CONFIRMAR" == "Y" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            echo "Buena suerte"
            echo ""
        elif [ "$CONFIRMAR" == "N" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
            echo $NOMBRE "$PUNTUACIONT $MODALIDAD $CATEG" >> $FICHPUNT
            echo "Puntuación total: $PUNTUACIONT"
            i=$[ NUMERO + 1 ]
        else
            echo "ERROR, INTRODUCE UN VALOR CORRECTO"
        fi
    fi
done
echo ""
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;

"Programación")
NUM=0
CATEG="PROGRAMACIÓN"
for(( i = 1; i <= $NUMERO; i = i + 1 ))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    if [ "$LINEA" == "PROGRAMACIÓN" ]; then
        echo $LINEA

        CONTADOR=0
        PUNTUACION=10
        RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)
        echo ""

        PALABRA=""
        echo ""
        while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
        do

            CONTADOR=$[ $CONTADOR + 1 ] 


            PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
            echo $PISTA

            read -t 20 -p "Introduce la respuesta: " PAL

            PALABRA=$PAL
            echo ""

            if [ "$RESPUESTA" == "$PALABRA" ]; then
                CONTADOR=10
            else
                PUNTUACION=$[ PUNTUACION  - 1 ]
            fi

        done

        NUM=$[ NUM + 1 ]

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
        else
            echo "La próxima vez será" 
            echo -n "La respuesta correcta es: $RESPUESTA"
        fi

        if [ $NUM -ge $PRO ]; then
            CONFIRMAR="N"
            echo "Lo sentimos, no hay más adivinanzas"
        else
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        fi

        while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
        do
            read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
        done

        if [ "$CONFIRMAR" == "Y" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            echo "Buena suerte"
            echo ""
        elif [ "$CONFIRMAR" == "N" ]; then
            PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
            read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
            echo $NOMBRE "$PUNTUACIONT $MODALIDAD $CATEG" >> $FICHPUNT
            echo "Puntuación total: $PUNTUACIONT"
            i=$[ NUMERO + 1 ]
        else
            echo "ERROR, INTRODUCE UN VALOR CORRECTO"
        fi
    fi
done
echo ""
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;

*)

break;;
esac
done

break;;

"Aleatorio")
PUNTUACIONT=0
CONFIRMAR="Y"
MODALIDAD="ALEATORIO"
CATEG="TODO"
while [ "$CONFIRMAR" == "Y" ]
do
    ALEATORIO=$[RANDOM % $NUMERO +1]
    LINEA=$(head -n 1 adivinanza$ALEATORIO.txt)
    echo $LINEA

    CONTADOR=0
    PUNTUACION=10
    RESPUESTA=$(head -n 2 adivinanza$ALEATORIO.txt | tail -n 1)
    echo ""

    PALABRA=""
    echo ""
    while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
    do

        CONTADOR=$[ $CONTADOR + 1 ] 


        PISTA=$(tail -n 10 adivinanza$ALEATORIO.txt | head -n $CONTADOR | tail -n 1)
        echo $PISTA

        read -t 20 -p "Introduce la respuesta: " PAL

        PALABRA=$PAL
        echo ""

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            CONTADOR=10
        else
            PUNTUACION=$[ PUNTUACION  - 1 ]
        fi

    done

    if [ "$RESPUESTA" == "$PALABRA" ]; then
        echo "Correcto, has acertado. Has conseguido $PUNTUACION puntos"
    else
        echo "La próxima vez será" 
        echo -n "La respuesta correcta es : $RESPUESTA"
    fi

    read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR

    while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
    do
        read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
    done

    if [ "$CONFIRMAR" == "Y" ]; then
        PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
        echo "Buena suerte"
        echo ""
    elif [ "$CONFIRMAR" == "N" ]; then
        PUNTUACIONT=$[ PUNTUACION + PUNTUACIONT ]
        read -p "Introduce tu nombre para guardar la puntuación: " NOMBRE
        echo $NOMBRE" "$PUNTUACIONT" "$MODALIDAD" "$CATEG >> $FICHPUNT
        echo "Puntuación total: $PUNTUACIONT"
    else
        echo "ERROR, INTRODUCE UN VALOR CORRECTO"
    fi
done
break;;

"Ránking")
#echo "NOMBRE" "PUNTUACIÓN" "MODALIDAD" "CATEGORÍA"
#echo "$(cat $FICHPUNT)" | sort -k2 -nr 
echo ""
printf "%-25s %-25s %-24s %-25s\n" "NOMBRE" "PUNTUACIÓN" "MODALIDAD" "CATEGORÍA"
printf "%-25s %-24s %-25s %-25s\n" $(cat $FICHPUNT) | sort -k2 -nr
echo ""

echo "Selecciona una opción"
printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
break;;
"Dos Jugadores")
    read -p "Introduce el nombre del Jugador 1: " J1
    read -p "Introduce el nombre del jugador 2: " J2
    echo "Selecciona una opción"

    select OPCIONES in "Normal" "Categorías" "Aleatorio" "Salir"
    do
        while [ "$OPCIONES" != "4" ]
        do
            case $OPCIONES in

            "Normal")
PUNTUACIONTJ1=0
PUNTUACIONTJ2=0
PUNTUACIONT=0
MODALIDAD="NORMAL"
CATEG="TODO"

for(( i = 1; i <= $NUMERO; i = i + 1))
do

    LINEA=$(head -n 1 adivinanza$i.txt)
    echo $LINEA

    CONTADOR=0
    PUNTUACION=10
    RESPUESTA=$(head -n 2 adivinanza$i.txt | tail -n 1)

    echo ""

    PALABRA=""
    echo ""
    while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
    do

        CONTADOR=$[ $CONTADOR + 1 ] 


        PISTA=$(tail -n 10 adivinanza$i.txt | head -n $CONTADOR | tail -n 1)
        echo $PISTA

        read -t 20 -p "Introduce la respuesta: " PAL

        PALABRA=$PAL
        echo ""

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            CONTADOR=10
        else
            PUNTUACION=$[ PUNTUACION  - 1 ]
        fi

    done
    MODULO=$[ PUNTUACION % 2 ]
    if [ "$RESPUESTA" == "$PALABRA" ]; then
        if [ $MODULO -eq 0 ]; then
            echo "Correcto, has acertado. El jugador $J1 ha conseguido $PUNTUACION puntos"
        else
            echo "Correcto, has acertado. El jugador $J2 ha conseguido $PUNTUACION puntos"
        fi

    else
        echo "La próxima vez será"
        echo -n "La respuesta correcta es : $RESPUESTA" 
    fi

    if [ $i == $NUMERO ]; then
        CONFIRMAR="N"
        echo "Lo sentimos, no hay más adivinanzas"
    else
        read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
    fi

    while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
    do
        read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
    done

    if [ "$CONFIRMAR" == "Y" ]; then
        if [ $MODULO -eq 0 ]; then
            PUNTUACIONTJ1=$[ PUNTUACION + PUNTUACIONTJ1 ]
        else
            PUNTUACIONTJ2=$[ PUNTUACION + PUNTUACIONTJ2 ]
        fi
        echo "Buena suerte"
        echo ""
    elif [ "$CONFIRMAR" == "N" ]; then
        PUNTUACIONTJ1=$[ PUNTUACION + PUNTUACIONTJ1 ]
        PUNTUACIONTJ2=$[ PUNTUACION + PUNTUACIONTJ2 ]
        if [ $MODULO -eq 0 ]; then
            echo $J1 "$PUNTUACIONTJ1 $MODALIDAD $CATEG" >> $FICHPUNT
        else
            echo $J2 "$PUNTUACIONTJ2 $MODALIDAD $CATEG" >> $FICHPUNT
        fi

        echo "Puntuación total de $J1: $PUNTUACIONTJ1"
        echo "Puntuación total de $J2: $PUNTUACIONTJ2"
        i=$[ NUMERO + 1 ]
    else
        echo "ERROR, INTRODUCE UN VALOR CORRECTO"
    fi

done
            break;;

            "Categorías")
                echo "Podrás jugar en este modo en actualizaciones futuras. Perdona las molestias"
            break;;

            "Aleatorio")
PUNTUACIONTJ1=0
PUNTUACIONTJ2=0
PUNTUACIONT=0
CONFIRMAR="Y"
MODALIDAD="ALEATORIO"
CATEG="TODO"
while [ "$CONFIRMAR" == "Y" ]
do
    ALEATORIO=$[RANDOM % $NUMERO +1]
    LINEA=$(head -n 1 adivinanza$ALEATORIO.txt)
    echo $LINEA

    CONTADOR=0
    PUNTUACION=10
    RESPUESTA=$(head -n 2 adivinanza$ALEATORIO.txt | tail -n 1)
    echo ""

    PALABRA=""
    echo ""
    while [ "$RESPUESTA" != "$PALABRA" ]  && [ $CONTADOR -lt 10 ]
    do

        CONTADOR=$[ $CONTADOR + 1 ] 


        PISTA=$(tail -n 10 adivinanza$ALEATORIO.txt | head -n $CONTADOR | tail -n 1)
        echo $PISTA

        read -t 20 -p "Introduce la respuesta: " PAL

        PALABRA=$PAL
        echo ""

        if [ "$RESPUESTA" == "$PALABRA" ]; then
            CONTADOR=10
        else
            PUNTUACION=$[ PUNTUACION - 1 ]
        fi

    done

    MODULO=$[ PUNTUACION % 2 ]
    if [ "$RESPUESTA" == "$PALABRA" ]; then
        if [ $MODULO -eq 0 ]; then
            echo "Correcto, has acertado. El jugador $J1 ha conseguido $PUNTUACION puntos"
        else
            echo "Correcto, has acertado. El jugador $J2 ha conseguido $PUNTUACION puntos"
        fi

    else
        echo "La próxima vez será"
        echo -n "La respuesta correcta es : $RESPUESTA" 
    fi

    read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR

    while [ "$CONFIRMAR" != "Y" ] && [ "$CONFIRMAR" != "N" ] 
    do
        read -p "¿Quieres seguir jugando? Y/N " CONFIRMAR
    done

    if [ "$CONFIRMAR" == "Y" ]; then
        if [ $MODULO -eq 0 ]; then
            PUNTUACIONTJ1=$[ PUNTUACION + PUNTUACIONTJ1 ]
        else
            PUNTUACIONTJ2=$[ PUNTUACION + PUNTUACIONTJ2 ]
        fi
        echo "Buena suerte"
        echo ""
    elif [ "$CONFIRMAR" == "N" ]; then
        PUNTUACIONTJ1=$[ PUNTUACION + PUNTUACIONTJ1 ]
        PUNTUACIONTJ2=$[ PUNTUACION + PUNTUACIONTJ2 ]
        if [ $MODULO -eq 0 ]; then
            echo $J1 "$PUNTUACIONTJ1 $MODALIDAD $CATEG" >> $FICHPUNT
        else
            echo $J2 "$PUNTUACIONTJ2 $MODALIDAD $CATEG" >> $FICHPUNT
        fi

        echo "Puntuación total de $J1: $PUNTUACIONTJ1"
        echo "Puntuación total de $J2: $PUNTUACIONTJ2"
        i=$[ NUMERO + 1 ]
    else
        echo "ERROR, INTRODUCE UN VALOR CORRECTO"
    fi
done
            break;;
            "Salir")
            exit
                break;;
            *)
                echo "Opción no válida"
                break;;
        esac
        done
    done
    echo ""
echo "Selecciona una opción"

printf "%-17s %-17s %-15s\n" "1) Normal" "3) Aleatorio" "5) Ránking"
printf "%-18s %-17s %-15s\n" "2) Categorías" "4) Dos Jugadores" "6) Salir"
    break;;
"Salir")
exit
break;;
*)
echo "Opción no válida"
break;;

esac
done
done


