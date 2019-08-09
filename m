Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A145086EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 02:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405117AbfHIArV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 20:47:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403901AbfHIArV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:47:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x790lK7s111171
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 20:47:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8ub9xbrn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:47:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 9 Aug 2019 01:47:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Aug 2019 01:47:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x790lBMc28115392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 00:47:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB128AE056;
        Fri,  9 Aug 2019 00:47:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F10AE045;
        Fri,  9 Aug 2019 00:47:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Aug 2019 00:47:11 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5C714A01F3;
        Fri,  9 Aug 2019 10:47:10 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <cai@lca.pw>, Allison Randal <allison@lohutok.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: Convert flush_icache_range to C
Date:   Fri,  9 Aug 2019 10:46:55 +1000
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080900-0016-0000-0000-0000029C81A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080900-0017-0000-0000-000032FC8780
Message-Id: <20190809004658.22512-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Similar to commit 22e9c88d486a
("powerpc/64: reuse PPC32 static inline flush_dcache_range()")
this patch converts flush_icache_range to C.

This was done as we discovered a long-standing bug where the
length of the range was truncated due to using a 32 bit shift
instead of a 64 bit one.

By converting this function to C, it becomes easier to maintain.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/cache.h      | 35 +++++++++++++--
 arch/powerpc/include/asm/cacheflush.h | 63 +++++++++++++++++++++++----
 arch/powerpc/kernel/misc_64.S         | 55 -----------------------
 3 files changed, 85 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index b3388d95f451..d3d7077b75e2 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -55,25 +55,46 @@ struct ppc64_caches {
 
 extern struct ppc64_caches ppc64_caches;
 
-static inline u32 l1_cache_shift(void)
+static inline u32 l1_dcache_shift(void)
 {
 	return ppc64_caches.l1d.log_block_size;
 }
 
-static inline u32 l1_cache_bytes(void)
+static inline u32 l1_dcache_bytes(void)
 {
 	return ppc64_caches.l1d.block_size;
 }
+
+static inline u32 l1_icache_shift(void)
+{
+	return ppc64_caches.l1i.log_block_size;
+}
+
+static inline u32 l1_icache_bytes(void)
+{
+	return ppc64_caches.l1i.block_size;
+}
 #else
-static inline u32 l1_cache_shift(void)
+static inline u32 l1_dcache_shift(void)
 {
 	return L1_CACHE_SHIFT;
 }
 
-static inline u32 l1_cache_bytes(void)
+static inline u32 l1_dcache_bytes(void)
 {
 	return L1_CACHE_BYTES;
 }
+
+static inline u32 l1_icache_shift(void)
+{
+	return L1_CACHE_SHIFT;
+}
+
+static inline u32 l1_icache_bytes(void)
+{
+	return L1_CACHE_BYTES;
+}
+
 #endif
 #endif /* ! __ASSEMBLY__ */
 
@@ -124,6 +145,12 @@ static inline void dcbst(void *addr)
 {
 	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) : "memory");
 }
+
+static inline void icbi(void *addr)
+{
+	__asm__ __volatile__ ("icbi %y0" : : "Z"(*(u8 *)addr) : "memory");
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index eef388f2659f..f68e75a6dc4b 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -42,7 +42,6 @@ extern void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
-extern void flush_icache_range(unsigned long, unsigned long);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 				    struct page *page, unsigned long addr,
 				    int len);
@@ -57,14 +56,17 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
 }
 #endif
 
-/*
- * Write any modified data cache blocks out to memory and invalidate them.
+/**
+ * flush_dcache_range: Write any modified data cache blocks out to memory and invalidate them.
  * Does not invalidate the corresponding instruction cache blocks.
+ *
+ * @start: the start address
+ * @stop: the stop address (exclusive)
  */
 static inline void flush_dcache_range(unsigned long start, unsigned long stop)
 {
-	unsigned long shift = l1_cache_shift();
-	unsigned long bytes = l1_cache_bytes();
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
 	void *addr = (void *)(start & ~(bytes - 1));
 	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
@@ -82,6 +84,49 @@ static inline void flush_dcache_range(unsigned long start, unsigned long stop)
 		isync();
 }
 
