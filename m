Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B366112B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfLDMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 07:09:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:14982 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLDMJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:09:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 04:08:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,277,1571727600"; 
   d="scan'208";a="412563600"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.95])
  by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2019 04:08:55 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject: Fix processing of ID index for injected instruction tracing
Date:   Wed,  4 Dec 2019 14:08:00 +0200
Message-Id: <20191204120800.8138-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ID index event is used when decoding, but can result in the
following error:

 $ perf record --aux-sample -e '{intel_pt//,branch-misses}:u' ls
 $ perf inject -i perf.data -o perf.data.inj --itrace=be
 $ perf script -i perf.data.inj
 0x1020 [0x410]: failed to process type: 69 [No such file or directory]

Fix by having 'perf inject' drop the ID index event.

Fixes: c0a6de06c446 ("perf record: Add support for AUX area sampling")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 9664a72a089d..7e124a7b8bfd 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -403,17 +403,6 @@ static int perf_event__repipe_tracing_data(struct perf_session *session,
 	return err;
 }
 
-static int perf_event__repipe_id_index(struct perf_session *session,
-				       union perf_event *event)
-{
-	int err;
-
-	perf_event__repipe_synth(session->tool, event);
-	err = perf_event__process_id_index(session, event);
-
-	return err;
-}
-
 static int dso__read_build_id(struct dso *dso)
 {
 	if (dso->has_build_id)
@@ -651,7 +640,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.comm	    = perf_event__repipe_comm;
 		inject->tool.namespaces	    = perf_event__repipe_namespaces;
 		inject->tool.exit	    = perf_event__repipe_exit;
-		inject->tool.id_index	    = perf_event__repipe_id_index;
+		inject->tool.id_index	    = perf_event__process_id_index;
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.aux	    = perf_event__drop_aux;
-- 
2.17.1

