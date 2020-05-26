Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622E6199ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgCaQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:04:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6129 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbgCaQDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdt56BVz9twdg;
        Tue, 31 Mar 2020 18:03:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Is9RMFR5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PobSqOxh4iKT; Tue, 31 Mar 2020 18:03:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdt3zkVz9twdT;
        Tue, 31 Mar 2020 18:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670626; bh=vZcSBuZpy2JEce88eyEgrrbGhtU7CbJwJhN+5rohDtw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Is9RMFR5whps7wXVMPg2bWOqnWI4sFlcLgMa6l3Lno3XyO5+rDvVZLbRN/ZxKcJ3L
         B5fus98swn75dujOXYaULp9Q+ezEXEzUv79y59k2XDVSxgE0k552qce351AGuenXLF
         /pwwCrhzqJa4ctbtUzc0YQEX8mhdMB8HoVBzJTcw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B6328B86A;
        Tue, 31 Mar 2020 18:03:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dy9V9tTjrNDf; Tue, 31 Mar 2020 18:03:48 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A53F98B752;
        Tue, 31 Mar 2020 18:03:47 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 94605656AC; Tue, 31 Mar 2020 16:03:47 +0000 (UTC)
Message-Id: <098b0fd3f6299aa1bd692bd576bd7012c84608de.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 12/12] powerpc/entry32: Blacklist exception exit points for
 kprobe.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode.

The very last part of exception exits cannot support a trap.
Blacklist them from kprobe.

While we are at it, remove exc_exit_start symbol which is not
used to avoid having to blacklist it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_32.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 577d17fe0d94..02c81192ba52 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -810,6 +810,7 @@ fast_exception_return:
 	lwz	r11,GPR11(r11)
 	SYNC
 	RFI
+_ASM_NOKPROBE_SYMBOL(fast_exception_return)
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 /* check if the exception happened in a restartable section */
@@ -1049,6 +1050,8 @@ exc_exit_restart:
 exc_exit_restart_end:
 	SYNC
 	RFI
+_ASM_NOKPROBE_SYMBOL(exc_exit_restart)
+_ASM_NOKPROBE_SYMBOL(exc_exit_restart_end)
 
 #else /* !(CONFIG_4xx || CONFIG_BOOKE) */
 	/*
@@ -1070,7 +1073,6 @@ exc_exit_restart_end:
 exc_exit_restart:
 	lwz	r11,_NIP(r1)
 	lwz	r12,_MSR(r1)
-exc_exit_start:
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r12
 	REST_2GPRS(11, r1)
@@ -1080,6 +1082,7 @@ exc_exit_restart_end:
 	PPC405_ERR77_SYNC
 	rfi
 	b	.			/* prevent prefetch past rfi */
+_ASM_NOKPROBE_SYMBOL(exc_exit_restart)
 
 /*
  * Returning from a critical interrupt in user mode doesn't need
@@ -1193,6 +1196,7 @@ ret_from_crit_exc:
 	mtspr	SPRN_SRR0,r9;
 	mtspr	SPRN_SRR1,r10;
 	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, PPC_RFCI)
+_ASM_NOKPROBE_SYMBOL(ret_from_crit_exc)
 #endif /* CONFIG_40x */
 
 #ifdef CONFIG_BOOKE
@@ -1204,6 +1208,7 @@ ret_from_crit_exc:
 	RESTORE_xSRR(SRR0,SRR1);
 	RESTORE_MMU_REGS;
 	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, PPC_RFCI)
+_ASM_NOKPROBE_SYMBOL(ret_from_crit_exc)
 
 	.globl	ret_from_debug_exc
 ret_from_debug_exc:
@@ -1214,6 +1219,7 @@ ret_from_debug_exc:
 	RESTORE_xSRR(CSRR0,CSRR1);
 	RESTORE_MMU_REGS;
 	RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)
+_ASM_NOKPROBE_SYMBOL(ret_from_debug_exc)
 
 	.globl	ret_from_mcheck_exc
 ret_from_mcheck_exc:
@@ -1225,6 +1231,7 @@ ret_from_mcheck_exc:
 	RESTORE_xSRR(DSRR0,DSRR1);
 	RESTORE_MMU_REGS;
 	RET_FROM_EXC_LEVEL(SPRN_MCSRR0, SPRN_MCSRR1, PPC_RFMCI)
+_ASM_NOKPROBE_SYMBOL(ret_from_mcheck_exc)
 #endif /* CONFIG_BOOKE */
 
 /*
-- 
2.25.0

