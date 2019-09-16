Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270E8B41BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391374AbfIPUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 16:25:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31164 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730502AbfIPUZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:25:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46XHn274NLz9v0sp;
        Mon, 16 Sep 2019 22:25:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qc2T5P4b; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W_5UD_T94ppf; Mon, 16 Sep 2019 22:25:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46XHn2603lz9v0sm;
        Mon, 16 Sep 2019 22:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568665542; bh=EfeppcJfC7z4dz+NpDaNTk1OezSvA6hyV2vlPsX3zdQ=;
        h=From:Subject:To:Cc:Date:From;
        b=qc2T5P4bhLOJoXzmeUEqXDyn6GzxgKREKfKhCztODnRYXyep+GBRQ7r3P3b9aVk0w
         IZu0kgm4yo7BGrqMGXF7+jeVO5XnbbH+PSDg4ze3CcVYSogFF0OQT9F4NULR+oQ4kU
         PIowAGQfDB6Pq9R8VUcZweRRcG4LEqqkLg54eYlA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA2D98B848;
        Mon, 16 Sep 2019 22:25:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tvSznHTgdhzQ; Mon, 16 Sep 2019 22:25:42 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3C738B841;
        Mon, 16 Sep 2019 22:25:42 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id A38306B763; Mon, 16 Sep 2019 20:25:39 +0000 (UTC)
Message-Id: <a212bd36fbd6179e0929b6c727febc35132ac25c.1568665466.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/2] powerpc/32s: automatically allocate BAT in setbat()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Sep 2019 20:25:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no BAT is given to setbat(), select an available BAT.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: no change
v3: no change
---
 arch/powerpc/mm/book3s32/mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 84d5fab94f8f..69b2419accef 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -251,9 +251,18 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 {
 	unsigned int bl;
 	int wimgxpp;
-	struct ppc_bat *bat = BATS[index];
+	struct ppc_bat *bat;
 	unsigned long flags = pgprot_val(prot);
 
+	if (index == -1)
+		index = find_free_bat();
+	if (index == -1) {
+		pr_err("%s: no BAT available for mapping 0x%llx\n", __func__,
+		       (unsigned long long)phys);
+		return;
+	}
+	bat = BATS[index];
+
 	if ((flags & _PAGE_NO_CACHE) ||
 	    (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
 		flags &= ~_PAGE_COHERENT;
-- 
2.13.3

