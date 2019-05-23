Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DF27A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfEWKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:24:29 -0400
Received: from foss.arm.com ([217.140.101.70]:42632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA97AA78;
        Thu, 23 May 2019 03:24:28 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4DE43F718;
        Thu, 23 May 2019 03:24:26 -0700 (PDT)
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
Subject: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
Date:   Thu, 23 May 2019 11:22:52 +0100
Message-Id: <20190523102256.29168-1-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the code introduced in v5.2 to manage the permissions
of executable vmalloc regions (and their linear aliases) more
strictly.

One of the things that came up in the internal discussion is
whether non-x86 architectures have any benefit at all from the
lazy vunmap feature, and whether it would perhaps be better to
implement eager vunmap instead.

Cc: Nadav Amit <namit@vmware.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: James Morse <james.morse@arm.com>

Ard Biesheuvel (4):
  arm64: module: create module allocations without exec permissions
  arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
  arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
  arm64: bpf: do not allocate executable memory

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cacheflush.h |  3 ++
 arch/arm64/kernel/module.c          |  4 +-
 arch/arm64/kernel/probes/kprobes.c  |  4 +-
 arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
 arch/arm64/net/bpf_jit_comp.c       |  2 +-
 mm/vmalloc.c                        | 11 -----
 7 files changed, 50 insertions(+), 23 deletions(-)

-- 
2.17.1

