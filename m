Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF5156B4A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 17:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBIQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 11:02:44 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40364 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgBIQCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 11:02:44 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Fv270CRmz9tyMk;
        Sun,  9 Feb 2020 17:02:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=lE+tzqxN; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DHOWXb4BTZrm; Sun,  9 Feb 2020 17:02:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Fv265hf2z9ty3q;
        Sun,  9 Feb 2020 17:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581264158; bh=RXS+cr69C+by33s3QcKFWkRIGV+m2UuuFcW1oKBiMuw=;
        h=From:Subject:To:Cc:Date:From;
        b=lE+tzqxNNiTApdVHV4eMpi9YtmRKJM1SppnPSOPE3Q9iEhAkHvX72B29w13I4+HfE
         KQIjRtshWh0Ha4soBY3gVFnAWBDpyCGQtfu9sLLNkrVcZolkbtNjZYqP+YvCczo4od
         Ht0M8HRaLfW+ZHANhNbuMMTVYJamATIIimcue/VQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13CAE8B771;
        Sun,  9 Feb 2020 17:02:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VGoWebiepzSY; Sun,  9 Feb 2020 17:02:42 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9DF88B755;
        Sun,  9 Feb 2020 17:02:41 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 46A23652AE; Sun,  9 Feb 2020 16:02:41 +0000 (UTC)
Message-Id: <778b1a248c4c7ca79640eeff7740044da6a220a0.1581264115.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/hugetlb: Fix 8M hugepages on 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  9 Feb 2020 16:02:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With HW assistance all page tables must be 4k aligned, the 8xx
drops the last 12 bits during the walk.

Redefine HUGEPD_SHIFT_MASK to mask last 12 bits out.
HUGEPD_SHIFT_MASK is used to for alignment of page table cache.

Fixes: 22569b881d37 ("powerpc/8xx: Enable 8M hugepage support with HW assistance")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: Only do the fix of alignment which is the only vital fix.
---
 arch/powerpc/include/asm/page.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 86332080399a..080a0bf8e54b 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -295,8 +295,13 @@ static inline bool pfn_valid(unsigned long pfn)
 /*
  * Some number of bits at the level of the page table that points to
  * a hugepte are used to encode the size.  This masks those bits.
+ * On 8xx, HW assistance requires 4k alignment for the hugepte.
  */
+#ifdef CONFIG_PPC_8xx
+#define HUGEPD_SHIFT_MASK     0xfff
+#else
 #define HUGEPD_SHIFT_MASK     0x3f
+#endif
 
 #ifndef __ASSEMBLY__
 
-- 
2.25.0

