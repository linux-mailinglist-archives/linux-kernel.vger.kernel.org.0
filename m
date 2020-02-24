Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4129116AD29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 18:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBXRVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgBXRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717F5222C2;
        Mon, 24 Feb 2020 17:21:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPw-001Act-Cw; Mon, 24 Feb 2020 12:21:16 -0500
Message-Id: <20200224172116.266942305@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 03/15] tracing: Check that number of vals matches number of synth event
 fields
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Commit 7276531d4036('tracing: Consolidate trace() functions')
inadvertently dropped the synth_event_trace() and
synth_event_trace_array() checks that verify the number of values
passed in matches the number of fields in the synthetic event being
traced, so add them back.

Link: http://lkml.kernel.org/r/32819cac708714693669e0dfe10fe9d935e94a16.1581720155.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6a380fb83864..45622194a34d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1878,6 +1878,11 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		u64 val;
@@ -1914,7 +1919,7 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		}
 	}
 	va_end(args);
-
+out:
 	__synth_event_trace_end(&state);
 
 	return ret;
@@ -1953,6 +1958,11 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)vals[i];
@@ -1984,7 +1994,7 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			n_u64++;
 		}
 	}
-
+out:
 	__synth_event_trace_end(&state);
 
 	return ret;
-- 
2.25.0


