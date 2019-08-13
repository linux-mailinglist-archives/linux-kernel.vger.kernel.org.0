Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA718C1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfHMULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 16:11:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12883 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfHMULj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467P4T39FRz9v0CN;
        Tue, 13 Aug 2019 22:11:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WVI/sWHH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jma1B7RXAY28; Tue, 13 Aug 2019 22:11:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467P4T26hXz9v0CM;
        Tue, 13 Aug 2019 22:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565727097; bh=D4rnDjt76MjLP9FCo1mtrw2GgE/1jNpQh3hpE9TrM5c=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=WVI/sWHHHTEaXelA/2N8dAgRlqEiGx+OFPnzq9sQ1falzv0J6JlHJsVtuUhzGKkuS
         PjburZRD38LHh+/hAoWP4AsRsdzBmnkUS4AERicMKt6CX4atPCMeDnptzPn1zRMold
         C358R6UqfnkfcodQcLfDNA4nCeYETR42CS9QnxaI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69EA88B7F2;
        Tue, 13 Aug 2019 22:11:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id boINXiBMs1Qc; Tue, 13 Aug 2019 22:11:37 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25AE98B7F0;
        Tue, 13 Aug 2019 22:11:37 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0D89669632; Tue, 13 Aug 2019 20:11:36 +0000 (UTC)
Message-Id: <da225f763855771763723d7bb01ededb50fbb839.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 04/10] powerpc/mm: move ioremap_prot() into ioremap.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Aug 2019 20:11:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both ioremap_prot() are idenfical, move them into ioremap.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ioremap.c    | 19 +++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c | 17 -----------------
 arch/powerpc/mm/pgtable_64.c | 24 ------------------------
 3 files changed, 19 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 89479ee88344..a44d9e4c948a 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -50,3 +50,22 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 		return iowa_ioremap(addr, size, prot, caller);
 	return __ioremap_caller(addr, size, prot, caller);
 }
+
+void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
+{
+	pte_t pte = __pte(flags);
+	void *caller = __builtin_return_address(0);
+
+	/* writeable implies dirty for kernel addresses */
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
+
+	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
+	pte = pte_exprotect(pte);
+	pte = pte_mkprivileged(pte);
+
+	if (iowa_is_active())
+		return iowa_ioremap(addr, size, pte_pgprot(pte), caller);
+	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
+}
+EXPORT_SYMBOL(ioremap_prot);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 1999ec11706d..8126c2d1afbf 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -39,23 +39,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
 void __iomem *
-ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
-{
-	pte_t pte = __pte(flags);
-
-	/* writeable implies dirty for kernel addresses */
-	if (pte_write(pte))
-		pte = pte_mkdirty(pte);
-
-	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	pte = pte_exprotect(pte);
-	pte = pte_mkprivileged(pte);
-
-	return __ioremap_caller(addr, size, pte_pgprot(pte), __builtin_return_address(0));
-}
-EXPORT_SYMBOL(ioremap_prot);
-
-void __iomem *
 __ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *caller)
 {
 	unsigned long v, i;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 3ad921ac4862..6fa2e969bf0e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -204,29 +204,6 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	return ret;
 }
 
-void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
-			     unsigned long flags)
-{
-	pte_t pte = __pte(flags);
-	void *caller = __builtin_return_address(0);
-
-	/* writeable implies dirty for kernel addresses */
-	if (pte_write(pte))
-		pte = pte_mkdirty(pte);
-
-	/* we don't want to let _PAGE_EXEC leak out */
-	pte = pte_exprotect(pte);
-	/*
-	 * Force kernel mapping.
-	 */
-	pte = pte_mkprivileged(pte);
-
-	if (iowa_is_active())
-		return iowa_ioremap(addr, size, pte_pgprot(pte), caller);
-	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
-}
-
-
 /*  
  * Unmap an IO region and remove it from imalloc'd list.
  * Access to IO memory should be serialized by driver.
@@ -253,7 +230,6 @@ void iounmap(volatile void __iomem *token)
 	__iounmap(token);
 }
 
-EXPORT_SYMBOL(ioremap_prot);
 EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(__iounmap);
-- 
2.13.3

