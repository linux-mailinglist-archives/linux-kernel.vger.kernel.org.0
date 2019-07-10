Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E55643FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfGJJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 05:00:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:35469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfGJI7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102552"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] perf db-export: Also export thread's current comm
Date:   Wed, 10 Jul 2019 11:58:01 +0300
Message-Id: <20190710085810.1650-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the initial comm of the main thread is exported. Export also a
thread's current comm. That better supports the tracing of multi-threaded
applications that set different comms for different threads to make it
easier to distinguish them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 305adead3a1d..2220a60ad29e 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -298,6 +298,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	};
 	struct thread *main_thread;
 	struct comm *comm = NULL;
+	struct comm *curr_comm;
 	int err;
 
 	err = db_export__evsel(dbe, evsel);
@@ -349,6 +350,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		}
 	}
 
+	curr_comm = thread__comm(thread);
+	if (curr_comm) {
+		err = db_export__comm(dbe, curr_comm, thread);
+		if (err)
+			goto out_put;
+	}
+
 	es.db_id = ++dbe->sample_last_db_id;
 
 	err = db_ids_from_al(dbe, al, &es.dso_db_id, &es.sym_db_id, &es.offset);
-- 
2.17.1

