Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC07999980
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbfHVQoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 12:44:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45386 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731384AbfHVQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:44:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Dr2r50ngz9v4WL;
        Thu, 22 Aug 2019 18:44:04 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Zplosrd3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VvLBuWFOsunQ; Thu, 22 Aug 2019 18:44:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Dr2r3nZSz9v4WK;
        Thu, 22 Aug 2019 18:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566492244; bh=trYGHVEpD6dtjnX/NVUZh4W1Wy/UH0BDAKfhUgaCEmY=;
        h=From:Subject:To:Cc:Date:From;
        b=Zplosrd318O7wa1i5Ht5wVHUCoBWL2mXV/77ebvy9Uhi1/1L+lC39r6p+9KfFamVG
         LVtrPWEH3dUKVF1xhmAE5u26j6FGZVXhI05Vi186+VxvD97vmV7Cwi/mKJ5dyscYzZ
         qO4sxllZttXY8bmsPoWAeHtuhSrf+dq8Wpf2trSQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3AD858B84C;
        Thu, 22 Aug 2019 18:44:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7eVKBjGnOb26; Thu, 22 Aug 2019 18:44:06 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1143B8B81D;
        Thu, 22 Aug 2019 18:44:06 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DDDB46B730; Thu, 22 Aug 2019 16:44:05 +0000 (UTC)
Message-Id: <a8b567c569aa521a7cf1beb061d43d79070e850c.1566492229.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/64: don't select ARCH_HAS_SCALED_CPUTIME on book3E
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Aug 2019 16:44:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Book3E doesn't have SPRN_SPURR/SPRN_PURR.

Activating ARCH_HAS_SCALED_CPUTIME is just wasting CPU time.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Link: https://github.com/linuxppc/issues/issues/171
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0c322abb1495..6137f5e3bb2d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -132,7 +132,7 @@ config PPC
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
-	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
+	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
-- 
2.13.3

