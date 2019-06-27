Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CDC585F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfF0Pf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfF0Pfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:35:50 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE642133F;
        Thu, 27 Jun 2019 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561649749;
        bh=RCGifiVz8V6cdTzobvvNSuUfwMpPMegshY+y1Ib4/qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=deeP1mrmqw6QMEv6rf+7p/N5fvG8xbMb1ixvZZP3mIljlsda3pDE+ArW3jOzdzny2
         iqRhk4RsChBPzdioe1WSYqWntD/afvPcfmb1Qpn0HY2WXOfP3KaMOY+JGvRB+6OWoM
         3fF0IkFxbHhpqEWUrJbFL73sNQNFr/plNLMLQmM4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] tracing: Add new testcases for hist trigger parsing errors
Date:   Thu, 27 Jun 2019 10:35:19 -0500
Message-Id: <972493d3f6aeda94d4c84f0bcab72e13254a4745.1561647046.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1561647046.git.zanussi@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
In-Reply-To: <cover.1561647046.git.zanussi@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase ensuring that the tracing error_log correctly displays
hist trigger parsing errors.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
new file mode 100644
index 000000000000..d44087a2f3d1
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-errors.tc
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test histogram parser errors
+
+if [ ! -f set_event -o ! -d events/kmem ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f events/kmem/kmalloc/trigger ]; then
+    echo "event trigger is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f events/kmem/kmalloc/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
+[ -f error_log ] || exit_unsupported
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'hist:kmem:kmalloc' "$1" 'events/kmem/kmalloc/trigger'
+}
+
+check_error 'hist:keys=common_pid:vals=bytes_req:sort=common_pid,^junk'	# INVALID_SORT_FIELD
+check_error 'hist:keys=common_pid:vals=bytes_req:^sort='		# EMPTY_ASSIGNMENT
+check_error 'hist:keys=common_pid:vals=bytes_req:^sort=common_pid,'	# EMPTY_SORT_FIELD
+check_error 'hist:keys=common_pid:vals=bytes_req:sort=common_pid.^junk'	# INVALID_SORT_MODIFIER
+check_error 'hist:keys=common_pid:vals=bytes_req,bytes_alloc:^sort=common_pid,bytes_req,bytes_alloc'	# TOO_MANY_SORT_FIELDS
+
+exit 0
-- 
2.14.1

