Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112F1149C81
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 20:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAZTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 14:20:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbgAZTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:20:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F58C214AF;
        Sun, 26 Jan 2020 19:20:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ivnSH-000zrY-1d; Sun, 26 Jan 2020 14:20:21 -0500
Message-Id: <20200126192020.939296571@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 Jan 2020 14:19:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 4/7] tracing: Remove unneeded NULL check
References: <20200126191932.984391723@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We checked "iter->trace" earlier so there is no need to check here.

Link: http://lkml.kernel.org/r/20141122183012.GB6994@mwanda

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
[ Pulled from the archeological digging of my INBOX ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1410b4462ac..6fed9b0a8d58 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4224,7 +4224,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	mutex_init(&iter->mutex);
 
 	/* Notify the tracer early; before we stop tracing. */
-	if (iter->trace && iter->trace->open)
+	if (iter->trace->open)
 		iter->trace->open(iter);
 
 	/* Annotate start of buffers if we had overruns */
-- 
2.24.1


