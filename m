Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1836186B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgCPMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:37:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41784 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731199AbgCPMgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwlF1x5Yz9v02h;
        Mon, 16 Mar 2020 13:36:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=V+eQ96TP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9bdRDHnPwipI; Mon, 16 Mar 2020 13:36:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlF0lZLz9v02f;
        Mon, 16 Mar 2020 13:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362169; bh=+r3Uvs2NtrSKSiP3s1jpNGh3Th8SL2VqTSytf4YScZ4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=V+eQ96TPp3u3xmKIbOsbK5oIg7eFSGjt+Dw9pDe5z3WHsU7sgdf+zBGAzpKetsQ7Z
         pUVHHn+1czKfg70bULXccIVnBpbNtnLJpUCidlzwvLJnMU0EwQHEWVfVvxJib0WBL3
         qkczsSD/kW5LQ0y2MeoLH4Z0IkwrJ8RalH9YtJJc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 117808B7D0;
        Mon, 16 Mar 2020 13:36:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Rxv6_hnFHVdB; Mon, 16 Mar 2020 13:36:14 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E33D48B7CB;
        Mon, 16 Mar 2020 13:36:13 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D819065595; Mon, 16 Mar 2020 12:36:13 +0000 (UTC)
Message-Id: <74c690b4b60bf414eaa1463864a42e51fc798856.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 28/46] powerpc/8xx: Only 8M pages are hugepte pages now
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

512k pages are now standard pages, so only 8M pages
are hugepte.

No more handling of normal page tables through hugepd allocation
and freeing, and hugepte helpers can also be simplified.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h |  7 +++----
 arch/powerpc/mm/hugetlbpage.c                    | 16 +++-------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index 785437323576..1c7d4693a78e 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -13,13 +13,13 @@ static inline pte_t *hugepd_page(hugepd_t hpd)
 
 static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
-	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
+	return PAGE_SHIFT_8M;
 }
 
 static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 				    unsigned int pdshift)
 {
-	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
+	unsigned long idx = (addr & (SZ_4M - 1)) >> PAGE_SHIFT;
 
 	return hugepd_page(hpd) + idx;
 }
@@ -32,8 +32,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 
 static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
 {
-	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT |
-			 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M : _PMD_PAGE_512K));
+	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT | _PMD_PAGE_8M);
 }
 
 static inline int check_and_get_huge_psize(int shift)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 35eb29584b54..243e90db400c 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -54,24 +54,17 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (pshift >= pdshift) {
 		cachep = PGT_CACHE(PTE_T_ORDER);
 		num_hugepd = 1 << (pshift - pdshift);
-		new = NULL;
-	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
-		cachep = NULL;
-		num_hugepd = 1;
-		new = pte_alloc_one(mm);
 	} else {
 		cachep = PGT_CACHE(pdshift - pshift);
 		num_hugepd = 1;
-		new = NULL;
 	}
 
-	if (!cachep && !new) {
+	if (!cachep) {
 		WARN_ONCE(1, "No page table cache created for hugetlb tables");
 		return -ENOMEM;
 	}
 
-	if (cachep)
-		new = kmem_cache_alloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
+	new = kmem_cache_alloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
 
 	BUG_ON(pshift > HUGEPD_SHIFT_MASK);
 	BUG_ON((unsigned long)new & HUGEPD_SHIFT_MASK);
@@ -102,10 +95,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (i < num_hugepd) {
 		for (i = i - 1 ; i >= 0; i--, hpdp--)
 			*hpdp = __hugepd(0);
-		if (cachep)
-			kmem_cache_free(cachep, new);
-		else
-			pte_free(mm, new);
+		kmem_cache_free(cachep, new);
 	} else {
 		kmemleak_ignore(new);
 	}
-- 
2.25.0

