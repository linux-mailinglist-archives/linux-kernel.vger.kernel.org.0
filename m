Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7612DE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfE2NhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfE2NhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:37:12 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1DD2190D;
        Wed, 29 May 2019 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137032;
        bh=NlkLu9RjQ8AyUEpx1kdxPzJMzLPBwfYdjqnmfeIBWUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdfyklXW4+zZLz51nPaHcfWOsKR3+7ZzXuebwyePA0hR8XM5X89F0tlBV/lzf+U5m
         jVixTjh9e99mmPKfhXFFS3GZO1q33OyYK2+mwGyBoA7FD2iMHcxCH7LuKaJT0Jl4NC
         bScwxU5hSOU1SuPSGUXtuLyIn73WCTReK/ND8BJE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 12/41] perf beauty: Add generator for fsconfig's 'cmd' arg values
Date:   Wed, 29 May 2019 10:35:36 -0300
Message-Id: <20190529133605.21118-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/fsconfig.sh
  static const char *fsconfig_cmds[] = {
          [0] = "SET_FLAG",
          [1] = "SET_STRING",
          [2] = "SET_BINARY",
          [3] = "SET_PATH",
          [4] = "SET_PATH_EMPTY",
          [5] = "SET_FD",
          [6] = "CMD_CREATE",
          [7] = "CMD_RECONFIGURE",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u721396rkqmawmt91dwwsntu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fsconfig.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/fsconfig.sh

diff --git a/tools/perf/trace/beauty/fsconfig.sh b/tools/perf/trace/beauty/fsconfig.sh
new file mode 100755
index 000000000000..83fb24df05c9
--- /dev/null
+++ b/tools/perf/trace/beauty/fsconfig.sh
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
+linux_mount=${linux_header_dir}/mount.h
+
+printf "static const char *fsconfig_cmds[] = {\n"
+regex='^[[:space:]]*+FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,[[:space:]]*.*'
+egrep $regex ${linux_mount} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

