Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D151147AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 20:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfLETdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 14:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbfLETdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:33:09 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4853A206D9;
        Thu,  5 Dec 2019 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574389;
        bh=CakUgEpoTO3EI+8Z+rMPHakY5MIJ6CL2iKyNMaVqYaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYPgWX82mliMDZyCbzRWWnc4+lFM1gcGRaDc8e5o8Zl+Eo+a2chcUo/zH/H5clgJj
         ExrOo5a+/5qUmnujUWH2QDIGjLVaITj6r6NL/V/PtyhEhUxcRqqbusWiorhq3sHhvY
         tC8DUaqyiEOjLvbcXWJgBlViVBLlPYg5Bwg/L6tM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/6] perf inject: Fix processing of ID index for injected instruction tracing
Date:   Thu,  5 Dec 2019 16:32:22 -0300
Message-Id: <20191205193224.24629-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The ID index event is used when decoding, but can result in the
following error:

 $ perf record --aux-sample -e '{intel_pt//,branch-misses}:u' ls
 $ perf inject -i perf.data -o perf.data.inj --itrace=be
 $ perf script -i perf.data.inj
 0x1020 [0x410]: failed to process type: 69 [No such file or directory]

Fix by having 'perf inject' drop the ID index event.

Fixes: c0a6de06c446 ("perf record: Add support for AUX area sampling")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191204120800.8138-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

