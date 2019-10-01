Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5BC2B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 02:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfJAAIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 20:08:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfJAAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:08:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so1184781wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 17:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=67Mr/6O8Y4cHHYsguOm2P8LaictF0tLKtq+mSEkr+qI=;
        b=TmGELoLMS9Yd8Ahc9JPAlUjQpv+EtQUSXaT85SoeSiZJy5REobrwdOAUegpunkrC82
         zs1qKkJFiPmGUgissTjlXdQvlaJMgIi/uJeo7ZWmduItHHGv/prOVcrazytiaOB0BAbz
         Ht5TGkxMpLPaGIAgF+a78NAFSuatRbmkvyiUVHHZ4Cr8Mt4GUFZ4pilR0adWmmAu/BZs
         LsCHCuU+QOq1SXtheDLmKbdqK9vDm7dHnpXxUDOelU2VtxwVbVwcUQu0amOkzC2jcbJm
         CayuWJscwI7OyYkwD8gwRV6obKus28KgeeNXIfdEOmgPwz7N+OrOPpMPF/IDUQsMYlYl
         aTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=67Mr/6O8Y4cHHYsguOm2P8LaictF0tLKtq+mSEkr+qI=;
        b=CtRY0Y3+4FVrZUtsZIhs2HTABW4ICVHWBYQ+dpb+NaOiuiGRJwAqwCOw+4ghZQ9ghg
         MVcgnwstQH1lQJiTiCyTyM6tfeSoYsuwSg5Hbkl4AdtOh80nO8pCacZaKG8W8q6aiCoe
         XX3Jp0H1/OSi8MrSuVUbKXbGuVemK2ZbzxaB9bX+zwJskgVjoc0DOMK3+UdIsnKZUu4B
         zNiYGx9lSEsFG/RVM8uR8CGJzlwfWZmEjSvSYsyWxdtezjWWhZRpO1j0zRajDkK3YbvD
         H9Cl00SAbqsU954koZrXPf0PecqfEagbqjEdQLrUJ0ttl8tB5vgaZzI+kjI356OUfoun
         WSmQ==
X-Gm-Message-State: APjAAAVNWCN3DQznjaCzk4cd1eIhmmqcJCIXcQ7UqnX7ssdvtTfRij/8
        op/S/BRncE36rkalHi+adw8MRA==
X-Google-Smtp-Source: APXvYqzsEEqR1d02Yz1JjmNopqogec2uM7OhdvlcmOA1I3mj7x4q48Wghuv/9JIQ+Sa7bZvCYISV8Q==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr1211015wmu.139.1569888526519;
        Mon, 30 Sep 2019 17:08:46 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b62sm1953868wmc.13.2019.09.30.17.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 17:08:45 -0700 (PDT)
Message-ID: <5d92990d.1c69fb81.aea25.ad10@mx.google.com>
Date:   Mon, 30 Sep 2019 17:08:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc1
X-Kernelci-Branch: clk-next
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: clk
Subject: clk/clk-next boot bisection: v5.4-rc1 on bcm2837-rpi-3-b-32
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        tomeu.vizoso@collabora.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

clk/clk-next boot bisection: v5.4-rc1 on bcm2837-rpi-3-b-32

Summary:
  Start:      54ecb8f7028c Linux 5.4-rc1
  Details:    https://kernelci.org/boot/id/5d92746459b514e473d857e7
  Plain log:  https://storage.kernelci.org//clk/clk-next/v5.4-rc1/arm/bcm28=
35_defconfig/gcc-8/lab-baylibre/boot-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org//clk/clk-next/v5.4-rc1/arm/bcm28=
35_defconfig/gcc-8/lab-baylibre/boot-bcm2837-rpi-3-b.html
  Result:     ac7c3e4ff401 compiler: enable CONFIG_OPTIMIZE_INLINING forcib=
