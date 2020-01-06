Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87E1315AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 17:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgAFQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 11:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgAFQHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673CC222D9;
        Mon,  6 Jan 2020 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326853;
        bh=Ovu1rMnUCCX2bBQ7Y3IY1VxNqtP5TnxhrK46f1gK5JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDGbEOUjiJynWQdyhoxiBcqwAouuHT4VDE711rwnf6brvXNHxKNzM+N1/Y8SvnBKV
         WGfenU+XyGvUx4FbOzm34fcqhsYb8Nm2A683cCpkDXIvWryGNaFpYAukv2qb8qDNZk
         vb62eJk+Imsjb/K386O29oLYUu90vqlW7eGbEmFU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/20] perf tests bp_signal: Show expected versus obtained values
Date:   Mon,  6 Jan 2020 13:06:50 -0300
Message-Id: <20200106160705.10899-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help understand failures.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c951j3gvrgnrsyg7ki7pwkiz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 415903b48578..da8ec1e8e064 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -263,20 +263,20 @@ int test__bp_signal(struct test *test __maybe_unused, int subtest __maybe_unused
 		if (count1 == 11)
 			pr_debug("failed: RF EFLAG recursion issue detected\n");
 		else
-			pr_debug("failed: wrong count for bp1%lld\n", count1);
+			pr_debug("failed: wrong count for bp1: %lld, expected 1\n", count1);
 	}
 
 	if (overflows != 3)
-		pr_debug("failed: wrong overflow hit\n");
+		pr_debug("failed: wrong overflow (%d) hit, expected 3\n", overflows);
 
 	if (overflows_2 != 3)
-		pr_debug("failed: wrong overflow_2 hit\n");
+		pr_debug("failed: wrong overflow_2 (%d) hit, expected 3\n", overflows_2);
 
 	if (count2 != 3)
-		pr_debug("failed: wrong count for bp2\n");
+		pr_debug("failed: wrong count for bp2 (%lld), expected 3\n", count2);
 
 	if (count3 != 2)
-		pr_debug("failed: wrong count for bp3\n");
+		pr_debug("failed: wrong count for bp3 (%lld), expected 2\n", count3);
 
 	return count1 == 1 && overflows == 3 && count2 == 3 && overflows_2 == 3 && count3 == 2 ?
 		TEST_OK : TEST_FAIL;
-- 
2.21.1

