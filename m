Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC68F107FCA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 19:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKWSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 13:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfKWSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1330B2072D;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000EyL-7U; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181241.108477734@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [for-next][PATCH 03/10] ftrace: Return ENOTSUPP when DYNAMIC_FTRACE_WITH_DIRECT_CALLS is not
 configured
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>

When CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is not set it's best to
have the stub functions return ENOTSUPP instead of ENODEV,
otherwise ENODEV is a valid error when ip is incorrect which is
indistinguishable from ftrace not compiled in.

Link: http://lkml.kernel.org/r/CAADnVQ+OzTikM9EhrfsC7NFsVYhATW1SVHxK64w3xn9qpk81pg@mail.gmail.com

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dfaa37e1943d..af79b0f8cdc1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -268,16 +268,16 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
-	return -ENODEV;
+	return -ENOTSUPP;
 }
 static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
-	return -ENODEV;
+	return -ENOTSUPP;
 }
 static inline int modify_ftrace_direct(unsigned long ip,
 				       unsigned long old_addr, unsigned long new_addr)
 {
-	return -ENODEV;
+	return -ENOTSUPP;
 }
 static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
 {
-- 
2.24.0


