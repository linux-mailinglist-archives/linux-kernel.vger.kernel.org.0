Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EB148B15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbgAXPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbgAXPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B38222D9;
        Fri, 24 Jan 2020 15:17:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i5-000qG8-VY; Fri, 24 Jan 2020 10:17:25 -0500
Message-Id: <20200124151725.860071968@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:17:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [for-next][PATCH 11/14] tracing: Remove unused TRACE_SEQ_BUF_USED
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

This macro isn't used from commit 3a161d99c43c ("tracing: Create
seq_buf layer in trace_seq"). so no needs to keep it.

Link: http://lkml.kernel.org/r/1579586086-45543-1-git-send-email-alex.shi@linux.alibaba.com

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_seq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 87de6edafd14..1d84fcc78e3e 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -30,9 +30,6 @@
 /* How much buffer is left on the trace_seq? */
 #define TRACE_SEQ_BUF_LEFT(s) seq_buf_buffer_left(&(s)->seq)
 
-/* How much buffer is written? */
-#define TRACE_SEQ_BUF_USED(s) seq_buf_used(&(s)->seq)
-
 /*
  * trace_seq should work with being initialized with 0s.
  */
-- 
2.24.1


