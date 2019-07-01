Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3591122B12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 07:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfETFSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 01:18:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETFSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:18:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E096C15AB;
        Sun, 19 May 2019 22:18:50 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0887E3F5AF;
        Sun, 19 May 2019 22:18:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        james.morse@arm.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com
Subject: [PATCH V4 3/4] arm64/mm: Hold memory hotplug lock while walking for kernel page table dump
Date:   Mon, 20 May 2019 10:48:35 +0530
Message-Id: <1558329516-10445-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
References: <1558329516-10445-1-git-send-email-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/ptdump_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 064163f..80171d1 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -7,7 +7,10 @@
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
2.7.4

