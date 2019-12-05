#lang racket

;Se permite exportar las funciones del programa para realizar las pruebas unitarias desde un archivo externo
(provide buscar_lista_pos_val_0
         get_cuadrante
         getNum
         ajustar_matriz
         ajustar_matriz_a_fila
         is_camino_valido
         get_valores_validos
         comprobar_valor
         comprobar_lista
         get_elem_columna
         get_elem_cuadrante
         is_matriz_completa
         is_sudoku_correctamente_completo
         is_correcto_sumatorio_filas
         is_correcto_sumatorio_columna
         is_correcto_sumatorio_cuadrante
         suma_lista
         is_valida_lista
         is_posible_resolver_sudoku)


(define sudokuTest1
  (list
   (list 5 0 0 0 0 0 0 0 0)
   (list 0 2 8 4 0 0 5 0 3)
   (list 1 0 0 2 7 0 0 0 6)
   (list 0 0 3 0 5 2 1 9 0)
   (list 7 0 6 0 1 0 2 0 8)
   (list 0 1 9 7 4 0 3 0 0)
   (list 6 0 0 0 9 4 0 0 2)
   (list 8 0 1 0 0 6 7 5 0)
   (list 0 0 0 0 0 0 0 0 4)
   ))
(define sudokuTest2
  (list
   (list 5 6 0 0 0 4 1 0 0)
   (list 0 7 0 6 0 0 0 3 0)
   (list 0 0 0 1 2 0 0 6 0)
   (list 0 0 0 3 0 0 6 9 2)
   (list 0 8 0 0 7 0 0 4 0)
   (list 4 3 2 9 0 6 0 0 0)
   (list 0 5 0 0 9 7 0 0 0)
   (list 0 2 0 0 0 1 0 5 0)
   (list 0 0 9 5 0 0 0 8 6)
   ))

(define sudokuTest3
  (list
   (list 0 0 4 0 3 0 0 6 0)
   (list 1 6 0 0 0 2 0 3 0)
   (list 9 0 2 8 0 6 4 5 0)
   (list 0 0 0 0 6 0 9 1 0)
   (list 0 0 0 0 0 0 0 0 0)
   (list 0 1 8 0 5 0 0 0 0)
   (list 0 2 6 1 0 5 3 0 4)
   (list 0 7 0 6 0 0 0 8 2)
   (list 0 4 0 0 2 0 6 0 0)
   ))

(define sudokuTest4
  (list
   (list 0 0 0 0 0 4 8 0 0)
   (list 0 2 0 0 0 3 0 1 0)
   (list 6 0 1 0 0 0 7 0 5)
   (list 5 8 0 0 0 9 0 7 0)
   (list 0 0 4 0 0 0 5 0 0)
   (list 0 1 0 7 0 0 0 8 6)
   (list 4 0 3 0 0 0 9 0 2)
   (list 0 6 0 3 0 0 0 4 0)
   (list 0 0 2 6 0 0 0 0 0)
   ))

(define sudokuTest5
  (list
   (list 9 0 8 0 0 2 0 0 0)
   (list 0 0 0 0 7 0 0 5 8)
   (list 0 7 0 0 0 9 0 0 0)
   (list 0 9 4 0 1 8 5 0 7)
   (list 5 0 0 0 9 0 0 0 1)
   (list 2 0 1 7 6 0 3 9 0)
   (list 0 0 0 5 0 0 0 3 0)
   (list 8 1 0 0 3 0 0 0 0)
   (list 0 0 0 9 0 0 7 0 6)
   ))

(define sudokuTest6
  (list
   (list 0 1 0 9 4 2 7 0 0)
   (list 0 0 0 6 0 0 2 0 0)
   (list 2 0 0 0 7 1 9 0 0)
   (list 4 8 0 0 0 0 0 0 2)
   (list 7 0 0 0 0 0 0 0 9)
   (list 1 0 0 0 0 0 0 8 6)
   (list 0 0 7 8 2 0 0 0 1)
   (list 0 0 1 0 0 9 0 0 0)
   (list 0 0 8 5 1 6 0 2 0)
   ))
(define sudokuTest7
  (list
   (list 6 1 0 3 5 4 0 9 0)
   (list 0 9 0 0 0 0 0 0 4)
   (list 8 4 0 0 9 0 6 1 0)
   (list 0 3 0 4 0 0 8 0 0)
   (list 0 0 0 9 6 1 0 0 0)
   (list 0 0 1 0 0 3 0 5 0)
   (list 0 6 4 0 3 0 0 8 2)
   (list 2 0 0 0 0 0 0 3 0)
   (list 0 8 0 5 1 2 0 6 9)
   ))

