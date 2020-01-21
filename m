Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C669E143FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAUOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 09:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgAUOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:39:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C4E24653;
        Tue, 21 Jan 2020 14:39:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ituhA-000dx0-Il; Tue, 21 Jan 2020 09:39:56 -0500
Message-Id: <20200121143956.452375431@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 21 Jan 2020 09:38:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-linus][PATCH 1/5] tracing: xen: Ordered comparison of function pointers
References: <20200121143847.609307852@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Just as commit 0566e40ce7 ("tracing: initcall: Ordered comparison of
function pointers"), this patch fixes another remaining one in xen.h
found by clang-9.

In file included from arch/x86/xen/trace.c:21:
In file included from ./include/trace/events/xen.h:475:
In file included from ./include/trace/define_trace.h:102:
In file included from ./include/trace/trace_events.h:473:
./include/trace/events/xen.h:69:7: warning: ordered comparison of function \
pointers ('xen_mc_callback_fn_t' (aka 'void (*)(void *)') and 'xen_mc_callback_fn_t') [-Wordered-compare-function-pointers]
                    __field(xen_mc_callback_fn_t, fn)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:421:29: note: expanded from macro '__field'
                                ^
./include/trace/trace_events.h:407:6: note: expanded from macro '__field_ext'
                                 is_signed_type(type), filter_type);    \
                                 ^
./include/linux/trace_events.h:554:44: note: expanded from macro 'is_signed_type'
                                              ^

Fixes: c796f213a6934 ("xen/trace: add multicall tracing")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/xen.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 9a0e8af21310..a5ccfa67bc5c 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -66,7 +66,11 @@ TRACE_EVENT(xen_mc_callback,
 	    TP_PROTO(xen_mc_callback_fn_t fn, void *data),
 	    TP_ARGS(fn, data),
 	    TP_STRUCT__entry(
-		    __field(xen_mc_callback_fn_t, fn)
+		    /*
+		     * Use field_struct to avoid is_signed_type()
+		     * comparison of a function pointer.
+		     */
+		    __field_struct(xen_mc_callback_fn_t, fn)
 		    __field(void *, data)
 		    ),
 	    TP_fast_assign(
-- 
2.24.1


