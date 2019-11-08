Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D0F5A13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbfKHVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:34:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732900AbfKHVev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074DE218AE;
        Fri,  8 Nov 2019 21:34:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu6-0007w7-0C; Fri, 08 Nov 2019 16:34:50 -0500
Message-Id: <20191108213449.887070634@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 02/10] ftrace: Separate out functionality from ftrace_location_range()
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Create a new function called lookup_rec() from the functionality of
ftrace_location_range(). The difference between lookup_rec() is that it
returns the record that it finds, where as ftrace_location_range() returns
only if it found a match or not.

The lookup_rec() is static, and can be used for new functionality where
ftrace needs to find a record of a specific address.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 76e5de8c7822..b0e7f03919de 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1541,6 +1541,26 @@ static int ftrace_cmp_recs(const void *a, const void *b)
 	return 0;
 }
 
+static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
+{
+	struct ftrace_page *pg;
+	struct dyn_ftrace *rec = NULL;
+	struct dyn_ftrace key;
+
+	key.ip = start;
+	key.flags = end;	/* overload flags, as it is unsigned long */
+
+	for (pg = ftrace_pages_start; pg; pg = pg->next) {
+		if (end < pg->records[0].ip ||
+		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
+			continue;
+		rec = bsearch(&key, pg->records, pg->index,
+			      sizeof(struct dyn_ftrace),
+			      ftrace_cmp_recs);
+	}
+	return rec;
+}
+
 /**
  * ftrace_location_range - return the first address of a traced location
  *	if it touches the given ip range
@@ -1555,23 +1575,11 @@ static int ftrace_cmp_recs(const void *a, const void *b)
  */
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
-	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
-	struct dyn_ftrace key;
 
-	key.ip = start;
-	key.flags = end;	/* overload flags, as it is unsigned long */
-
-	for (pg = ftrace_pages_start; pg; pg = pg->next) {
-		if (end < pg->records[0].ip ||
-		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
-			continue;
-		rec = bsearch(&key, pg->records, pg->index,
-			      sizeof(struct dyn_ftrace),
-			      ftrace_cmp_recs);
-		if (rec)
-			return rec->ip;
-	}
+	rec = lookup_rec(start, end);
+	if (rec)
+		return rec->ip;
 
 	return 0;
 }
-- 
2.23.0


