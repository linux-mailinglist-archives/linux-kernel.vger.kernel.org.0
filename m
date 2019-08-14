Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3BC8D33F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfHNMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 08:36:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53457 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfHNMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:36:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467pwS4ckmz9v0dH;
        Wed, 14 Aug 2019 14:36:08 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dh8izLOP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wBCHr_sXx0qq; Wed, 14 Aug 2019 14:36:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467pwS3CNQz9v0QX;
        Wed, 14 Aug 2019 14:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565786168; bh=MWqbG02vkZmNYQgLQGkfZFOAvx7JkFoLhh24LWW8kCI=;
        h=From:Subject:To:Cc:Date:From;
        b=dh8izLOPZYR8ldqOQVPvsQ6hvHulPJd60EPpHHy6fzWjMHpNgxZWDv8uBAdGXzt70
         CQSZGUMgAwoGrYE5np0E2jQDNiRvxkf2Ke3EPDvxnpZp+Fd59EC0PSIAW+N70Ntqje
         IZAD04osr73vdQW0DGq2grwKvhmn2CxMzNNpNIaA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EBA778B7F5;
        Wed, 14 Aug 2019 14:36:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i4GER-nDqlfb; Wed, 14 Aug 2019 14:36:09 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C63568B761;
        Wed, 14 Aug 2019 14:36:09 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 905886B6C0; Wed, 14 Aug 2019 12:36:09 +0000 (UTC)
Message-Id: <eb4d626514e22f85814830012642329018ef6af9.1565786091.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/5] powerpc/ptdump: fix addresses display on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 14 Aug 2019 12:36:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
wrongly changed KERN_VIRT_START from 0 to PAGE_OFFSET, leading to a
shift in the displayed addresses.

Lets revert that change to resync walk_pagetables()'s addr val and
pgd_t pointer for PPC32.

Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ptdump/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 6a88a9f585d4..3ad64fc11419 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -27,7 +27,7 @@
 #include "ptdump.h"
 
 #ifdef CONFIG_PPC32
-#define KERN_VIRT_START	PAGE_OFFSET
+#define KERN_VIRT_START	0
 #endif
 
 /*
-- 
2.13.3

