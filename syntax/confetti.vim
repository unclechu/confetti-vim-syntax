" Generic Confetti syntax highlighting.
" Keep the rules independent of the application interpreting the directives.

if exists('b:current_syntax')
  finish
endif

syntax case match

" Confetti comments start with # and finish at the end of the line.
syntax match confettiComment /#.*/ contains=@Spell

" Define triple-quoted strings after ordinary double-quoted strings so that
" the longer delimiter wins when both patterns start at the same position.
syntax region confettiString start=+"+ skip=+\\.+ end=+"+ oneline contains=confettiEscape,@Spell
syntax region confettiTripleString start=+"""+ skip=+\\.+ end=+"""+ contains=confettiEscape,@Spell
syntax match confettiEscape /\\./ contained

" Confetti colors the first bare word of each directive as its name.
" A new directive starts at the beginning of a line or just after a brace
" or semicolon. Other arguments are deliberately left unhighlighted.
" Require a complete bare word so that filenames such as init.c stay plain.
syntax match confettiDirective /^\s*\zs[A-Za-z_][A-Za-z0-9_-]*\ze\%($\|[[:space:]{};]\)/
syntax match confettiInlineDirective /[A-Za-z_][A-Za-z0-9_-]*\ze\%($\|[[:space:]{};]\)/ contained

" Recognize operators only when separated as Confetti arguments, rather
" than coloring hyphens in identifiers or symbols inside quoted strings.
" Check the separator without consuming it, including closing braces.
syntax match confettiOperator /\%(^\|[[:space:]{};]\)\@<=\%(&&\|||\|==\|!=\|<=\|>=\|[<>+*\/-]\)\ze\%($\|[[:space:]{};]\)/

" Numeric-looking arguments can include dots and alphabetic suffixes (3s,
" 4000k, 6.14), but should not color a prefix of an arbitrary identifier.
" The lookbehind checks the separator without consuming it, which also lets
" numbers immediately after an opening brace match after nextgroup checks.
" Confetti leaves the meaning of numeric-looking values to the application.
syntax match confettiNumber /\%(^\|[[:space:]{};]\)\@<=[-+]\=[0-9][0-9_.]*\%([eE][-+]\=[0-9][0-9_]*\)\=[A-Za-z]*\ze\%($\|[[:space:]{};]\)/

" nextgroup recognizes adjacent directives even without an optional ';'.
syntax match confettiDelimiter /[{};]/ nextgroup=confettiInlineDirective skipwhite

highlight default link confettiComment Comment
highlight default link confettiString String
highlight default link confettiTripleString String
highlight default link confettiEscape SpecialChar
highlight default link confettiDirective Function
highlight default link confettiInlineDirective Function
highlight default link confettiOperator Operator
highlight default link confettiNumber Number
highlight default link confettiDelimiter Delimiter

let b:current_syntax = 'confetti'
