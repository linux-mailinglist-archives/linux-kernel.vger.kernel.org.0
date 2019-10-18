Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E83DBC97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504336AbfJRFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:07:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407377AbfJRFHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:07:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CAF54C605E226D2ACC9E;
        Fri, 18 Oct 2019 11:19:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:22 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Rich Felker" <dalias@libc.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 05/33] sh: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:22 +0800
Message-ID: <20191018031850.48498-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sh/boards/mach-sdk7786/nmi.c    | 2 +-
 arch/sh/drivers/pci/fixups-sdk7786.c | 2 +-
 arch/sh/kernel/io_trapped.c          | 2 +-
 arch/sh/kernel/setup.c               | 2 +-
 arch/sh/mm/consistent.c              | 5 ++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-sdk7786/nmi.c b/arch/sh/boards/mach-sdk7786/nmi.c
index c2e09d798537..afba49679a12 100644
--- a/arch/sh/boards/mach-sdk7786/nmi.c
+++ b/arch/sh/boards/mach-sdk7786/nmi.c
@@ -37,7 +37,7 @@ static int __init nmi_mode_setup(char *str)
 		nmi_mode = NMI_MODE_ANY;
 	else {
 		nmi_mode = NMI_MODE_UNKNOWN;
-		pr_warning("Unknown NMI mode %s\n", str);
+		pr_warn("Unknown NMI mode %s\n", str);
 	}
 
 	printk("Set NMI mode to %d\n", nmi_mode);
diff --git a/arch/sh/drivers/pci/fixups-sdk7786.c b/arch/sh/drivers/pci/fixups-sdk7786.c
index 8cbfa5310a4b..6972af7b4e93 100644
--- a/arch/sh/drivers/pci/fixups-sdk7786.c
+++ b/arch/sh/drivers/pci/fixups-sdk7786.c
@@ -53,7 +53,7 @@ static int __init sdk7786_pci_init(void)
 
 		/* Warn about forced rerouting if slot#3 is occupied */
 		if ((data & PCIECR_PRST3) == 0) {
-			pr_warning("Unreachable card detected in slot#3\n");
+			pr_warn("Unreachable card detected in slot#3\n");
 			return -EBUSY;
 		}
 	} else
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index bacad6da4fe4..60c828a2b8a2 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -99,7 +99,7 @@ int register_trapped_io(struct trapped_io *tiop)
 
 	return 0;
  bad:
-	pr_warning("unable to install trapped io filter\n");
+	pr_warn("unable to install trapped io filter\n");
 	return -1;
 }
 EXPORT_SYMBOL_GPL(register_trapped_io);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 914174a125a4..d232cfa01877 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -355,7 +355,7 @@ void __init setup_arch(char **cmdline_p)
 /* processor boot mode configuration */
 int generic_mode_pins(void)
 {
-	pr_warning("generic_mode_pins(): missing mode pin configuration\n");
+	pr_warn("generic_mode_pins(): missing mode pin configuration\n");
 	return 0;
 }
 
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..3169a343a5ab 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -43,8 +43,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 
 	r = pdev->resource + pdev->num_resources - 1;
 	if (r->flags) {
-		pr_warning("%s: unable to find empty space for resource\n",
-			name);
+		pr_warn("%s: unable to find empty space for resource\n", name);
 		return -EINVAL;
 	}
 
@@ -54,7 +53,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 
 	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
-		pr_warning("%s: unable to allocate memory\n", name);
+		pr_warn("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
 	}
 
-- 
2.20.1

