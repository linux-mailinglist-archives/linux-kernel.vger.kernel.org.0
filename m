Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8E961E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfHTOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:07:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30751 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:07:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46CXfk2zsjz9v0Gd;
        Tue, 20 Aug 2019 16:07:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jrAPZmUP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cpWiJ5Agsxq7; Tue, 20 Aug 2019 16:07:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46CXfk1qL2z9v0GZ;
        Tue, 20 Aug 2019 16:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566310030; bh=T5uG7mG7FB/c459qUonEdQYtjb7qA4SseH9TqeFbrkM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=jrAPZmUPsblAorp3HRCw9glee11alBdjilbQ1iRtfwcj2d3ilsqLqZ9xWDDa9vmlh
         VmhZeGhqmnYwL2yNhKqIeOZ1Kz9zfqSAY4DXYjCyRrwOs9+s/s/v1wuPXccQ8C8Xxa
         QcG/uzH1rdek6qDHn3IduPLfiw+jkP0Xl4ga19No=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95F048B7D0;
        Tue, 20 Aug 2019 16:07:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rQvR8mqpXLe9; Tue, 20 Aug 2019 16:07:10 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 632018B7C9;
        Tue, 20 Aug 2019 16:07:10 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4FA846B734; Tue, 20 Aug 2019 14:07:10 +0000 (UTC)
Message-Id: <36bff5d875ff562889c5e12dab63e5d7c5d1fbd8.1566309262.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1566309262.git.christophe.leroy@c-s.fr>
References: <cover.1566309262.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/12] powerpc/ps3: replace __ioremap() by ioremap_prot()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Aug 2019 14:07:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ioremap() is similar to ioremap_prot() except that ioremap_prot()
does a few sanity changes in addition.

The flags used by PS3 are not impacted by those changes so for
PS3 both functions are equivalent.

At the same time, drop parts of the comment that have been invalid
since commit e58e87adc8bf ("powerpc/mm: Update _PAGE_KERNEL_RO")

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/ps3/spu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index bdaeaecdc06b..1193c294b8d0 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -184,10 +184,7 @@ static void spu_unmap(struct spu *spu)
  * setup_areas - Map the spu regions into the address space.
  *
  * The current HV requires the spu shadow regs to be mapped with the
- * PTE page protection bits set as read-only (PP=3).  This implementation
- * uses the low level __ioremap() to bypass the page protection settings
- * inforced by ioremap_prot() to get the needed PTE bits set for the
- * shadow regs.
+ * PTE page protection bits set as read-only.
  */
 
 static int __init setup_areas(struct spu *spu)
@@ -195,9 +192,8 @@ static int __init setup_areas(struct spu *spu)
 	struct table {char* name; unsigned long addr; unsigned long size;};
 	unsigned long shadow_flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL_RO));
 
-	spu_pdata(spu)->shadow = __ioremap(spu_pdata(spu)->shadow_addr,
-					   sizeof(struct spe_shadow),
-					   shadow_flags);
+	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
+					      sizeof(struct spe_shadow), shadow_flags);
 	if (!spu_pdata(spu)->shadow) {
 		pr_debug("%s:%d: ioremap shadow failed\n", __func__, __LINE__);
 		goto fail_ioremap;
-- 
2.13.3

