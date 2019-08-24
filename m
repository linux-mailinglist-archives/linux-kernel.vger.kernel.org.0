Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F929BDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfHXNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 09:12:54 -0400
Received: from foss.arm.com ([217.140.110.172]:44298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfHXNMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 09:12:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6994D28;
        Sat, 24 Aug 2019 06:12:53 -0700 (PDT)
Received: from why.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505413F246;
        Sat, 24 Aug 2019 06:12:52 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] kallsyms: Don't let kallsyms_lookup_size_offset() fail on retrieving the first symbol
Date:   Sat, 24 Aug 2019 14:12:31 +0100
Message-Id: <20190824131231.26399-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An arm64 kernel configured with

  CONFIG_KPROBES=y
  CONFIG_KALLSYMS=y
  # CONFIG_KALLSYMS_ALL is not set
  CONFIG_KALLSYMS_BASE_RELATIVE=y

reports the following kprobe failure:

  [    0.032677] kprobes: failed to populate blacklist: -22
  [    0.033376] Please take care of using kprobes.

It appears that kprobe fails to retrieve the symbol at address
0xffff000010081000, despite this symbol being in System.map:

  ffff000010081000 T __exception_text_start

This symbol is part of the first group of aliases in the
kallsyms_offsets array (symbol names generated using ugly hacks in
scripts/kallsyms.c):

  kallsyms_offsets:
          .long   0x1000 // do_undefinstr
          .long   0x1000 // efi_header_end
          .long   0x1000 // _stext
          .long   0x1000 // __exception_text_start
          .long   0x12b0 // do_cp15instr

Looking at the implementation of get_symbol_pos(), it returns the
lowest index for aliasing symbols. In this case, it return 0.

But kallsyms_lookup_size_offset() considers 0 as a failure, which
is obviously wrong (there is definitely a valid symbol living there).
In turn, the kprobe blacklisting stops abruptly, hence the original
error.

A CONFIG_KALLSYMS_ALL kernel wouldn't fail as there is always
some random symbols at the beginning of this array, which are never
looked up via kallsyms_lookup_size_offset.

Fix it by considering that get_symbol_pos() is always successful
(which is consistent with the other uses of this function).

Fixes: ffc5089196446 ("[PATCH] Create kallsyms_lookup_size_offset()")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/kallsyms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 95a260f9214b..136ce049c4ad 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -263,8 +263,10 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 {
 	char namebuf[KSYM_NAME_LEN];
 
-	if (is_ksym_addr(addr))
-		return !!get_symbol_pos(addr, symbolsize, offset);
+	if (is_ksym_addr(addr)) {
+		get_symbol_pos(addr, symbolsize, offset);
+		return 1;
+	}
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
-- 
2.20.1

