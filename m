Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8464BC85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfFSPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:09:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299CA218A0;
        Wed, 19 Jun 2019 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956940;
        bh=btA/z5308vWoUlNe3FXH+Xg+ydtCOcukS3mZsJaB0YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6+fYiBZ4lHDyW0+ArmyeznrHBpwFkJ30MYPu0Undzxd2JGdVnqS7E3vvWQcwvidD
         Dhs8RQud38IHKK/6rpXjEbHZMN1lfO4FQs1CIY5rWvMFJhtKXj96ibuUroPsXiveR7
         wktb40yOiowdq+qPV1iLutbE8y9kOjxRTZNaVqL4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 11/12] selftests/ftrace: Add syntax error test for immediates
Date:   Thu, 20 Jun 2019 00:08:55 +0900
Message-Id: <156095693553.28024.7730929892585591691.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