ly

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       clk
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
  Branch:     clk-next
  Target:     bcm2837-rpi-3-b-32
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     bcm2835_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit ac7c3e4ff401b304489a031938dbeaab585bfe0a
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Sep 25 16:47:42 2019 -0700

    compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
    =

    Commit 9012d011660e ("compiler: allow all arches to enable
    CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable this
    option.  A couple of build errors were reported by randconfig, but all =
of
    them have been ironed out.
    =

    Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely (and it
    will simplify the 'inline' macro in compiler_types.h), this commit chan=
ges
    it to always-on option.  Going forward, the compiler will always be
    allowed to not inline functions marked 'inline'.
    =

    This is not a problem for x86 since it has been long used by
    arch/x86/configs/{x86_64,i386}_defconfig.
    =

    I am keeping the config option just in case any problem crops up for ot=
her
    architectures.
    =

    The code clean-up will be done after confirming this is solid.
    =

    Link: http://lkml.kernel.org/r/20190830034304.24259-1-yamada.masahiro@s=
ocionext.com
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Acked-by: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b1b1703a646..93d97f9b0157 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -311,7 +311,7 @@ config HEADERS_CHECK
 	  relevant for userspace, say 'Y'.
 =

 config OPTIMIZE_INLINING
-	bool "Allow compiler to uninline functions marked 'inline'"
+	def_bool y
 	help
 	  This option determines if the kernel forces gcc to inline the functions
 	  developers have marked 'inline'. Doing so takes away freedom from gcc to
@@ -322,8 +322,6 @@ config OPTIMIZE_INLINING
 	  decision will become the default in the future. Until then this option
 	  is there to test gcc for this.
 =

-	  If unsure, say N.
-
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [ebd47c8434064687ab6641e837144e0a3ea3872d] Merge branches 'clk-bulk=
-fix', 'clk-at91' and 'clk-sprd' into clk-next
git bisect good ebd47c8434064687ab6641e837144e0a3ea3872d
# bad: [54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c] Linux 5.4-rc1
git bisect bad 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
# good: [8b53c76533aa4356602aea98f98a2f3b4051464c] Merge branch 'linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 8b53c76533aa4356602aea98f98a2f3b4051464c
# good: [574cc4539762561d96b456dbc0544d8898bd4c6e] Merge tag 'drm-next-2019=
-09-18' of git://anongit.freedesktop.org/drm/drm
git bisect good 574cc4539762561d96b456dbc0544d8898bd4c6e
# good: [7e2f2a0cd17cfc42acb4b6a293d5cb6c7eda9862] mm, page_owner: record p=
age owner for each subpage
git bisect good 7e2f2a0cd17cfc42acb4b6a293d5cb6c7eda9862
# bad: [972a2bf7dfe39ebf49dd47f68d27c416392e53b1] Merge tag 'nfs-for-5.4-1'=
 of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect bad 972a2bf7dfe39ebf49dd47f68d27c416392e53b1
# good: [9c9fa97a8edbc3668dfc7a25de516e80c146e86f] Merge branch 'akpm' (pat=
ches from Andrew)
git bisect good 9c9fa97a8edbc3668dfc7a25de516e80c146e86f
# bad: [a22fea94992a2bc5328005e62f368413ede49c14] arch/sparc/include/asm/pg=
table_64.h: fix build
git bisect bad a22fea94992a2bc5328005e62f368413ede49c14
# good: [351c8a09b00b5c51c8f58b016fffe51f87e2d820] Merge branch 'i2c/for-5.=
4' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 351c8a09b00b5c51c8f58b016fffe51f87e2d820
# bad: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: enable CONFIG_O=
PTIMIZE_INLINING forcibly
git bisect bad ac7c3e4ff401b304489a031938dbeaab585bfe0a
# good: [94fb98450456da82a16a378816390d99b85edb55] checkpatch: allow consec=
utive close braces
git bisect good 94fb98450456da82a16a378816390d99b85edb55
# good: [4fadcd1c14d810ec6a695039cfc71e03ae742deb] fs/reiserfs/fix_node.c: =
remove set but not used variables
git bisect good 4fadcd1c14d810ec6a695039cfc71e03ae742deb
# good: [8495f7e6732ed248b648d36439795b42ec650b9e] fork: improve error mess=
age for corrupted page tables
git bisect good 8495f7e6732ed248b648d36439795b42ec650b9e
# good: [7c3a6aedcd6aae0a32a527e68669f7dd667492d1] kexec: bail out upon SIG=
KILL when allocating memory.
git bisect good 7c3a6aedcd6aae0a32a527e68669f7dd667492d1
# good: [9dd819a15162f8f82a6001b090caa38c18297b39] uaccess: add missing __m=
ust_check attributes
git bisect good 9dd819a15162f8f82a6001b090caa38c18297b39
# first bad commit: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: en=
able CONFIG_OPTIMIZE_INLINING forcibly
---------------------------------------------------------------------------=
----