(define sudokuTest8
  (list
   (list 5 0 0 3 4 0 0 0 1)
   (list 0 1 4 0 0 6 3 7 0)
   (list 7 0 3 9 0 8 4 0 0)
   (list 2 7 9 0 0 0 0 0 0)
   (list 0 4 0 0 0 0 0 3 0)
   (list 0 0 0 0 0 0 6 1 7)
   (list 0 0 7 2 0 3 8 0 6)
   (list 0 5 6 8 0 0 1 2 0)
   (list 8 0 0 0 6 4 0 0 9)
   ))
(define sudokuTest9
  (list
   (list 0 0 5 0 0 7 0 6 8)
   (list 0 0 0 0 0 0 0 0 0)
   (list 9 8 0 6 3 0 2 7 0)
   (list 0 0 6 1 0 0 0 2 4)
   (list 0 0 0 0 4 0 0 0 0)
   (list 2 3 0 0 0 8 9 0 0)
   (list 0 5 8 0 1 3 0 9 2)
   (list 0 0 0 0 0 0 0 0 0)
   (list 4 6 0 2 0 0 5 0 0)
   ))
(define sudokuTest10
  (list
   (list 1 0 0 0 9 6 0 0 0)
   (list 0 9 0 3 5 7 0 6 8)
   (list 0 0 0 0 8 0 7 0 0)
   (list 0 1 0 7 0 0 6 5 0)
   (list 0 0 0 0 0 0 0 0 0)
   (list 0 3 4 0 0 9 0 8 0)
   (list 0 0 1 0 7 0 0 0 0)
   (list 9 8 0 1 6 4 0 7 0)
   (list 0 0 0 5 3 0 0 0 6)
   ))
(define sudokuTest11
  (list
   (list 0 0 0 2 1 9 0 0 6)
   (list 0 2 7 6 0 0 0 0 5)
   (list 0 0 0 5 0 3 8 0 0)
   (list 1 0 0 0 9 0 0 6 0)
   (list 7 0 0 1 0 8 0 0 3)
   (list 0 9 0 0 4 0 0 0 7)
   (list 0 0 9 8 0 1 0 0 0)
   (list 8 0 0 0 0 6 5 3 0)
   (list 5 0 0 9 3 7 0 0 0)
   ))
(define sudokuTest12
  (list
   (list 3 5 0 2 0 0 8 9 0)
   (list 0 4 0 7 0 8 0 0 0)
   (list 1 0 8 0 3 0 0 0 0)
   (list 4 0 5 0 7 2 0 1 0)
   (list 0 0 6 8 0 1 9 0 0)
   (list 0 9 0 3 5 0 2 0 7)
   (list 0 0 0 0 2 0 3 0 5)
   (list 0 0 0 6 0 5 0 2 0)
   (list 0 1 2 0 0 3 0 6 9)
   ))
(define sudokuTest13
  (list
   (list 1 6 0 9 3 0 0 8 0)
   (list 0 0 0 1 0 0 0 0 9)
   (list 0 0 0 8 5 0 1 3 0)
   (list 9 0 5 0 1 0 6 4 2)
   (list 0 0 0 0 0 0 0 0 0)
   (list 4 8 2 0 6 0 5 0 1)
   (list 0 4 3 0 8 2 0 0 0)
   (list 5 0 0 0 0 3 0 0 0)
   (list 0 2 0 0 9 1 0 5 6)
   ))
(define sudokuTest14
  (list
   (list 0 0 0 0 6 3 0 5 4)
   (list 1 0 5 7 0 0 0 2 3)
   (list 0 6 7 0 0 2 0 0 0)
   (list 0 0 0 0 4 0 3 8 6)
   (list 8 0 0 5 0 6 0 0 1)
   (list 4 1 6 0 9 0 0 0 0)
   (list 0 0 0 8 0 0 1 6 0)
   (list 6 3 0 0 0 7 8 0 5)
   (list 7 8 0 6 1 0 0 0 0)
   ))
