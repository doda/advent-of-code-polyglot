Separate commands between <> like <RET>

Part 1:

:s/!.//g<RET>

:s/!.//g<RET>

:s/<[^>]*>//g<RET>

:s/,//g<RET>

:s/./&<CTRL+V><RET>/g<RET>

:set sw=1<RET>
={

:%s/^/ /<RET>

:v/{/d

:%s/\v([^\{\}]+)./\='+'.strlen(submatch(1))<RET>

GV{J0C<CTRL+R>=<CTRL+R>-<RET><Esc>


Part 2:

:s/!.//g<RET>

:s/\v\<([^>]*)\>/\=strlen(submatch(1))/g<RET>

:s/[{}]//g<RET>

:s/\v,+/+/g<RET>

C<CTRL+R>=<CTRL+R>-<RET><Esc>
