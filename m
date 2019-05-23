Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A049527A61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfEWKYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:24:37 -0400
Received: from foss.arm.com ([217.140.101.70]:42688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:24:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15B3BA78;
        Thu, 23 May 2019 03:24:36 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8F623F718;
        Thu, 23 May 2019 03:24:33 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 3/4] arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
Date:   Thu, 23 May 2019 11:22:55 +0100
Message-Id: <20190523102256.29168-4-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523102256.29168-1-ard.biesheuvel@arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid transient inconsistencies where freed code pages
are remapped writable while stale TLB entries still exist on other
cores, mark the kprobes text pages with the VM_FLUSH_RESET_PERMS
attribute. This instructs the core vmalloc code not to defer the
TLB flush when this region is unmapped and returned to the page
allocator.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 2509fcb6d404..036cfbf9682a 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -131,8 +131,10 @@ void *alloc_insn_page(void)
 	void *page;
 
 	page = vmalloc_exec(PAGE_SIZE);
-	if (page)
+	if (page) {
 		set_memory_ro((unsigned long)page, 1);
+		set_vm_flush_reset_perms(page);
+	}
 
 	return page;
 }
-- 
2.17.1

