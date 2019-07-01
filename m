Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A461A454E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFNGlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 02:41:46 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28675 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNGlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:41:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Q9xd0cYgz9v16q;
        Fri, 14 Jun 2019 08:41:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=W+LACJVt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5vqt1m5JGduG; Fri, 14 Jun 2019 08:41:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Q9xc6gCrz9v16l;
        Fri, 14 Jun 2019 08:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560494500; bh=mszSrikscbgZHgKNqdr5fBuo6tVQqJ4xBpR0SgppJSM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=W+LACJVtf9/UITPAGDD6IcVop34pL+XmWzXOxoHakdDNFfqXDMwRTSvowDJldO0hy
         TPKTR9BwGYNkM6uaOSi3GvaFtbXMNaK15SEa1wk6kD4Xl1dGzrRGaw8GGu5U1wdcP9
         H3INITE8DkrZb7Vn+jMn1x95W9ybHmGDi/8nbaoU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D61678B77A;
        Fri, 14 Jun 2019 08:41:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Z3Br4Hd4TmYT; Fri, 14 Jun 2019 08:41:41 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9B098B775;
        Fri, 14 Jun 2019 08:41:41 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AC29F68D77; Fri, 14 Jun 2019 06:41:41 +0000 (UTC)
Message-Id: <c4cbd9d789ceecfc5ae3f03827a0b1a2287d1d72.1560494349.git.christophe.leroy@c-s.fr>
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
References: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 04/10] powerpc/8xx: refactor writing of CPM microcode
 arrays
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 06:41:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a function to refactor the writing of CPM microcode arrays.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 35 ++++++++++++---------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index e14b6bcadce3..2abc226d1139 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -203,9 +203,15 @@ static uint patch_2f00[] __initdata = {
 };
 #endif
 
+static void __init cpm_write_patch(cpm8xx_t *cp, int offset, uint *patch, int len)
+{
+	if (!len)
+		return;
+	memcpy_toio(cp->cp_dpmem + offset, patch, len);
+}
+
 void __init cpm_load_patch(cpm8xx_t *cp)
 {
-	volatile uint		*dp;		/* Dual-ported RAM. */
 	volatile cpm8xx_t	*commproc;
 #if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
     defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
@@ -215,20 +221,13 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	volatile smc_uart_t	*smp;
 #endif
 #endif
-	int	i;
-
 	commproc = cp;
 
 #ifdef CONFIG_USB_SOF_UCODE_PATCH
 	commproc->cp_rccr = 0;
 
-	dp = (uint *)(commproc->cp_dpmem);
-	for (i=0; i<(sizeof(patch_2000)/4); i++)
-		*dp++ = patch_2000[i];
-
-	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
-	for (i=0; i<(sizeof(patch_2f00)/4); i++)
-		*dp++ = patch_2f00[i];
+	cpm_write_patch(cp, 0, patch_2000, sizeof(patch_2000));
+	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
 
 	commproc->cp_rccr = 0x0009;
 
@@ -240,13 +239,8 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 
 	commproc->cp_rccr = 0;
 
-	dp = (uint *)(commproc->cp_dpmem);
-	for (i=0; i<(sizeof(patch_2000)/4); i++)
-		*dp++ = patch_2000[i];
-
-	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
-	for (i=0; i<(sizeof(patch_2f00)/4); i++)
-		*dp++ = patch_2f00[i];
+	cpm_write_patch(cp, 0, patch_2000, sizeof(patch_2000));
+	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
 
 	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
 # define RPBASE 0x0500
@@ -254,9 +248,8 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 
 	/* Put SPI above the IIC, also 32-byte aligned.
 	*/
-	i = (RPBASE + sizeof(iic_t) + 31) & ~31;
 	spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
-	spp->rpbase = i;
+	spp->rpbase = (RPBASE + sizeof(iic_t) + 31) & ~31;
 
 # if defined(CONFIG_I2C_SPI_UCODE_PATCH)
 	commproc->cp_cpmcr1 = 0x802a;
@@ -270,9 +263,7 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 
 # if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 
-	dp = (uint *)&(commproc->cp_dpmem[0x0e00]);
-	for (i=0; i<(sizeof(patch_2e00)/4); i++)
-		*dp++ = patch_2e00[i];
+	cpm_write_patch(cp, 0xe00, patch_2e00, sizeof(patch_2e00));
 
 	commproc->cp_cpmcr1 = 0x8080;
 	commproc->cp_cpmcr2 = 0x808a;
-- 
2.13.3

