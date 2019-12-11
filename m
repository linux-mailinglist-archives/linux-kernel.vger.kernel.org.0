Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654F811AC39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfLKNkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 08:40:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfLKNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:40:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mdv2u-1i7M5t0wNC-00b4PK; Wed, 11 Dec 2019 14:39:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] gcc-plugins: make it possible to disable CONFIG_GCC_PLUGINS again
Date:   Wed, 11 Dec 2019 14:39:28 +0100
Message-Id: <20191211133951.401933-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+nmB7TYbeF+BbF1KYAsTCC10nXeyaJq0hfe0KpydKA2p+Otku3i
 /HMw47ZC370YdiwwA2iFeJ1n00wEOhd8ZpyGd2d3d+tUHhdNkk6xOI55m8KfR/Af1xXnmRk
 uJnl8uAvfeWWu1lir93AVBa49mZdCBu9xhylvPGJSH6gET5l2DxsXTwEEyoV3FhgWLLMkRJ
 uL1tGBQBgb0YkP3ZeMw2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mDV/RTPIJ3w=:eKif/Og3P8/X7Fw17BCTtN
 Cl9jKu9p2v6izmw011BOHn6/K9GY07jxXMShZ4olfc2Gd6YCEdAMwkoa1mmX9jb0XkejA0sNp
 tzEsDim8f70Eknt3szdPZb6SoX3WB2szAS7ogNjfsjntgPMInAjYdknD9LRLuId8OXdTIsJOy
 h+a+VO3MILFVzFShouk4fs5XKrfFLbVi4UEcEtyFij9kYdEIwICWunPbC5SqNB+sHBByyqvUZ
 Gf06xWAzHiUFfAi7ZHzAWcjqmSzoOlwu0hXAHHAFJIghq6vTEVNgqH2DXvTbMGWJxwz+M+rP6
 NDwdSQLNbQaBJMRkQhGxO/IgNQDsGW9wZ/Oh201qXioUXKeOj2IdK5BxFOwXpPpWFrV72USuU
 9hz2NM8+9SH4hkVItgVH6FwI/eWKDYdX13Nwh7K069l2ICBOtm+VHXlqMFyW6sju0fhxDwdXr
 EiznRvbD6dHKCyYaHdiqOlZeoAZaJfTOwHbiHi3hSruRGThx4nVgP7TY7VDOZI1mow0BoFHyO
 cCRJWwijAd73s4x1X7wD+pFusfq7fAi79J01dpXjWm0Z0xijOhtBkiBDp6IYh9SKhKopL4vLu
 u0LFX9ZYybNbddOwMcdeASQidktoVbgRIu5TU4R+RSWO2sZfCJ/n+7SbotKctVrsXGAif2atb
 RJkSI4jo7pzA/bRKxxuO4L1eZP1nBvbTnPjGmopnp3LYJpwu7Jsh14Xc01g/a2sU4LZYcS187
 /CslxGcFpLtXbOSYJAq/EX7UeKtipQigCXtVfk9pdUOhAxCfdjR9HVShXZ1dZKNcXsu7QHikh
 FqoWuJXtSO4tZnP+SxE1pdoQ72G2KXpfLKvssLLWFro5jBV0CBTMJxKfUQgf0bXSta0TxDiw2
 Qz9OmB190C+pXgfsJ+4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that randconfig builds with gcc no longer produce a lot of
ccache hits, unlike with clang, and traced this back to plugins
now being enabled unconditionally if they are supported.

I am now working around this by adding

   export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%

to my top-level Makefile. This changes the heuristic that ccache uses
to determine whether the plugins are the same after a 'make clean'.

However, it also seems that being able to just turn off the plugins is
generally useful, at least for build testing it adds noticeable overhead
but does not find a lot of bugs additional bugs, and may be easier for
ccache users than my workaround.

Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/gcc-plugins/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index d33de0b9f4f5..e3569543bdac 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -14,8 +14,8 @@ config HAVE_GCC_PLUGINS
 	  An arch should select this symbol if it supports building with
 	  GCC plugins.
 
-config GCC_PLUGINS
-	bool
+menuconfig GCC_PLUGINS
+	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
 	depends on PLUGIN_HOSTCC != ""
 	default y
@@ -25,8 +25,7 @@ config GCC_PLUGINS
 
 	  See Documentation/core-api/gcc-plugins.rst for details.
 
-menu "GCC plugins"
-	depends on GCC_PLUGINS
+if GCC_PLUGINS
 
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
@@ -113,4 +112,4 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
 
-endmenu
+endif
-- 
2.20.0

