"
" This file was automatically generated by riml 0.3.4
" Modify with care!
"
function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

if exists('g:portkey_extension_ember_loaded')
  finish
endif
" included: 'extension_loader.riml'
function! s:ExtensionLoaderConstructor(name)
  let extensionLoaderObj = {}
  let extensionLoaderObj.name = a:name
  let extensionLoaderObj.start = function('<SNR>' . s:SID() . '_s:ExtensionLoader_start')
  let extensionLoaderObj.stop = function('<SNR>' . s:SID() . '_s:ExtensionLoader_stop')
  return extensionLoaderObj
endfunction

function! <SID>s:ExtensionLoader_start() dict
  let extension_cmd = self.name . "#get_extension()"
  let reg_cmd = ":call portkey#add_extension(" . extension_cmd . ")"
  execute ":augroup portkey_extension_" . self.name . "_group"
  execute ":autocmd!"
  execute ":autocmd User portkey_extension_" . self.name . " " . reg_cmd
  execute ":augroup END"
endfunction

function! <SID>s:ExtensionLoader_stop() dict
  execute ":augroup portkey_extension_" . self.name . "_group"
  execute ":autocmd!"
  execute ":augroup END"
endfunction

function! s:EmberPluginConstructor()
  let emberPluginObj = {}
  let emberPluginObj.start = function('<SNR>' . s:SID() . '_s:EmberPlugin_start')
  return emberPluginObj
endfunction

function! <SID>s:EmberPlugin_start() dict
  let self.loader = s:ExtensionLoaderConstructor('ember')
  call self.loader.start()
endfunction

function! s:main()
  let s:plugin = s:EmberPluginConstructor()
  call s:plugin.start()
endfunction

if !(exists('g:speckle_mode'))
  call s:main()
endif
let g:portkey_extension_ember_loaded = 1