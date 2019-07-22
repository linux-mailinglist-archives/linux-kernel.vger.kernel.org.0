Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECC707A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfGVRkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfGVRkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:45 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD73021903;
        Mon, 22 Jul 2019 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817244;
        bh=iWw8WjW7t/Xogrxr28Hix4tdM3kV2pKhLX8g+mvoGrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuzHevRT1DbKucsOAkcEWwa+SpDH80extcNUXBxpKCejl84tL6m3cebIEJmHGLzyU
         wm7/QOAo97zkR1pwNxt+WELnYKjFooP/pX9tEjIiljh+ikoSjOUsgKH+5uHg8Zi8g3
         ZWhSQjIPOIgUrPgfTHv3Of8k2vUp2wtt+zde3xO4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/37] perf script: Improve man page description of metrics
Date:   Mon, 22 Jul 2019 14:38:19 -0300
Message-Id: <20190722173839.22898-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Clarify that a metric is based on events, not referring to itself. Also
some improvements with the sentences.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 042b9e5dcc32..caaab28f8400 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,11 +228,11 @@ OPTIONS
 
 	With the metric option perf script can compute metrics for
 	sampling periods, similar to perf stat. This requires
-	specifying a group with multiple metrics with the :S option
+	specifying a group with multiple events defining metrics with the :S option
 	for perf record. perf will sample on the first event, and
-	compute metrics for all the events in the group. Please note
+	print computed metrics for all the events in the group. Please note
 	that the metric computed is averaged over the whole sampling
-	period, not just for the sample point.
+	period (since the last sample), not just for the sample point.
 
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
-- 
2.21.0

