Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC9186AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgCPMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:35:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58171 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbgCPMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkl2P0vz9tygM;
        Mon, 16 Mar 2020 13:35:43 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BMb3AhoC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0PVZ3z9qOGel; Mon, 16 Mar 2020 13:35:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkl1GVHz9tyg5;
        Mon, 16 Mar 2020 13:35:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362143; bh=oZtGTa78Y5rPjQ2MGHaSLF8e7B/jMIoLfcLZyfGVsyo=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=BMb3AhoCOeAldRXTG4vJ6619xho/XuXMFlouhTDI5CN7cojvnC/qz9owVyy/sKZ2/
         J9daoDnXGcksulXnwY88b9WcJDM3aihb13UWeHtPLq2jqslu+NTuME2JElXknoR/Uk
         1tlfZB34nEmbPlAOUqWQP67h+hPlEjC/4BkFx/oQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A2E88B7D0;
        Mon, 16 Mar 2020 13:35:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 055xfmERVy42; Mon, 16 Mar 2020 13:35:48 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BDD28B7CB;
        Mon, 16 Mar 2020 13:35:48 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0448F65595; Mon, 16 Mar 2020 12:35:48 +0000 (UTC)
Message-Id: <535706809d9404621d70bd7ad8456e844c427090.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 03/46] powerpc/kasan: Fix issues by lowering
 KASAN_SHADOW_END
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, KASAN_SHADOW_END is 0x100000000, which
is 0 in 32 bits representation.

This leads to a couple of issues:
- kasan_remap_early_shadow_ro() does nothing because the comparison
k_cur < k_end is always false.
- In ptdump, address comparison for markers display fails and the
marker's name is printed at the start of the KASAN area instead of
being printed at the end.

However, there is no need to shadow the KASAN shadow area itself,
so the KASAN shadow area can stop shadowing memory at the start
of itself.

With a PAGE_OFFSET set to 0xc0000000, KASAN shadow area is then going
from 0xf8000000 to 0xff000000.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: cbd18991e24f ("powerpc/mm: Fix an Oops in kasan_mmu_init()")
Cc: stable@vger.kernel.org
---
 arch/powerpc/include/asm/kasan.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index fbff9ff9032e..fc900937f653 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -23,9 +23,7 @@
 
 #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
 
-#define KASAN_SHADOW_END	0UL
-
-#define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
+#define KASAN_SHADOW_END	(-(-KASAN_SHADOW_START >> KASAN_SHADOW_SCALE_SHIFT))
 
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
-- 
2.25.0

