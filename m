Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89A7C0E58
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 01:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfI0Xfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 19:35:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:17015 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI0Xfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:35:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 16:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="273983171"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2019 16:35:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 031D5300322; Fri, 27 Sep 2019 16:35:50 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf jevents: Fix period for Intel fixed counters
Date:   Fri, 27 Sep 2019 16:35:45 -0700
Message-Id: <20190927233546.11533-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927233546.11533-1-andi@firstfloor.org>
References: <20190927233546.11533-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The Intel fixed counters use a special table to override the JSON
information. During this override the period information from
the JSON file got dropped, which results in inst_retired.any
and similar running with frequency mode instead of a period.
Just specify the expected period in the table.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d413761621b0..fa85e33762f7 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -449,12 +449,12 @@ static struct fixed {
 	const char *name;
 	const char *event;
 } fixed[] = {
-	{ "inst_retired.any", "event=0xc0" },
-	{ "inst_retired.any_p", "event=0xc0" },
-	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
-	{ "cpu_clk_unhalted.thread", "event=0x3c" },
-	{ "cpu_clk_unhalted.core", "event=0x3c" },
-	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
+	{ "inst_retired.any", "event=0xc0,period=2000003" },
+	{ "inst_retired.any_p", "event=0xc0,period=2000003" },
+	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03,period=2000003" },
+	{ "cpu_clk_unhalted.thread", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.core", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1,period=2000003" },
 	{ NULL, NULL},
 };
 
-- 
2.21.0

