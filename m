Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB98310C9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfK1Nld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfK1Nlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:31 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD21221787;
        Thu, 28 Nov 2019 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948490;
        bh=mH9g3Vifsixa+l0k7MuRbmDzt21UQM0uIs3jyCd0deI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnLsyTtZvMOtXvmAN2COKymtXOWWDOc34PN5P6vDsmQcWR/ZfM8qmzhNR64UTuCyv
         N8Io1iFWC3/exUhYAZ+KCqJHSPrUlaebdXWPOX6Q4krIuDvqlL12WyS0hO8UzxZB6W
         ksdVANCmOcVSiNIeGnc0cvAPx+BxjD588dX8sW5Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/22] perf diff: Use llabs() with 64-bit values
Date:   Thu, 28 Nov 2019 10:40:22 -0300
Message-Id: <20191128134027.23726-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To fix this build error on a debian mipsel cross build environment:

  builtin-diff.c: In function 'compute_cycles_diff':
  builtin-diff.c:649:10: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    649 |    val = labs(pair->block_info->cycles_spark[i] -
        |          ^~~~

Fixes: cebf7d51a6c3 ("perf diff: Report noisy for cycles diff")
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index eae879376283..f8b6ae557d8b 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -646,7 +646,7 @@ static void compute_cycles_diff(struct hist_entry *he,
 			if (i >= he->block_info->num || i >= NUM_SPARKS)
 				break;
 
-			val = labs(pair->block_info->cycles_spark[i] -
+			val = llabs(pair->block_info->cycles_spark[i] -
 				     he->block_info->cycles_spark[i]);
 
 			update_spark_value(pair->diff.svals, NUM_SPARKS,
-- 
2.21.0

