Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067A064403
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfGJJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:00:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:35469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfGJI7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102529"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] perf db-export: Fix a white space issue in db_export__sample()
Date:   Wed, 10 Jul 2019 11:57:56 +0300
Message-Id: <20190710085810.1650-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a white space issue in db_export__sample()

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 31986c8c4ad2..aad322a90863 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -273,7 +273,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		      struct perf_sample *sample, struct perf_evsel *evsel,
 		      struct addr_location *al)
 {
-	struct thread* thread = al->thread;
+	struct thread *thread = al->thread;
 	struct export_sample es = {
 		.event = event,
 		.sample = sample,
-- 
2.17.1

