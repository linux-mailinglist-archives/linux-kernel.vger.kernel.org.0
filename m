Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE2CDC26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfJGHDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 03:03:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:25273 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfJGHDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:03:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 00:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="394249606"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by fmsmga006.fm.intel.com with ESMTP; 07 Oct 2019 00:03:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix mode setting in copyfile_mode_ns()
Date:   Mon,  7 Oct 2019 10:02:21 +0300
Message-Id: <20191007070221.11158-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slow_copyfile() opens the file by name, so "write" permissions must not
be removed in copyfile_mode_ns() before calling slow_copyfile().

Example:

 Before:
  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -k /proc/kcore
  Couldn't add /proc/kcore

 After:
  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -v -k /proc/kcore
  kcore added to build-id cache directory /home/ahunter/.debug/[kernel.kcore]/37e340b1b5a7cf4f57ba8de2bc777359588a957f/2019100709562289

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/copyfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
index 3fa0db136667..47e03de7c235 100644
--- a/tools/perf/util/copyfile.c
+++ b/tools/perf/util/copyfile.c
@@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
 	if (tofd < 0)
 		goto out;
 
-	if (fchmod(tofd, mode))
-		goto out_close_to;
-
 	if (st.st_size == 0) { /* /proc? do it slowly... */
 		err = slow_copyfile(from, tmp, nsi);
+		if (!err && fchmod(tofd, mode))
+			err = -1;
 		goto out_close_to;
 	}
 
+	if (fchmod(tofd, mode))
+		goto out_close_to;
+
 	nsinfo__mountns_enter(nsi, &nsc);
 	fromfd = open(from, O_RDONLY);
 	nsinfo__mountns_exit(&nsc);
-- 
2.17.1

