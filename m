Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1541975DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 09:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgC3Hlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 03:41:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56424 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbgC3Hlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:41:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79CE774F8F34A2E3430B;
        Mon, 30 Mar 2020 15:41:23 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.117) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 15:41:13 +0800
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <ndesaulniers@google.com>, <irogers@google.com>,
        <tmricht@linux.ibm.com>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
From:   Kemeng Shi <shikemeng@huawei.com>
Subject: [PATCH] perf report: Fix arm64 gap between kernel start and module
 end
Message-ID: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
Date:   Mon, 30 Mar 2020 15:41:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.117]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During execution of command 'perf report' in my arm64 virtual machine,
the error message is showed:

failed to process sample

__symbol__inc_addr_samples(860): ENOMEM! sym->name=__this_module,
    start=0x1477100, addr=0x147dbd8, end=0x80002000, func: 0

The error is caused with path:
cmd_report
 __cmd_report
  perf_session__process_events
   __perf_session__process_events
    ordered_events__flush
     __ordered_events__flush
      oe->deliver (ordered_events__deliver_event)
       perf_session__deliver_event
        machines__deliver_event
         perf_evlist__deliver_sample
          tool->sample (process_sample_event)
           hist_entry_iter__add
            iter->add_entry_cb(hist_iter__report_callback)
             hist_entry__inc_addr_samples
              symbol__inc_addr_samples
               __symbol__inc_addr_samples
                h = annotated_source__histogram(src, evidx) (NULL)

annotated_source__histogram failed is caused with path:
...
 hist_entry__inc_addr_samples
  symbol__inc_addr_samples
   symbol__hists
    annotated_source__alloc_histograms
     src->histograms = calloc(nr_hists, sizeof_sym_hist) (failed)

Calloc failed as the symbol__size(sym) is too huge. As show in error
message: start=0x1477100, end=0x80002000, size of symbol is about 2G.

This is the same problem as 'perf annotate: Fix s390 gap between kernel
end and module start (b9c0a64901d5bd)'. Perf gets symbol information from
/proc/kallsyms in __dso__load_kallsyms. A part of symbol in /proc/kallsyms
from my virtual machine is as follows:
 #cat /proc/kallsyms | sort
 ...
 ffff000001475080 d rpfilter_mt_reg      [ip6t_rpfilter]
 ffff000001475100 d $d   [ip6t_rpfilter]
 ffff000001475100 d __this_module        [ip6t_rpfilter]
 ffff000080080000 t _head
 ffff000080080000 T _text
 ffff000080080040 t pe_header
 ...

Take line 'ffff000001475100 d __this_module [ip6t_rpfilter]' as example.
The start and end of symbol are both set to ffff000001475100 in
dso__load_all_kallsyms. Then symbols__fixup_end will set the end of symbol
to next big address to ffff000001475100 in /proc/kallsyms, ffff000080080000
in this example. Then sizeof of symbol will be about 2G and cause the
problem.

The start of module in my machine is
 ffff000000a62000 t $x   [dm_mod]

The start of kernel in my machine is
 ffff000080080000 t _head

There is a big gap between end of module and begin of kernel if a samll
amount of memory is used by module. And the last symbol in module will
have a large address range as caotaining the big gap.

Give that the module and kernel text segment sequence may change in
the future, fix this by limiting range of last symbol in module and kernel
to 4K in arch arm64.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 tools/perf/arch/arm64/util/Build     |  1 +
 tools/perf/arch/arm64/util/machine.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/machine.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 393b9895c..37cbfa5e9 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -2,6 +2,7 @@ libperf-y += header.o
 libperf-y += tsc.o
 libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
+libperf-y += machine.o
 libperf-$(CONFIG_DWARF)     += dwarf-regs.o
 libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
new file mode 100644
index 000000000..a25be2431
--- /dev/null
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include "debug.h"
+#include "symbol.h"
+
+/* On arm64, kernel text segment start at high memory address,
+ * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
+ * address, like 0xffff 0000 00ax xxxx. When only samll amount of
+ * memory is used by modules, gap between end of module's text segment
+ * and start of kernel text segment may be reach 2G.
+ * Therefore do not fill this gap and do not assign it to the kernel dso map.
+ */
+
+#define SYMBOL_LIMIT (1 << 12) /* 4K */
+
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
+			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
+		/* Limit range of last symbol in module and kernel */
+		p->end += SYMBOL_LIMIT;
+	else
+		p->end = c->start;
+	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
+}
-- 
2.19.1


