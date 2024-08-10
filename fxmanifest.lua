fx_version "adamant"
games {"gta5", "rdr3"}

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
    "cl_msg.lua"
}

server_scripts {
    "sv_msg.lua"
}

ui_page "html/index.html"

files {
    "html/index.html", -- Arquivo HTML principal
    "html/images/icon.png", -- Imagem do ícone utilizada no HTML
    "html/images/background.png" -- Imagem de fundo utilizada no HTML
}