(define sudokuTest15
  (list
   (list 0 5 4 6 2 0 0 0 0)
   (list 6 0 7 0 0 8 0 3 1)
   (list 8 0 0 0 0 5 2 0 4)
   (list 0 0 0 9 0 1 0 7 0)
   (list 7 0 0 5 0 4 0 0 6)
   (list 0 9 0 7 0 2 0 0 0)
   (list 3 0 1 8 0 0 0 0 2)
   (list 2 8 0 3 0 0 4 0 9)
   (list 0 0 0 0 1 6 3 8 0)
   ))

(define sudokuTest16
  (list
   (list 9 7 0 0 0 3 4 5 0)
   (list 1 0 0 0 2 4 0 3 0)
   (list 4 3 0 0 0 9 2 0 6)
   (list 7 0 4 8 0 0 0 0 0)
   (list 0 9 0 0 0 0 0 8 0)
   (list 0 0 0 0 0 2 7 0 5)
   (list 2 0 7 9 0 0 0 6 8)
   (list 0 4 0 3 6 0 0 0 7)
   (list 0 5 3 2 0 0 0 9 4)
   ))
(define sudokuTest17
  (list
   (list 3 0 8 0 0 0 0 0 0)
   (list 0 0 0 0 4 0 5 0 7)
   (list 6 7 0 0 5 8 0 1 9)
   (list 1 8 0 0 0 0 0 0 0)
   (list 7 9 0 8 2 3 0 4 5)
   (list 0 0 0 0 0 0 0 9 3)
   (list 4 6 0 7 8 0 0 3 1)
   (list 2 0 9 0 1 0 0 0 0)
   (list 0 0 0 0 0 0 4 0 6)
   ))
(define sudokuTest18
  (list
   (list 0 7 6 0 0 3 0 0 0)
   (list 0 0 0 8 0 0 6 0 0)
   (list 3 0 0 0 5 0 0 2 4)
   (list 7 8 3 5 0 0 0 9 0)
   (list 1 2 9 6 0 8 7 4 5)
   (list 0 4 0 0 0 7 8 1 3)
   (list 8 5 0 0 6 0 0 0 2)
   (list 0 0 7 0 0 1 0 0 0)
   (list 0 0 0 4 0 0 3 8 0)
   ))
(define sudokuTest19 
  (list
   (list 0 0 0 0 0 8 0 0 0)
   (list 3 0 8 0 0 0 7 0 0)
   (list 2 9 4 7 0 0 0 8 1)
   (list 4 0 0 8 6 0 0 7 0)
   (list 0 0 0 0 0 0 0 0 0)
   (list 0 7 0 0 9 2 0 0 6)
   (list 6 5 0 0 0 1 2 4 3)
   (list 0 0 3 0 0 0 8 0 9)
   (list 0 0 0 5 0 0 0 0 0)
   ))
(define sudokuTest20 
  (list
   (list 8 0 0 4 6 0 0 0 0)
   (list 0 0 0 0 1 0 0 0 9)
   (list 0 7 0 3 0 8 6 0 0)
   (list 2 0 0 0 0 0 0 9 0)
   (list 3 8 0 0 7 0 0 2 1)
   (list 0 5 0 0 0 0 0 0 8)
   (list 0 0 4 5 0 6 0 1 0)
   (list 5 0 0 4 0 0 0 0 0)
   (list 0 0 0 0 9 3 0 0 6)
   ))

