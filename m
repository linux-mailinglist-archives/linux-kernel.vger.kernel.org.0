Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454738C1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfHMULp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 16:11:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12883 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfHMULk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467P4W3T5fz9v0CQ;
        Tue, 13 Aug 2019 22:11:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JmAbr5Mo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Myi4YRIYF-B0; Tue, 13 Aug 2019 22:11:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467P4W2LHXz9v0CM;
        Tue, 13 Aug 2019 22:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565727099; bh=BzfqDe0EFbhH8rVq4zZCletoPvFTHtiBN7yf0nX9ga0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=JmAbr5MoXjjC6E/iRe+EOErk6epFjABJTrPkUkGEiusbd3rLXcRPRrKC7sOND1NYI
         6Se3U/B3A95dz6FhHjsZkFxQvXfl9rcs0c4cO6ELPDKFDugPST5ajr8PEB+N0shG0s
         bHx8of6yxzvlgvmOLcyuvGvH7mZ2j8V21j/r1jFM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 757D08B7F2;
        Tue, 13 Aug 2019 22:11:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lqf9J6CVNTbe; Tue, 13 Aug 2019 22:11:39 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 36F158B7F0;
        Tue, 13 Aug 2019 22:11:39 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1B1AF69632; Tue, 13 Aug 2019 20:11:39 +0000 (UTC)
Message-Id: <9f2104e23cc4992dc8ed5c599038f829ae50abbb.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 06/10] powerpc/mm: make ioremap_bot common to all
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Aug 2019 20:11:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop multiple definitions of ioremap_bot and make one common to
all subarches.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 --
 arch/powerpc/include/asm/book3s/64/pgtable.h | 1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h | 2 --
 arch/powerpc/include/asm/pgtable.h           | 2 ++
 arch/powerpc/mm/ioremap.c                    | 3 +++
 arch/powerpc/mm/mmu_decl.h                   | 1 -
 arch/powerpc/mm/nohash/tlb.c                 | 2 ++
 arch/powerpc/mm/pgtable_32.c                 | 3 ---
 arch/powerpc/mm/pgtable_64.c                 | 3 ---
 9 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 838de59f6754..aa1bc5f8da90 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -201,8 +201,6 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 #include <linux/sched.h>
 #include <linux/threads.h>
 
-extern unsigned long ioremap_bot;
-
 /* Bits to mask out from a PGD to get to the PUD page */
 #define PGD_MASKED_BITS		0
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8308f32e9782..11819e3c755e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -289,7 +289,6 @@ extern unsigned long __kernel_io_end;
 #define KERN_IO_END __kernel_io_end
 
 extern struct page *vmemmap;
-extern unsigned long ioremap_bot;
 extern unsigned long pci_io_base;
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 0284f8f5305f..7ce2a7c9fade 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -11,8 +11,6 @@
 #include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
 #include <asm/asm-405.h>
 
-extern unsigned long ioremap_bot;
-
 #ifdef CONFIG_44x
 extern int icache_44x_need_flush;
 #endif
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index c58ba7963688..c54bb68c1354 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -68,6 +68,8 @@ extern pgd_t swapper_pg_dir[];
 
 extern void paging_init(void);
 
+extern unsigned long ioremap_bot;
+
 /*
  * kern_addr_valid is intended to indicate whether an address is a valid
  * kernel address.  Most 32-bit archs define it as always true (like this)
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index a44d9e4c948a..0c23660522ca 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -3,6 +3,9 @@
 #include <linux/io.h>
 #include <asm/io-workarounds.h>
 
+unsigned long ioremap_bot;
+EXPORT_SYMBOL(ioremap_bot);
+
 void __iomem *__ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
 	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 32c1a191c28a..6ee64d5e2824 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -108,7 +108,6 @@ extern u8 early_hash[];
 
 #endif /* CONFIG_PPC32 */
 
-extern unsigned long ioremap_bot;
 extern unsigned long __max_low_memory;
 extern phys_addr_t __initial_memory_limit_addr;
 extern phys_addr_t total_memory;
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index d4acf6fa0596..350a54f70a37 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -704,6 +704,8 @@ static void __init early_init_mmu_global(void)
 	 * for use by the TLB miss code
 	 */
 	linear_map_top = memblock_end_of_DRAM();
+
+	ioremap_bot = IOREMAP_END;
 }
 
 static void __init early_mmu_set_memory_limit(void)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 8126c2d1afbf..7efdb1dee19b 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -33,9 +33,6 @@
 
 #include <mm/mmu_decl.h>
 
-unsigned long ioremap_bot;
-EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
-
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
 void __iomem *
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0f0b1e1ea5ab..d631659c8859 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -99,9 +99,6 @@ unsigned long __pte_frag_nr;
 EXPORT_SYMBOL(__pte_frag_nr);
 unsigned long __pte_frag_size_shift;
 EXPORT_SYMBOL(__pte_frag_size_shift);
-unsigned long ioremap_bot;
-#else /* !CONFIG_PPC_BOOK3S_64 */
-unsigned long ioremap_bot = IOREMAP_END;
 #endif
 
 int __weak ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size, pgprot_t prot, int nid)
-- 
2.13.3

