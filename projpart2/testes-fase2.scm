
(require (lib "misc.ss" "swindle")
         (lib "list.ss")
         (lib "lset.ss" "srfi" "1")
         (lib "trace.ss"))

;;
;; Ficheiro com código a testar
;;
;; Nota: o ficheiro tem que que estar na mesma directoria ou 
;;       então tem que ser fornecido o caminho até ao ficheiro.

;;
;; Grupo a testar
;;
(define *grupo* 90)
(load (string-append "FP0910-parte2-grupo" (number->string *grupo*) ".scm"))

(define jogador-grupo (string->symbol (string-append "cria-jogador" (number->string *grupo*))))
(define jogador-grupo-lambda (eval jogador-grupo))

(define cria-jogador jogador-grupo)

(define (set-jogador-lambda! fn)
  (eval `(set! ,jogador-grupo ,fn)))
(define (unset-jogador-lambda!)
  (eval `(set! ,jogador-grupo ,jogador-grupo-lambda)))


(define (cria-jogador-adivinha s)
  (lambda (tipo)
    (define (proc . args)
      s)
    (lambda (tipo1)
      proc)))

(define (cria-jogador-segredo s r)
  (lambda (tipo)
    (define (proc1 . args)
       s)
    (define (proc2 . args)
      r)
    (lambda (tipo1)
       (if (eq? tipo1 'responde-adivinha)
          proc2
          proc1))))


;; Interface
(define fpmm-inicia-jogo 0)
(define fpmm-inicia-jogo-c 0)
(define fpmm-escreve-linha 0)
(define fpmm-escreve-linha-c 0)
(define fpmm-apaga-linha 0)
(define fpmm-apaga-linha-c 0)
(define fpmm-pede-adivinha 0)
(define fpmm-pede-adivinha-c 0)
(define fpmm-mostra-adivinha 0)
(define fpmm-mostra-adivinha-c 0)
(define fpmm-mostra-resposta 0)
(define fpmm-mostra-resposta-c 0)
(define fpmm-pede-segredo 0)
(define fpmm-pede-segredo-c 0)
(define fpmm-mostra-segredo 0)
(define fpmm-mostra-segredo-c 0)
(define fpmm-pede-continuar 0)
(define fpmm-pede-continuar-c 0)
(define fpmm-fim-jogo 0)
(define fpmm-fim-jogo-c 0)

(define fpmm-mostra-adivinha-s 0)
(define fpmm-mostra-adivinha-l 0)          
(define fpmm-mostra-resposta-s 0)
(define fpmm-mostra-resposta-l 0)          
(define fpmm-mostra-segredo-s 0)
(define fpmm-fim-jogo-s 0)


(define (mostra-int)
  (newline)
  (display "fpmm-inicia-jogo-c: ") (display fpmm-inicia-jogo-c) (newline)
  (display "fpmm-escreve-linha-c: ") (display fpmm-escreve-linha-c) (newline)
  (display "fpmm-apaga-linha-c: ") (display fpmm-apaga-linha-c) (newline)
  (display "fpmm-pede-adivinha-c: ") (display fpmm-pede-adivinha-c) (newline)
  (display "fpmm-mostra-adivinha-c: ") (display fpmm-mostra-adivinha-c) (newline)
  (display "fpmm-mostra-resposta-c: ") (display fpmm-mostra-resposta-c) (newline)
  (display "fpmm-pede-segredo-c: ")(display fpmm-pede-segredo-c) (newline)
  (display "fpmm-mostra-segredo-c: ") (display fpmm-mostra-segredo-c) (newline)
  (display "fpmm-pede-continuar-c: ") (display fpmm-pede-continuar-c) (newline)
  (display "fpmm-fim-jogo-c: ") (display fpmm-fim-jogo-c) (newline))  
  
(define (fpmm-cria-interface)
  (set! fpmm-inicia-jogo-c 0)
  (set! fpmm-inicia-jogo
        (lambda ()
          (set! fpmm-inicia-jogo-c (+ 1 fpmm-inicia-jogo-c))))
  (set! fpmm-escreve-linha-c 0)
  (set! fpmm-escreve-linha
        (lambda (texto l)
          (set! fpmm-escreve-linha-c (+ 1 fpmm-escreve-linha-c))))
  (set! fpmm-apaga-linha-c 0)
  (set! fpmm-apaga-linha
        (lambda (l)
          (set! fpmm-apaga-linha-c (+ 1 fpmm-apaga-linha-c))))
  (set! fpmm-pede-adivinha-c 0)
  (set! fpmm-pede-adivinha
        (lambda (l)
          (set! fpmm-pede-adivinha-c (+ 1 fpmm-pede-adivinha-c))))
  (set! fpmm-mostra-adivinha-c 0)
  (set! fpmm-mostra-adivinha
        (lambda (adivinha l)
          (set! fpmm-mostra-adivinha-s adivinha)
          (set! fpmm-mostra-adivinha-l l)          
          (set! fpmm-mostra-adivinha-c (+ 1 fpmm-mostra-adivinha-c))))
  (set! fpmm-mostra-resposta-c 0)
  (set! fpmm-mostra-resposta
        (lambda (resposta l)
          (set! fpmm-mostra-resposta-s resposta)
          (set! fpmm-mostra-resposta-l l)          
          (set! fpmm-mostra-resposta-c (+ 1 fpmm-mostra-resposta-c))))
  (set! fpmm-pede-segredo-c 0)
  (set! fpmm-pede-segredo
        (lambda ()
          (set! fpmm-pede-segredo-c (+ 1 fpmm-pede-segredo-c))))
  (set! fpmm-mostra-segredo-c 0)
  (set! fpmm-mostra-segredo
        (lambda (s)
          (set! fpmm-mostra-segredo-s s)
          (set! fpmm-mostra-segredo-c (+ 1 fpmm-mostra-segredo-c))))
  (set! fpmm-pede-continuar-c 0)
  (set! fpmm-pede-continuar
        (lambda ()
          (set! fpmm-pede-continuar-c (+ 1 fpmm-pede-continuar-c))))
  (set! fpmm-fim-jogo-c 0)
  (set! fpmm-fim-jogo
        (lambda (t)
          (set! fpmm-fim-jogo-s t)
          (set! fpmm-fim-jogo-c (+ 1 fpmm-fim-jogo-c))))
  (lambda (tipo)
    (eval tipo)))


;; TAI teste
(define (cria-teste nome forma erro?)
  (cons erro? (cons nome forma)))

;; Nome do teste
(define (nome-teste teste)
  (cadr teste))

;; Código a ser avaliado
(define (forma-teste teste)
  (cddr teste))

;; Indica se a avaliação do código deve gerar um erro de execução
(define (erro?-teste teste)
  (car teste))


;; Definição dos testes
(define *ts*
  (list
   ;; TAI pino-chave
   (cria-teste "teste pino-chave 01" '(eq? (pino-chave? 'red) #t) #f)
   (cria-teste "teste pino-chave 02" '(eq? (pino-chave? 'cyan) #f) #f)
   (cria-teste "teste pino-chave 03" '(eq? (pino-chave? 12) #f) #f)
   (cria-teste "teste pino-chave 04" '(string=? (pino-chave->string 'red) "|pino-chave%red|") #f)
   ;; TAI seq-pinos-chave
   (cria-teste "teste seq-pinos-chave 01" 
               '(eq? (cria-seq-pinos-chave 'red 'cyan 'red 'red) 0) #t)
   (cria-teste "teste seq-pinos-chave 02" 
               '(eq? (elemento-i-seq-pinos-chave (cria-seq-pinos-chave 'red 'orange 'aqua 'lime) 1) 'red) #f)
   (cria-teste "teste seq-pinos-chave 03" 
               '(eq? (elemento-i-seq-pinos-chave (cria-seq-pinos-chave 'red 'orange 'aqua 'lime) 4) 'lime) #f)
   (cria-teste "teste seq-pinos-chave 04" 
               '(eq? (seq-pinos-chave? (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) #t) #f)
   (cria-teste "teste seq-pinos-chave 05" 
               '(eq? (seq-pinos-chave? 12) #f) #f)
   (cria-teste "teste seq-pinos-chave 06" 
               '(eq? (seq-pinos-chave=? (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)
                                        (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) #t) #f)
   (cria-teste "teste seq-pinos-chave 07" 
               '(eq? (seq-pinos-chave=? (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)
                                        (cria-seq-pinos-chave 'orange 'red 'aqua 'lime)) #f) #f)
   (cria-teste "teste seq-pinos-chave 08" 
               '(eq? (seq-pinos-chave=? (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)
                                        (cria-seq-pinos-chave 'red 'red 'aqua 'lime)) #f) #f)
   (cria-teste "teste seq-pinos-chave 09" '(string=? (seq-pinos-chave->string (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                                                     "|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||") #f)
   ;; TAI resposta
   (cria-teste "teste resposta 01" 
               '(eq? (faz-resposta 'red 'cyan) 0) #t)
   (cria-teste "teste resposta 02" 
               '(= (resposta-pretos (faz-resposta 4 0)) 4) #f)
   (cria-teste "teste resposta 03" 
               '(= (resposta-vermelhos (faz-resposta 0 4)) 4) #f)
   (cria-teste "teste resposta 04" 
               '(= (resposta-pretos (faz-resposta 4 -1)) 0) #t)
   (cria-teste "teste resposta 05" 
               '(= (resposta-vermelhos (faz-resposta 5 4)) 0) #t)
   (cria-teste "teste resposta 06" 
               '(eq? (resposta? (faz-resposta 4 0)) #t) #f)
   (cria-teste "teste resposta 07" 
               '(eq? (resposta? 12) #f) #f)
   (cria-teste "teste resposta 08" 
               '(eq? (resposta=? (faz-resposta 0 4) (faz-resposta 0 4)) #t) #f)
   (cria-teste "teste resposta 09" 
               '(eq? (resposta=? (faz-resposta 0 4) (faz-resposta 1 1)) #f) #f)
   (cria-teste "teste resposta 10" '(string=? (resposta->string (faz-resposta 0 4)) "|resposta%0%4|") #f)
   ;; TAI jogada
   (cria-teste "teste jogada 01" 
               '(eq? (faz-jogada 'red 'cyan) #f) #t)
   (cria-teste "teste jogada 02" 
               '(faz-jogada (cria-seq-pinos-chave 'red 'orange 'aqua 'lime) (faz-resposta 4 0)) #f)
   (cria-teste "teste jogada 03" 
               '(let ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                      (r1 (faz-resposta 4 0)))
                  (eq? (resposta=? (jogada-resposta (faz-jogada s1 r1)) r1) #t)) #f)
   (cria-teste "teste jogada 04" 
               '(let ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                      (r1 (faz-resposta 4 0)))
                  (eq? (seq-pinos-chave=? (jogada-seq-pinos-chave (faz-jogada s1 r1)) s1) #t)) #f)
   (cria-teste "teste jogada 05" 
               '(let ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                      (r1 (faz-resposta 4 0)))
                  (eq? (jogada? (faz-jogada s1 r1)) #t)) #f)
   (cria-teste "teste jogada 06" 
               '(eq? (jogada? 'lime) #f) #f)
   (cria-teste "teste jogada 07" 
               '(let ((s1 (cria-seq-pinos-chave 'red 'red 'aqua 'lime)) 
                      (r1 (faz-resposta 4 0)))
                  (string=? (jogada->string (faz-jogada s1 r1))
                            "|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%red|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||")) #f)
   ;; TAI jogadas
   (cria-teste "teste jogadas 01" 
               '(eq? (jogadas 'cyan) 0) #t)
   (cria-teste "teste jogadas 02" 
               '(let* ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                       (r1 (faz-resposta 4 0))
                       (j1 (faz-jogada s1 r1)))
                  (eq? (jogadas? (jogadas j1)) #t)) #f)
   (cria-teste "teste jogadas 03" 
               '(let* ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                       (r1 (faz-resposta 4 0))
                       (j1 (faz-jogada s1 r1)))
                  (eq? (jogada? (jogadas-i (jogadas j1) 1)) #t)) #f)
   (cria-teste "teste jogadas 05" 
               '(let* ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                       (r1 (faz-resposta 4 0))
                       (j1 (faz-jogada s1 r1)))
                  (eq? (jogada? (jogadas-i (jogadas j1) 12)) #t)) #f)
   (cria-teste "teste jogadas 07" 
               '(let* ((s1 (cria-seq-pinos-chave 'red 'orange 'aqua 'lime)) 
                       (r1 (faz-resposta 4 0))
                       (j1 (faz-jogada s1 r1)))
                  (string=? (jogadas->string (jogadas j1))
                            "|jogadas%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0||%|jogada%|seq-pinos-chave%|pino-chave%red|%|pino-chave%orange|%|pino-chave%aqua|%|pino-chave%lime||%|resposta%4%0|||"
                            )) #f)
   
   
   (cria-teste "teste jogador 01" 
               '(procedure? (eval cria-jogador)) #f)

   (cria-teste "teste jogador 02" 
               '(procedure? ((eval cria-jogador) 'segredo)) #f)

   (cria-teste "teste jogador 03" 
               '(procedure? ((eval cria-jogador) 'adivinha)) #f)

   (cria-teste "teste jogador 04" 
               '(procedure? ((eval cria-jogador) 'xpto)) #t)

   (cria-teste "teste jogador 04" 
               '(let ((j ((eval cria-jogador) 'segredo)))
                  (seq-pinos-chave? (em j 'novo-segredo))) #f)

   (cria-teste "teste jogador 05" 
               '(let* ((j ((eval cria-jogador) 'segredo))
                       (s (em j 'novo-segredo)))
                  (resposta? (em j 'responde-adivinha s))) #f)

   (cria-teste "teste jogador 06" 
               '(let* ((j ((eval cria-jogador) 'segredo))
                       (s (em j 'novo-segredo))
                       (r (faz-resposta 4 0)))
                  (resposta=? r (em j 'responde-adivinha s))) #f)

   (cria-teste "teste jogador 07" 
               '(let* ((j ((eval cria-jogador) 'segredo))
                       (s (em j 'novo-segredo))
                       (s1 (cria-seq-pinos-chave 'white 'white 'white 'white))
                       (r (faz-resposta 0 0)))
                  (resposta=? r (em j 'responde-adivinha s1))) #f)

   (cria-teste "teste jogador 08" 
               '(let ((j ((eval cria-jogador) 'adivinha)))
                  (seq-pinos-chave? (em j 'adivinha))) #f)

   (cria-teste "teste jogador 09" 
               '(let* ((j1 ((eval cria-jogador) 'adivinha))
                       (s1 (em j1 'adivinha))
                       (j2 ((eval cria-jogador) 'segredo))
                       (s2 (em j2 'novo-segredo))
                       (r2 (em j2 'responde-adivinha s1)))
                  (em j1 'recebe-resposta r2)
                  #t) #f)

 
   ;; Jogador automático: Explorador
   ;; (em mm-controle ’novo-segredo <seq-pinos-chave>)
   ;; (em mm-controle ’continuar)
   (cria-teste "teste controle 01"
               '(begin (mastermind 'teste 'adivinha)
                       (procedure? (cria-controle 'teste 'adivinha))) #f)

   (cria-teste "teste controle 02"
               '(begin (mastermind 'teste 'adivinha)
                       (and
                        (= fpmm-inicia-jogo-c 1)
                        (> fpmm-escreve-linha-c 0)
                        ;(= fpmm-apaga-linha-c 0)
                        (= fpmm-pede-adivinha-c 0)
                        (= fpmm-mostra-adivinha-c 0)
                        (= fpmm-mostra-resposta-c 0)
                        (= fpmm-pede-segredo-c 1)
                        (= fpmm-mostra-segredo-c 0)
                        (= fpmm-pede-continuar-c 0)
                        (= fpmm-fim-jogo-c 0))) #f)
   
   (cria-teste "teste controle 03"
               '(begin (mastermind 'teste 'adivinha)
                       (let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua)))
                         (em mm-controle 'novo-segredo s1)
                         (and
                          (= fpmm-inicia-jogo-c 1)
                          (> fpmm-escreve-linha-c 0)
                          ;(= fpmm-apaga-linha-c 0)
                          (= fpmm-pede-adivinha-c 0)
                          (= fpmm-mostra-adivinha-c 1)
                          (= fpmm-mostra-resposta-c 1)
                          (= fpmm-pede-segredo-c 1)
                          (= fpmm-mostra-segredo-c 1)
                          (= fpmm-pede-continuar-c 1)
                          (= fpmm-fim-jogo-c 0)))) #f)

      (cria-teste "teste controle 04"
                  '(let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua))
                          (s2 (cria-seq-pinos-chave 'red 'red 'lime 'aqua))
                          (r2 (faz-resposta 3 0)))
                     (set-jogador-lambda! (cria-jogador-adivinha s2))
                     (mastermind 'teste 'adivinha)
                     (em mm-controle 'novo-segredo s1)
                     (unset-jogador-lambda!)
                     
                     (and
                      (= fpmm-inicia-jogo-c 1)
                      (> fpmm-escreve-linha-c 0)
                      ;(= fpmm-apaga-linha-c 0)
                      (= fpmm-pede-adivinha-c 0)
                      (= fpmm-mostra-adivinha-c 1)
                      (seq-pinos-chave=? fpmm-mostra-adivinha-s s2)
                      (= fpmm-mostra-resposta-c 1)
                      (resposta=? fpmm-mostra-resposta-s r2)
                      (= fpmm-pede-segredo-c 1)
                      (>= fpmm-mostra-segredo-c 1)
                      (seq-pinos-chave=? fpmm-mostra-segredo-s s1)
                      (= fpmm-pede-continuar-c 1)
                      (= fpmm-fim-jogo-c 0))) #f)

      (cria-teste "teste controle 05"
                  '(let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua))
                          (s2 (cria-seq-pinos-chave 'red 'red 'lime 'aqua))
                          (r2 (faz-resposta 4 0)))
                     (set-jogador-lambda! (cria-jogador-adivinha s1))
                     (mastermind 'teste 'adivinha)
                     (em mm-controle 'novo-segredo s1)
                     (unset-jogador-lambda!)
                     
                     (and
                      (= fpmm-inicia-jogo-c 1)
                      (> fpmm-escreve-linha-c 0)
                      ;(= fpmm-apaga-linha-c 0)
                      (= fpmm-pede-adivinha-c 0)
                      (= fpmm-mostra-adivinha-c 1)
                      (seq-pinos-chave=? fpmm-mostra-adivinha-s s1)
                      (= fpmm-mostra-resposta-c 1)
                      (resposta=? fpmm-mostra-resposta-s r2)
                      (= fpmm-pede-segredo-c 1)
                      (= fpmm-mostra-segredo-c 1)
                      (seq-pinos-chave=? fpmm-mostra-segredo-s s1)
                      (= fpmm-pede-continuar-c 0)
                      (= fpmm-fim-jogo-c 1))) #f)
      
      (cria-teste "teste controle 06"
                  '(let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua))
                          (s2 (cria-seq-pinos-chave 'red 'red 'lime 'aqua))
                          (r2 (faz-resposta 3 0)))
                     (set-jogador-lambda! (cria-jogador-adivinha s2))
                     (mastermind 'teste 'adivinha)
                     (em mm-controle 'novo-segredo s1)
                     ;;(display fpmm-mostra-adivinha-s)(newline)
                     (em mm-controle 'continuar)
                     ;;(display fpmm-mostra-adivinha-s)(newline)
                     (unset-jogador-lambda!)
                     
                     (and
                      (= fpmm-inicia-jogo-c 1)
                      (> fpmm-escreve-linha-c 0)
                      ;(= fpmm-apaga-linha-c 0)
                      (= fpmm-pede-adivinha-c 0)
                      (= fpmm-mostra-adivinha-c 2)
                      (seq-pinos-chave=? fpmm-mostra-adivinha-s s2)
                      (= fpmm-mostra-resposta-c 2)
                      (resposta=? fpmm-mostra-resposta-s r2)
                      (= fpmm-pede-segredo-c 1)
                      (>= fpmm-mostra-segredo-c 1)
                      (seq-pinos-chave=? fpmm-mostra-segredo-s s1)
                      (= fpmm-pede-continuar-c 1)
                      (= fpmm-fim-jogo-c 1))) #f)
      
   (cria-teste "teste controle 07"
               '(begin (mastermind 'teste 'adivinha)
                       (let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua)))
                         (em mm-controle 'novo-segredo s1)
                         (em mm-controle 'continuar)
                         (and
                          (= fpmm-inicia-jogo-c 1)
                          (> fpmm-escreve-linha-c 0)
                          ;(= fpmm-apaga-linha-c 0)
                          (= fpmm-pede-adivinha-c 0)
                          (= fpmm-mostra-adivinha-c 2)
                          (= fpmm-mostra-resposta-c 2)
                          (= fpmm-pede-segredo-c 1)
                          (= fpmm-mostra-segredo-c 1)
                          (= fpmm-pede-continuar-c 2)
                          (= fpmm-fim-jogo-c 0)))) #f)
     
  (cria-teste "teste controle 08"
               '(begin (mastermind 'teste 'adivinha)
                       (let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua)))
                         (em mm-controle 'novo-segredo s1)
                         (em mm-controle 'continuar)
                         (em mm-controle 'continuar)
                         (and
                          (= fpmm-inicia-jogo-c 1)
                          (> fpmm-escreve-linha-c 0)
                          ;(= fpmm-apaga-linha-c 0)
                          (= fpmm-pede-adivinha-c 0)
                          (= fpmm-mostra-adivinha-c 3)
                          (= fpmm-mostra-resposta-c 3)
                          (= fpmm-pede-segredo-c 1)
                          (= fpmm-mostra-segredo-c 1)
                          (= fpmm-pede-continuar-c 3)
                          (= fpmm-fim-jogo-c 0)))) #f)

   ;; Jogador automático: Guardião do Segredo
   ;; (em mm-controle ’nova-adivinha <seq-pinos-chave>)
   (cria-teste "teste controle 11"
               '(begin (mastermind 'teste 'segredo)
                       (procedure? (cria-controle 'teste 'segredo))) #f)

   (cria-teste "teste controle 12"
               '(begin (mastermind 'teste 'segredo)
                       (and
                        (= fpmm-inicia-jogo-c 1)
                        (> fpmm-escreve-linha-c 0)
                        ;(= fpmm-apaga-linha-c 0)
                        (= fpmm-pede-adivinha-c 1)
                        (= fpmm-mostra-adivinha-c 0)
                        (= fpmm-mostra-resposta-c 0)
                        (= fpmm-pede-segredo-c 0)
                        (= fpmm-mostra-segredo-c 0)
                        (= fpmm-pede-continuar-c 0)
                        (= fpmm-fim-jogo-c 0))) #f)

   (cria-teste "teste controle 13"
               '(begin (mastermind 'teste 'segredo)
                       (let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua)))
                         (em mm-controle 'nova-adivinha s1)
                         (and
                          (= fpmm-inicia-jogo-c 1)
                          (> fpmm-escreve-linha-c 0)
                          ;(= fpmm-apaga-linha-c 0)
                          (= fpmm-pede-adivinha-c 2)
                         
                          (= fpmm-mostra-adivinha-c 1)
;                          (= fpmm-mostra-adivinha-l 0)
                          (seq-pinos-chave=? fpmm-mostra-adivinha-s s1)
                          
;                          (= fpmm-mostra-resposta-c 1)
;                          (= fpmm-mostra-resposta-l 0)
                          
                          (= fpmm-pede-segredo-c 0)
;                          (= fpmm-mostra-segredo-c 0)
                          (= fpmm-pede-continuar-c 0)
;                          (= fpmm-fim-jogo-c 0)
                          ))) #f)
   
   (cria-teste "teste controle 14"
               '(begin (mastermind 'teste 'segredo)
                       (let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua))
                              (s2 (cria-seq-pinos-chave 'red 'yellow 'aqua 'lime)))
                         (em mm-controle 'nova-adivinha s1)
                         (em mm-controle 'nova-adivinha s2)
                         (and
                          (= fpmm-inicia-jogo-c 1)
                          (> fpmm-escreve-linha-c 0)
                          ;(= fpmm-apaga-linha-c 0)
                          (= fpmm-pede-adivinha-c 3)

                          (= fpmm-mostra-adivinha-c 2)
;                          (= fpmm-mostra-adivinha-l 1)
                          (seq-pinos-chave=? fpmm-mostra-adivinha-s s2)

;                          (= fpmm-mostra-resposta-c 2)
;                          (= fpmm-mostra-resposta-l 1)
                          
                          (= fpmm-pede-segredo-c 0)
;                          (= fpmm-mostra-segredo-c 0)
                          (= fpmm-pede-continuar-c 0)
;                          (= fpmm-fim-jogo-c 0)
                          ))) #f)

   (cria-teste "teste controle 15"
               '(let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua))
                       (s2 (cria-seq-pinos-chave 'red 'red 'lime 'aqua))
                       (r1 (faz-resposta 3 0)))
                  (set-jogador-lambda! (cria-jogador-segredo s1 r1))
                  (mastermind 'teste 'segredo)
                  (em mm-controle 'nova-adivinha s2)
                  (unset-jogador-lambda!)
                  
                  (and
                   (= fpmm-inicia-jogo-c 1)
                   (> fpmm-escreve-linha-c 0)
                   ;(= fpmm-apaga-linha-c 0)
                   (= fpmm-pede-adivinha-c 2)
                   
                   (= fpmm-mostra-adivinha-c 1)
;                   (= fpmm-mostra-adivinha-l 0)
                   (seq-pinos-chave=? fpmm-mostra-adivinha-s s2)
                   
;                   (= fpmm-mostra-resposta-c 1)
;                   (= fpmm-mostra-resposta-l 0)
;                   (resposta=? fpmm-mostra-resposta-s r1)
                   
                   (= fpmm-pede-segredo-c 0)
;                   (= fpmm-mostra-segredo-c 0)
                   (= fpmm-pede-continuar-c 0)
;                   (= fpmm-fim-jogo-c 0)
                   )) #f)

      (cria-teste "teste controle 16"
               '(let* ((s1 (cria-seq-pinos-chave 'red 'yellow 'lime 'aqua))
                       (r1 (faz-resposta 4 0)))
                  (set-jogador-lambda! (cria-jogador-segredo s1 r1))
                  (mastermind 'teste 'segredo)
                  (em mm-controle 'nova-adivinha s1)
                  (unset-jogador-lambda!)
                  
                  (and
                   (= fpmm-inicia-jogo-c 1)
                   (> fpmm-escreve-linha-c 0)
                   ;(= fpmm-apaga-linha-c 0)
                   (= fpmm-pede-adivinha-c 1)
                   
                   (= fpmm-mostra-adivinha-c 1)
;                   (= fpmm-mostra-adivinha-l 0)
                   (seq-pinos-chave=? fpmm-mostra-adivinha-s s1)
                   
                   (= fpmm-mostra-resposta-c 1)
;                   (= fpmm-mostra-resposta-l 0)
                   (resposta=? fpmm-mostra-resposta-s r1)
                   
                   (= fpmm-pede-segredo-c 0)
                   (= fpmm-mostra-segredo-c 1)
                   (seq-pinos-chave=? fpmm-mostra-segredo-s s1)
                   
                   (= fpmm-pede-continuar-c 0)
                   (= fpmm-fim-jogo-c 1)
                   )) #f)

   
   ))

(define (testa testes)
  (dolist (teste testes)
          (let ((res (no-errors (eval (forma-teste teste)))))
            (newline)
            (display (nome-teste teste))
            (cond ((and (eq? res #f) (erro?-teste teste)) (display " - Passou."))
                  ((eq? res #f) (display " - FALHOU."))
                  (else (display " - Passou."))))))

(testa *ts*)
                