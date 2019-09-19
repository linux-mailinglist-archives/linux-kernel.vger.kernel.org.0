Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327DFB8804
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 01:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405848AbfISXYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 19:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390719AbfISXYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:24:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E6121907;
        Thu, 19 Sep 2019 23:24:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iB5mJ-0000f7-Ju; Thu, 19 Sep 2019 19:23:59 -0400
Message-Id: <20190919232359.500805713@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 19:23:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 1/8] ftrace: Simplify ftrace hash lookup code in clear_func_from_hash()
References: <20190919232313.198902049@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Function ftrace_lookup_ip() will check empty hash table. So we don't
need extra check outside.

Link: http://lkml.kernel.org/r/20190910143336.13472-1-changbin.du@gmail.com

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9821a3374e9..c4cc048eb594 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6036,11 +6036,7 @@ clear_func_from_hash(struct ftrace_init_func *func, struct ftrace_hash *hash)
 {
 	struct ftrace_func_entry *entry;
 
-	if (ftrace_hash_empty(hash))
-		return;
-
-	entry = __ftrace_lookup_ip(hash, func->ip);
-
+	entry = ftrace_lookup_ip(hash, func->ip);
 	/*
 	 * Do not allow this rec to match again.
 	 * Yeah, it may waste some memory, but will be removed
-- 
2.20.1


