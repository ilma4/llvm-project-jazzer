; RRUN: llc < %s -march=x86 -mattr=+mmx,+sse -mtriple=i686-apple-darwin9 -o - | grep pinsrd | count 2
; MMX insertelement is not available; these are promoted to XMM.
; (Without SSE they are split to two ints, and the code is much better.)

define x86_mmx @mmx_movzl(x86_mmx %x) nounwind  {
entry:
        %tmp = bitcast x86_mmx %x to <2 x i32> 
	%tmp3 = insertelement <2 x i32> %tmp, i32 32, i32 0		; <<2 x i32>> [#uses=1]
	%tmp8 = insertelement <2 x i32> %tmp3, i32 0, i32 1		; <<2 x i32>> [#uses=1]
        %tmp9 = bitcast <2 x i32> %tmp8 to x86_mmx
	ret x86_mmx %tmp9
}
