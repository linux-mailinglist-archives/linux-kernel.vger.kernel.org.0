Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17551106944
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKVJtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 04:49:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:65472 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKVJtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:49:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 01:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="408843721"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.70])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2019 01:49:50 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf record: Fix perf_can_aux_sample_size()
Date:   Fri, 22 Nov 2019 11:48:56 +0200
Message-Id: <20191122094856.10923-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_can_aux_sample_size() always returned true because it did not pass
the attribute size to sys_perf_event_open, nor correctly check the
return value and errno.

Before:

  # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
  Error:
  The sys_perf_event_open() syscall returned with 7 (Argument list too long) for event (branch-misses:u).
  /bin/dmesg | grep -i perf may provide additional information.

After:

  # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
  AUX area sampling is not supported by kernel

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index e2321edcdd8f..7def66168503 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -143,6 +143,7 @@ bool perf_can_record_cpu_wide(void)
 bool perf_can_aux_sample(void)
 {
 	struct perf_event_attr attr = {
+		.size = sizeof(struct perf_event_attr),
 		.exclude_kernel = 1,
 		/*
 		 * Non-zero value causes the kernel to calculate the effective
@@ -158,7 +159,7 @@ bool perf_can_aux_sample(void)
 	 * then we assume that it is supported. We are relying on the kernel to
 	 * validate the attribute size before anything else that could be wrong.
 	 */
-	if (fd == -E2BIG)
+	if (fd < 0 && errno == E2BIG)
 		return false;
 	if (fd >= 0)
 		close(fd);
-- 
2.17.1

