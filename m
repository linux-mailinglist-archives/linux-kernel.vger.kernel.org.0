Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2145F45A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFNKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 06:16:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23606 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfFNKQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:16:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45QGjP1Vnrz9vDbm;
        Fri, 14 Jun 2019 12:16:25 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=tj85kPHp; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id x-ieB8R6280X; Fri, 14 Jun 2019 12:16:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45QGjP0QnZz9vDbh;
        Fri, 14 Jun 2019 12:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560507385; bh=Ncvp/xcVUmXSd5BetDki7lkPoESwzmp5vh6/pH0lEKQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=tj85kPHpr2D177M+FGuhqLYv9NsLU1LQYGPQYwqCLNN9iZeMM8RgHmBtgN4jRdWEQ
         VTgA4m5NgBN/KV1BWQ2o4sMdw/HdJsKveV4NzIVEri9Wk9ctOPjYaVh5w28rPAYK3H
         tIkmm6g3RiQTWPOygCtyb04gEqUqF65aBWB3G0So=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32B6D8B7AD;
        Fri, 14 Jun 2019 12:16:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZtED3dm1Hgo0; Fri, 14 Jun 2019 12:16:26 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE9C18B7AC;
        Fri, 14 Jun 2019 12:16:25 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id EE63568D78; Fri, 14 Jun 2019 10:16:25 +0000 (UTC)
Message-Id: <513745c616ff9c46a077578a21c843ab818a0e57.1560507284.git.christophe.leroy@c-s.fr>
In-Reply-To: <1b4946c9e580b51b6ca2ddc5963d66406c013c2d.1560507284.git.christophe.leroy@c-s.fr>
References: <1b4946c9e580b51b6ca2ddc5963d66406c013c2d.1560507284.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/boot: Add lzo support for uImage
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 10:16:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to generate lzo compressed uImage

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 v3: rebased following the drop of patch 3 (bzip2) which is not supported anymore by uboot.
 v2: restore alphabetic order in Kconfig
---
 arch/powerpc/Kconfig       | 1 +
 arch/powerpc/boot/Makefile | 2 ++
 arch/powerpc/boot/wrapper  | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5542430ba261..2b041f88b593 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -197,6 +197,7 @@ config PPC
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA			if DEFAULT_UIMAGE
+	select HAVE_KERNEL_LZO			if DEFAULT_UIMAGE
 	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9b7b11a22925..36fb51a9329f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -23,6 +23,7 @@ all: $(obj)/zImage
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
 compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 compress-$(CONFIG_KERNEL_LZMA) := CONFIG_KERNEL_LZMA
+compress-$(CONFIG_KERNEL_LZO)   := CONFIG_KERNEL_LZO
 
 ifdef CROSS32_COMPILE
     BOOTCC := $(CROSS32_COMPILE)gcc
@@ -259,6 +260,7 @@ endif
 compressor-$(CONFIG_KERNEL_GZIP) := gz
 compressor-$(CONFIG_KERNEL_XZ)   := xz
 compressor-$(CONFIG_KERNEL_LZMA)   := lzma
+compressor-$(CONFIG_KERNEL_LZO) := lzo
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 19887f6ad7c1..5148ac271f28 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -136,7 +136,7 @@ while [ "$#" -gt 0 ]; do
     -Z)
 	shift
 	[ "$#" -gt 0 ] || usage
-        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "none" ] || usage
+        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "lzo" -o "$1" != "none" ] || usage
 
 	compression=".$1"
 	uboot_comp=$1
@@ -376,6 +376,9 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     .lzma)
         xz --format=lzma -f -6 "$vmz.$$"
 	;;
+    .lzo)
+        lzop -f -9 "$vmz.$$"
+	;;
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
-- 
2.13.3

