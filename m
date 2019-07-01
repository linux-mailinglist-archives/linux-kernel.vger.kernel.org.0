Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DBF4EDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFURjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:39:34 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468802083B;
        Fri, 21 Jun 2019 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138772;
        bh=IicUlTp7j3qaf+9rB3N/J6u3WKwIDsCmIrPHt00XId0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYjBvPBf7q95uEfMSW3gueHcdP+Nk8W8zN8u4KjG8L2D8HMF0PfOhERJo4mq18cas
         xYHU20EuzNBAw1BzWmM+ng+aA3crZBAUdxvFMr7VfAsldsPXkX1daU/fFB9xQGsKtU
         HN3aG+Wl2Po3NanG8ix5Pj744voQU2dpDwEYlgzE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 04/25] perf intel-pt: Add Intel PT packet decoder test
Date:   Fri, 21 Jun 2019 14:38:10 -0300
Message-Id: <20190621173831.13780-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add Intel PT packet decoder test. This test feeds byte sequences to the
Intel PT packet decoder and checks the results. Changes to the packet
context are also checked.

Committer testing:

  # perf test "Intel PT"
  65: Intel PT packet decoder                               : Ok
  # perf test -v "Intel PT"
  65: Intel PT packet decoder                               :
  --- start ---
  test child forked, pid 6360
  Decoded ok: 00                                                PAD
  Decoded ok: 04                                                TNT N (1)
  Decoded ok: 06                                                TNT T (1)
  Decoded ok: 80                                                TNT NNNNNN (6)
  Decoded ok: fe                                                TNT TTTTTT (6)
  Decoded ok: 02 a3 02 00 00 00 00 00                           TNT N (1)
  Decoded ok: 02 a3 03 00 00 00 00 00                           TNT T (1)
  Decoded ok: 02 a3 00 00 00 00 00 80                           TNT NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN (47)
  Decoded ok: 02 a3 ff ff ff ff ff ff                           TNT TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT (47)
  Decoded ok: 0d                                                TIP no ip
  Decoded ok: 2d 01 02                                          TIP 0x201
  Decoded ok: 4d 01 02 03 04                                    TIP 0x4030201
  Decoded ok: 6d 01 02 03 04 05 06                              TIP 0x60504030201
  Decoded ok: 8d 01 02 03 04 05 06                              TIP 0x60504030201
  Decoded ok: cd 01 02 03 04 05 06 07 08                        TIP 0x807060504030201
  Decoded ok: 11                                                TIP.PGE no ip
  Decoded ok: 31 01 02                                          TIP.PGE 0x201
  Decoded ok: 51 01 02 03 04                                    TIP.PGE 0x4030201
  Decoded ok: 71 01 02 03 04 05 06                              TIP.PGE 0x60504030201
  Decoded ok: 91 01 02 03 04 05 06                              TIP.PGE 0x60504030201
  Decoded ok: d1 01 02 03 04 05 06 07 08                        TIP.PGE 0x807060504030201
  Decoded ok: 01                                                TIP.PGD no ip
  Decoded ok: 21 01 02                                          TIP.PGD 0x201
  Decoded ok: 41 01 02 03 04                                    TIP.PGD 0x4030201
  Decoded ok: 61 01 02 03 04 05 06                              TIP.PGD 0x60504030201
  Decoded ok: 81 01 02 03 04 05 06                              TIP.PGD 0x60504030201
  Decoded ok: c1 01 02 03 04 05 06 07 08                        TIP.PGD 0x807060504030201
  Decoded ok: 1d                                                FUP no ip
  Decoded ok: 3d 01 02                                          FUP 0x201
  Decoded ok: 5d 01 02 03 04                                    FUP 0x4030201
  Decoded ok: 7d 01 02 03 04 05 06                              FUP 0x60504030201
  Decoded ok: 9d 01 02 03 04 05 06                              FUP 0x60504030201
  Decoded ok: dd 01 02 03 04 05 06 07 08                        FUP 0x807060504030201
  Decoded ok: 02 43 02 04 06 08 0a 0c                           PIP 0x60504030201 (NR=0)
  Decoded ok: 02 43 03 04 06 08 0a 0c                           PIP 0x60504030201 (NR=1)
  Decoded ok: 99 00                                             MODE.Exec 16
  Decoded ok: 99 01                                             MODE.Exec 64
  Decoded ok: 99 02                                             MODE.Exec 32
  Decoded ok: 99 20                                             MODE.TSX TXAbort:0 InTX:0
  Decoded ok: 99 21                                             MODE.TSX TXAbort:0 InTX:1
  Decoded ok: 99 22                                             MODE.TSX TXAbort:1 InTX:0
  Decoded ok: 02 83                                             TraceSTOP
  Decoded ok: 02 03 12 00                                       CBR 0x12
  Decoded ok: 19 01 02 03 04 05 06 07                           TSC 0x7060504030201
  Decoded ok: 59 12                                             MTC 0x12
  Decoded ok: 02 73 00 00 00 00 00                              TMA CTC 0x0 FC 0x0
  Decoded ok: 02 73 01 02 00 00 00                              TMA CTC 0x201 FC 0x0
  Decoded ok: 02 73 00 00 00 ff 01                              TMA CTC 0x0 FC 0x1ff
  Decoded ok: 02 73 80 c0 00 ff 01                              TMA CTC 0xc080 FC 0x1ff
  Decoded ok: 03                                                CYC 0x0
  Decoded ok: 0b                                                CYC 0x1
  Decoded ok: fb                                                CYC 0x1f
  Decoded ok: 07 02                                             CYC 0x20
  Decoded ok: ff fe                                             CYC 0xfff
  Decoded ok: 07 01 02                                          CYC 0x1000
  Decoded ok: ff ff fe                                          CYC 0x7ffff
  Decoded ok: 07 01 01 02                                       CYC 0x80000
  Decoded ok: ff ff ff fe                                       CYC 0x3ffffff
  Decoded ok: 07 01 01 01 02                                    CYC 0x4000000
  Decoded ok: ff ff ff ff fe                                    CYC 0x1ffffffff
  Decoded ok: 07 01 01 01 01 02                                 CYC 0x200000000
  Decoded ok: ff ff ff ff ff fe                                 CYC 0xffffffffff
  Decoded ok: 07 01 01 01 01 01 02                              CYC 0x10000000000
  Decoded ok: ff ff ff ff ff ff fe                              CYC 0x7fffffffffff
  Decoded ok: 07 01 01 01 01 01 01 02                           CYC 0x800000000000
  Decoded ok: ff ff ff ff ff ff ff fe                           CYC 0x3fffffffffffff
  Decoded ok: 07 01 01 01 01 01 01 01 02                        CYC 0x40000000000000
  Decoded ok: ff ff ff ff ff ff ff ff fe                        CYC 0x1fffffffffffffff
  Decoded ok: 07 01 01 01 01 01 01 01 01 02                     CYC 0x2000000000000000
  Decoded ok: ff ff ff ff ff ff ff ff ff 0e                     CYC 0xffffffffffffffff
  Decoded ok: 02 c8 01 02 03 04 05                              VMCS 0x504030201
  Decoded ok: 02 f3                                             OVF
  Decoded ok: 02 f3                                             OVF
  Decoded ok: 02 f3                                             OVF
  Decoded ok: 02 82 02 82 02 82 02 82 02 82 02 82 02 82 02 82   PSB
  Decoded ok: 02 82 02 82 02 82 02 82 02 82 02 82 02 82 02 82   PSB
  Decoded ok: 02 82 02 82 02 82 02 82 02 82 02 82 02 82 02 82   PSB
  Decoded ok: 02 23                                             PSBEND
  Decoded ok: 02 c3 88 01 02 03 04 05 06 07 00                  MNT 0x7060504030201
  Decoded ok: 02 12 01 02 03 04                                 PTWRITE 0x4030201 IP:0
  Decoded ok: 02 32 01 02 03 04 05 06 07 08                     PTWRITE 0x807060504030201 IP:0
  Decoded ok: 02 92 01 02 03 04                                 PTWRITE 0x4030201 IP:1
  Decoded ok: 02 b2 01 02 03 04 05 06 07 08                     PTWRITE 0x807060504030201 IP:1
  Decoded ok: 02 62                                             EXSTOP IP:0
  Decoded ok: 02 e2                                             EXSTOP IP:1
  Decoded ok: 02 c2 00 00 00 00 00 00 00 00                     MWAIT 0x0 Hints 0x0 Extensions 0x0
  Decoded ok: 02 c2 01 02 03 04 05 06 07 08                     MWAIT 0x807060504030201 Hints 0x1 Extensions 0x1
  Decoded ok: 02 c2 ff 02 03 04 07 06 07 08                     MWAIT 0x8070607040302ff Hints 0xff Extensions 0x3
  Decoded ok: 02 22 00 00                                       PWRE 0x0 HW:0 CState:0 Sub-CState:0
  Decoded ok: 02 22 01 02                                       PWRE 0x201 HW:0 CState:0 Sub-CState:2
  Decoded ok: 02 22 80 34                                       PWRE 0x3480 HW:1 CState:3 Sub-CState:4
  Decoded ok: 02 22 00 56                                       PWRE 0x5600 HW:0 CState:5 Sub-CState:6
  Decoded ok: 02 a2 00 00 00 00 00                              PWRX 0x0 Last CState:0 Deepest CState:0 Wake Reason 0x0
  Decoded ok: 02 a2 01 02 03 04 05                              PWRX 0x504030201 Last CState:0 Deepest CState:1 Wake Reason 0x2
  Decoded ok: 02 a2 ff ff ff ff ff                              PWRX 0xffffffffff Last CState:15 Deepest CState:15 Wake Reason 0xf
  Decoded ok: 02 63 00                                          BBP SZ 8-byte Type 0x0
  Decoded ok: 02 63 80                                          BBP SZ 4-byte Type 0x0
  Decoded ok: 02 63 1f                                          BBP SZ 8-byte Type 0x1f
  Decoded ok: 02 63 9f                                          BBP SZ 4-byte Type 0x1f
  Decoded ok: 04 00 00 00 00                                    BIP ID 0x00 Value 0x0
  Decoded ok: fc 00 00 00 00                                    BIP ID 0x1f Value 0x0
  Decoded ok: 04 01 02 03 04                                    BIP ID 0x00 Value 0x4030201
  Decoded ok: fc 01 02 03 04                                    BIP ID 0x1f Value 0x4030201
  Decoded ok: 04 00 00 00 00 00 00 00 00                        BIP ID 0x00 Value 0x0
  Decoded ok: fc 00 00 00 00 00 00 00 00                        BIP ID 0x1f Value 0x0
  Decoded ok: 04 01 02 03 04 05 06 07 08                        BIP ID 0x00 Value 0x807060504030201
  Decoded ok: fc 01 02 03 04 05 06 07 08                        BIP ID 0x1f Value 0x807060504030201
  Decoded ok: 02 33                                             BEP IP:0
  Decoded ok: 02 b3                                             BEP IP:1
  Decoded ok: 02 33                                             BEP IP:0
  Decoded ok: 02 b3                                             BEP IP:1
  test child finished with 0
  ---- end ----
  Intel PT packet decoder: Ok
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/include/arch-tests.h      |   1 +
 tools/perf/arch/x86/tests/Build               |   2 +-
 tools/perf/arch/x86/tests/arch-tests.c        |   4 +
 .../x86/tests/intel-pt-pkt-decoder-test.c     | 304 ++++++++++++++++++
 4 files changed, 310 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 613709cfbbd0..c41c5affe4be 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -9,6 +9,7 @@ struct test;
 int test__rdpmc(struct test *test __maybe_unused, int subtest);
 int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
