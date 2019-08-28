Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE0A0385
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfH1NmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:42:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22938 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfH1NmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:42:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46JRk12DWFz9txgl;
        Wed, 28 Aug 2019 15:42:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=McnM47Sw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EbMeLWH2Bh5V; Wed, 28 Aug 2019 15:42:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46JRk10cSKz9txgf;
        Wed, 28 Aug 2019 15:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566999721; bh=WlF/NSltuPx4PM3qTDCqQGZT8tc/4RbHenX+NeVwbvY=;
        h=From:Subject:To:Cc:Date:From;
        b=McnM47SwSpPMO6QuYvKKyyQZ648H4n+/LV51JTu8o3Xibt98fpDBFMT5U6czyfLJh
         k6E89dZM4kQUGZKK6cfnEXvNHz8PP9ehnwwMAnbA1LFoHYp1fgP3O0k7SAdQ7ScGdD
         x8vQDatxay1Us4HZnxp6IUnDo1ZQR+eNalwEyMcE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 86B838B89B;
        Wed, 28 Aug 2019 15:42:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id guMCPJ6UOkHP; Wed, 28 Aug 2019 15:42:02 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AF798B885;
        Wed, 28 Aug 2019 15:42:02 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 13C5B69728; Wed, 28 Aug 2019 13:42:01 +0000 (UTC)
Message-Id: <ac19713826fa55e9e7bfe3100c5a7b1712ab9526.1566999711.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/reg: use ASM_FTR_IFSET() instead of opencoding fixup.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 28 Aug 2019 13:42:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mftb() includes a feature fixup for CELL ppc.

Use ASM_FTR_IFSET() macro instead of opencoding the setup
of the fixup sections.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 10caa145f98b..7acce24ace49 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1378,19 +1378,9 @@ static inline void msr_check_and_clear(unsigned long bits)
 #define mftb()		({unsigned long rval;				\
 			asm volatile(					\
 				"90:	mfspr %0, %2;\n"		\
-				"97:	cmpwi %0,0;\n"			\
-				"	beq- 90b;\n"			\
-				"99:\n"					\
-				".section __ftr_fixup,\"a\"\n"		\
-				".align 3\n"				\
-				"98:\n"					\
-				"	.8byte %1\n"			\
-				"	.8byte %1\n"			\
-				"	.8byte 97b-98b\n"		\
-				"	.8byte 99b-98b\n"		\
-				"	.8byte 0\n"			\
-				"	.8byte 0\n"			\
-				".previous"				\
+				ASM_FTR_IFSET(				\
+					"97:	cmpwi %0,0;\n"		\
+					"	beq- 90b;\n", "", %1)	\
 			: "=r" (rval) \
 			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL) : "cr0"); \
 			rval;})
-- 
2.13.3

