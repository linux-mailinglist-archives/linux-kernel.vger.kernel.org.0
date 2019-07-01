Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43A2BC23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 00:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfE0WkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 18:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfE0WkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:40:10 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36442081C;
        Mon, 27 May 2019 22:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996810;
        bh=3oQ5s1g4g5tYeQU/ycSgQCeN4wNSVnvCnVJDdmc2IAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P12nnLP5EpNTFzp1lUQusmaVls61diRYmV6xxCC8+aJzJjJkLs2ngqkU+JpQCpzxF
         khEjQ65DF38hTuB/V9zKpJAS3TzH5+s5W3pTYAlll8VJabdqKRVIvdA/JPqwkUFyYb
         B7RGVlmZ7Gk6uo+wtdSf0ywEzuZTpWfMjj5GQihA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/44] perf dso: Separate generic code in dso__data_file_size()
Date:   Mon, 27 May 2019 19:37:16 -0300
Message-Id: <20190527223730.11474-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Moving file specific code in dso__data_file_size function into separate
file_size function. I'll add bpf specific code in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e059976d9d93..cb6199c1390a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -898,18 +898,12 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	return r;
 }
 
-int dso__data_file_size(struct dso *dso, struct machine *machine)
+static int file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
 	char sbuf[STRERR_BUFSIZE];
 
-	if (dso->data.file_size)
-		return 0;
-
-	if (dso->data.status == DSO_DATA_STATUS_ERROR)
-		return -1;
-
 	pthread_mutex_lock(&dso__data_open_lock);
 
 	/*
@@ -938,6 +932,17 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
 	return ret;
 }
 
+int dso__data_file_size(struct dso *dso, struct machine *machine)
+{
+	if (dso->data.file_size)
+		return 0;
+
+	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+		return -1;
+
+	return file_size(dso, machine);
+}
+
 /**
  * dso__data_size - Return dso data size
  * @dso: dso object
-- 
2.20.1

