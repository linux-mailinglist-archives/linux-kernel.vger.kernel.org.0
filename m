Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4315510C9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfK1Nlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfK1Nlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:42 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 028E6217BC;
        Thu, 28 Nov 2019 13:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948501;
        bh=rmc2xKUvUR/KxEciLiFSk7ODnJZiMppwUFApp5Jwxa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZSo1JmNXj6o120bbZNZI6aUMqKLOCxU+5tzLomd0h/pErmsgwlaWUBN7l1AJHBYC
         RlBjMiDGoBxPYdnMXl340aPQRohgcUE0/78fks5syc8240BwnQZFCwNNKVjS7LlE9K
         oKtVgsQ3ltzHJaAwHM0qK5GWNIm67uzqG3mbZV3o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/22] perf script: Fix brstackinsn for AUXTRACE
Date:   Thu, 28 Nov 2019 10:40:26 -0300
Message-Id: <20191128134027.23726-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

brstackinsn must be allowed to be set by the user when AUX area data has
been captured because, in that case, the branch stack might be
synthesized on the fly. This fixes the following error:

Before:

  $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
  [ perf record: Woken up 19 times to write data ]
  [ perf record: Captured and wrote 2.274 MB perf.data ]
  $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
  Display of branch stack assembler requested, but non all-branch filter set
  Hint: run 'perf record -b ...'

After:

  $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
  [ perf record: Woken up 19 times to write data ]
  [ perf record: Captured and wrote 2.274 MB perf.data ]
  $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
            grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
        bmexec+2485:
        00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
        00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
        00005641d5806bd6                        add %rdi, %rax
        00005641d5806bd9                        movzxb  -0x1(%rax), %edx
        00005641d5806bdd                        cmp %rax, %r14
        00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
        mismatch of LBR data and executable
        00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi

Fixes: 48d02a1d5c13 ("perf script: Add 'brstackinsn' for branch stacks")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191127095322.15417-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7b2f0922050c..e8db26b9b29e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -448,7 +448,7 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 		       "selected. Hence, no address to lookup the source line number.\n");
 		return -EINVAL;
 	}
-	if (PRINT_FIELD(BRSTACKINSN) &&
+	if (PRINT_FIELD(BRSTACKINSN) && !allow_user_set &&
 	    !(perf_evlist__combined_branch_type(session->evlist) &
 	      PERF_SAMPLE_BRANCH_ANY)) {
 		pr_err("Display of branch stack assembler requested, but non all-branch filter set\n"
-- 
2.21.0

