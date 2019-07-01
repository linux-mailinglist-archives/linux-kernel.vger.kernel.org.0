Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A332DFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE2Oaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 10:30:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:48770 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2Oay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:30:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:30:53 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 May 2019 07:30:53 -0700
Received: from [10.252.23.111] (unknown [10.252.23.111])
        by linux.intel.com (Postfix) with ESMTP id CE132580258;
        Wed, 29 May 2019 07:30:50 -0700 (PDT)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v4] perf record: collect user registers set jointly with dwarf
 stacks
Organization: Intel Corp.
Message-ID: <01a322ee-c99d-0bb7-b7cf-bc1fa8064d75@linux.intel.com>
Date:   Wed, 29 May 2019 17:30:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When dwarf stacks are collected jointly with user specified register
set using --user-regs option like below the full register context is
still captured on a sample:

  $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3

  188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
  ... FP chain: nr:0
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x53b
  .... BX    0x7ffedbdd3cc0
  .... CX    0xffffffff
  .... DX    0x33d3a
  .... SI    0x7f09b74c38d0
  .... DI    0x0
  .... BP    0x401260
  .... SP    0x7ffedbdd3cc0
  .... IP    0x401236
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x7f09b74c3800
  .... R9    0x7f09b74c2da0
  .... R10   0xfffffffffffff3ce
  .... R11   0x246
  .... R12   0x401070
  .... R13   0x7ffedbdd5db0
  .... R14   0x0
  .... R15   0x0
  ... ustack: size 1024, offset 0xe0
   . data_src: 0x5080021
   ... thread: stack_test2.g.O:23828
   ...... dso: /root/abudanko/stacks/stack_test2.g.O3

After applying the change suggested in the patch the sample data contain
only user specified register values. IP and SP registers (dwarf_regs)
are collected anyways regardless of the --user-regs option value provided
from the command line:

  -g call-graph dwarf,K                         full_regs
  -g call-graph dwarf,K --user-regs=user_regs	user_regs + dwarf_regs
  --user-regs=user_regs                         user_regs

  $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- ls
  WARNING: specified --user-regs register set doesn't include registers needed by also specified --call-graph=dwarf, auto adding IP, SP registers.
  arch   COPYING	Documentation  include	Kbuild	 lbuild    MAINTAINERS	modules.builtin		 Module.symvers  perf.data.old	scripts   System.map  virt
  block  CREDITS	drivers        init	Kconfig  lib	   Makefile	modules.builtin.modinfo  net		 README		security  tools       vmlinux
  certs  crypto	fs	       ipc	kernel	 LICENSES  mm		modules.order		 perf.data	 samples	sound	  usr	      vmlinux.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]

  188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
  ... FP chain: nr:0
  ... user regs: mask 0x1c0 ABI 64-bit
  .... BP    0x401260
  .... SP    0x7ffd3d85cc20
  .... IP    0x401236
  ... ustack: size 1024, offset 0x58
   . data_src: 0x5080021

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v4:
- added warning message about dwarf registers unconditionally 
  included into the collected registers set

Changes in v3:
- avoid changes in platform specific header files

Changes in v2:
- implemented dwarf register set to avoid corrupted trace 
  when --user-regs option value omits IP,SP

---
 tools/perf/util/evsel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a6f572a40deb..426dfefeecda 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -669,6 +669,9 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
+#define DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
+			 (1ULL << PERF_REG_SP))
+
 static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 					   struct record_opts *opts,
 					   struct callchain_param *param)
@@ -702,7 +705,13 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			attr->sample_regs_user |= PERF_REGS_MASK;
+			if (opts->sample_user_regs) {
+				attr->sample_regs_user |= DWARF_REGS_MASK;
+				pr_warning("WARNING: specified --user-regs register set doesn't include registers "
+					   "needed by also specified --call-graph=dwarf, auto adding IP, SP registers.\n");
+			} else {
+				attr->sample_regs_user |= PERF_REGS_MASK;
+			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
 		} else {
-- 
2.20.1

