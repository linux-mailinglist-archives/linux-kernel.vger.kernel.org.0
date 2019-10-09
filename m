Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05EFD0988
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJIIVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 04:21:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJIIVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:21:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9185E337;
        Wed,  9 Oct 2019 01:21:48 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.43.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DABB13F68E;
        Wed,  9 Oct 2019 01:21:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com
Subject: [PATCH V9 1/2] arm64/mm: Hold memory hotplug lock while walking for kernel page table dump
Date:   Wed,  9 Oct 2019 13:51:47 +0530
Message-Id: <1570609308-15697-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
References: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 page table dump code can race with concurrent modification of the
kernel page tables. When a leaf entries are modified concurrently, the dump
code may log stale or inconsistent information for a VA range, but this is
otherwise not harmful.

When intermediate levels of table are freed, the dump code will continue to
use memory which has been freed and potentially reallocated for another
purpose. In such cases, the dump code may dereference bogus addresses,
leading to a number of potential problems.

Intermediate levels of table may by freed during memory hot-remove,
which will be enabled by a subsequent patch. To avoid racing with
this, take the memory hotplug lock when walking the kernel page table.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/ptdump_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 064163f25592..b5eebc8c4924 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptdump.h>
@@ -7,7 +8,10 @@
 static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct ptdump_info *info = m->private;
+
+	get_online_mems();
 	ptdump_walk_pgd(m, info);
+	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
-- 
2.20.1

