# Kit de teste: filmes 1080p na HostGator

Esta pasta é um teste. Ela não faz parte do site publicado no Vercel.

## O que tem aqui
- `index.html`: página de teste com os 8 filmes do site embutidos em 1080p.
- `encode.sh`: gera os MP4 em 1080p a partir dos masters.
- `posters/`: imagens de capa dos 8 filmes (já existentes no site).

## Passo 1: gerar os arquivos (no Mac)
1. Instale o ffmpeg: `brew install ffmpeg`
2. No Terminal, dentro desta pasta:
   `./encode.sh "/Users/usuario/Desktop/Animamus/Reel" ./filmes`
3. O script cria a pasta `filmes/` com os oito arquivos. Cada um sai com 1920x1080, H.264, CRF 21 e `faststart`.

## Passo 2: conferir antes de subir
- Abra cada `.mp4` no QuickTime e veja se a imagem e o som estão corretos.
- Confira a duração: deve bater com a do master (ex.: Chilli Beans 30s, Bourbon 60s).

## Passo 3: subir na HostGator (cPanel → Gerenciador de arquivos)
1. Em `public_html`, crie a pasta `teste-1080`. Não mexa em `animamus-ajustes`, `index.html`, `og.jpg` nem no zip.
2. Dentro de `teste-1080`, envie:
   - `index.html`
   - a pasta `posters/` (com as 8 imagens)
   - a pasta `filmes/` (com os 8 MP4)
   Para arquivos acima de 300 MB, use FTP (FileZilla).
3. Abra `animamus.art.br/teste-1080/` no navegador e confira se os vídeos tocam.

## Passo 4: decidir
- Se a qualidade e o carregamento estiverem bons, a mesma estrutura serve para o site final.
- Os filmes ainda não publicados (Accenture Segurança BH, Aegea, gCash, Comgás e Ray-Ban case) entram depois, quando forem aprovados.

## Pontos de atenção
- O Wellhub é 4K no master. O script já reduz para 1080.
- Vídeos de 4 minutos em 8 Mbps ocupam cerca de 240 MB por visualização.
- Não há CDN na hospedagem compartilhada. Para visitas em massa, esse é o gargalo.
