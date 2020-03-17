Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28C189091
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 22:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCQVed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 17:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbgCQVeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107292076D;
        Tue, 17 Mar 2020 21:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480870;
        bh=azPq9RHUu7xA8L8SSQP4jx4KYcxztTAw7AnyamazPCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpvhz326YYSGFQaBs4x1NKY9N3x0bhfnTumZquoPLPxpaK0AXKVo4HeHXw14kEO/O
         CDgl5PuTwkDgkdFDOc+UaeRcdE8u2e9NQNfdGaPljtiZh24PT4h3WdC5Uy5x8/iD+V
         t1MPdTNliEwVdGxN7rEoNHE5A0VVkx2v/NgKRAaw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/23] perf expr: Fix copy/paste mistake
Date:   Tue, 17 Mar 2020 18:32:59 -0300
Message-Id: <20200317213259.15494-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Copy/paste leftover from recent refactor.

Fixes: 26226a97724d ("perf expr: Move expr lexer to flex")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200315155609.603948-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/expr.l | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 1928f2a3dddc..eaad29243c23 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -79,10 +79,10 @@ symbol		{spec}*{sym}*{spec}*{sym}*
 	{
 		int start_token;
 
-		start_token = parse_events_get_extra(yyscanner);
+		start_token = expr_get_extra(yyscanner);
 
 		if (start_token) {
-			parse_events_set_extra(NULL, yyscanner);
+			expr_set_extra(NULL, yyscanner);
 			return start_token;
 		}
 	}
-- 
2.21.1

