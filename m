Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEA1928B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCYMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgCYMnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:43:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F31208D6;
        Wed, 25 Mar 2020 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140180;
        bh=jYglO2+wPOu/DhBJpp5FiZUBwypWcRUTlXtwSJUrn1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvrrLhf12pi8JqbrBJr4e9yVNK9KsnQ39T1Rba/yxKfdDRwtuErs5C2sn36TPkXLi
         egsw61gAH31n/CK9kls4DC1nK5tCjqBUdNhCzD2WfazxvoELvHKYp05LIwc7JUeizZ
         qk3pYVwzTwftIq30SDDq8fLF+cYblmx2h+4ObLqE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/24] perf pmu: Make pmu_uncore_alias_match() public
Date:   Wed, 25 Mar 2020 09:41:21 -0300
Message-Id: <20200325124124.32648-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

The perf pmu-events test will want to use pmu_uncore_alias_match(), so
make it public.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-7-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 2 +-
 tools/perf/util/pmu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 55129d09f19d..616fbda7c3fc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -698,7 +698,7 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
-static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
+bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
 	bool res;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b756946ae78d..5fb3f16828df 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -103,6 +103,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 			     struct pmu_events_map *map);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
+bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
-- 
2.21.1

