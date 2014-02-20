;Francisco Afonso Raposo 66986 | Ricardo Daniel da Silva Bento 67065 | Diogo Costa Relvas Garcia 66971 ||| Grupo 90
;Nota: Só os construtores, os testes e os reconhecedores testam os argumentos de forma a não sobrecarregar com código.
;Tipo Pino Chave
;Reconhecedor
(define (pino-chave? arg)
  (if (symbol? arg)
      (or (eq? arg 'red)
          (eq? arg 'aqua)
          (eq? arg 'brown)
          (eq? arg 'orange)
          (eq? arg 'yellow)
          (eq? arg 'lime))
      #f))
;Transformador
(define (pino-chave->string pc)
  (string-append "|pino-chave%" 
                 (symbol->string pc) 
                 "|"))
;Tipo Sequência de Pinos Chave
;Construtor
(define (cria-seq-pinos-chave p1 p2 p3 p4)
  (if (and (pino-chave? p1) 
           (pino-chave? p2) 
           (pino-chave? p3) 
           (pino-chave? p4))
      (list p1 p2 p3 p4)
      (error "cria-seq-pinos-chave :argumento(s) inválido(s) (não é pino-chave)")))
;Selector
(define (elemento-i-seq-pinos-chave s i)
  (cond ((= 1 i) (car s))
        ((= 2 i) (car (cdr s)))
        ((= 3 i) (car (cdr (cdr s))))
        ((= 4 i) (car (cdr (cdr (cdr s)))))))
;Reconhecedor
(define (seq-pinos-chave? arg)
  (if (list? arg)
      (and (pino-chave? (elemento-i-seq-pinos-chave arg 1))
           (pino-chave? (elemento-i-seq-pinos-chave arg 2))
           (pino-chave? (elemento-i-seq-pinos-chave arg 3))
           (pino-chave? (elemento-i-seq-pinos-chave arg 4)))
      #f))
;Teste
(define (seq-pinos-chave=? s1 s2)
  (if (and (seq-pinos-chave? s1)
           (seq-pinos-chave? s2))
      (and (eq? (elemento-i-seq-pinos-chave s1 1) (elemento-i-seq-pinos-chave s2 1))
           (eq? (elemento-i-seq-pinos-chave s1 2) (elemento-i-seq-pinos-chave s2 2))
           (eq? (elemento-i-seq-pinos-chave s1 3) (elemento-i-seq-pinos-chave s2 3))
           (eq? (elemento-i-seq-pinos-chave s1 4) (elemento-i-seq-pinos-chave s2 4)))
      (error "seq-pinos-chave=?:argumento(s) inválido(s) (não é seq-pinos-chave)")))
;Transformador
(define (seq-pinos-chave->string s)
  (string-append "|seq-pinos-chave%" 
                 (pino-chave->string (elemento-i-seq-pinos-chave s 1))
                 "%" 
                 (pino-chave->string (elemento-i-seq-pinos-chave s 2)) 
                 "%" 
                 (pino-chave->string (elemento-i-seq-pinos-chave s 3)) 
                 "%" 
                 (pino-chave->string (elemento-i-seq-pinos-chave s 4)) 
                 "|"))
;Tipo Resposta
;Construtor
(define (faz-resposta p v)
  (if (and (integer? p)
           (integer? v)
           (>= p 0)
           (<= p 4)
           (>= v 0)
           (<= v 4)
           (<= (+ p v) 4)
           (not (= p 3)))
      (cons p v)
      (error "faz-resposta:argumento(s) inválido(s)")))
;Selectores
(define (resposta-pretos r)
  (car r))
(define (resposta-vermelhos r)
  (cdr r))
;Reconhecedor
(define (resposta? arg)
  (if (pair? arg)
      (and (integer? (car arg))
           (integer? (cdr arg))
           (>= (car arg) 0)
           (<= (car arg) 4)
           (>= (cdr arg) 0)
           (<= (cdr arg) 4)
           (<= (+ (car arg) (cdr arg)) 4)
           (not (= (car arg) 3)))
      #f))
;Teste
(define (resposta=? r1 r2)
  (if (and (resposta? r1)
           (resposta? r2))
      (and (= (resposta-pretos r1)
              (resposta-pretos r2))
           (= (resposta-vermelhos r1)
              (resposta-vermelhos r2)))
      (error "resposta=?:argumento(s) inválido(s) (não é resposta)")))
;Transformador
(define (resposta->string r)
  (string-append "|resposta%"
                 (number->string (resposta-pretos r))
                 "%"
                 (number->string (resposta-vermelhos r))
                 "|"))
;Tipo Jogada
;Construtor
(define (faz-jogada s r)
  (if (and (seq-pinos-chave? s)
           (resposta? r))
      (cons s r)
      (error "faz-jogada:argumento(s) inválido(s) (primeiro argumento não é seq-pinos-chave ou segundo argumento não é resposta)")))
;Selectores
(define (jogada-seq-pinos-chave j)
  (car j))
(define (jogada-resposta j)
  (cdr j))
;Reconhecedor
(define (jogada? arg)
  (if (pair? arg)
      (and (seq-pinos-chave? (car arg))
           (resposta? (cdr arg)))
      #f))
;Transformador
(define (jogada->string j)
  (string-append "|jogada%"
                 (seq-pinos-chave->string (jogada-seq-pinos-chave j))
                 "%"
                 (resposta->string (jogada-resposta j))
                 "|"))
;Tipo Jogadas
;Construtores
(define (jogadas j)
  (if (jogada? j)
      (list j j j j j j j j j j j j)
      (error "jogadas:argumento inválido (não é jogada)")))
(define (altera-jogadas js i j)
  (define (altera-jogadas-aux js i j)
    (if (= i 1)
        (cons j (cdr js))
        (cons (car js) (altera-jogadas-aux (cdr js) (- i 1) j))))
  (if (and (jogadas? js)
           (jogada? j)
           (integer? i)
           (>= i 1)
           (<= i 12))
      (altera-jogadas-aux js i j)
      (error "altera-jogadas:argumento inválido (js não é jogadas ou j não é jogada ou i não é inteiro >=1 e <=12")))
;Selector
(define (jogadas-i js i)
  (if (= i 1)
      (car js)
      (jogadas-i (cdr js) (- i 1))))
;Reconhecedor
(define (jogadas? arg)
  (if (list? arg)
      (and (jogada? (jogadas-i arg 1))
           (jogada? (jogadas-i arg 2))
           (jogada? (jogadas-i arg 3))
           (jogada? (jogadas-i arg 4))
           (jogada? (jogadas-i arg 5))
           (jogada? (jogadas-i arg 6))
           (jogada? (jogadas-i arg 7))
           (jogada? (jogadas-i arg 8))
           (jogada? (jogadas-i arg 9))
           (jogada? (jogadas-i arg 10))
           (jogada? (jogadas-i arg 11))
           (jogada? (jogadas-i arg 12)))
      #f))
;Transformador
(define (jogadas->string js)
  (string-append "|jogadas%"
                 (jogada->string (jogadas-i js 1))
                 "%"
                 (jogada->string (jogadas-i js 2))
                 "%"
                 (jogada->string (jogadas-i js 3))
                 "%"
                 (jogada->string (jogadas-i js 4))
                 "%"
                 (jogada->string (jogadas-i js 5))
                 "%"
                 (jogada->string (jogadas-i js 6))
                 "%"
                 (jogada->string (jogadas-i js 7))
                 "%"
                 (jogada->string (jogadas-i js 8))
                 "%"
                 (jogada->string (jogadas-i js 9))
                 "%"
                 (jogada->string (jogadas-i js 10))
                 "%"
                 (jogada->string (jogadas-i js 11))
                 "%"
                 (jogada->string (jogadas-i js 12))
                 "|"))




           
      
  
  



                        







       


  
  



           


           
     