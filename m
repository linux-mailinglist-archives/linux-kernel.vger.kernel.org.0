Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B982F834
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfE3ICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:02:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3ICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:02:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U82Td12901074
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:02:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U82Td12901074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203350;
        bh=8cQAOozQH0gOcNQyEnuYBjPjTQB4VF5oI4gvOLNspCY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=vJYrZCPM6l64ZFc2HIUQSoLnuhqQSv0Y5IVXKZYHw3m4Dgamvk4tpfcT0+MDzshYg
         Y3A3M6KHl12SXO+GLKoArp6jsE0gcy+ki4s84Su4SezYQbbo9TxF/rTOZxBQ/BoFtc
         YoCUTtgQy6BdO6f6GE9Gfffs6TyMVabFNvjXDURvHWTOaIDJo4ht6IO0/i5fLa6k6T
         qAEUzuo/XsJu6DD/hD0+Ox3U5zc1YifvYd01P9aUt2mfRZ241N3tNf/xzQx2i/zvHQ
         stpKnQoGNJCCfBLHQvyxK+iOjzrdYla18acHKeExlwcusVCgwO7qsy7vzKdzg7lW9/
         YSkr5B5BOyNxQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U82TRg2901071;
        Thu, 30 May 2019 01:02:29 -0700
Date:   Thu, 30 May 2019 01:02:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sl24d7m2ge82mfmrbaf1mb0s@git.kernel.org>
Cc:     mingo@kernel.org, dhowells@redhat.com, adrian.hunter@intel.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        brendan.d.gregg@gmail.com, tglx@linutronix.de, namhyung@kernel.org
Reply-To: brendan.d.gregg@gmail.com, namhyung@kernel.org,
          tglx@linutronix.de, viro@zeniv.linux.org.uk,
          adrian.hunter@intel.com, dhowells@redhat.com, mingo@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for fsmount's
 'attr_flags' arg values
Git-Commit-ID: 3637c64731a78ebe81fba0c282208a860c839307
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

Commit-ID:  3637c64731a78ebe81fba0c282208a860c839307
Gitweb:     https://git.kernel.org/tip/3637c64731a78ebe81fba0c282208a860c839307
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 15:57:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf beauty: Add generator for fsmount's 'attr_flags' arg values

  $ tools/perf/trace/beauty/fsmount.sh
  static const char *fsmount_attr_flags[] = {
          [ilog2(0x00000001) + 1] = "RDONLY",
          [ilog2(0x00000002) + 1] = "NOSUID",
          [ilog2(0x00000004) + 1] = "NODEV",
          [ilog2(0x00000008) + 1] = "NOEXEC",
          [ilog2(0x00000010) + 1] = "NOATIME",
          [ilog2(0x00000020) + 1] = "STRICTATIME",
          [ilog2(0x00000080) + 1] = "NODIRATIME",
  }

MOUNT_ATTR__ATIME and MOUNT_ATTR_RELATIME will be special cased in the
fsmount__scnprintf_flags() beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-sl24d7m2ge82mfmrbaf1mb0s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fsmount.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/trace/beauty/fsmount.sh b/tools/perf/trace/beauty/fsmount.sh
new file mode 100755
index 000000000000..615cc0fcf4f9
--- /dev/null
+++ b/tools/perf/trace/beauty/fsmount.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	linux_header_dir=tools/include/uapi/linux
+else
+	linux_header_dir=$1
+fi
+
+linux_mount=${linux_header_dir}/mount.h
+
+# Remove MOUNT_ATTR_RELATIME as it is zeros, handle it a special way in the beautifier
+# Only handle MOUNT_ATTR_ followed by a capital letter/num as __ is special case
+# for things like MOUNT_ATTR__ATIME that is a mask for the possible ATIME handling
+# bits. Special case it as well in the beautifier
+
+printf "static const char *fsmount_attr_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOUNT_ATTR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_mount} | grep -v MOUNT_ATTR_RELATIME | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
