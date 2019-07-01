Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D777454DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 08:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfFNGll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 02:41:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47164 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNGll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:41:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Q9xZ0kVyz9v16m;
        Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jTtPxoPJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vIk17qXUOh77; Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Q9xY6pC5z9v16l;
        Fri, 14 Jun 2019 08:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560494497; bh=W5X8PtSPgth6FDAmJOFG/rBOmmW+Ue2es6uJEna8ELo=;
        h=From:Subject:To:Cc:Date:From;
        b=jTtPxoPJvfx3Www0oYBRY2a5ArbYbtMfgADocmampnfhnbGutokEf9XTNdVn/W5aK
         ePXARYxKI1evvwhrUyTy71b2siF+kcfHZhG+wnq+Q5Q4Dv+dcSIJqZeTyFN5kmbSKr
         npdUO1lKfvpVegicCulw2RBytIo9TE9h6JTs4JCU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D983E8B77A;
        Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id saAqovqk-WQl; Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B16F18B775;
        Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 99D0D68D77; Fri, 14 Jun 2019 06:41:38 +0000 (UTC)
Message-Id: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 01/10] powerpc/8xx: move CPM1 related files from sysdev/ to
 platforms/8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 06:41:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 8xx selects CPM1 and related CONFIG options are already
in platforms/8xx/Kconfig

Move the related C files to platforms/8xx/.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: cpm_gpio is also used by CPM2, so it has to remain in sysdev for now ; no change to other patches of the series.
 v2: added several patches in the series to clean up the microcode patching.

 arch/powerpc/platforms/8xx/Makefile                 | 2 ++
 arch/powerpc/{sysdev => platforms/8xx}/cpm1.c       | 0
 arch/powerpc/{sysdev => platforms/8xx}/micropatch.c | 0
 arch/powerpc/sysdev/Makefile                        | 2 --
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/powerpc/{sysdev => platforms/8xx}/cpm1.c (100%)
 rename arch/powerpc/{sysdev => platforms/8xx}/micropatch.c (100%)

diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 708ab099e886..27a7c6f828e0 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the PowerPC 8xx linux kernel.
 #
 obj-y			+= m8xx_setup.o machine_check.o pic.o
+obj-$(CONFIG_CPM1)		+= cpm1.o
+obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
similarity index 100%
rename from arch/powerpc/sysdev/cpm1.c
rename to arch/powerpc/platforms/8xx/cpm1.c
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
similarity index 100%
rename from arch/powerpc/sysdev/micropatch.c
rename to arch/powerpc/platforms/8xx/micropatch.c
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index aaf23283ba0c..9d73dfddf060 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -37,12 +37,10 @@ obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 
 obj-$(CONFIG_CPM)		+= cpm_common.o
-obj-$(CONFIG_CPM1)		+= cpm1.o
 obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o cpm_gpio.o
 obj-$(CONFIG_8xx_GPIO)		+= cpm_gpio.o
 obj-$(CONFIG_QUICC_ENGINE)	+= cpm_common.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
-obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 
 obj-$(CONFIG_PPC_MPC512x)	+= mpc5xxx_clocks.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc5xxx_clocks.o
-- 
2.13.3

