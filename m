Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274AB148B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbgAXPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387448AbgAXPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162A2208C4;
        Fri, 24 Jan 2020 15:17:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i4-000qCk-WB; Fri, 24 Jan 2020 10:17:25 -0500
Message-Id: <20200124151724.874372905@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [for-next][PATCH 04/14] ftrace: Remove abandoned macros
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

These 2 macros aren't used from commit eee8ded131f1 ("ftrace: Have the
function probes call their own function"), so remove them.

Link: http://lkml.kernel.org/r/1579585807-43316-1-git-send-email-alex.shi@linux.alibaba.com

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3f0ae07e72ef..7fe87c7ab1a8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -62,8 +62,6 @@
 	})
 
 /* hash bits for specific function selection */
-#define FTRACE_HASH_BITS 7
-#define FTRACE_FUNC_HASHSIZE (1 << FTRACE_HASH_BITS)
 #define FTRACE_HASH_DEFAULT_BITS 10
 #define FTRACE_HASH_MAX_BITS 12
 
-- 
2.24.1


