Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0319A959
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbgDAKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 06:18:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732289AbgDAKSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:18:00 -0400
IronPort-SDR: oZ5LXROW9bG/3QHuLzMS8rboMVhwrVw0qr1iOaRHCZZvygENKbp6KLZN25Ns9NcO0RvTICj+jI
 5YlwgAEkWSWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:58 -0700
IronPort-SDR: dYEBJTBYvJK+jQYUz3tvPjTiGcWM8s4pwIimR3GvzAARLEPJlp4zW3U5be+Q9QB+gbVC3G7PZy
 PcS3TRBnvWVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925589"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/16] perf tools: Rearrange perf_evsel__config_leader_sampling()
Date:   Wed,  1 Apr 2020 13:16:11 +0300
Message-Id: <20200401101613.6201-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for leader sampling with AUX area events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/record.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index ce383fc1bbbc..924c58b3fc36 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -172,24 +172,24 @@ static void perf_evsel__config_leader_sampling(struct evsel *evsel)
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
 
+	if (leader == evsel || !leader->sample_read)
+		return;
+
 	/*
 	 * Disable sampling for all group members other
 	 * than leader in case leader 'leads' the sampling.
 	 */
-	if (leader != evsel && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
+	attr->freq           = 0;
+	attr->sample_freq    = 0;
+	attr->sample_period  = 0;
+	attr->write_backward = 0;
 
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
+	/*
+	 * We don't get a sample for slave events, we make them when delivering
+	 * the group leader sample. Set the slave event to follow the master
+	 * sample_type to ease up reporting.
+	 */
+	attr->sample_type = leader->core.attr.sample_type;
 }
 
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
-- 
2.17.1

