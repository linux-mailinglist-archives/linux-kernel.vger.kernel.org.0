Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4211518A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 14:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLFNyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 08:54:54 -0500
Received: from foss.arm.com ([217.140.110.172]:45118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfLFNyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C797139F;
        Fri,  6 Dec 2019 05:54:52 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0F983F718;
        Fri,  6 Dec 2019 05:54:49 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v16 24/25] arm64: mm: Display non-present entries in ptdump
Date:   Fri,  6 Dec 2019 13:53:15 +0000
Message-Id: <20191206135316.47703-25-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206135316.47703-1-steven.price@arm.com>
References: <20191206135316.47703-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the /sys/kernel/debug/kernel_page_tables file would only show
lines for entries present in the page tables. However it is useful to
also show non-present entries as this makes the size and level of the
holes more visible. This aligns the behaviour with x86 which also shows
holes.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/mm/dump.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 9d9b740a86d2..3203dd8e6d0a 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -269,21 +269,22 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		if (st->current_prot) {
 			note_prot_uxn(st, addr);
 			note_prot_wx(st, addr);
-			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
+		}
+
+		pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
 				   st->start_address, addr);
 
-			delta = (addr - st->start_address) >> 10;
-			while (!(delta & 1023) && unit[1]) {
-				delta >>= 10;
-				unit++;
-			}
-			pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-				   pg_level[st->level].name);
-			if (pg_level[st->level].bits)
-				dump_prot(st, pg_level[st->level].bits,
-					  pg_level[st->level].num);
-			pt_dump_seq_puts(st->seq, "\n");
+		delta = (addr - st->start_address) >> 10;
+		while (!(delta & 1023) && unit[1]) {
+			delta >>= 10;
+			unit++;
 		}
+		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
+				   pg_level[st->level].name);
+		if (st->current_prot && pg_level[st->level].bits)
+			dump_prot(st, pg_level[st->level].bits,
+				  pg_level[st->level].num);
+		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
 			st->marker++;
-- 
2.20.1

