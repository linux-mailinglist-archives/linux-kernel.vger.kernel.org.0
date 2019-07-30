Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3E7AA92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfG3OJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:09:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42183 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfG3OJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:09:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so28986243plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHPjJv58lVrwg6giII+qHzNEmZDa61eVgrDBDTfVpak=;
        b=DdOm9udMcvmHE1orqtO9n8OFxskdl64iuJYu39Q4KZGHk7TxeaFSHHo5oAOAnKsDQ/
         uyYD/z6srPTl76pLYkMNZzqSiZNA5BQNK80x6W+xatQTOp9+rFNHzUC3xD1RLv3MllTB
         UQO7t0pK8xTLfOvjgveY+Y8Nha7eatlICV/JNUes1eHgClxqfjTT5kvUgodj/99R2h+l
         SFL//S4cyP8O8vrw/MXjX/SG+hjEE0QSMUyLCYOmao9iR3FZ3jkxETwVhJMOnXJiPn1b
         WjgFyfQ/KuV+pWCnOlO3OmflAIf2nsnfJyjBb3Ywd4oeiVoCqnwTJnsA4JLKOf2jQBjV
         RgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHPjJv58lVrwg6giII+qHzNEmZDa61eVgrDBDTfVpak=;
        b=ks0Ne0DeyxgDkWP2mW0t/pE3hCG5/5wBehdGl9vXnI8SFkqp1nzVUtLCKQA+U57cyi
         Tv4abboDXJrRw8bbhjIM4fcUEc1BsMf3QdbJhnI+BGQUt4/6kxuCRB1l3rol/XsZOLF0
         B7B5Lp2/LEi/6Yj/mXWVjcJNU7Y1gdY5t96vSRD7oWW8/48HjOpKFxnxi63ysi6qzifA
         oUyh6xJwe0O/QFdb3FzbxZPtNXjCm8CB5kZ9zKohGgTsTuRS0hEVk/oyGL2u+qLO3MrM
         GMFDd6WNhgPPLd5LMX8dqrwY8ZmKtSotrcx5JvT+KXRdLr6W07jl3utS9QhrkMpfVpFv
         suTQ==
X-Gm-Message-State: APjAAAW7yUxIoAvFmEw023pG5CP6JERKlauBjJsx1jPQ4yT+MK303b2P
        OE29i5cPa3sccUxZKfSbaOE=
X-Google-Smtp-Source: APXvYqyxL7Y2isD78hMwUqEvNi8sdW0nlyiV+/7D6/s+DZLzlJjBKPg28SY5TV/ONjYI6VgK/6AuvA==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr115822673plb.103.1564495752244;
        Tue, 30 Jul 2019 07:09:12 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w16sm78941293pfj.85.2019.07.30.07.09.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 07:09:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] fgraph: Remove redundant ftrace_graph_notrace_addr() test
Date:   Tue, 30 Jul 2019 22:08:50 +0800
Message-Id: <20190730140850.7927-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have tested it before. The second one should be removed.
With this change, the performance should have little improvement.

Fixes: 9cd2992f2d6c ("fgraph: Have set_graph_notrace only affect function_graph tracer")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_functions_graph.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 69ebf3c2f1b5..78af97163147 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -137,6 +137,13 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
 		return 0;
 
+	/*
+	 * Do not trace a function if it's filtered by set_graph_notrace.
+	 * Make the index of ret stack negative to indicate that it should
+	 * ignore further functions.  But it needs its own ret stack entry
+	 * to recover the original index in order to continue tracing after
+	 * returning from the function.
+	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
 		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
 		/*
@@ -155,16 +162,6 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	if (ftrace_graph_ignore_irqs())
 		return 0;
 
-	/*
-	 * Do not trace a function if it's filtered by set_graph_notrace.
-	 * Make the index of ret stack negative to indicate that it should
-	 * ignore further functions.  But it needs its own ret stack entry
-	 * to recover the original index in order to continue tracing after
-	 * returning from the function.
-	 */
-	if (ftrace_graph_notrace_addr(trace->func))
-		return 1;
-
 	/*
 	 * Stop here if tracing_threshold is set. We only write function return
 	 * events to the ring buffer.
-- 
2.20.1

