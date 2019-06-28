Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1EC5A295
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF1Rk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 13:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfF1Rk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:40:56 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F399214DA;
        Fri, 28 Jun 2019 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561743656;
        bh=IlM91rekBXzF2Dulk2z+OG35/Nb1/C6HO3bulRbEMa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Mosgy565Lij4YKeWdTSt8BoGOKG/cqvoNnkQPXLFi2O/ayL+qN4i/YISjP3TMYTBz
         /EiqGAVMEK6y1Y48wopWNYIipP3cPVnFh8Xlcf0eDta7f3cxiXxaKpV9xgpYtowZw/
         j3mYFNgq8tt7ZeoUiksXXMclMMazHU5sWnkMrsm0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] tracing: Add new testcases for hist trigger parsing errors
Date:   Fri, 28 Jun 2019 12:40:23 -0500
Message-Id: <62ec58d9aca661cde46ba678e32a938427945e9e.1561743018.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
In-Reply-To: <cover.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase ensuring that the tracing error_log correctly displays
hist trigger parsing errors.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
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

