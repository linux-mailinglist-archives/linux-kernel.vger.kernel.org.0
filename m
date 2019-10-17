Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C7EDB674
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439118AbfJQSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 14:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390183AbfJQSlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:41:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F782089C;
        Thu, 17 Oct 2019 18:41:15 +0000 (UTC)
Date:   Thu, 17 Oct 2019 14:41:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017144114.48e25298@gandalf.local.home>
In-Reply-To: <20191017143841.317b26b5@gandalf.local.home>
References: <20191017154205.GC8974@kernel.org>
        <20191017143841.317b26b5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 14:38:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>  struct tep_event *trace_find_next_event(struct tep_handle *pevent,
>  					struct tep_event *event)
>  {
> +	static struct tep_event **all_events;
>  	static int idx;
>  	int events_count;
> -	struct tep_event *all_events;

If we are going to use static variables, let's make them all static and
optimize it a little more...

-- Steve

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index ad74be1f0e42..3f23462517a3 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -193,30 +193,35 @@ int parse_event_file(struct tep_handle *pevent,
 struct tep_event *trace_find_next_event(struct tep_handle *pevent,
 					struct tep_event *event)
 {
+	static struct tep_event **all_events;
+	static int events_count;
 	static int idx;
-	int events_count;
-	struct tep_event *all_events;
 
-	all_events = tep_get_first_event(pevent);
-	events_count = tep_get_events_count(pevent);
-	if (!pevent || !all_events || events_count < 1)
+	if (!pevent || !all_events)
 		return NULL;
 
 	if (!event) {
 		idx = 0;
-		return all_events;
+		events_count = tep_get_events_count(pevent);
+		if (events_count < 1)
+			return NULL;
+
+		all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
+		if (all_events)
+			return all_events[0];
+		return NULL;
 	}
 
-	if (idx < events_count && event == (all_events + idx)) {
+	if (idx < events_count && event == all_events[idx]) {
 		idx++;
 		if (idx == events_count)
 			return NULL;
-		return (all_events + idx);
+		return all_events[idx];
 	}
 
 	for (idx = 1; idx < events_count; idx++) {
-		if (event == (all_events + (idx - 1)))
-			return (all_events + idx);
+		if (event == all_events[idx - 1])
+			return all_events[idx];
 	}
 	return NULL;
 }