+/**
+ * flush_icache_range: Write any modified data cache blocks out to memory
+ * and invalidate the corresponding blocks in the instruction cache
+ *
+ * Generic code will call this after writing memory, before executing from it.
+ *
+ * @start: the start address
+ * @stop: the stop address (exclusive)
+ */
+static inline void flush_icache_range(unsigned long start, unsigned long stop)
+{
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
+	void *addr = (void *)(start & ~(bytes - 1));
+	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
+	unsigned long i;
+
+	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
+		mb(); /* sync */
+		icbi((void *)start);
+		mb(); /* sync */
+		isync();
+		return;
+	}
+
+	/* Flush the data cache to memory */
+	for (i = 0; i < size >> shift; i++, addr += bytes)
+		dcbst(addr);
+
+	mb();	/* sync */
+
+	shift = l1_icache_shift();
+	bytes = l1_icache_bytes();
+	addr = (void *)(start & ~(bytes - 1));
+	size = stop - (unsigned long)addr + (bytes - 1);
+
+	/* Now invalidate the instruction cache */
+	for (i = 0; i < size >> shift; i++, addr += bytes)
+		icbi(addr);
+
+	isync();
+}
+
 /*
  * Write any modified data cache blocks out to memory.
  * Does not invalidate the corresponding cache lines (especially for
@@ -89,8 +134,8 @@ static inline void flush_dcache_range(unsigned long start, unsigned long stop)
  */
 static inline void clean_dcache_range(unsigned long start, unsigned long stop)
 {
-	unsigned long shift = l1_cache_shift();
-	unsigned long bytes = l1_cache_bytes();
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
 	void *addr = (void *)(start & ~(bytes - 1));
 	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
@@ -108,8 +153,8 @@ static inline void clean_dcache_range(unsigned long start, unsigned long stop)
 static inline void invalidate_dcache_range(unsigned long start,
 					   unsigned long stop)
 {
-	unsigned long shift = l1_cache_shift();
-	unsigned long bytes = l1_cache_bytes();
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
 	void *addr = (void *)(start & ~(bytes - 1));
 	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 9bc0aa9aeb65..999828e86bba 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -54,61 +54,6 @@ PPC64_CACHES:
 	.tc		ppc64_caches[TC],ppc64_caches
 	.section	".text"
 
-/*
- * Write any modified data cache blocks out to memory
- * and invalidate the corresponding instruction cache blocks.
- *
- * flush_icache_range(unsigned long start, unsigned long stop)
- *
- *   flush all bytes from start through stop-1 inclusive
- */
-
-_GLOBAL_TOC(flush_icache_range)
-BEGIN_FTR_SECTION
-	PURGE_PREFETCHED_INS
-	blr
-END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
-/*
- * Flush the data cache to memory 
- * 
- * Different systems have different cache line sizes
- * and in some cases i-cache and d-cache line sizes differ from
- * each other.
- */
- 	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1BLOCKSIZE(r10)/* Get cache block size */
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of cache block size */
-	srd.	r8,r8,r9		/* compute line count */
-	beqlr				/* nothing to do? */
-	mtctr	r8
-1:	dcbst	0,r6
-	add	r6,r6,r7
-	bdnz	1b
-	sync
-
-/* Now invalidate the instruction cache */
-	
-	lwz	r7,ICACHEL1BLOCKSIZE(r10)	/* Get Icache block size */
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5
-	lwz	r9,ICACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of Icache block size */
-	srd.	r8,r8,r9		/* compute line count */
-	beqlr				/* nothing to do? */
-	mtctr	r8
-2:	icbi	0,r6
-	add	r6,r6,r7
-	bdnz	2b
-	isync
-	blr
-_ASM_NOKPROBE_SYMBOL(flush_icache_range)
-EXPORT_SYMBOL(flush_icache_range)
-
 /*
  * Flush a particular page from the data cache to RAM.
  * Note: this is necessary because the instruction cache does *not*
-- 
2.21.0

