Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23937148B11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbgAXPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388018AbgAXPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C78218AC;
        Fri, 24 Jan 2020 15:17:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i6-000qH6-83; Fri, 24 Jan 2020 10:17:26 -0500
Message-Id: <20200124151726.137118966@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:17:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Subject: [for-next][PATCH 13/14] tracing: Fix uninitialized buffer var on early exit to
 trace_vbprintk()
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If we exit due to a bad input to trace_printk() (highly unlikely), then the
buffer variable will not be initialized when we unnest the ring buffer.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2e1db19dce97..d1410b4462ac 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3230,7 +3230,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	len = vbin_printf((u32 *)tbuffer, TRACE_BUF_SIZE/sizeof(int), fmt, args);
 
 	if (len > TRACE_BUF_SIZE/sizeof(int) || len < 0)
-		goto out;
+		goto out_put;
 
 	local_save_flags(flags);
 	size = sizeof(*entry) + sizeof(u32) * len;
@@ -3252,6 +3252,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 
 out:
 	ring_buffer_nest_end(buffer);
+out_put:
 	put_trace_buf();
 
 out_nobuffer:
-- 
2.24.1


