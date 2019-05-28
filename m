Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD42CA87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfE1Pno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:43:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38169 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfE1Pnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:43:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so18195436ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QcHyU0ChRIqu42slw8WQtOrrcCMUCI+/jcdZM9VOkM=;
        b=nAzcPGxTp8r6ndLEWEm43735s8vwleAVc9BIhk0Ih8z0T9Vx3+c/Gxsl7Vcij6cYHJ
         we2Fz6MnR6sE51Vpq4b+zvGP2mxoDYCdo6rEN3UrfNkOv/6aBEYat7amBcMltixqla+P
         BXeGwQxA29rR6w3zpAb0E3hMOHt6VjhH4xJBhME6gW4X1GeFyv5h0vdlXPySfxIylrpJ
         3O4o3+oSgenC3MSx4S+bHgiQJoDzEFM9OD9lW0eyQWpuD4/+11kg4UHfmbHHGEjERcoY
         qFmpfXBszmU1wAAQvHDVwd/l2UP6O7OK6MECtjyD37iLTfKxHL10G67w/E6KEGkwG4n0
         P4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QcHyU0ChRIqu42slw8WQtOrrcCMUCI+/jcdZM9VOkM=;
        b=VNLshYNqqTrrDB6YpVUMlO9wFGPeI0JaK86PesfOk11uNsViMBL+yaptxFLoBjgdc/
         YTtRpmiXo6ii87VIbAg4ZfCD+kLVxXYk9CUvQLqVpCogfc6ibbAus/UyCZVlzrcf50Lr
         aPcVGK7kkjw4uuEVkaL1Dctw1y/vRDIdYtnnKtOu3Zbjq9PKCg3tbTP7fdEHVVIVcN31
         EukHxoWZWL0qo17Tot2Tf1YAzgOgmDOrezA9UU+PA+IoW9H2zbaJWxdgrGHZD0z1EcAC
         rVpDxmI/QBKJ6ABMkx0fuenZ+sYfefUGVNZLZKHeHFGJze8E4QtKYR1FE2cs+nKGlxyB
         Uc6Q==
X-Gm-Message-State: APjAAAUu/Oj6CPr3qaiiOKy9eE+L02za21nVIhx0MU+9OJ7ZPYz0mQXO
        JOZckNYlXlFfkV2gc1UjmsgtrZdm3VU=
X-Google-Smtp-Source: APXvYqyz5YsSxz0vrXcwdISmbk/vzC/Dgdxg9bnlL5PtosCdyFhY4zLWVw04czcE3pHxTuxQ/u3onA==
X-Received: by 2002:a2e:4710:: with SMTP id u16mr36129829lja.41.1559058222035;
        Tue, 28 May 2019 08:43:42 -0700 (PDT)
Received: from debian-tom.home (2-111-15-75-dynamic.dk.customer.tdc.net. [2.111.15.75])
        by smtp.gmail.com with ESMTPSA id t2sm3415721ljd.36.2019.05.28.08.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:43:41 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] trace: Avoid memory leak in predicate_parse()
Date:   Tue, 28 May 2019 17:43:38 +0200
Message-Id: <20190528154338.29976-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190528104400.388e4c3f@gandalf.local.home>
References: <20190528104400.388e4c3f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of errors, predicate_parse() goes to the out_free label
to free memory and to return an error code.

However, predicate_parse() does not free the predicates of the
temporary prog_stack array, thence leaking them.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com
---
 kernel/trace/trace_events_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 05a66493a164..ecfa6f0f1c7e 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -427,7 +427,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kmalloc_array(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
@@ -578,6 +578,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 out_free:
 	kfree(op_stack);
 	kfree(inverts);
+	for (i = 0; prog_stack[i].pred; i++)
+		kfree(prog_stack[i].pred);
 	kfree(prog_stack);
 	return ERR_PTR(ret);
 }
-- 
2.11.0

