Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7D21EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfEQTkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfEQTka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:40:30 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E4821734;
        Fri, 17 May 2019 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122030;
        bh=b8nr9yB2RbJ8/Jr/PNCqtTC5VOrb5g5cP6fnS9COZwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSIyOQuOtdKpljWkVcjBZSGPw0fKHLBSI3SORnugscAziKp0eZpelH9D73iBFbe4h
         i1CTr27qbYiyT4tf4RRJxmSIKTTtwUNkd5GDu4CX6x3y5ID8x5n9YAZN1u0YIIOcrb
         oQ/ys4bpwjMKOG/CroIUEuBmskVbu1igM0h/iIeg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 57/73] perf inject: Enable COMPRESSED record decompression
Date:   Fri, 17 May 2019 16:35:55 -0300
Message-Id: <20190517193611.4974-58-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Initialized decompression part of Zstd based API so COMPRESSED records
would be decompressed into the resulting output data file.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/c27d7500-ecdd-3569-cab5-8f70bbed5ea4@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 24086b7f1b14..8e0e06d3edfc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -837,6 +837,9 @@ int cmd_inject(int argc, const char **argv)
 	if (inject.session == NULL)
 		return -1;
 
+	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
+		pr_warning("Decompression initialization failed.\n");
+
 	if (inject.build_ids) {
 		/*
 		 * to make sure the mmap records are ordered correctly
@@ -867,6 +870,7 @@ int cmd_inject(int argc, const char **argv)
 	ret = __cmd_inject(&inject);
 
 out_delete:
+	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
 	return ret;
 }
-- 
2.20.1

