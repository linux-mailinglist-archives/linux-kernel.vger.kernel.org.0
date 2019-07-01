Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2143E87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbfFMPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:50:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33401 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731673AbfFMJMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:12:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45PdKW6XMlzB09Zq;
        Thu, 13 Jun 2019 11:11:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sjMYA3Q7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZVuszKe76_fZ; Thu, 13 Jun 2019 11:11:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45PdKW5VLhzB09Zg;
        Thu, 13 Jun 2019 11:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560417119; bh=mqHvMNCVo1J8F/0+o546XcKtxPNuB5rRLMclAu10TBw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=sjMYA3Q70EyzBqP9X7rFgnKphniWcmh5J7A1+eDIphhqIg99FrLEz/FsIOqxpujPJ
         deHosTzsF3S/IekJUb9/XjNwsb9adITrCG/IL9BbFeaZeqax7CFlAY/q/GFuZeq0il
         4vk9dyLi7WolJ9TN/JxTbKmbBE6P6xYBFIHhSRU4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D86818B8C0;
        Thu, 13 Jun 2019 11:12:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PUiRkJUwmOiS; Thu, 13 Jun 2019 11:12:00 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95A498B8B9;
        Thu, 13 Jun 2019 11:12:00 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 487D968B1D; Thu, 13 Jun 2019 09:12:00 +0000 (UTC)
Message-Id: <e637bd2d3884c8be1067bf382c71b2b0b7ffc370.1560416987.git.christophe.leroy@c-s.fr>
In-Reply-To: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
References: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/10] powerpc/8xx: replace #ifdefs by IS_ENABLED() in
 microcode.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 09:12:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce #ifdef mess by using IS_ENABLED() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 02490c54ebac..252db7c90599 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -243,14 +243,9 @@ static void __init cpm_write_patch(cpm8xx_t *cp, int offset, uint *patch, int le
 void __init cpm_load_patch(cpm8xx_t *cp)
 {
 	volatile cpm8xx_t	*commproc;
-#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
-    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 	volatile iic_t		*iip;
 	volatile struct spi_pram *spp;
-#ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
 	volatile smc_uart_t	*smp;
-#endif
-#endif
 	commproc = cp;
 
 	commproc->cp_rccr = 0;
@@ -259,24 +254,22 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
 	cpm_write_patch(cp, 0xe00, patch_2e00, sizeof(patch_2e00));
 
-#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
-    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-
-	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-# define RPBASE 0x0500
-	iip->iic_rpbase = RPBASE;
+	if (IS_ENABLED(CONFIG_I2C_SPI_UCODE_PATCH) ||
+	    IS_ENABLED(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)) {
+		u16 rpbase = 0x500;
 
-	/* Put SPI above the IIC, also 32-byte aligned.
-	*/
-	spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
-	spp->rpbase = (RPBASE + sizeof(iic_t) + 31) & ~31;
+		iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
+		iip->iic_rpbase = rpbase;
 
-# if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
-	smp->smc_rpbase = 0x1FC0;
-# endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
+		/* Put SPI above the IIC, also 32-byte aligned. */
+		spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
+		spp->rpbase = (rpbase + sizeof(iic_t) + 31) & ~31;
 
-#endif /* some variation of the I2C/SPI patch was selected */
+		if (IS_ENABLED(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)) {
+			smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
+			smp->smc_rpbase = 0x1FC0;
+		}
+	}
 
 	commproc->cp_cpmcr1 = patch_params.cpmcr1;
 	commproc->cp_cpmcr2 = patch_params.cpmcr2;
-- 
2.13.3

