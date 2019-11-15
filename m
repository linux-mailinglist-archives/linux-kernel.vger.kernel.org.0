Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD3FDCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 12:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKOL6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 06:58:22 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:49613 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfKOL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:58:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id EBABD3F703;
        Fri, 15 Nov 2019 12:58:18 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=EaF1pA0X;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qVsn6bKa468W; Fri, 15 Nov 2019 12:58:18 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E4D233F59D;
        Fri, 15 Nov 2019 12:58:16 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2637A3601D5;
        Fri, 15 Nov 2019 12:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1573819096; bh=biXbplT4Ss3tnjsfc08aEbyfLDVtox+O3ydwXnrP4Q8=;
        h=From:To:Cc:Subject:Date:From;
        b=EaF1pA0X3T5TLQmZ/lCJ10YK8/EoyB9GzPMO74bzPXrqr3mnMZUbxpjiJgVPOECWG
         2Gt3jXbm/Zi8IXeH1cObF5Ft3Rri/Xnn4PbWpbX1gWSvnw4wvXQLs4iDhPGOCHMKMW
         +b+n/NfbK0jrL3sm7xpv5+G2D85RH2arwV1tWeFw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: [PATCH 1/2] mm: Move the backup x_devmap() functions to asm-generic/pgtable.h
Date:   Fri, 15 Nov 2019 12:58:07 +0100
Message-Id: <20191115115808.21181-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The asm-generic/pgtable.h include file appears to be the correct place
for the backup x_devmap() inline functions. Moving them here is also
necessary if we want to include x_devmap() in the [pmd|pud]_unstable
functions. So move the x_devmap() functions to asm-generic/pgtable.h

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Matthew Wilcox" <willy@infradead.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/asm-generic/pgtable.h | 15 +++++++++++++++
 include/linux/mm.h            | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 818691846c90..8efa45580fd0 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -903,6 +903,21 @@ static inline int pud_write(pud_t pud)
 }
 #endif /* pud_write */
 
+#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
+static inline int pmd_devmap(pmd_t pmd)
+{
+	return 0;
+}
+static inline int pud_devmap(pud_t pud)
+{
+	return 0;
+}
+static inline int pgd_devmap(pgd_t pgd)
+{
+	return 0;
+}
+#endif
+
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
 	(defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
 	 !defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4bc93477375e..78a09ff33cd7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -564,21 +564,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
-#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || !defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static inline int pmd_devmap(pmd_t pmd)
-{
-	return 0;
-}
-static inline int pud_devmap(pud_t pud)
-{
-	return 0;
-}
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 /*
  * FIXME: take this include out, include page-flags.h in
  * files which need it (119 of them)
-- 
2.21.0

