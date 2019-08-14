Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C828D33B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfHNMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 08:36:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40469 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHNMgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:36:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467pwT32gPz9v0dK;
        Wed, 14 Aug 2019 14:36:09 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=U2w1Iv45; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pH6aw3bPfSq4; Wed, 14 Aug 2019 14:36:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467pwT20mVz9v0dJ;
        Wed, 14 Aug 2019 14:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565786169; bh=x4QYzhKgvTlm6zZvQQfzyv6zEBi/dLidRDqMdAm2N1g=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=U2w1Iv45hSz3xYUsyxWicQkh36fkxhITJhxilnDGUv8Tq5yKIxV3SdyHXa2drdReG
         GJHN4O6GVOPEkKTMKxoESCS3Jsw6VB3MQiaP1wQj4z3O/qCTk/T/uuayWvgUegr4CK
         gJKfmG7Wi6wR+mlSghP8PJc6aAHI+s/bqklr2Vxg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9CCE8B7F5;
        Wed, 14 Aug 2019 14:36:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lALxzmVyFtil; Wed, 14 Aug 2019 14:36:10 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F0198B761;
        Wed, 14 Aug 2019 14:36:10 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9C1636B6C0; Wed, 14 Aug 2019 12:36:10 +0000 (UTC)
Message-Id: <5aa2ac513295f594cce8ddb1c649f61947bd063d.1565786091.git.christophe.leroy@c-s.fr>
In-Reply-To: <eb4d626514e22f85814830012642329018ef6af9.1565786091.git.christophe.leroy@c-s.fr>
References: <eb4d626514e22f85814830012642329018ef6af9.1565786091.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/5] powerpc/ptdump: fix walk_pagetables() address mismatch
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 14 Aug 2019 12:36:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_pagetables() always walk the entire pgdir from address 0
but considers PAGE_OFFSET or KERN_VIRT_START as the starting
address of the walk, resulting in a possible mismatch in the
displayed addresses.

Ex: on PPC32, when KERN_VIRT_START was locally defined as
PAGE_OFFSET, ptdump displayed 0x80000000
instead of 0xc0000000 for the first kernel page,
because 0xc0000000 + 0xc0000000 = 0x80000000

Start the walk at st->start_address instead of starting at 0.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ptdump/ptdump.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 3ad64fc11419..74ff2bff4ea0 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -299,17 +299,15 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 
 static void walk_pagetables(struct pg_state *st)
 {
-	pgd_t *pgd = pgd_offset_k(0UL);
 	unsigned int i;
-	unsigned long addr;
-
-	addr = st->start_address;
+	unsigned long addr = st->start_address & PGDIR_MASK;
+	pgd_t *pgd = pgd_offset_k(addr);
 
 	/*
 	 * Traverse the linux pagetable structure and dump pages that are in
 	 * the hash pagetable.
 	 */
-	for (i = 0; i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
+	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
 		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
-- 
2.13.3

