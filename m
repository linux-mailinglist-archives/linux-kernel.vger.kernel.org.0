Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747E2B8809
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 01:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407258AbfISXYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 19:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405737AbfISXYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:24:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8898021D56;
        Thu, 19 Sep 2019 23:24:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iB5mK-0000iX-Nz; Thu, 19 Sep 2019 19:24:00 -0400
Message-Id: <20190919232400.623356642@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 19:23:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 8/8] selftests/ftrace: Update kprobe event error testcase
References: <20190919232313.198902049@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Update kprobe event error testcase to test if it correctly
finds the exact same probe event.

Link: http://lkml.kernel.org/r/156879695513.31056.1580235733738840126.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 39ef7ac1f51c..8a4025e912cb 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -95,6 +95,7 @@ echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
 check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
+check_error '^p:kprobes/testevent _do_fork'	# SAME_PROBE
 fi
 
 exit 0
-- 
2.20.1


