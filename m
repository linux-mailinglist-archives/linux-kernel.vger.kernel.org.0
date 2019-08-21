Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2697F18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfHUPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 11:39:37 -0400
Received: from foss.arm.com ([217.140.110.172]:60692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfHUPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:39:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA15337;
        Wed, 21 Aug 2019 08:39:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EBA83F718;
        Wed, 21 Aug 2019 08:39:35 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        mark.rutland@arm.com, will.deacon@arm.com
Subject: [PATCHv3] lib/test_kasan: add roundtrip tests
Date:   Wed, 21 Aug 2019 16:39:27 +0100
Message-Id: <20190821153927.28630-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several places we need to be able to operate on pointers which have
gone via a roundtrip:

	virt -> {phys,page} -> virt

With KASAN_SW_TAGS, we can't preserve the tag for SLUB objects, and the
{phys,page} -> virt conversion will use KASAN_TAG_KERNEL.

This patch adds tests to ensure that this works as expected, without
false positives which have recently been spotted [1,2] in testing.

[1] https://lore.kernel.org/linux-arm-kernel/20190819114420.2535-1-walter-zh.wu@mediatek.com/
[2] https://lore.kernel.org/linux-arm-kernel/20190819132347.GB9927@lakrids.cambridge.arm.com/

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 lib/test_kasan.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

Since v1:
* Spin as a separate patch
* Fix typo
* Note examples in commit message
Since v2:
* Fold Andrey Ryabinin's ack
* Include <asm/io.h> for virt_to_phys() and phys_to_virt()

Mark.

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index b63b367a94e8..91a2ec4b87f9 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -19,6 +19,9 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+#include <asm/io.h>
+#include <asm/page.h>
+
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
@@ -337,6 +340,42 @@ static noinline void __init kmalloc_uaf2(void)
 	kfree(ptr2);
 }
 
+static noinline void __init kfree_via_page(void)
+{
+	char *ptr;
+	size_t size = 8;
+	struct page *page;
+	unsigned long offset;
+
+	pr_info("invalid-free false positive (via page)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	page = virt_to_page(ptr);
+	offset = offset_in_page(ptr);
+	kfree(page_address(page) + offset);
+}
+
+static noinline void __init kfree_via_phys(void)
+{
+	char *ptr;
+	size_t size = 8;
+	phys_addr_t phys;
+
+	pr_info("invalid-free false positive (via phys)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	phys = virt_to_phys(ptr);
+	kfree(phys_to_virt(phys));
+}
+
 static noinline void __init kmem_cache_oob(void)
 {
 	char *p;
@@ -737,6 +776,8 @@ static int __init kmalloc_tests_init(void)
 	kmalloc_uaf();
 	kmalloc_uaf_memset();
 	kmalloc_uaf2();
+	kfree_via_page();
+	kfree_via_phys();
 	kmem_cache_oob();
 	memcg_accounted_kmem_cache();
 	kasan_stack_oob();
-- 
2.11.0

