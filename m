Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24ADAF81E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 10:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfIKIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 04:39:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3075 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbfIKIjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:39:32 -0400
X-UUID: 1da5aa5210c14e98850fc278477b392b-20190911
X-UUID: 1da5aa5210c14e98850fc278477b392b-20190911
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1427945322; Wed, 11 Sep 2019 16:39:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Sep 2019 16:39:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Sep 2019 16:39:23 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3] mm/kasan: dump alloc and free stack for page allocator
Date:   Wed, 11 Sep 2019 16:39:21 +0800
Message-ID: <20190911083921.4158-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is KASAN's report adds the alloc/free stack for page allocator
in order to help programmer to see memory corruption caused by the page.

By default, KASAN doesn't record alloc or free stack for page allocator.
It is difficult to fix up the page use-after-free or double-free issue.

We add the following changing:
1) KASAN enable PAGE_OWNER by default to get the alloc stack of the page.
2) Add new feature option to get the free stack of the page.

The new feature KASAN_DUMP_PAGE depends on DEBUG_PAGEALLOC, it will help
to record free stack of the page, it is very helpful for solving the page
use-after-free or double-free issue.

When KASAN_DUMP_PAGE is enabled then KASAN's report will show the last
alloc and free stack of the page, it should be:

BUG: KASAN: use-after-free in kmalloc_pagealloc_uaf+0x70/0x80
Write of size 1 at addr ffffffc0d60e4000 by task cat/115
...
 prep_new_page+0x1c8/0x218
 get_page_from_freelist+0x1ba0/0x28d0
 __alloc_pages_nodemask+0x1d4/0x1978
 kmalloc_order+0x28/0x58
 kmalloc_order_trace+0x28/0xe0
 kmalloc_pagealloc_uaf+0x2c/0x80
page last free stack trace:
 __free_pages_ok+0x116c/0x1630
 __free_pages+0x50/0x78
 kfree+0x1c4/0x250
 kmalloc_pagealloc_uaf+0x38/0x80

Changes since v1:
- slim page_owner and move it into kasan
- enable the feature by default

Changes since v2:
- enable PAGE_OWNER by default
- use DEBUG_PAGEALLOC to get page information

cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
cc: Vlastimil Babka <vbabka@suse.cz>
cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
---
 lib/Kconfig.kasan | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 4fafba1a923b..4d59458c0c5a 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -41,6 +41,7 @@ config KASAN_GENERIC
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
+	select PAGER_OWNER
 	help
 	  Enables generic KASAN mode.
 	  Supported in both GCC and Clang. With GCC it requires version 4.9.2
@@ -63,6 +64,7 @@ config KASAN_SW_TAGS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
+	select PAGER_OWNER
 	help
 	  Enables software tag-based KASAN mode.
 	  This mode requires Top Byte Ignore support by the CPU and therefore
@@ -135,6 +137,19 @@ config KASAN_S390_4_LEVEL_PAGING
 	  to 3TB of RAM with KASan enabled). This options allows to force
 	  4-level paging instead.
 
+config KASAN_DUMP_PAGE
+	bool "Dump the last allocation and freeing stack of the page"
+	depends on KASAN
+	select DEBUG_PAGEALLOC
+	help
+	  By default, KASAN enable PAGE_OWNER only to record alloc stack
+	  for page allocator. It is difficult to fix up page use-after-free
+	  or double-free issue.
+	  This feature depends on DEBUG_PAGEALLOC, it will extra record
+	  free stack of page. It is very helpful for solving the page
+	  use-after-free or double-free issue.
+	  This option will have a small memory overhead.
+
 config TEST_KASAN
 	tristate "Module for testing KASAN for bug detection"
 	depends on m && KASAN
-- 
2.18.0

