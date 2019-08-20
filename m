Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFD961F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfHTOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:07:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30751 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfHTOHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:07:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46CXfm4NrVz9v0Gg;
        Tue, 20 Aug 2019 16:07:12 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VRyHc+g2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hklT6zho8N0y; Tue, 20 Aug 2019 16:07:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46CXfm3D1Jz9v0GZ;
        Tue, 20 Aug 2019 16:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566310032; bh=wYmWQVbOL8+HyhpkF7UnISkf2nMl4sTU2NwnfBVkSic=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VRyHc+g2lcnsNgDrluO1aW6YmcSnztD3Xp6HxV+1VRwSs1VSBtlMxsm9clacEjkKb
         lEyLIp3g804qEptg5KC4saUF4mxMy/Nljx5BBCe0RZ+i4l4sI4T1S0B45q3RyGRXZH
         DyI5E9fGXNza2EqwcpOzTCLCiR/DqVrruCV9PH7M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF1F98B7D0;
        Tue, 20 Aug 2019 16:07:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4IEqfRPCvbSD; Tue, 20 Aug 2019 16:07:12 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 72AB08B7C9;
        Tue, 20 Aug 2019 16:07:12 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5C0D06B734; Tue, 20 Aug 2019 14:07:12 +0000 (UTC)
Message-Id: <ccc439f481a0884e00a6be1bab44bab2a4477fea.1566309262.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1566309262.git.christophe.leroy@c-s.fr>
References: <cover.1566309262.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/12] powerpc/mm: drop function __ioremap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Aug 2019 14:07:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ioremap() is not used anymore, drop it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/io.h |  6 ------
 arch/powerpc/mm/pgtable_32.c  | 11 ++---------
 arch/powerpc/mm/pgtable_64.c  |  7 -------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 02d6256fe1ea..8e65ba59f06a 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -705,10 +705,6 @@ static inline void iosync(void)
  *   create hand-made mappings for use only by the PCI code and cannot
  *   currently be hooked. Must be page aligned.
  *
- * * __ioremap is the low level implementation used by ioremap and
- *   ioremap_prot and cannot be hooked (but can be used by a hook on one
- *   of the previous ones)
- *
  * * __ioremap_caller is the same as above but takes an explicit caller
  *   reference rather than using __builtin_return_address(0)
  *
@@ -726,8 +722,6 @@ void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
 
 extern void iounmap(volatile void __iomem *addr);
 
-extern void __iomem *__ioremap(phys_addr_t, unsigned long size,
-			       unsigned long flags);
 extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
 				      pgprot_t prot, void *caller);
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 35cb96cfc258..848ee4a30dd1 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -92,12 +92,6 @@ ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 EXPORT_SYMBOL(ioremap_prot);
 
 void __iomem *
-__ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
-{
-	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
-}
-
-void __iomem *
 __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *caller)
 {
 	unsigned long v, i;
@@ -127,8 +121,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 	 */
 	if (slab_is_available() && p <= virt_to_phys(high_memory - 1) &&
 	    page_is_ram(__phys_to_pfn(p))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
-		       (unsigned long long)p, __builtin_return_address(0));
+		pr_warn("%s(): phys addr 0x%llx is RAM lr %ps\n", __func__,
+			(unsigned long long)p, __builtin_return_address(0));
 		return NULL;
 	}
 #endif
@@ -171,7 +165,6 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *call
 out:
 	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
 }
-EXPORT_SYMBOL(__ioremap);
 
 void iounmap(volatile void __iomem *addr)
 {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 57cdd6182932..2882419737b9 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -203,12 +203,6 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	return ret;
 }
 
-void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
-			 unsigned long flags)
-{
-	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
-}
-
 void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 {
 	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
@@ -286,7 +280,6 @@ void iounmap(volatile void __iomem *token)
 EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(ioremap_wc);
 EXPORT_SYMBOL(ioremap_prot);
-EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(__iounmap_at);
-- 
2.13.3

