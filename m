Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91285AA78F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390748AbfIEPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 11:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390527AbfIEPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B47021906;
        Thu,  5 Sep 2019 15:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvC-0007ZR-5A; Thu, 05 Sep 2019 11:43:42 -0400
Message-Id: <20190905154342.047670545@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 15/25] selftests/ftrace: Add syntax error test for immediates
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add syntax error test cases for immediate value and
immediate string.

Link: http://lkml.kernel.org/r/156095693553.28024.7730929892585591691.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 29faaec942c6..aa59944bcace 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -41,6 +41,11 @@ check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
 check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
 check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
 
+grep -q "imm-value" README && \
+check_error 'p vfs_read arg1=\^x'	# BAD_IMM
+grep -q "imm-string" README && \
+check_error 'p vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+
 check_error 'p vfs_read ^+0@0)'		# DEREF_NEED_BRACE
 check_error 'p vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
 check_error 'p vfs_read +0(+0(@0^)'	# DEREF_OPEN_BRACE
-- 
2.20.1