+int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 3d83d0c6982d..2997c506550c 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -4,5 +4,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 perf-y += arch-tests.o
 perf-y += rdpmc.o
 perf-y += perf-time-to-tsc.o
-perf-$(CONFIG_AUXTRACE) += insn-x86.o
+perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index d47d3f8e3c8e..6763135aec17 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -23,6 +23,10 @@ struct test arch_tests[] = {
 		.desc = "x86 instruction decoder - new instructions",
 		.func = test__insn_x86,
 	},
+	{
+		.desc = "Intel PT packet decoder",
+		.func = test__intel_pt_pkt_decoder,
+	},
 #endif
 #if defined(__x86_64__)
 	{
diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
new file mode 100644
index 000000000000..901bf1f449c4
--- /dev/null
+++ b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+
+#include "intel-pt-decoder/intel-pt-pkt-decoder.h"
+
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+/**
+ * struct test_data - Test data.
+ * @len: number of bytes to decode
+ * @bytes: bytes to decode
+ * @ctx: packet context to decode
+ * @packet: expected packet
+ * @new_ctx: expected new packet context
+ * @ctx_unchanged: the packet context must not change
+ */
+struct test_data {
+	int len;
+	u8 bytes[INTEL_PT_PKT_MAX_SZ];
+	enum intel_pt_pkt_ctx ctx;
+	struct intel_pt_pkt packet;
+	enum intel_pt_pkt_ctx new_ctx;
+	int ctx_unchanged;
+} data[] = {
+	/* Padding Packet */
+	{1, {0}, 0, {INTEL_PT_PAD, 0, 0}, 0, 1 },
+	/* Short Taken/Not Taken Packet */
+	{1, {4}, 0, {INTEL_PT_TNT, 1, 0}, 0, 0 },
+	{1, {6}, 0, {INTEL_PT_TNT, 1, 0x20ULL << 58}, 0, 0 },
+	{1, {0x80}, 0, {INTEL_PT_TNT, 6, 0}, 0, 0 },
+	{1, {0xfe}, 0, {INTEL_PT_TNT, 6, 0x3fULL << 58}, 0, 0 },
+	/* Long Taken/Not Taken Packet */
+	{8, {0x02, 0xa3, 2}, 0, {INTEL_PT_TNT, 1, 0xa302ULL << 47}, 0, 0 },
+	{8, {0x02, 0xa3, 3}, 0, {INTEL_PT_TNT, 1, 0x1a302ULL << 47}, 0, 0 },
+	{8, {0x02, 0xa3, 0, 0, 0, 0, 0, 0x80}, 0, {INTEL_PT_TNT, 47, 0xa302ULL << 1}, 0, 0 },
+	{8, {0x02, 0xa3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, 0, {INTEL_PT_TNT, 47, 0xffffffffffffa302ULL << 1}, 0, 0 },
+	/* Target IP Packet */
+	{1, {0x0d}, 0, {INTEL_PT_TIP, 0, 0}, 0, 0 },
+	{3, {0x2d, 1, 2}, 0, {INTEL_PT_TIP, 1, 0x201}, 0, 0 },
+	{5, {0x4d, 1, 2, 3, 4}, 0, {INTEL_PT_TIP, 2, 0x4030201}, 0, 0 },
+	{7, {0x6d, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_TIP, 3, 0x60504030201}, 0, 0 },
+	{7, {0x8d, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_TIP, 4, 0x60504030201}, 0, 0 },
+	{9, {0xcd, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_TIP, 6, 0x807060504030201}, 0, 0 },
+	/* Packet Generation Enable */
+	{1, {0x11}, 0, {INTEL_PT_TIP_PGE, 0, 0}, 0, 0 },
+	{3, {0x31, 1, 2}, 0, {INTEL_PT_TIP_PGE, 1, 0x201}, 0, 0 },
+	{5, {0x51, 1, 2, 3, 4}, 0, {INTEL_PT_TIP_PGE, 2, 0x4030201}, 0, 0 },
+	{7, {0x71, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_TIP_PGE, 3, 0x60504030201}, 0, 0 },
+	{7, {0x91, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_TIP_PGE, 4, 0x60504030201}, 0, 0 },
+	{9, {0xd1, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_TIP_PGE, 6, 0x807060504030201}, 0, 0 },
+	/* Packet Generation Disable */
+	{1, {0x01}, 0, {INTEL_PT_TIP_PGD, 0, 0}, 0, 0 },
+	{3, {0x21, 1, 2}, 0, {INTEL_PT_TIP_PGD, 1, 0x201}, 0, 0 },
+	{5, {0x41, 1, 2, 3, 4}, 0, {INTEL_PT_TIP_PGD, 2, 0x4030201}, 0, 0 },
+	{7, {0x61, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_TIP_PGD, 3, 0x60504030201}, 0, 0 },
+	{7, {0x81, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_TIP_PGD, 4, 0x60504030201}, 0, 0 },
+	{9, {0xc1, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_TIP_PGD, 6, 0x807060504030201}, 0, 0 },
+	/* Flow Update Packet */
+	{1, {0x1d}, 0, {INTEL_PT_FUP, 0, 0}, 0, 0 },
+	{3, {0x3d, 1, 2}, 0, {INTEL_PT_FUP, 1, 0x201}, 0, 0 },
+	{5, {0x5d, 1, 2, 3, 4}, 0, {INTEL_PT_FUP, 2, 0x4030201}, 0, 0 },
+	{7, {0x7d, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_FUP, 3, 0x60504030201}, 0, 0 },
+	{7, {0x9d, 1, 2, 3, 4, 5, 6}, 0, {INTEL_PT_FUP, 4, 0x60504030201}, 0, 0 },
+	{9, {0xdd, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_FUP, 6, 0x807060504030201}, 0, 0 },
+	/* Paging Information Packet */
+	{8, {0x02, 0x43, 2, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0x60504030201}, 0, 0 },
+	{8, {0x02, 0x43, 3, 4, 6, 8, 10, 12}, 0, {INTEL_PT_PIP, 0, 0x60504030201 | (1ULL << 63)}, 0, 0 },
+	/* Mode Exec Packet */
+	{2, {0x99, 0x00}, 0, {INTEL_PT_MODE_EXEC, 0, 16}, 0, 0 },
+	{2, {0x99, 0x01}, 0, {INTEL_PT_MODE_EXEC, 0, 64}, 0, 0 },
+	{2, {0x99, 0x02}, 0, {INTEL_PT_MODE_EXEC, 0, 32}, 0, 0 },
+	/* Mode TSX Packet */
+	{2, {0x99, 0x20}, 0, {INTEL_PT_MODE_TSX, 0, 0}, 0, 0 },
+	{2, {0x99, 0x21}, 0, {INTEL_PT_MODE_TSX, 0, 1}, 0, 0 },
+	{2, {0x99, 0x22}, 0, {INTEL_PT_MODE_TSX, 0, 2}, 0, 0 },
+	/* Trace Stop Packet */
+	{2, {0x02, 0x83}, 0, {INTEL_PT_TRACESTOP, 0, 0}, 0, 0 },
+	/* Core:Bus Ratio Packet */
+	{4, {0x02, 0x03, 0x12, 0}, 0, {INTEL_PT_CBR, 0, 0x12}, 0, 1 },
+	/* Timestamp Counter Packet */
+	{8, {0x19, 1, 2, 3, 4, 5, 6, 7}, 0, {INTEL_PT_TSC, 0, 0x7060504030201}, 0, 1 },
+	/* Mini Time Counter Packet */
+	{2, {0x59, 0x12}, 0, {INTEL_PT_MTC, 0, 0x12}, 0, 1 },
+	/* TSC / MTC Alignment Packet */
+	{7, {0x02, 0x73}, 0, {INTEL_PT_TMA, 0, 0}, 0, 1 },
+	{7, {0x02, 0x73, 1, 2}, 0, {INTEL_PT_TMA, 0, 0x201}, 0, 1 },
+	{7, {0x02, 0x73, 0, 0, 0, 0xff, 1}, 0, {INTEL_PT_TMA, 0x1ff, 0}, 0, 1 },
+	{7, {0x02, 0x73, 0x80, 0xc0, 0, 0xff, 1}, 0, {INTEL_PT_TMA, 0x1ff, 0xc080}, 0, 1 },
+	/* Cycle Count Packet */
+	{1, {0x03}, 0, {INTEL_PT_CYC, 0, 0}, 0, 1 },
+	{1, {0x0b}, 0, {INTEL_PT_CYC, 0, 1}, 0, 1 },
+	{1, {0xfb}, 0, {INTEL_PT_CYC, 0, 0x1f}, 0, 1 },
+	{2, {0x07, 2}, 0, {INTEL_PT_CYC, 0, 0x20}, 0, 1 },
+	{2, {0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0xfff}, 0, 1 },
+	{3, {0x07, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x1000}, 0, 1 },
+	{3, {0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0x7ffff}, 0, 1 },
+	{4, {0x07, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x80000}, 0, 1 },
+	{4, {0xff, 0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0x3ffffff}, 0, 1 },
+	{5, {0x07, 1, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x4000000}, 0, 1 },
+	{5, {0xff, 0xff, 0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0x1ffffffff}, 0, 1 },
+	{6, {0x07, 1, 1, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x200000000}, 0, 1 },
+	{6, {0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0xffffffffff}, 0, 1 },
+	{7, {0x07, 1, 1, 1, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x10000000000}, 0, 1 },
+	{7, {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0x7fffffffffff}, 0, 1 },
+	{8, {0x07, 1, 1, 1, 1, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x800000000000}, 0, 1 },
+	{8, {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0x3fffffffffffff}, 0, 1 },
+	{9, {0x07, 1, 1, 1, 1, 1, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x40000000000000}, 0, 1 },
+	{9, {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe}, 0, {INTEL_PT_CYC, 0, 0x1fffffffffffffff}, 0, 1 },
+	{10, {0x07, 1, 1, 1, 1, 1, 1, 1, 1, 2}, 0, {INTEL_PT_CYC, 0, 0x2000000000000000}, 0, 1 },
+	{10, {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xe}, 0, {INTEL_PT_CYC, 0, 0xffffffffffffffff}, 0, 1 },
+	/* Virtual-Machine Control Structure Packet */
+	{7, {0x02, 0xc8, 1, 2, 3, 4, 5}, 0, {INTEL_PT_VMCS, 5, 0x504030201}, 0, 0 },
+	/* Overflow Packet */
+	{2, {0x02, 0xf3}, 0, {INTEL_PT_OVF, 0, 0}, 0, 0 },
+	{2, {0x02, 0xf3}, INTEL_PT_BLK_4_CTX, {INTEL_PT_OVF, 0, 0}, 0, 0 },
+	{2, {0x02, 0xf3}, INTEL_PT_BLK_8_CTX, {INTEL_PT_OVF, 0, 0}, 0, 0 },
+	/* Packet Stream Boundary*/
+	{16, {0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82}, 0, {INTEL_PT_PSB, 0, 0}, 0, 0 },
+	{16, {0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82}, INTEL_PT_BLK_4_CTX, {INTEL_PT_PSB, 0, 0}, 0, 0 },
+	{16, {0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82, 0x02, 0x82}, INTEL_PT_BLK_8_CTX, {INTEL_PT_PSB, 0, 0}, 0, 0 },
+	/* PSB End Packet */
+	{2, {0x02, 0x23}, 0, {INTEL_PT_PSBEND, 0, 0}, 0, 0 },
+	/* Maintenance Packet */
+	{11, {0x02, 0xc3, 0x88, 1, 2, 3, 4, 5, 6, 7}, 0, {INTEL_PT_MNT, 0, 0x7060504030201}, 0, 1 },
+	/* Write Data to PT Packet */
+	{6, {0x02, 0x12, 1, 2, 3, 4}, 0, {INTEL_PT_PTWRITE, 0, 0x4030201}, 0, 0 },
+	{10, {0x02, 0x32, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_PTWRITE, 1, 0x807060504030201}, 0, 0 },
+	{6, {0x02, 0x92, 1, 2, 3, 4}, 0, {INTEL_PT_PTWRITE_IP, 0, 0x4030201}, 0, 0 },
+	{10, {0x02, 0xb2, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_PTWRITE_IP, 1, 0x807060504030201}, 0, 0 },
+	/* Execution Stop Packet */
+	{2, {0x02, 0x62}, 0, {INTEL_PT_EXSTOP, 0, 0}, 0, 1 },
+	{2, {0x02, 0xe2}, 0, {INTEL_PT_EXSTOP_IP, 0, 0}, 0, 1 },
+	/* Monitor Wait Packet */
+	{10, {0x02, 0xc2}, 0, {INTEL_PT_MWAIT, 0, 0}, 0, 0 },
+	{10, {0x02, 0xc2, 1, 2, 3, 4, 5, 6, 7, 8}, 0, {INTEL_PT_MWAIT, 0, 0x807060504030201}, 0, 0 },
+	{10, {0x02, 0xc2, 0xff, 2, 3, 4, 7, 6, 7, 8}, 0, {INTEL_PT_MWAIT, 0, 0x8070607040302ff}, 0, 0 },
+	/* Power Entry Packet */
+	{4, {0x02, 0x22}, 0, {INTEL_PT_PWRE, 0, 0}, 0, 1 },
+	{4, {0x02, 0x22, 1, 2}, 0, {INTEL_PT_PWRE, 0, 0x0201}, 0, 1 },
+	{4, {0x02, 0x22, 0x80, 0x34}, 0, {INTEL_PT_PWRE, 0, 0x3480}, 0, 1 },
+	{4, {0x02, 0x22, 0x00, 0x56}, 0, {INTEL_PT_PWRE, 0, 0x5600}, 0, 1 },
+	/* Power Exit Packet */
+	{7, {0x02, 0xa2}, 0, {INTEL_PT_PWRX, 0, 0}, 0, 1 },
+	{7, {0x02, 0xa2, 1, 2, 3, 4, 5}, 0, {INTEL_PT_PWRX, 0, 0x504030201}, 0, 1 },
+	{7, {0x02, 0xa2, 0xff, 0xff, 0xff, 0xff, 0xff}, 0, {INTEL_PT_PWRX, 0, 0xffffffffff}, 0, 1 },
+	/* Block Begin Packet */
+	{3, {0x02, 0x63, 0x00}, 0, {INTEL_PT_BBP, 0, 0}, INTEL_PT_BLK_8_CTX, 0 },
+	{3, {0x02, 0x63, 0x80}, 0, {INTEL_PT_BBP, 1, 0}, INTEL_PT_BLK_4_CTX, 0 },
+	{3, {0x02, 0x63, 0x1f}, 0, {INTEL_PT_BBP, 0, 0x1f}, INTEL_PT_BLK_8_CTX, 0 },
+	{3, {0x02, 0x63, 0x9f}, 0, {INTEL_PT_BBP, 1, 0x1f}, INTEL_PT_BLK_4_CTX, 0 },
+	/* 4-byte Block Item Packet */
+	{5, {0x04}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BIP, 0, 0}, INTEL_PT_BLK_4_CTX, 0 },
+	{5, {0xfc}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BIP, 0x1f, 0}, INTEL_PT_BLK_4_CTX, 0 },
+	{5, {0x04, 1, 2, 3, 4}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BIP, 0, 0x04030201}, INTEL_PT_BLK_4_CTX, 0 },
+	{5, {0xfc, 1, 2, 3, 4}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BIP, 0x1f, 0x04030201}, INTEL_PT_BLK_4_CTX, 0 },
+	/* 8-byte Block Item Packet */
+	{9, {0x04}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BIP, 0, 0}, INTEL_PT_BLK_8_CTX, 0 },
+	{9, {0xfc}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BIP, 0x1f, 0}, INTEL_PT_BLK_8_CTX, 0 },
+	{9, {0x04, 1, 2, 3, 4, 5, 6, 7, 8}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BIP, 0, 0x0807060504030201}, INTEL_PT_BLK_8_CTX, 0 },
+	{9, {0xfc, 1, 2, 3, 4, 5, 6, 7, 8}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BIP, 0x1f, 0x0807060504030201}, INTEL_PT_BLK_8_CTX, 0 },
+	/* Block End Packet */
+	{2, {0x02, 0x33}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BEP, 0, 0}, 0, 0 },
+	{2, {0x02, 0xb3}, INTEL_PT_BLK_4_CTX, {INTEL_PT_BEP_IP, 0, 0}, 0, 0 },
+	{2, {0x02, 0x33}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BEP, 0, 0}, 0, 0 },
+	{2, {0x02, 0xb3}, INTEL_PT_BLK_8_CTX, {INTEL_PT_BEP_IP, 0, 0}, 0, 0 },
+	/* Terminator */
+	{0, {0}, 0, {0, 0, 0}, 0, 0 },
+};
+
+static int dump_packet(struct intel_pt_pkt *packet, u8 *bytes, int len)
+{
+	char desc[INTEL_PT_PKT_DESC_MAX];
+	int ret, i;
+
+	for (i = 0; i < len; i++)
+		pr_debug(" %02x", bytes[i]);
+	for (; i < INTEL_PT_PKT_MAX_SZ; i++)
+		pr_debug("   ");
+	pr_debug("   ");
+	ret = intel_pt_pkt_desc(packet, desc, INTEL_PT_PKT_DESC_MAX);
+	if (ret < 0) {
+		pr_debug("intel_pt_pkt_desc failed!\n");
+		return TEST_FAIL;
+	}
+	pr_debug("%s\n", desc);
+
+	return TEST_OK;
+}
+
+static void decoding_failed(struct test_data *d)
+{
+	pr_debug("Decoding failed!\n");
+	pr_debug("Decoding:  ");
+	dump_packet(&d->packet, d->bytes, d->len);
+}
+
+static int fail(struct test_data *d, struct intel_pt_pkt *packet, int len,
+		enum intel_pt_pkt_ctx new_ctx)
+{
+	decoding_failed(d);
+
+	if (len != d->len)
+		pr_debug("Expected length: %d   Decoded length %d\n",
+			 d->len, len);
+
+	if (packet->type != d->packet.type)
+		pr_debug("Expected type: %d   Decoded type %d\n",
+			 d->packet.type, packet->type);
+
+	if (packet->count != d->packet.count)
+		pr_debug("Expected count: %d   Decoded count %d\n",
+			 d->packet.count, packet->count);
+
+	if (packet->payload != d->packet.payload)
+		pr_debug("Expected payload: 0x%llx   Decoded payload 0x%llx\n",
+			 (unsigned long long)d->packet.payload,
+			 (unsigned long long)packet->payload);
+
+	if (new_ctx != d->new_ctx)
+		pr_debug("Expected packet context: %d   Decoded packet context %d\n",
+			 d->new_ctx, new_ctx);
+
+	return TEST_FAIL;
+}
+
+static int test_ctx_unchanged(struct test_data *d, struct intel_pt_pkt *packet,
+			      enum intel_pt_pkt_ctx ctx)
+{
+	enum intel_pt_pkt_ctx old_ctx = ctx;
+
+	intel_pt_upd_pkt_ctx(packet, &ctx);
+
+	if (ctx != old_ctx) {
+		decoding_failed(d);
+		pr_debug("Packet context changed!\n");
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
+
+static int test_one(struct test_data *d)
+{
+	struct intel_pt_pkt packet;
+	enum intel_pt_pkt_ctx ctx = d->ctx;
+	int ret;
+
+	memset(&packet, 0xff, sizeof(packet));
+
+	/* Decode a packet */
+	ret = intel_pt_get_packet(d->bytes, d->len, &packet, &ctx);
+	if (ret < 0 || ret > INTEL_PT_PKT_MAX_SZ) {
+		decoding_failed(d);
+		pr_debug("intel_pt_get_packet returned %d\n", ret);
+		return TEST_FAIL;
+	}
+
+	/* Some packets must always leave the packet context unchanged */
+	if (d->ctx_unchanged) {
+		int err;
+
+		err = test_ctx_unchanged(d, &packet, INTEL_PT_NO_CTX);
+		if (err)
+			return err;
+		err = test_ctx_unchanged(d, &packet, INTEL_PT_BLK_4_CTX);
+		if (err)
+			return err;
+		err = test_ctx_unchanged(d, &packet, INTEL_PT_BLK_8_CTX);
+		if (err)
+			return err;
+	}
+
+	/* Compare to the expected values */
+	if (ret != d->len || packet.type != d->packet.type ||
+	    packet.count != d->packet.count ||
+	    packet.payload != d->packet.payload || ctx != d->new_ctx)
+		return fail(d, &packet, ret, ctx);
+
+	pr_debug("Decoded ok:");
+	ret = dump_packet(&d->packet, d->bytes, d->len);
+
+	return ret;
+}
+
+/*
+ * This test feeds byte sequences to the Intel PT packet decoder and checks the
+ * results. Changes to the packet context are also checked.
+ */
+int test__intel_pt_pkt_decoder(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct test_data *d = data;
+	int ret;
+
+	for (d = data; d->len; d++) {
+		ret = test_one(d);
+		if (ret)
+			return ret;
+	}
+
+	return TEST_OK;
+}
-- 
2.20.1

