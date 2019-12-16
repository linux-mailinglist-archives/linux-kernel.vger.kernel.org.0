Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF411F0D9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfLNIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 03:10:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21118 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfLNIKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:10:31 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47ZgFd0bxnz9vBmV;
        Sat, 14 Dec 2019 09:10:29 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=W0NFSiHz; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id D22I_wQSIGpE; Sat, 14 Dec 2019 09:10:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47ZgFc6QmRz9vBmT;
        Sat, 14 Dec 2019 09:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576311028; bh=9OX3cbpsdk/Bx1nvgsH+3knqA1sJ152d4iqy6Fxiacc=;
        h=From:Subject:To:Cc:Date:From;
        b=W0NFSiHzN8TKwEHuS4NXLTbNpGOQ/TefcbudBWs89mBUVsBorYJJa/Nn6ThfUMsE1
         U1eDe96p23NSClCS1ZyPVzYJzPHMX1CxNgjJO+J4VgkC/CS1Fw39KANsldnjdST8fM
         bG9jGs0E3Q1g9iqXvssCjbFq5HafPY6pwWKPzrYE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D75D18B788;
        Sat, 14 Dec 2019 09:10:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Zsh-J2ty9Sz4; Sat, 14 Dec 2019 09:10:29 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 992C78B755;
        Sat, 14 Dec 2019 09:10:29 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 3F4736377C; Sat, 14 Dec 2019 08:10:29 +0000 (UTC)
Message-Id: <56648921986a6b3e7315b1fbbf4684f21bd2dea8.1576310997.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix bogus __init on mmu_mapin_ram_chunk()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 14 Dec 2019 08:10:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove __init qualifier for mmu_mapin_ram_chunk() as it is called by
mmu_mark_initmem_nx() and mmu_mark_rodata_ro() which are not __init
functions.

At the same time, mark it static as it is only used in this file.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: a2227a277743 ("powerpc/32: Don't populate page tables for block mapped pages except on the 8xx")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/nohash/8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 2c98078d2ede..3189308dece4 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -104,7 +104,7 @@ static void mmu_patch_addis(s32 *site, long simm)
 	patch_instruction_site(site, instr);
 }
 
-void __init mmu_mapin_ram_chunk(unsigned long offset, unsigned long top, pgprot_t prot)
+static void mmu_mapin_ram_chunk(unsigned long offset, unsigned long top, pgprot_t prot)
 {
 	unsigned long s = offset;
 	unsigned long v = PAGE_OFFSET + s;
-- 
2.13.3