(define (buscar_lista_pos_val_0 matriz) ; Obtiene la lista de las posiciones en donde su valor es 0
  (for*/list ([i 9]
             [j 9]
             #:when (zero? (list-ref (list-ref matriz i) j)))
    (list i j (get_cuadrante i j))))
    
(define (get_cuadrante i j) ; Obtiene el cuadrante indicado por la fila y la columna de una posición
  ; Dado que se trata de un sudoku 9x9, hay 9 cuadrantes. Cada condición representa un cuadrante diferente
  (cond [(and (equal? (quotient i 3) 0) (equal? (quotient j 3) 0)) 0] 
        [(and (equal? (quotient i 3) 0) (equal? (quotient j 3) 1)) 1]
        [(and (equal? (quotient i 3) 0) (equal? (quotient j 3) 2)) 2]
        [(and (equal? (quotient i 3) 1) (equal? (quotient j 3) 0)) 3]
        [(and (equal? (quotient i 3) 1) (equal? (quotient j 3) 1)) 4]
        [(and (equal? (quotient i 3) 1) (equal? (quotient j 3) 2)) 5]
        [(and (equal? (quotient i 3) 2) (equal? (quotient j 3) 0)) 6]
        [(and (equal? (quotient i 3) 2) (equal? (quotient j 3) 1)) 7]
        [(and (equal? (quotient i 3) 2) (equal? (quotient j 3) 2)) 8]
        [else -1]))

(define (imprimir_matriz matriz) ; Imprime la matriz mostrada por parámetro en un sudoku 9x9
  (for* ([i 9] [j 9])
    (cond
      [(and (= j 0) (or (= i 0) (= i 3)(= i 6))) (printDiv) (printf "| ~a " (getNum matriz i j))]
      [(= j 0) (printf "| ~a " (getNum matriz i j))]
      [(= j 2) (printf "~a | " (getNum matriz i j))]
      [(= j 5) (printf "~a | " (getNum matriz i j))]
      [(= j 8) (printf "~a |\n" (getNum matriz i j))]
      [else (printf "~a " (getNum matriz i j))]))
    (printDiv))

(define (printDiv) ; Imprime la cabecera de las líneas superiores e inferiores de cada cuadrante en un sudoku 9x9
  (for ([i 25])
    (if (or (= i 0) (= i 8) (= i 16) (= i 24))
        (printf "+")
        (printf "-")))
    (printf "\n"))

(define (getNum matriz i j) ; Obtiene el valor de una posición del sudoku.
  (list-ref (list-ref matriz i) j))

(define (ajustar_matriz matriz pos_elem_val_0 valor)
  ;Obtener la matriz ajustando el valor pasado por parámetro en la posición indicada por parámetro (la posición se encuentra en una lista que proporciona la fila, la columna y el cuadrante). 
  (ajustar_matriz_a_fila matriz (list-ref pos_elem_val_0 0) (list-ref pos_elem_val_0 1) valor))

(define (ajustar_matriz_a_fila matriz fila columna valor)
  ;Obtiene la matriz ajustada de manera recursiva teniendo en cuenta que si la fila es la que tiene el elemento que se desea cambiar, en esa fila uno de sus elementos será cambiado.
  ;El resto de filas no se modificarán.
  (cond
    [(empty? matriz) '()]
    [(equal? fila 0) (append (list (ajustar_matriz_a_columna (car matriz) columna valor)) (cdr matriz))]
    [else (append (list (car matriz)) (ajustar_matriz_a_fila (cdr matriz) (- fila 1) columna valor))]))

(define (ajustar_matriz_a_columna lista columna valor) ;Obtiene la lista que representa una fila de la matriz con el valor cambiado en uno de sus elementos
  (cond
    [(empty? lista) '()]
    [(equal? columna 0) (append (list valor) (cdr lista))] ; Sino funciona cdr lista, probar  (ajustar_matriz_a_columna (cdr lista) (- columna 1) valor)
    [else (append (list (car lista)) (ajustar_matriz_a_columna (cdr lista) (- columna 1) valor))]))

(define (set_pos_vacias_profundidad matriz lista_pos_val_0 num_operacion_pasos_intermedios num_paso) ; Poner valores en las posiciones en búsqueda en profundidad con valor 0 en matrices NxN
  (cond
    [(empty? lista_pos_val_0) (printf "Paso ~a, paso final:\n" num_paso)(imprimir_matriz matriz)
     matriz]; Éxito, no quedan más elementos con valor 0
    [(equal? (length (get_valores_validos matriz (car lista_pos_val_0))) 0)
     (cond [(equal? (string->number num_operacion_pasos_intermedios) 1) (printf "Paso ~a, paso intermedio:\nCamino no válido.\n" num_paso)(imprimir_matriz matriz)] [else (printf "")])
     ; Se ha llegado a un nodo que no tiene hijos
     matriz]; No hay valores válidos para esta posición
    [else
     (let ([lista_pos_validos (get_valores_validos matriz (car lista_pos_val_0))])
            (for/first ([i (length lista_pos_validos)]
                  #:when (equal? (is_camino_valido (ajustar_matriz matriz (car lista_pos_val_0) (list-ref lista_pos_validos i)) (cdr lista_pos_val_0)) #t)) ; Se cogerá el primero de la lista que dé éxito
              (cond [(equal? num_operacion_pasos_intermedios 1) (printf "Paso ~a, paso intermedio:\n" num_paso)(imprimir_matriz (ajustar_matriz matriz (car lista_pos_val_0) (list-ref lista_pos_validos i)))]
                    [else(printf "")])
              (set_pos_vacias_profundidad (ajustar_matriz matriz (car lista_pos_val_0) (list-ref lista_pos_validos i)) (cdr lista_pos_val_0) num_operacion_pasos_intermedios (+ num_paso 1)))
            )]))

(define (is_camino_valido matriz lista_pos_val_0)
  (cond
  [(empty? lista_pos_val_0) #t]; Éxito, no quedan más elementos con valor 0
  [(equal? (length (get_valores_validos matriz (car lista_pos_val_0))) 0) #f]; No hay valores válidos para esta posición
  [else
   (let ([lista_pos_validos (get_valores_validos matriz (car lista_pos_val_0))])
     (for/first ([i (length lista_pos_validos)]
                 #:when (equal? (is_camino_valido (ajustar_matriz matriz (car lista_pos_val_0) (list-ref lista_pos_validos i)) (cdr lista_pos_val_0)) #t))
       ; Se cogerá el primero de la lista que dé éxito
       #t))]))

(define (set_pos_vacias_anchura sucesores num_operacion_pasos_intermedios num_paso) ; Poner valores en las posiciones en búsqueda en anchura con valor 0 en un sudoku NxN
  (cond
    [(empty? (list-ref (car sucesores) 1))
     (printf "Paso ~a, paso final:\n" num_paso)(imprimir_matriz (car(car sucesores)))
     (car(car sucesores))] ;En caso de que no quede ningún elemento en la lista de posición con valor 0
    [(equal? (length (get_valores_validos (car(car sucesores)) (car(list-ref (car sucesores) 1)))) 0)
     (cond [(equal? num_operacion_pasos_intermedios 1)
         (printf "Paso ~a, paso intermedio.\n La matriz en este paso no tiene hijos.\n" num_paso)(imprimir_matriz (car(car sucesores)))] [else (printf "")])
     
     (set_pos_vacias_anchura (cdr sucesores)  num_operacion_pasos_intermedios (+ num_paso 1))] ;En caso de que no tenga hijos, pasa al siguiente elemento de la lista de sucesores
    [else
     (cond [(equal? num_operacion_pasos_intermedios 1) (printf "Paso ~a, paso intermedio:\n" num_paso)(imprimir_matriz (car(car sucesores)))] [else (printf "")])
     (let ([lista_pos_validos (get_valores_validos (car(car sucesores)) (car(list-ref (car sucesores) 1)))])
       (set_pos_vacias_anchura (introducir_hijos(car sucesores) lista_pos_validos (cdr sucesores)) num_operacion_pasos_intermedios (+ num_paso 1)))]))
                                                                      
(define (introducir_hijos nodo_padre lista_pos_validos sucesores); Introduce los sudokus obtenidos del sudoku padre estudiado en la lista de sucesores
  (if(empty? lista_pos_validos) sucesores ; Los hijos ya se encuentran introducidos en la lista de sucesores
     (introducir_hijos nodo_padre (cdr lista_pos_validos)
                       (append sucesores (list(list (ajustar_matriz(car nodo_padre)(car(list-ref nodo_padre 1))(car lista_pos_validos)) (cdr (list-ref nodo_padre 1))))))))

(define (get_valores_validos matriz pos_val_0) ;Obtiene los valores que puede tener una casilla
    (for/list ([i (in-range 1 10)]
             #:when (equal? (comprobar_valor matriz pos_val_0 i) #t))
      i))

(define (comprobar_valor matriz pos_val_0 valor)   ;Verifica si un valor se puede introducir en una posición de acuerdo a la fila, a la columna y al cuadrante
  (cond
    [(equal? (length pos_val_0) 0) #f]
    [(or
      (comprobar_lista(list-ref matriz (car pos_val_0)) valor) ; Comprueba la fila
      (comprobar_lista(get_elem_columna matriz (list-ref pos_val_0 1)) valor) ; Comprueba la columna
      (comprobar_lista(get_elem_cuadrante matriz (list-ref pos_val_0 2))valor)) ; ; Comprueba el cuadrante
    #f] ; El valor ya se encuentra en el sudoku
    [else #t])) ; El valor no ha sido usado en el sudoku

(define (comprobar_lista  fila  valor) ; Comprueba si un valor se encuentra entre los elementos de una lista ya fuera una fila, una columna o un cuadrante
  (for/first ([i (length fila)]
            #:when (equal? valor (list-ref fila i)))
  #t))

(define (get_elem_columna matriz num_columna) ; Obtiene los elementos que forman una columna en forma de lista
  (for*/list ([i 9]
             [j 9]
             #:when (equal? num_columna j))
    (list-ref (list-ref matriz i) j)))

(define (get_elem_cuadrante matriz num_cuadrante) ; Obtiene los elementos que forman un cuadrante en forma de lista
  (for*/list ([i 9]
             [j 9]
             #:when (equal? (get_cuadrante i j) num_cuadrante))
    (list-ref(list-ref matriz i) j)))
          

(define (is_matriz_completa matriz) ; Verifica si a la matriz le queda algún cero
  (if (empty? (buscar_lista_pos_val_0 matriz)) #t #f))

(define (is_sudoku_correctamente_completo matriz) ; Comprueba si una matriz ha sido completado correctamente
  (if (and(is_correcto_sumatorio_filas matriz)(is_correcto_sumatorio_columna matriz)(is_correcto_sumatorio_cuadrante matriz)) #t #f))
; Todo sudoku que se encuentre correctamente resuelto, deben sumar todos sus cuadrantes, sus columnas y sus filas, tienen que tener el mismo resultado del sumatorio de los valores de sus celdas

(define (is_correcto_sumatorio_filas matriz) ; Obtiene si el sumatorio de todas las filas de la matriz es igual
  (for/and ([i (length matriz)])
        (equal? (suma_lista (list-ref matriz i)) 45)))

(define (is_correcto_sumatorio_columna matriz) ; Obtiene si el sumatorio de todas las columna de la matriz es igual
  (for/and ([i (length matriz)])
        (equal? (suma_lista (get_elem_columna matriz i)) 45)))

(define (is_correcto_sumatorio_cuadrante matriz) ; Obtiene si el sumatorio de todas las cuadrante de la matriz es igual
  (for/and ([i (length matriz)])
        (equal? (suma_lista (get_elem_cuadrante matriz i)) 45)))

(define (suma_lista lista) ; Obtiene el sumatorio de las celdas de una lista
  (foldr + 0 lista))

(define (is_valida_lista lista) ; Comprueba si no hay elementos repetidos distintos a 0
  (for*/and ([i (- (length lista) 1)][j (in-range (+ i 1) (length lista))])
    (or (not (equal? (list-ref lista i) (list-ref lista j)))(equal? (list-ref lista i) 0)(equal? (list-ref lista j) 0))))
    
(define (is_posible_resolver_sudoku matriz) ; Valida si se puede resolver una matriz
  (for/and ([i (length matriz)])
    (and (equal? (is_valida_lista (list-ref matriz i)) #t)(equal? (is_valida_lista (get_elem_columna matriz i)) #t)(equal? (is_valida_lista (get_elem_cuadrante matriz i)) #t))))

(define (resolver_matriz_profundidad matriz num_operacion_pasos_intermedios) ; Resuelve el sudoku por profundidad, verifica que es válido y lo muestra por pantalla si es así
  (define lista_pos_val_0 (buscar_lista_pos_val_0 matriz))
  (printf "Búsqueda en profundidad:\n")
  (define matriz_resuelta (set_pos_vacias_profundidad matriz lista_pos_val_0 num_operacion_pasos_intermedios 0))
  (cond
      [(and (equal? (is_matriz_completa matriz_resuelta) #t) (equal? (is_sudoku_correctamente_completo matriz_resuelta) #t))
        (printf "El sudoku ha sido resuelto correctamente.\n")(printf "Resultado:\n")
        (imprimir_matriz matriz_resuelta)]
      [(equal? (is_matriz_completa matriz_resuelta) #f) (printf "El sudoku no ha sido completado.\n")]
      [else (printf "El sudoku no ha sido correctamente completado.\n")]))


(define (resolver_matriz_anchura matriz num_operacion_pasos_intermedios) ; Resuelve el sudoku por profundidad, verifica que es válido y lo muestra por pantalla si es así
  (define lista_pos_val_0 (buscar_lista_pos_val_0 matriz))
  (printf "Búsqueda en anchura\n")
  (define matriz_resuelta (set_pos_vacias_anchura (list(list matriz lista_pos_val_0)) num_operacion_pasos_intermedios 0))
  (cond
      [(and (equal? (is_matriz_completa matriz_resuelta) #t) (equal? (is_sudoku_correctamente_completo matriz_resuelta) #t))
        (printf "El sudoku ha sido resuelto correctamente.\n")(printf "Resultado:\n")
        (imprimir_matriz matriz_resuelta)]
      [(equal? (is_matriz_completa matriz_resuelta) #f) (printf "El sudoku no ha sido completado.\n")]
      [else (printf "El sudoku no ha sido correctamente completado.\n")]))

(define (menu_seleccion_sudoku) ; Permite seleccionar uno de los sudokus proporcionados
  (printf "Seleccione un sudoku a estudiar entre el 1 el 20:\n")
  (define num_sudoku (read-line (current-input-port) 'any))
  (if (and (> (string->number num_sudoku) 0) (<= (string->number num_sudoku) 20))
      (seleccionar_sudoku (string->number num_sudoku))
      ""
  ))

(define (seleccionar_sudoku num_sudoku) ; Retorna el sudoku asignado al número pasado por parámetro
  (cond
    [(equal? num_sudoku 1) sudokuTest1]
    [(equal? num_sudoku 2) sudokuTest2]
    [(equal? num_sudoku 3) sudokuTest3]
    [(equal? num_sudoku 4) sudokuTest4]
    [(equal? num_sudoku 5) sudokuTest5]
    [(equal? num_sudoku 6) sudokuTest6]
    [(equal? num_sudoku 7) sudokuTest7]
    [(equal? num_sudoku 8) sudokuTest8]
    [(equal? num_sudoku 9) sudokuTest9]
    [(equal? num_sudoku 10) sudokuTest10]
    [(equal? num_sudoku 11) sudokuTest11]
    [(equal? num_sudoku 12) sudokuTest12]
    [(equal? num_sudoku 13) sudokuTest13]
    [(equal? num_sudoku 14) sudokuTest14]
    [(equal? num_sudoku 15) sudokuTest15]
    [(equal? num_sudoku 16) sudokuTest16]
    [(equal? num_sudoku 17) sudokuTest17]
    [(equal? num_sudoku 18) sudokuTest18]
    [(equal? num_sudoku 19) sudokuTest19]
    [(equal? num_sudoku 20) sudokuTest20]))

(define (menu sudoku) ; Menú para la selección del tipo de búsqueda y aparición de pasos intermedios además de la resolución de un sudoku 
  (printf "Matriz inicial:\n")
  (imprimir_matriz sudoku)
  (printf "Seleccione un método de búsqueda:\n 1. Búsqueda en profundidad.\n 2. Búsqueda en anchura.\n")
  (define num_operacion (read-line (current-input-port) 'any))
  (printf "Seleccione si desea que aparezcan los pasos intermedios o solo el resultado final:\n")
  (printf "1. Inclusión pasos intermedios.\n")
  (printf "2. Omisión pasos intermedios.\n")
  (define num_operacion_pasos_intermedios (read-line (current-input-port) 'any))
  (printf "Tiempo de inicio: ~a milisegundos.\n" (current-milliseconds))
  (cond
    [(equal? num_operacion "1")
     (if (and (equal? (is_posible_resolver_sudoku sudoku) #t)(or (equal? (string->number num_operacion_pasos_intermedios) 1)(equal? (string->number num_operacion_pasos_intermedios) 2)))
      (resolver_matriz_profundidad sudoku (string->number num_operacion_pasos_intermedios))
      (printf "No se puede resolver el sudoku.\n"))
     (printf "Se salió del programa.\n")]
    [(equal? num_operacion "2")
     (if (and (equal? (is_posible_resolver_sudoku sudoku) #t)(or (equal? (string->number num_operacion_pasos_intermedios) 1)(equal? (string->number num_operacion_pasos_intermedios) 2)))
      (resolver_matriz_anchura sudoku (string->number num_operacion_pasos_intermedios))
      (printf "No se puede resolver el sudoku.\n"))
     (printf "Se salió del programa.\n")]
    [else (printf "Se salió del programa.\n")])
  (printf "Tiempo de fin: ~a milisegundos.\n" (current-milliseconds))
  )
  
(define (main) ; Inicia el programa para resolver un sudoku
  (define sudoku (menu_seleccion_sudoku))
  (if(equal? sudoku "")
     (printf "No existe ningún sudoku con el valor introducido.\n")
     (menu sudoku))
  )
;(main)

