#lang racket
;PRUEBAS UNITARIAS USANDO LA LIBRERIA RACKUNIT

(require rackunit
         "ResolucionSudoku.rkt")
         

(define matriz ;Uso esta matriz para probar principalmente que la lista de posiciones del 0 no sea muy grande, por eso tiene valores repetidos,si se necesita probar una funcion que necesite que sea coherente se usará otra matriz
  (list
   (list 0 0 0 3 1 2 4 5 6)
   (list 7 2 4 3 1 3 4 5 6)
   (list 7 2 4 3 1 6 4 5 6)
   (list 7 2 7 3 1 8 4 5 6)
   (list 7 2 6 2 1 1 9 5 6)
   (list 7 2 4 3 5 2 4 5 6)
   (list 7 2 4 3 3 2 4 5 6)
   (list 2 2 6 7 1 2 4 5 6)
   (list 7 2 4 3 1 2 4 5 6)
   ))

(check-equal? (buscar_lista_pos_val_0 matriz) '((0 0 0) (0 1 0) (0 2 0)))
(check-equal? (get_cuadrante 3 2) 3)
(check-equal? (getNum matriz 0 3) 3)
(check-equal? (ajustar_matriz matriz '(0 0 0) 4) (list
   (list 4 0 0 3 1 2 4 5 6)
   (list 7 2 4 3 1 3 4 5 6)
   (list 7 2 4 3 1 6 4 5 6)
   (list 7 2 7 3 1 8 4 5 6)
   (list 7 2 6 2 1 1 9 5 6)
   (list 7 2 4 3 5 2 4 5 6)
   (list 7 2 4 3 3 2 4 5 6)
   (list 2 2 6 7 1 2 4 5 6)
   (list 7 2 4 3 1 2 4 5 6)
   ))


(check-equal? (ajustar_matriz_a_fila matriz 0 0 4) (list
   (list 4 0 0 3 1 2 4 5 6)
   (list 7 2 4 3 1 3 4 5 6)
   (list 7 2 4 3 1 6 4 5 6)
   (list 7 2 7 3 1 8 4 5 6)
   (list 7 2 6 2 1 1 9 5 6)
   (list 7 2 4 3 5 2 4 5 6)
   (list 7 2 4 3 3 2 4 5 6)
   (list 2 2 6 7 1 2 4 5 6)
   (list 7 2 4 3 1 2 4 5 6)
   ))


(check-equal? (is_camino_valido matriz '((0 0 0) (0 1 0) (0 2 0))) #f)

(define sudokuTest ; Se usa este de referencia por que con el otro que tiene valores puestos al azar no tendría sentido
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
(check-equal? (get_valores_validos sudokuTest '(0 1 0)) '(3 4 6 7 9))

(check-equal? (comprobar_valor sudokuTest '(0 1 0) 6) #t)
(check-equal? (comprobar_lista (car sudokuTest) 6) #f)
(check-equal? (get_elem_columna sudokuTest 4) '(0 0 7 5 1 4 9 0 0))
(check-equal? (get_elem_cuadrante sudokuTest 0) '(5 0 0 0 2 8 1 0 0))

(define sudokuResuelto
  (list
   (list 5 6 7 8 3 9 4 2 1)
   (list 9 2 8 4 6 1 5 7 3)
   (list 1 3 4 2 7 5 9 8 6)
   (list 4 8 3 6 5 2 1 9 7)
   (list 7 5 6 9 1 3 2 4 8)
   (list 2 1 9 7 4 8 3 6 5)
   (list 6 7 5 1 9 4 8 3 2)
   (list 8 4 1 3 2 6 7 5 9)
   (list 3 9 2 5 8 7 6 1 4)
   ))
(check-equal? (is_matriz_completa sudokuResuelto) #t)
(check-equal? (is_sudoku_correctamente_completo sudokuResuelto) #t)
(check-equal? (is_correcto_sumatorio_filas sudokuResuelto) #t)
(check-equal? (is_correcto_sumatorio_columna sudokuResuelto) #t)
(check-equal? (is_correcto_sumatorio_cuadrante sudokuResuelto) #t)
(check-equal? (suma_lista (car sudokuResuelto) )45)
(check-equal? (is_valida_lista (car sudokuResuelto)) #t)
(check-equal? (is_posible_resolver_sudoku sudokuResuelto) #t)
