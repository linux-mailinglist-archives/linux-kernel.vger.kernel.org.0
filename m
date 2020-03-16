Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D6186B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgCPMgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:36:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5721 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbgCPMg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:36:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwlT4YkRz9v02q;
        Mon, 16 Mar 2020 13:36:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=l0bR5UYC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ty--1Qk6W4L5; Mon, 16 Mar 2020 13:36:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlT3WhFz9v02f;
        Mon, 16 Mar 2020 13:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362181; bh=x26mXVn6Nab3fc/LmUcn855fqhkA/0J1NfUOpIoWioU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=l0bR5UYCn1p/5G7TSU7TgMKB95AaWdzZo20Kk4u640+p1at+AErnr3qZKdJYUNmxv
         3JY9CnHgan4wWUf/JQx0/HlLau1g4YTH78zW+3/WZjo1bdI0DEmzZFOpM6c2N/xnzY
         BdMXlWLw3yr+Ym1hCkK+Gfp/yE9TTz5BcSruDaHE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 749CA8B7D0;
        Mon, 16 Mar 2020 13:36:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pbKgllfO0WA4; Mon, 16 Mar 2020 13:36:26 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 583EE8B7CB;
        Mon, 16 Mar 2020 13:36:26 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4B86565595; Mon, 16 Mar 2020 12:36:26 +0000 (UTC)
Message-Id: <26f9e79d95a1ad94dd05e1e782f721f5d5d2664d.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 40/46] powerpc/8xx: Map IMMR with a huge page
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:36:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the IMMR area with a single 512k huge page.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/nohash/8xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 81ddcd9554e1..57e0c7496a6a 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -117,17 +117,13 @@ static bool immr_is_mapped __initdata;
 
 void __init mmu_mapin_immr(void)
 {
-	unsigned long p = PHYS_IMMR_BASE;
-	unsigned long v = VIRT_IMMR_BASE;
-	int offset;
-
 	if (immr_is_mapped)
 		return;
 
 	immr_is_mapped = true;
 
-	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
-		map_kernel_page(v + offset, p + offset, PAGE_KERNEL_NCG);
+	__early_map_kernel_hugepage(VIRT_IMMR_BASE, PHYS_IMMR_BASE,
+				    PAGE_KERNEL_NCG, MMU_PAGE_512K, true);
 }
 
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
-- 
2.25.0

