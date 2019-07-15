Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4269D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 23:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfGOVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 17:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733137AbfGOVN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:26 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1422220693;
        Mon, 15 Jul 2019 21:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225205;
        bh=TzRPVXTGtpFbGvflVxnQ0VQizLnw9wXEGsonmgq1m48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9NskH9+FzBldWxijXfWevp2TOtEFqSlC8/5gckvKQfmdou5M45wjSF0bUBQZSPuA
         bEXrvyuo0n9Oo/+ySb54p49bxGDZ88u50kYsP+uo4ysDH1Y6pSxRNDYTJ6LcU6fdIH
         JPCbHjdjDDlanUycKpHdnqhNfBJ/7Y8++Lw6Plqk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/28] perf db-export: Factor out db_export__comm()
Date:   Mon, 15 Jul 2019 18:11:46 -0300
Message-Id: <20190715211200.10984-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for exporting the current comm for a thread, factor out
db_export__comm().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 30 +++++++++++++++++++++++-------
 tools/perf/util/db-export.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b0504d3eb130..b1e581c13963 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -78,6 +78,26 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
+static int __db_export__comm(struct db_export *dbe, struct comm *comm,
+			     struct thread *thread)
+{
+	comm->db_id = ++dbe->comm_last_db_id;
+
+	if (dbe->export_comm)
+		return dbe->export_comm(dbe, comm, thread);
+
+	return 0;
+}
+
+int db_export__comm(struct db_export *dbe, struct comm *comm,
+		    struct thread *thread)
+{
+	if (comm->db_id)
+		return 0;
+
+	return __db_export__comm(dbe, comm, thread);
+}
+
 /*
  * Export the "exec" comm. The "exec" comm is the program / application command
  * name at the time it first executes. It is used to group threads for the same
@@ -92,13 +112,9 @@ int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 	if (comm->db_id)
 		return 0;
 
-	comm->db_id = ++dbe->comm_last_db_id;
-
-	if (dbe->export_comm) {
-		err = dbe->export_comm(dbe, comm, main_thread);
-		if (err)
-			return err;
-	}
+	err = __db_export__comm(dbe, comm, main_thread);
+	if (err)
+		return err;
 
 	/*
 	 * Record the main thread for this comm. Note that the main thread can
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 29f7c3b035a7..f5f0865f07e1 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -77,6 +77,8 @@ int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct thread *main_thread);
+int db_export__comm(struct db_export *dbe, struct comm *comm,
+		    struct thread *thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
-- 
2.21.0

