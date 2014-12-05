tumblr.sh
=========

Versão 0.2

Este script baixa as imagens dos blogs do Tumblr.com.

A cada 30 páginas verificadas o script cria uma nova pasta para organizar as imagens.

Formato das imagens.
```bash
jpg,jpeg,png
```
Resoluções das imagens.
```bash
500px ou 1280px
```

Modo de Uso
--------------

Conceda permissão de execução no arquivo.
```bash
sudo chmod +x tumblr.sh
```

Acessar o ajuda do script.
```bash
./tumblr.sh --help
```

Executando o script tumblr.sh e inserindo os parâmetros.
```bash
./tumblr.sh %1 %2 %3 %4 %5"
             |  |  |  |  |"
             |  |  |  |  Pasta de destino (. pasta local)"
             |  |  |  true / false - [true] Imagens em 1280px - [false] Imagens em 500px"
             |  |  true / false - [true] Cria uma pasta a cada 30 páginas verificadas"
             |  Quantidade de páginas (ex: 10) ou entre as páginas (ex: 5-10)"
             URL do tumblr sem http (dominio.com ou site.tumblr.com)"
```
