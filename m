Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29634789
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfFDNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:01:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfFDNBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:01:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:01:53 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:01:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] perf script: Set perf time interval in itrace_synth_ops
Date:   Tue,  4 Jun 2019 16:00:00 +0300
Message-Id: <20190604130017.31207-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction trace decoders can optimize output based on what time intervals
will be filtered, so pass that information in itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 80c722ade852..61f00055476a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3829,6 +3829,10 @@ int cmd_script(int argc, const char **argv)
 						  &script.range_num);
 		if (err < 0)
 			goto out_delete;
+
+		itrace_synth_opts__set_time_range(&itrace_synth_opts,
+						  script.ptime_range,
+						  script.range_num);
 	}
 
 	err = __cmd_script(&script);
@@ -3836,8 +3840,10 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	if (script.ptime_range)
+	if (script.ptime_range) {
+		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&script.ptime_range);
+	}
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
-- 
2.17.1

