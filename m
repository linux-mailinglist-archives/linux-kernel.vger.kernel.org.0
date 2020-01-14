Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB32E13A29A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgANINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 03:13:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1923 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgANINL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:13:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47xjrN48tlz9txps;
        Tue, 14 Jan 2020 09:13:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qVJjeOJt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ax4DlAU-LFRw; Tue, 14 Jan 2020 09:13:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47xjrN2hdfz9txpr;
        Tue, 14 Jan 2020 09:13:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1578989588; bh=nYNmObGRX5QXwkyrQ/z88cc0DXGjurU82OHj/0TKFB0=;
        h=From:Subject:To:Cc:Date:From;
        b=qVJjeOJtqePHi46tx2HmBZQ5Y0NPD/PYS74kgHj3x+gDrsQy6IDqCpp2mTtp1gFHI
         DVgqicSNmXARCu2Sf/ml1wiDXDIOebbTuwOOBcg4IsGfiTy1dV6XW9dGfAO5oCrri6
         5YCoYtiBrBe97N8ND8Vt1bj3Ipj8acVpg64HCikc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 53F6F8B7D1;
        Tue, 14 Jan 2020 09:13:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PW_4TgoO8Lwi; Tue, 14 Jan 2020 09:13:09 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 14D548B769;
        Tue, 14 Jan 2020 09:13:09 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AC38064A20; Tue, 14 Jan 2020 08:13:08 +0000 (UTC)
Message-Id: <37517da8310f4457f28921a4edb88fb21d27b62a.1578989531.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/ptdump: fix W+X verification call in mark_rodata_ro()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Jan 2020 08:13:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptdump_check_wx() also have to be called when pages are mapped
by blocks.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
---
 arch/powerpc/mm/pgtable_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 73b84166d06a..5fb90edd865e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -218,6 +218,7 @@ void mark_rodata_ro(void)
 
 	if (v_block_mapped((unsigned long)_sinittext)) {
 		mmu_mark_rodata_ro();
+		ptdump_check_wx();
 		return;
 	}
 
-- 
2.13.3

