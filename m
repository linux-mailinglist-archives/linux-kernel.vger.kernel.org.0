Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1008BE99E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389381AbfIZAfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389070AbfIZAfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:09 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0169C222C2;
        Thu, 26 Sep 2019 00:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458108;
        bh=aPj28JvVi6+IHkXUA6xE6SyHudfNSB3yg5ki9++mSY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6k7WWTECn/lQPHdWXq0Mj9Ndoyk2CtR/x5DVloip35xYmvyQMJtlxK1121Kll/1r
         GxfF7z2CpvtM0cwhGInypNUKip3I1KXnrodquld0PZ92+y9MUEQQ+XfgaMZnBJgTJf
         QZerdnJE8JvLrunI9jxHiJ0bovEbVcE86TGCmk7Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 36/66] libperf: Add missing 'struct xyarray' forward declaration
Date:   Wed, 25 Sep 2019 21:32:14 -0300
Message-Id: <20190926003244.13962-37-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were getting it by luck, from files included before internal/evsel.h
where it is being included.

Fixes: 9dfcb7599084 ("libperf: Move fd array from perf's evsel to lobperf's perf_evsel class")
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lkml.kernel.org/n/tip-r8ukhxprpkflbd2k9vcc42v1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 1bff789b0923..60daee6db914 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -8,6 +8,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct xyarray;
 
 struct perf_evsel {
 	struct list_head	 node;
-- 
2.21.0

