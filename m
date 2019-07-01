Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F193331128
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfEaPUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 11:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:20:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4847F23DD8;
        Fri, 31 May 2019 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559316004;
        bh=btA/z5308vWoUlNe3FXH+Xg+ydtCOcukS3mZsJaB0YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3FVgv/lDchFUcfbwrCXK34btToM9Ncd3pNIBac4OXEpBZ9UP9DcR1WEZRnAmcGJ8
         g8T5L+3WE+9V6hEliOWGQpZal43wki4K0TIqha+zc76C+IZ1B2kZxv0Hzi1qUNbG0A
         /d41U68DNxVpPXlvzDltRjM06PaCuxOjqSl8hm8Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/21] selftests/ftrace: Add syntax error test for immediates
Date:   Sat,  1 Jun 2019 00:19:59 +0900
Message-Id: <155931599918.28323.6899374683842385090.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add syntax error test cases for immediate value and
immediate string.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    5 +++++
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

