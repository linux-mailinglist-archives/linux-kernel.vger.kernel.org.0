Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446FC99945
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbfHVQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 12:34:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46152 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbfHVQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:34:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46DqqK5g1dz9v0d9;
        Thu, 22 Aug 2019 18:34:05 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=lhnl3XYt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ICs6f2pPk8DL; Thu, 22 Aug 2019 18:34:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46DqqK4fVjz9v0d3;
        Thu, 22 Aug 2019 18:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566491645; bh=rDwOZc+1kwejUHMuYtIRr+S6e2LDgMgUE9GuQBU06PY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=lhnl3XYtE5hOHdJwxzX4SnOSrN06Cg6qcnzUeZVdpLv3QgcZA1kKUrwq7AYWGw6YZ
         YZhxU+tUY/WhhamK15W57cuOtb+c4cD/qP7WtWaNUlIn2Fv3nqKJJ80fDMYG+DEpyL
         ibgeZ7RCQft0D576vk3Ge1TFYmD/Uxd33CPENfnA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59B028B84C;
        Thu, 22 Aug 2019 18:34:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 19iNAiDvTBSW; Thu, 22 Aug 2019 18:34:07 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A2A68B81D;
        Thu, 22 Aug 2019 18:34:07 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F2F646B730; Thu, 22 Aug 2019 16:34:06 +0000 (UTC)
Message-Id: <f4b92057c405e78c2a2a51f6f1ca2a9e356063d5.1566491310.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1566491310.git.christophe.leroy@c-s.fr>
References: <cover.1566491310.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 6/8] powerpc/vdso32: use LOAD_REG_IMMEDIATE()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Aug 2019 16:34:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use LOAD_REG_IMMEDIATE() to load registers with immediate value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 3e55cba19f44..0f87be0ebf7e 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -40,8 +40,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	get_datapage	r9, r0
 	cmplwi	r10,0			/* check if tv is NULL */
 	beq	3f
-	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
-	addi	r7,r7,1000000@l		/* so we get microseconds in r4 */
+	LOAD_REG_IMMEDIATE(r7, 1000000)	/* load up USEC_PER_SEC */
 	bl	__do_get_tspec@local	/* get sec/usec from tb & kernel */
 	stw	r3,TVAL32_TV_SEC(r10)
 	stw	r4,TVAL32_TV_USEC(r10)
@@ -84,8 +83,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
   .cfi_register lr,r12
 	mr	r11,r4			/* r11 saves tp */
 	get_datapage	r9, r0
-	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
-	ori	r7,r7,NSEC_PER_SEC@l
+	LOAD_REG_IMMEDIATE(r7, NSEC_PER_SEC)	/* load up NSEC_PER_SEC */
 	beq	cr5, .Lcoarse_clocks
 .Lprecise_clocks:
 	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
-- 
2.13.3

