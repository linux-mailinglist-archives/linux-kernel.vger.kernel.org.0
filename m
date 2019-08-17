Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6336490F99
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfHQJEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 05:04:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12830 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfHQJEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 05:04:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 469Z561HnLz9tyWV;
        Sat, 17 Aug 2019 11:04:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LZQq9LzK; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8u0J3v829NZD; Sat, 17 Aug 2019 11:04:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 469Z5606bJz9tyWT;
        Sat, 17 Aug 2019 11:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566032682; bh=6D6Fw4eHKQRo9SntiTRLQdojFuLMX/qxVXEv1BnUofI=;
        h=From:Subject:To:Cc:Date:From;
        b=LZQq9LzKeP6vMUzRlEQpJFCxS3DoJflQdw0cDeSROz8BPSBjLPfAORKGKv5q4zslK
         rNe1mPHfktUNI/kDqajBCp4KSryl2YLGbGfk9H6IUZqY6ssOKuCbPbTyBXFkKMPqo+
         Us4iATJdQ2RJnPCl5xIyrHQp26AlkvQp3+HhGCdA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B5BA8B793;
        Sat, 17 Aug 2019 11:04:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tS95EnQl6bXB; Sat, 17 Aug 2019 11:04:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 086FC8B790;
        Sat, 17 Aug 2019 11:04:43 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id C5FEF106613; Sat, 17 Aug 2019 09:04:42 +0000 (UTC)
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: optimise WARN_ON()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20190817090442.C5FEF106613@localhost.localdomain>
Date:   Sat, 17 Aug 2019 09:04:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike BUG_ON(x), WARN_ON(x) uses !!(x) as the trigger
of the t(d/w)nei instruction instead of using directly the
value of x.

This leads to GCC adding unnecessary pair of addic/subfe. This was
revealed after adding a WARN_ON() on top of clear_page() in order
to detect misaligned destination:

@@ -49,6 +51,8 @@ static inline void clear_page(void *addr)
 {
 	unsigned int i;

+	WARN_ON((unsigned long)addr & (L1_CACHE_BYTES - 1));
+
 	for (i = 0; i < PAGE_SIZE / L1_CACHE_BYTES; i++, addr += L1_CACHE_BYTES)
 		dcbz(addr);
 }

This resulted on:

0000019c <clear_user_page>:
 19c:	54 68 06 fe 	clrlwi  r8,r3,27
 1a0:	31 48 ff ff 	addic   r10,r8,-1
 1a4:	7d 4a 41 10 	subfe   r10,r10,r8
 1a8:	0f 0a 00 00 	twnei   r10,0
 1ac:	39 20 00 80 	li      r9,128
 1b0:	7d 29 03 a6 	mtctr   r9
 1b4:	7c 00 1f ec 	dcbz    0,r3
 1b8:	38 63 00 20 	addi    r3,r3,32
 1bc:	42 00 ff f8 	bdnz    1b4 <clear_user_page+0x18>
 1c0:	7c a3 2b 78 	mr      r3,r5
 1c4:	48 00 00 00 	b       1c4 <clear_user_page+0x28>
			1c4: R_PPC_REL24	flush_dcache_page

By using (x) instead of !!(x) like BUG_ON() does, the additional
instructions go away:

0000019c <clear_user_page>:
 19c:	54 6a 06 fe 	clrlwi  r10,r3,27
 1a0:	0f 0a 00 00 	twnei   r10,0
 1a4:	39 20 00 80 	li      r9,128
 1a8:	7d 29 03 a6 	mtctr   r9
 1ac:	7c 00 1f ec 	dcbz    0,r3
 1b0:	38 63 00 20 	addi    r3,r3,32
 1b4:	42 00 ff f8 	bdnz    1ac <clear_user_page+0x10>
 1b8:	7c a3 2b 78 	mr      r3,r5
 1bc:	48 00 00 00 	b       1bc <clear_user_page+0x20>
			1bc: R_PPC_REL24	flush_dcache_page

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index fed7e6241349..77074582fe65 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -107,7 +107,7 @@
 		: : "i" (__FILE__), "i" (__LINE__),		\
 		  "i" (BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)),\
 		  "i" (sizeof(struct bug_entry)),		\
-		  "r" (__ret_warn_on));				\
+		  "r" ((__force long)(x)));			\
 	}							\
 	unlikely(__ret_warn_on);				\
 })
-- 
2.17.1

