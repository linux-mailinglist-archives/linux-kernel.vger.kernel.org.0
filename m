Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038BF130CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 05:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgAFEhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 23:37:45 -0500
Received: from foss.arm.com ([217.140.110.172]:40368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgAFEhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 23:37:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F72731B;
        Sun,  5 Jan 2020 20:37:44 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F1943F534;
        Sun,  5 Jan 2020 20:37:41 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memblock: Use __func__ in remaining memblock_dbg() call sites
Date:   Mon,  6 Jan 2020 10:08:30 +0530
Message-Id: <1578285510-28261-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open function name strings with %s (__func__) in all remaining
memblock_dbg() call sites.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/memblock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index fc0d4db1d646..eba94ee3de0b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -694,7 +694,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("memblock_add: [%pa-%pa] %pS\n",
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
@@ -795,7 +795,7 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("memblock_remove: [%pa-%pa] %pS\n",
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
 	return memblock_remove_range(&memblock.memory, base, size);
@@ -813,7 +813,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("   memblock_free: [%pa-%pa] %pS\n",
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
 	kmemleak_free_part_phys(base, size);
@@ -824,7 +824,7 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("memblock_reserve: [%pa-%pa] %pS\n",
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
 		     &base, &end, (void *)_RET_IP_);
 
 	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
-- 
2.20.1

