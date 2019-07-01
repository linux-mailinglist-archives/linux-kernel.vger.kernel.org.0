Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28C72ABDF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfEZTTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 15:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfEZTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B2321783;
        Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfQ-0004cV-7a; Sun, 26 May 2019 15:18:48 -0400
Message-Id: <20190526191848.121312660@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 11/16] tracing/kprobe: Cast user-space address correctly
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Cast user-space address correctly to pass to probe_user_read().

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ff14eb011c1c..2c5357dddb92 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -955,7 +955,9 @@ probe_mem_read(void *dest, void *src, size_t size)
 static nokprobe_inline int
 probe_mem_read_user(void *dest, void *src, size_t size)
 {
-	return probe_user_read(dest, src, size);
+	const void __user *uaddr =  (__force const void __user *)src;
+
+	return probe_user_read(dest, uaddr, size);
 }
 
 /* Note that we don't verify it, since the code does not come from user space */
-- 
2.20.1


