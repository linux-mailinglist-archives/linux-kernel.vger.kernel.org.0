Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D574D13B16C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgANRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:54:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:46906 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgANRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:54:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47xykg4CK5z9txh1;
        Tue, 14 Jan 2020 18:54:03 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=trAj8ycD; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id E1j5e-IhSXwz; Tue, 14 Jan 2020 18:54:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47xykg3Bhsz9txgv;
        Tue, 14 Jan 2020 18:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579024443; bh=1gi8tiy8dwBccsWJGA9/konOi1hFYyPrqA/8BJnI8Bs=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=trAj8ycD8diCyKtiJlgO5Ksee62ZFOkwrA+hRQdP9J69dNXqYLdXFLF/S5kH/XJYD
         sM/Xp3fxcPY1UrSNa85p0CbGbpkO0ciXIWM7iC8jwuwPqhXABX6uqkqftL4oWioqiN
         z1z5Mn2ujoPm1x3Bb/4sXqjYMfQaL2VS5/zay9nE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29EE68B7EB;
        Tue, 14 Jan 2020 18:54:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R8LJQr3mEul9; Tue, 14 Jan 2020 18:54:05 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E258D8B7E8;
        Tue, 14 Jan 2020 18:54:04 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B1B776381C; Tue, 14 Jan 2020 17:54:04 +0000 (UTC)
Message-Id: <b29ffffb9206dc14541fa420c17604240728041b.1579024426.git.christophe.leroy@c-s.fr>
In-Reply-To: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
References: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/5] powerpc/32: reuse orphaned memblocks in
 kasan_init_shadow_page_tables()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Jan 2020 17:54:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If concurrent PMD population has happened, re-use orphaned memblocks.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index c4bf9ed04f88..d3cacd462560 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -34,17 +34,17 @@ static int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned
 {
 	pmd_t *pmd;
 	unsigned long k_cur, k_next;
+	pte_t *new = NULL;
 
 	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
 
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
-		pte_t *new;
-
 		k_next = pgd_addr_end(k_cur, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
-		new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
+		if (!new)
+			new = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
 
 		if (!new)
 			return -ENOMEM;
-- 
2.13.3

