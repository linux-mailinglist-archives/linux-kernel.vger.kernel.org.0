Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2033127A63
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfEWKYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:24:39 -0400
Received: from foss.arm.com ([217.140.101.70]:42706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:24:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7582D15AB;
        Thu, 23 May 2019 03:24:38 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5623A3F718;
        Thu, 23 May 2019 03:24:36 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: bpf: do not allocate executable memory
Date:   Thu, 23 May 2019 11:22:56 +0100
Message-Id: <20190523102256.29168-5-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523102256.29168-1-ard.biesheuvel@arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPF code now takes care of mapping the code pages executable
after mapping them read-only, to ensure that no RWX mapped regions
are needed, even transiently. This means we can drop the executable
permissions from the mapping at allocation time.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index df845cee438e..aef4ff467222 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -981,7 +981,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
 {
 	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
 				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 }
 
-- 
2.17.1

