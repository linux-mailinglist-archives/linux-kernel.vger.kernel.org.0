Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740F7247ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfEUGSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 02:18:16 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50479 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:18:16 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4L6H3Aj032461;
        Tue, 21 May 2019 15:17:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4L6H3Aj032461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558419423;
        bh=XrIYM7aPLD1wF9IwpTW/Z8OCfZUnOmtJFdrupyPx8Jg=;
        h=From:To:Cc:Subject:Date:From;
        b=qRhjmuYxD1rELM9hqEW562/6ESLP8dewpyu3CRkbpHWF/HyEsjx4CGe5Z9rn8qLQ+
         gboSm5Et1KAj3cRJMaRBFPSH4UA7AkbxWqvj495Ob5JkS8H/a9sJA494+KEZvTfxoh
         3INjo03cOlwI6gYC0amArPqePIVHH8CDPPZEYRd8Gt/aS+niGNLLi2HBOly8hnGu9L
         XquUKHIO435JOzS08erKhaVC/V3+jc5FuO/Tf6AB8rEd15ACMZuObKOyldeDbk4Fas
         TyuVWDZrd55cnf86Y+vvNrnQ7cM0OsEo9jy9RD4igjtuKvrN/FgYG+TOTMjMz50Hdz
         /zHMLg0X9EnQA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
Date:   Tue, 21 May 2019 15:16:59 +0900
Message-Id: <20190521061659.6073-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
with gcc 9.1.1:

  arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
  arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
    104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
        |  ^~~
  arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'

Fixing _tlbiel_pid() is enough to address the warning above, but I
inlined more functions to fix all potential issues.

To meet the 'i' (immediate) constraint for the asm operands, functions
propagating propagated 'ric' must be always inlined.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/mm/book3s64/hash_native.c |  8 +++--
 arch/powerpc/mm/book3s64/radix_tlb.c   | 44 +++++++++++++++-----------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
index aaa28fd918fe..bc2c35c0d2b1 100644
--- a/arch/powerpc/mm/book3s64/hash_native.c
+++ b/arch/powerpc/mm/book3s64/hash_native.c
@@ -60,9 +60,11 @@ static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
  * tlbiel instruction for hash, set invalidation
  * i.e., r=1 and is=01 or is=10 or is=11
  */
-static inline void tlbiel_hash_set_isa300(unsigned int set, unsigned int is,
-					unsigned int pid,
-					unsigned int ric, unsigned int prs)
+static __always_inline void tlbiel_hash_set_isa300(unsigned int set,
+						   unsigned int is,
+						   unsigned int pid,
+						   unsigned int ric,
+						   unsigned int prs)
 {
 	unsigned long rb;
 	unsigned long rs;
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 4d841369399f..91c4242c1be3 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -29,9 +29,11 @@
  * tlbiel instruction for radix, set invalidation
  * i.e., r=1 and is=01 or is=10 or is=11
  */
-static inline void tlbiel_radix_set_isa300(unsigned int set, unsigned int is,
-					unsigned int pid,
-					unsigned int ric, unsigned int prs)
+static __always_inline void tlbiel_radix_set_isa300(unsigned int set,
+						    unsigned int is,
+						    unsigned int pid,
+						    unsigned int ric,
+						    unsigned int prs)
 {
 	unsigned long rb;
 	unsigned long rs;
@@ -150,8 +152,8 @@ static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 	trace_tlbie(lpid, 0, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
-				unsigned long ric)
+static __always_inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
+						unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -167,8 +169,8 @@ static inline void __tlbiel_lpid_guest(unsigned long lpid, int set,
 }
 
 
-static inline void __tlbiel_va(unsigned long va, unsigned long pid,
-			       unsigned long ap, unsigned long ric)
+static __always_inline void __tlbiel_va(unsigned long va, unsigned long pid,
+					unsigned long ap, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -183,8 +185,8 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_va(unsigned long va, unsigned long pid,
-			      unsigned long ap, unsigned long ric)
+static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
+				       unsigned long ap, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -199,8 +201,10 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
-			      unsigned long ap, unsigned long ric)
+static __always_inline void __tlbie_lpid_va(unsigned long va,
+					    unsigned long lpid,
+					    unsigned long ap,
+					    unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -239,7 +243,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
+static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
@@ -341,7 +345,8 @@ static inline void _tlbie_lpid(unsigned long lpid, unsigned long ric)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
+static __always_inline void _tlbiel_lpid_guest(unsigned long lpid,
+					       unsigned long ric)
 {
 	int set;
 
@@ -381,8 +386,8 @@ static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
 		__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
 }
 
-static inline void _tlbiel_va(unsigned long va, unsigned long pid,
-			      unsigned long psize, unsigned long ric)
+static __always_inline void _tlbiel_va(unsigned long va, unsigned long pid,
+				       unsigned long psize, unsigned long ric)
 {
 	unsigned long ap = mmu_get_ap(psize);
 
@@ -413,8 +418,8 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
 		__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
 }
 
-static inline void _tlbie_va(unsigned long va, unsigned long pid,
-			      unsigned long psize, unsigned long ric)
+static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
+				      unsigned long psize, unsigned long ric)
 {
 	unsigned long ap = mmu_get_ap(psize);
 
@@ -424,8 +429,9 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
-			      unsigned long psize, unsigned long ric)
+static __always_inline void _tlbie_lpid_va(unsigned long va, unsigned long lpid,
+					   unsigned long psize,
+					   unsigned long ric)
 {
 	unsigned long ap = mmu_get_ap(psize);
 
-- 
2.17.1

