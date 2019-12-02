Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0219610E68E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 08:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLBH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 02:57:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51844 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBH5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 02:57:32 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47RHX55VPrz9txt0;
        Mon,  2 Dec 2019 08:57:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=u3k4vTtV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YpKDb2vRMwTF; Mon,  2 Dec 2019 08:57:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47RHX54QHKz9txsp;
        Mon,  2 Dec 2019 08:57:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575273445; bh=F1lZuWS+PyLbK6sq+A4k6BmEnOC0Gj9jYu0JPSBEWhE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=u3k4vTtVnQxEpjQzahRrU5ApkwGtcJ9Ocjjbeg2aq+AnrdUsEXYTBSmNSolR3CVsB
         E/9AS69itgUYNRsuEQrNG6dtLJmqmDCN0IzZ/o7de4JXzao053I68jCZNX+jbwn9oX
         kEM2EEW3cQBc/tLDMBVffrZZg2K6oHJNskCyF4WM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CADE8B79C;
        Mon,  2 Dec 2019 08:57:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aY637NVkfqSP; Mon,  2 Dec 2019 08:57:30 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DF20C8B79A;
        Mon,  2 Dec 2019 08:57:29 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D986963600; Mon,  2 Dec 2019 07:57:29 +0000 (UTC)
Message-Id: <a55eca3a5e85233838c2349783bcb5164dae1d09.1575273217.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1575273217.git.christophe.leroy@c-s.fr>
References: <cover.1575273217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 3/8] powerpc: Fix vDSO clock_getres()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de
Date:   Mon,  2 Dec 2019 07:57:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

Fix the powerpc vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support
to 32 bits kernel")
Cc: stable@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
[chleroy: changed CLOCK_REALTIME_RES to CLOCK_HRTIMER_RES]
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/vdso_datapage.h  | 2 ++
 arch/powerpc/kernel/asm-offsets.c         | 2 +-
 arch/powerpc/kernel/time.c                | 1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S | 7 +++++--
 arch/powerpc/kernel/vdso64/gettimeofday.S | 7 +++++--
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a115970a6809..40f13f3626d3 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -83,6 +83,7 @@ struct vdso_data {
 	__s64 wtom_clock_sec;			/* Wall to monotonic clock sec */
 	__s64 stamp_xtime_sec;			/* xtime secs as at tb_orig_stamp */
 	__s64 stamp_xtime_nsec;			/* xtime nsecs as at tb_orig_stamp */
+	__u32 hrtimer_res;			/* hrtimer resolution */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };
@@ -105,6 +106,7 @@ struct vdso_data {
 	__s32 stamp_xtime_sec;		/* xtime seconds as at tb_orig_stamp */
 	__s32 stamp_xtime_nsec;		/* xtime nsecs as at tb_orig_stamp */
 	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
+	__u32 hrtimer_res;		/* hrtimer resolution */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 	__u32 dcache_block_size;	/* L1 d-cache block size     */
 	__u32 icache_block_size;	/* L1 i-cache block size     */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f22bd6d1fe93..3d47aec7becf 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -388,6 +388,7 @@ int main(void)
 	OFFSET(STAMP_XTIME_SEC, vdso_data, stamp_xtime_sec);
 	OFFSET(STAMP_XTIME_NSEC, vdso_data, stamp_xtime_nsec);
 	OFFSET(STAMP_SEC_FRAC, vdso_data, stamp_sec_fraction);
+	OFFSET(CLOCK_HRTIMER_RES, vdso_data, hrtimer_res);
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_data, icache_block_size);
 	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_data, dcache_block_size);
 	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_data, icache_log_block_size);
@@ -413,7 +414,6 @@ int main(void)
 	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
-	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2d13cea13954..1168e8b37e30 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -960,6 +960,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->stamp_xtime_sec = xt.tv_sec;
 	vdso_data->stamp_xtime_nsec = xt.tv_nsec;
 	vdso_data->stamp_sec_fraction = frac_sec;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	smp_wmb();
 	++(vdso_data->tb_update_count);
 }
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 7c1be86c1e90..e9ce8ee56edb 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -204,12 +204,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
+	mflr	r12
+  .cfi_register lr,r12
+	bl	__get_datapage@local	/* get data page */
+	lwz	r5, CLOCK_HRTIMER_RES(r3)
+	mtlr	r12
 	li	r3,0
 	cmpli	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
 	stw	r3,TSPC32_TV_SEC(r4)
 	stw	r5,TSPC32_TV_NSEC(r4)
 	blr
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 1f24e411af80..1c9a04703250 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -186,12 +186,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
+	mflr	r12
+  .cfi_register lr,r12
+	bl	V_LOCAL_FUNC(__get_datapage)
+	lwz	r5, CLOCK_HRTIMER_RES(r3)
+	mtlr	r12
 	li	r3,0
 	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
 	std	r3,TSPC64_TV_SEC(r4)
 	std	r5,TSPC64_TV_NSEC(r4)
 	blr
-- 
2.13.3

