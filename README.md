# project-denoising-image
Adaptive median filter denoising

It is done based on research paper. Here we developed two algorithms:
1) MODPA - based on base paper . advantage is that computaionaly fast
2)MOD2PA - modified algorithm based on base paper .  advantage- better PSNR than MODPA but computationaly expensive

matlab code for MODPA - basepaperalgomod.m
matlab code for MOD2PA - modifieednewalgo.m


NOTE: these matlab codes work only on square sized images like 512x512 or 256x256 so on...(better use 512x512 or 256x256 for better working)
Our MOD2PA algo scored 18.9 PSNR on 99% applied noise on lena.png
