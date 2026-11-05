" Use # when inserting or toggling comments in Confetti buffers.
if exists('b:did_ftplugin')
  finish
endif

let b:did_ftplugin = 1
setlocal commentstring=#\ %s
let b:undo_ftplugin = 'setlocal commentstring<'
