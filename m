Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4018C1890D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 22:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCQVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 17:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:55:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C76420738;
        Tue, 17 Mar 2020 21:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEKB6-000EuH-Q3; Tue, 17 Mar 2020 17:55:12 -0400
Message-Id: <20200317215512.653565426@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:54:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 2/5] tracing: Remove unused TRACE_BUFFER bits
References: <20200317215455.885042360@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit 567cd4da54ff ("ring-buffer: User context bit recursion checking")
added the TRACE_BUFFER bits to be used in the current task's trace_recursion
field. But the final submission of the logic removed the use of those bits,
but never removed the bits themselves (they were never used in upstream
Linux). These can be safely removed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 99372dd7d168..c61e1b1c85a6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -557,12 +557,7 @@ struct tracer {
  * caller, and we can skip the current check.
  */
 enum {
-	TRACE_BUFFER_BIT,
-	TRACE_BUFFER_NMI_BIT,
-	TRACE_BUFFER_IRQ_BIT,
-	TRACE_BUFFER_SIRQ_BIT,
-
-	/* Start of function recursion bits */
+	/* Function recursion bits */
 	TRACE_FTRACE_BIT,
 	TRACE_FTRACE_NMI_BIT,
 	TRACE_FTRACE_IRQ_BIT,
-- 
2.25.1


