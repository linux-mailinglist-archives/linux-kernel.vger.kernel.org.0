Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96A961E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfHTOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:07:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59915 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbfHTOHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:07:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46CXfl3q3Tz9v0Gf;
        Tue, 20 Aug 2019 16:07:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=KetSW1tQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FhcSZut_9CBR; Tue, 20 Aug 2019 16:07:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46CXfl2fRrz9v0GZ;
        Tue, 20 Aug 2019 16:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566310031; bh=h5vRXYYeGFb9Dv62GRqWpI9L4RjB8tlKO8cMtVPQqEw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=KetSW1tQCEAXJpQnqCCDGf05LpfhDhWIX8/hjI/e+Ko3Wd7vcqzdiVBaa99jVVK/3
         t1CIbQtIB6NJMhr/xFWeGMoaXg6IKxEEI+Bsn8cBfbdPcjiulKfUfqOshjq76FPSo4
         NpTcfqVMTg2ZQlQwVu7djJYppVdtPknZshRi8z7s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6F5D8B7D0;
        Tue, 20 Aug 2019 16:07:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XaN3ndXVJ8XJ; Tue, 20 Aug 2019 16:07:11 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73ABB8B7C9;
        Tue, 20 Aug 2019 16:07:11 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 55C2F6B734; Tue, 20 Aug 2019 14:07:11 +0000 (UTC)
Message-Id: <d73ba92bb7a387cc58cc34666d7f5158a45851b0.1566309262.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1566309262.git.christophe.leroy@c-s.fr>
References: <cover.1566309262.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/12] powerpc/mm: drop ppc_md.iounmap() and __iounmap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Aug 2019 14:07:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc_md.iounmap() is never set, drop it.

Once ppc_md.iounmap() is gone, iounmap() remains the only user of
__iounmap() and iounmap() does nothing else than calling __iounmap().
So drop iounmap() and make __iounmap() the new iounmap().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/io.h      |  5 -----
 arch/powerpc/include/asm/machdep.h |  2 --
 arch/powerpc/mm/pgtable_64.c       | 11 +----------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 23e5d5d16c7e..02d6256fe1ea 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -712,9 +712,6 @@ static inline void iosync(void)
  * * __ioremap_caller is the same as above but takes an explicit caller
  *   reference rather than using __builtin_return_address(0)
  *
- * * __iounmap, is the low level implementation used by iounmap and cannot
- *   be hooked (but can be used by a hook on iounmap)
- *
  */
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
 extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
@@ -734,8 +731,6 @@ extern void __iomem *__ioremap(phys_addr_t, unsigned long size,
 extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
 				      pgprot_t prot, void *caller);
 
-extern void __iounmap(volatile void __iomem *addr);
-
 extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
 				   unsigned long size, pgprot_t prot);
 extern void __iounmap_at(void *ea, unsigned long size);
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c43d6eca9edd..3370df4bdaa0 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -33,8 +33,6 @@ struct machdep_calls {
 #ifdef CONFIG_PPC64
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   pgprot_t prot, void *caller);
-	void		(*iounmap)(volatile void __iomem *token);
-
 #ifdef CONFIG_PM
 	void		(*iommu_save)(void);
 	void		(*iommu_restore)(void);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 9ad59b733984..57cdd6182932 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -266,7 +266,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
  * Unmap an IO region and remove it from imalloc'd list.
  * Access to IO memory should be serialized by driver.
  */
-void __iounmap(volatile void __iomem *token)
+void iounmap(volatile void __iomem *token)
 {
 	void *addr;
 
@@ -283,21 +283,12 @@ void __iounmap(volatile void __iomem *token)
 	vunmap(addr);
 }
 
-void iounmap(volatile void __iomem *token)
-{
-	if (ppc_md.iounmap)
-		ppc_md.iounmap(token);
-	else
-		__iounmap(token);
-}
-
 EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(ioremap_wc);
 EXPORT_SYMBOL(ioremap_prot);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(__iounmap);
 EXPORT_SYMBOL(__iounmap_at);
 
 #ifndef __PAGETABLE_PUD_FOLDED
-- 
2.13.3

