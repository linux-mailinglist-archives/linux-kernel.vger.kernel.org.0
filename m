Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3BBDD0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 23:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407916AbfJRVHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 17:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJRVHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:07:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC5E20869;
        Fri, 18 Oct 2019 21:07:20 +0000 (UTC)
Date:   Fri, 18 Oct 2019 17:07:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GwanYeong Kim <gy741.kim@gmail.com>
Subject: [PATCH] tools lib traceevent: Fix sign variable to return signed in
 eval_type_str()
Message-ID: <20191018170718.3cc5013b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Seems that the value returned by eval_type_str() were always unsigned, and
never signed extended. Luckily, looking at all the trace events that
actually have a signed value seldom (if ever) are negative, so this bug
never showed its face, and if it has, nobody noticed it.

Converted the sign variable to boolean while at it.

Link: http://lkml.kernel.org/r/20191013134903.5f879ad1@gandalf.local.home
Fixes: f7d82350e597d ("tools/events: Add files to create libtraceevent.a")
Reported-by: GwanYeong Kim <gy741.kim@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475585ce..2b20063813ac 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2217,7 +2217,7 @@ static char *arg_eval (struct tep_print_arg *arg);
 static unsigned long long
 eval_type_str(unsigned long long val, const char *type, int pointer)
 {
-	int sign = 0;
+	bool sign = true;
 	char *ref;
 	int len;
 
@@ -2277,7 +2277,7 @@ eval_type_str(unsigned long long val, const char *type, int pointer)
 		return (unsigned long long)(int)val & 0xffffffff;
 
 	if (strncmp(type, "unsigned ", 9) == 0) {
-		sign = 0;
+		sign = false;
 		type += 9;
 	}
 
-- 
2.20.1

