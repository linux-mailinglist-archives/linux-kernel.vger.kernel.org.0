Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2AB91FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbfITO1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 10:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389407AbfITO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6842086A;
        Fri, 20 Sep 2019 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989614;
        bh=RB64jJDgCCReTC/kJhXAfgtzo0w571u1rRMzekGSWLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIq7HGp/De/+ckC8v2GtgcbA7bdwypAcS+MwKT08ltkx+njdvYxkVJuBlwCIf20B0
         FAK8crF33Byjm5o25BM0lcNpY6Y77ui1hlZnDnWgwMEJPTg2AUm19rgDo+ufrR37DR
         qT4SgZTElohfBcNcTwXfw7oeZ5sZUP5/Y+jfkreg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 23/31] perf memswap: Adopt 'struct u64_swap' from evsel.h
Date:   Fri, 20 Sep 2019 11:25:34 -0300
Message-Id: <20190920142542.12047-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is not used in evsel.h and is a memory swap struct, so fits better
in memswap.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wvzxu7a5l3m868ywwphrnnqo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h   | 5 -----
 tools/perf/util/memswap.h | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68321d10eb2d..74df298acb31 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -179,11 +179,6 @@ struct evsel {
 	} side_band;
 };
 
-union u64_swap {
-	u64 val64;
-	u32 val32[2];
-};
-
 struct perf_missing_features {
 	bool sample_id_all;
 	bool exclude_guest;
diff --git a/tools/perf/util/memswap.h b/tools/perf/util/memswap.h
index 1e29ff903ca9..2c38e8c2d548 100644
--- a/tools/perf/util/memswap.h
+++ b/tools/perf/util/memswap.h
@@ -2,6 +2,13 @@
 #ifndef PERF_MEMSWAP_H_
 #define PERF_MEMSWAP_H_
 
+#include <linux/types.h>
+
+union u64_swap {
+	u64 val64;
+	u32 val32[2];
+};
+
 void mem_bswap_64(void *src, int byte_size);
 void mem_bswap_32(void *src, int byte_size);
 
-- 
2.21.0

