Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD85719164A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgCXQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:26:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbgCXQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qIMWWQxcrMWzB33HEWsXx7X1zLiHCX65+Voa6N/CTeQ=; b=ahvYmZY7eKCvuIr6FrSo4uN1L9
        +zswzeDbzJIpnBtNKaD9FguQqdGgiBgO7iS/oO8kT3pJLDiPZSCPim+J9ARkqQQ5vtK5rigfVQSVK
        9QzQ8EMDniIr9O3C1wEtSKYEwX+tHXy3gAugW/aZoOHWoDLNVS0t36Vl0YY38D1f+4XF63RubaimR
        zInaEA3FMG3d4t7ML92gmswX1SBpg8mpO/p4bgISmNfE+Rz0f+F9HlPOe6MJmxnTv3tPAeE1gchIU
        2Lg5TvS81ExU1/1IwVGx4J0ROkOhsvw9Kbqoz2qQjNmtu91DxlxAxF2R1cDDpoAtANajg5GDe1UcY
        0piSaW2Q==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmO4-0007cq-H5; Tue, 24 Mar 2020 16:26:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] sh: move ioremap_fixed details out of <asm/io.h>
Date:   Tue, 24 Mar 2020 17:26:27 +0100
Message-Id: <20200324162633.754714-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
References: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap_fixed is an internal implementation detail and should not be
exposed to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h   | 16 ----------------
 arch/sh/mm/init.c          |  1 +
 arch/sh/mm/ioremap.c       |  1 +
 arch/sh/mm/ioremap.h       | 23 +++++++++++++++++++++++
 arch/sh/mm/ioremap_fixed.c |  1 +
 5 files changed, 26 insertions(+), 16 deletions(-)
 create mode 100644 arch/sh/mm/ioremap.h

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 5154c6b8c618..59d53b06d461 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -350,22 +350,6 @@ ioremap_prot(phys_addr_t offset, unsigned long size, unsigned long flags)
 }
 #endif
 
-#ifdef CONFIG_IOREMAP_FIXED
-extern void __iomem *ioremap_fixed(phys_addr_t, unsigned long, pgprot_t);
-extern int iounmap_fixed(void __iomem *);
-extern void ioremap_fixed_init(void);
-#else
-static inline void __iomem *
-ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
-{
-	BUG();
-	return NULL;
-}
-
-static inline void ioremap_fixed_init(void) { }
-static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
-#endif
-
 #define ioremap_uc	ioremap
 
 /*
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index d1b1ff2be17a..cf40b1ad4422 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/cache.h>
 #include <linux/sizes.h>
+#include "ioremap.h"
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index f6d02246d665..d9ec85b6bb21 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
+#include "ioremap.h"
 
 /*
  * Remap an arbitrary physical address space into the kernel virtual
diff --git a/arch/sh/mm/ioremap.h b/arch/sh/mm/ioremap.h
new file mode 100644
index 000000000000..f2544e721a35
--- /dev/null
+++ b/arch/sh/mm/ioremap.h
@@ -0,0 +1,23 @@
+#ifndef _SH_MM_IORMEMAP_H
+#define _SH_MM_IORMEMAP_H 1
+
+#ifdef CONFIG_IOREMAP_FIXED
+void __iomem *ioremap_fixed(phys_addr_t, unsigned long, pgprot_t);
+int iounmap_fixed(void __iomem *);
+void ioremap_fixed_init(void);
+#else
+static inline void __iomem *
+ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
+{
+	BUG();
+	return NULL;
+}
+static inline void ioremap_fixed_init(void)
+{
+}
+static inline int iounmap_fixed(void __iomem *addr)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_IOREMAP_FIXED */
+#endif /* _SH_MM_IORMEMAP_H */
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
index 07e744d75fa0..1914b79d1c53 100644
--- a/arch/sh/mm/ioremap_fixed.c
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
+#include "ioremap.h"
 
 struct ioremap_map {
 	void __iomem *addr;
-- 
2.25.1

