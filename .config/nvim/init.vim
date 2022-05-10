set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖХ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:{,фисвуапршолдьтщзйкыегмцчнях;abcdefghijklmnopqrstuvwxyz[

call plug#begin()

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

lua require 'nvim-tree'.setup()
