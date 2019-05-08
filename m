Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB19180FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfEHUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfEHUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175252173C;
        Wed,  8 May 2019 20:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7V-0007ik-83; Wed, 08 May 2019 16:24:53 -0400
Message-Id: <20190508202453.132275507@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 09/13] tracing: Fix white space issues in parse_pred() function
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up an indentation issue, a whole chunk of code
has an extra space in the indentation.

Link: http://lkml.kernel.org/r/20181109132312.20994-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 48 +++++++++++++++---------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 180ecb390baa..d3e59312ef40 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1222,30 +1222,30 @@ static int parse_pred(const char *str, void *data,
 		 * (perf doesn't use it) and grab everything.
 		 */
 		if (strcmp(field->name, "ip") != 0) {
-			 parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
-			 goto err_free;
-		 }
-		 pred->fn = filter_pred_none;
-
-		 /*
-		  * Quotes are not required, but if they exist then we need
-		  * to read them till we hit a matching one.
-		  */
-		 if (str[i] == '\'' || str[i] == '"')
-			 q = str[i];
-		 else
-			 q = 0;
-
-		 for (i++; str[i]; i++) {
-			 if (q && str[i] == q)
-				 break;
-			 if (!q && (str[i] == ')' || str[i] == '&' ||
-				    str[i] == '|'))
-				 break;
-		 }
-		 /* Skip quotes */
-		 if (q)
-			 s++;
+			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
+			goto err_free;
+		}
+		pred->fn = filter_pred_none;
+
+		/*
+		 * Quotes are not required, but if they exist then we need
+		 * to read them till we hit a matching one.
+		 */
+		if (str[i] == '\'' || str[i] == '"')
+			q = str[i];
+		else
+			q = 0;
+
+		for (i++; str[i]; i++) {
+			if (q && str[i] == q)
+				break;
+			if (!q && (str[i] == ')' || str[i] == '&' ||
+				   str[i] == '|'))
+				break;
+		}
+		/* Skip quotes */
+		if (q)
+			s++;
 		len = i - s;
 		if (len >= MAX_FILTER_STR_VAL) {
 			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
-- 
2.20.1


