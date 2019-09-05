Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE557AA77F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390670AbfIEPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 11:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390573AbfIEPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFAFB21D56;
        Thu,  5 Sep 2019 15:43:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvE-0007eH-9O; Thu, 05 Sep 2019 11:43:44 -0400
Message-Id: <20190905154344.177680295@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 25/25] tracing: Add "gfp_t" support in synthetic_events
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Add "gfp_t" support in synthetic_events, then the "gfp_t" type
parameter in some functions can be traced.

Prints the gfp flags as hex in addition to the human-readable flag
string.  Example output:

  whoopsie-630 [000] ...1 78.969452: testevent: bar=b20 (GFP_ATOMIC|__GFP_ZERO)
    rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20 (GFP_ATOMIC)
    rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20 (GFP_ATOMIC)

Link: http://lkml.kernel.org/r/20190712015308.9908-1-zhengjun.xing@linux.intel.com

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
[ Added printing of flag names ]
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 65e7d071ed28..3a6e42aa08e6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -13,6 +13,10 @@
 #include <linux/rculist.h>
 #include <linux/tracefs.h>
 
+/* for gfp flag names */
+#include <linux/trace_events.h>
+#include <trace/events/mmflags.h>
+
 #include "tracing_map.h"
 #include "trace.h"
 #include "trace_dynevent.h"
@@ -752,6 +756,8 @@ static int synth_field_size(char *type)
 		size = sizeof(unsigned long);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
+	else if (strcmp(type, "gfp_t") == 0)
+		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
 
@@ -792,6 +798,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%lu";
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
+	else if (strcmp(type, "gfp_t") == 0)
+		fmt = "%x";
 	else if (synth_field_is_string(type))
 		fmt = "%s";
 
@@ -834,9 +842,20 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 					 i == se->n_fields - 1 ? "" : " ");
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
+			struct trace_print_flags __flags[] = {
+			    __def_gfpflag_names, {-1, NULL} };
+
 			trace_seq_printf(s, print_fmt, se->fields[i]->name,
 					 entry->fields[n_u64],
 					 i == se->n_fields - 1 ? "" : " ");
+
+			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
+				trace_seq_puts(s, " (");
+				trace_print_flags_seq(s, "|",
+						      entry->fields[n_u64],
+						      __flags);
+				trace_seq_putc(s, ')');
+			}
 			n_u64++;
 		}
 	}
-- 
2.20.1


