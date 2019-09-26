Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84443BE98D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfIZAeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388418AbfIZAeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:34:16 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA48222C3;
        Thu, 26 Sep 2019 00:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458055;
        bh=/vh1dQ7KmwZqxFCtDs2tPEdCQgrfthk986mFf9k/ahE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9qoqgpSu0S08I80Bn0wCrWLH3xYLhE2iNxKynFIEGztQBHO3hPkt6GWfX+qzIi5I
         mIGW/8KhH05mqcUpBU295NN3zKBtEUJ/DhEljlj6T0nYJ9cjGPwSKYERvBnHHmAqNn
         e279DTEl6jIzVIkrO5eekTetfp6eSEMXkUmBjJ2E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/66] perf tools: Rename perf_evlist__purge() to evlist__purge()
Date:   Wed, 25 Sep 2019 21:31:58 -0300
Message-Id: <20190926003244.13962-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename (perf_evlist__purge) to evlist__purge(), so we don't have a
name clash when we add (perf_evlist__purge) in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4c5b7040c02b..c96c743cc1d2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -124,7 +124,7 @@ static void perf_evlist__update_id_pos(struct evlist *evlist)
 	perf_evlist__set_id_pos(evlist);
 }
 
-static void perf_evlist__purge(struct evlist *evlist)
+static void evlist__purge(struct evlist *evlist)
 {
 	struct evsel *pos, *n;
 
@@ -155,7 +155,7 @@ void evlist__delete(struct evlist *evlist)
 	perf_thread_map__put(evlist->core.threads);
 	evlist->core.cpus = NULL;
 	evlist->core.threads = NULL;
-	perf_evlist__purge(evlist);
+	evlist__purge(evlist);
 	evlist__exit(evlist);
 	free(evlist);
 }
-- 
2.21.0

