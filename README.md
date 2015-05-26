tumblr.sh
=========

Versão 0.3

Este script baixa as imagens dos blogs do Tumblr.com.

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
./tumblr-v0.3.sh %1 %2 %3 %4 %5"
                  |  |  |  |  |"
                  |  |  |  |  Pasta de destino (. pasta local)"
                  |  |  |  true / false - [true] Imagens em 1280px - [false] Imagens em 500px"
                  |  |  Quantidade de arquivos por pasta - [0] para não criar pasta"
                  |  Quantidade de páginas (ex: 15) ou entre as páginas (ex: 5-20)"
                  URL do tumblr sem http (dominio.com ou site.tumblr.com)"
```
