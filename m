Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA2707C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfGVRm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGVRm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:56 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F2321901;
        Mon, 22 Jul 2019 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817375;
        bh=+fJPmA0UFEDYLJBil4G+mAcx6gST7oFyFgdHHUMuk9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acpSCv0Rx1U36f55kY+MKqyJOkgb3kHLHaU4YdlWO/jhhZqhDiJljvGt6zj1ppvVO
         uUCpQzSh6Lmut9MXkv+Lws0OJ6tI6OGVvK02Mx0TiSvIdntLVmJYGu5qBBg+0bHr7e
         KTaVfbgSeIEs9mxIoB/ZymGn+9WpGPqiJbcaDoNM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 36/37] perf probe: Avoid calling freeing routine multiple times for same pointer
Date:   Mon, 22 Jul 2019 14:38:38 -0300
Message-Id: <20190722173839.22898-37-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When perf_add_probe_events() we call cleanup_perf_probe_events() for the
pev pointer it receives, then, as part of handling this failure the main
'perf probe' goes on and calls cleanup_params() and that will again call
cleanup_perf_probe_events()for the same pointer, so just set nevents to
zero when handling the failure of perf_add_probe_events() to avoid the
double free.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x8qgma4g813z96dvtw9w219q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6418782951a4..3d0ffd41fb55 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -698,6 +698,16 @@ __cmd_probe(int argc, const char **argv)
 
 		ret = perf_add_probe_events(params.events, params.nevents);
 		if (ret < 0) {
+
+			/*
+			 * When perf_add_probe_events() fails it calls
+			 * cleanup_perf_probe_events(pevs, npevs), i.e.
+			 * cleanup_perf_probe_events(params.events, params.nevents), which
+			 * will call clear_perf_probe_event(), so set nevents to zero
+			 * to avoid cleanup_params() to call clear_perf_probe_event() again
+			 * on the same pevs.
+			 */
+			params.nevents = 0;
 			pr_err_with_code("  Error: Failed to add events.", ret);
 			return ret;
 		}
-- 
2.21.0

