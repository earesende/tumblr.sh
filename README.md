tumblr.sh
=========

v0.1
Este script baixa as imagens dos blogs do Tumblr.com.
A cada 30 páginas verificadas o script cria uma nova pasta para organizar as imagens.

Formato das imagens
```bash
jpg,jpeg,gif,png
```

Modo de Uso
--------------

Conceda permissão de execução no arquivo.
```bash
sudo chmod +x tumblr.sh
```

Acessar o ajuda do script
```bash
./tumblr.sh --help
```

Executando o tumblr.sh
```bash
./tumblr.sh %1 %2 %3 %4 %5"
             |  |  |  |  |"
             |  |  |  |  Pasta de destino (. pasta local)"
             |  |  |  Formato da imagem separado por vírgula (jpg,jpeg,gif,png)"
             |  |  true / false - [true] Cria uma pasta a cada 30 páginas verificadas"
             |  Quantidade de páginas (ex: 10) ou entre as páginas (ex: 5-10)"
             URL do tumblr com http"
```
