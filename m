Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46D634790
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfFDNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:02:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfFDNCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:10 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] perf time-utils: Treat time ranges consistently
Date:   Tue,  4 Jun 2019 16:00:10 +0300
Message-Id: <20190604130017.31207-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, options allow only 1 explicit (non-percentage) time range.
In preparation for adding support for multiple explicit time ranges,
treat time ranges consistently.

Instead of treating some time ranges as inclusive and some as excluding the
end time, treat all time ranges as inclusive. This is only a 1 nanosecond
change but is necessary to treat multiple explicit time ranges in a
consistent manner.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/time-utils.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 20663a460df3..1d67cf1216c7 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -389,13 +389,12 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 		ptime = &ptime_buf[i];
 
 		if (timestamp >= ptime->start &&
-		    ((timestamp < ptime->end && i < num - 1) ||
-		     (timestamp <= ptime->end && i == num - 1))) {
-			break;
+		    (timestamp <= ptime->end || !ptime->end)) {
+			return false;
 		}
 	}
 
-	return (i == num) ? true : false;
+	return true;
 }
 
 int perf_time__parse_for_ranges(const char *time_str,
-- 
2.17.1

