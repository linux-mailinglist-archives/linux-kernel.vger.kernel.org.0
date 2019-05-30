Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC02F83D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfE3IFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:05:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:05:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U85U1s2903178
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:05:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U85U1s2903178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203531;
        bh=OpeCGEt23oiQGRBl0RS9w4ztJIw1EgOLi1vkPYgJRd4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=BwCbzuCIsbqkzeNa3P+dpSOJkLN1oZdLzIptarm8KqroxtWdFkl3hQOR7HLUw0B/6
         2hZJLBA2jtBLrUxbH0h0cAaC2Dv0jD2RqngVC0Y/bfdL3x1HERMVt1HWdhqPrj1O9t
         2dP03iiysrSkUiOm5g0iH9psIRJnp4kpqeOFfGi0ksWVaJ7TPgWIDIWOc/GE9TR+E7
         rMyDqB4+qNVA/rFv+1WDDkuMRcuulBbO+SP3scuTIjvuWfg3euGEyfpXdu9nwyytOR
         0uqQI75sI6Ues9Lu/w192aT3OEiwMVtB4DIcsr46u04T3iabTPJ3jJY/TO0NJlq1UR
         dZAERqVs3YhAA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U85TvD2903175;
        Thu, 30 May 2019 01:05:29 -0700
Date:   Thu, 30 May 2019 01:05:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uf2vd7bc8fkz65j7yit8dh84@git.kernel.org>
Cc:     torvalds@linux-foundation.org, adrian.hunter@intel.com,
        mingo@kernel.org, amir73il@gmail.com, brendan.d.gregg@gmail.com,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, adrian.hunter@intel.com,
          torvalds@linux-foundation.org, lclaudio@redhat.com,
          linux-kernel@vger.kernel.org, brendan.d.gregg@gmail.com,
          amir73il@gmail.com, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for sync_file_range's
 'flags' arg values
Git-Commit-ID: 8ef6d74e1dd5ac830fa8b7943255ad9a44a94914
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8ef6d74e1dd5ac830fa8b7943255ad9a44a94914
Gitweb:     https://git.kernel.org/tip/8ef6d74e1dd5ac830fa8b7943255ad9a44a94914
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 21:43:39 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf beauty: Add generator for sync_file_range's 'flags' arg values

  $ tools/perf/trace/beauty/sync_file_range.sh
  static const char *sync_file_range_flags[] = {
          [ilog2(1) + 1] = "WAIT_BEFORE",
          [ilog2(2) + 1] = "WRITE",
          [ilog2(4) + 1] = "WAIT_AFTER",
  };
  $

When all are the above are present, then we have something called
SYNC_FILE_RANGE_WRITE_AND_WAIT, that will be special cased in the
upcoming scnprintf beautifier for this flags arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uf2vd7bc8fkz65j7yit8dh84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sync_file_range.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/trace/beauty/sync_file_range.sh b/tools/perf/trace/beauty/sync_file_range.sh
new file mode 100755
index 000000000000..7a9282d04e44
--- /dev/null
+++ b/tools/perf/trace/beauty/sync_file_range.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	linux_header_dir=tools/include/uapi/linux
+else
+	linux_header_dir=$1
+fi
+
+linux_fs=${linux_header_dir}/fs.h
+
+printf "static const char *sync_file_range_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_fs} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
