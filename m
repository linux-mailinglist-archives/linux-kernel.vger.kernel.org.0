Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12C0232B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 13:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfETLhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 07:37:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbfETLhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:50 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] perf tools: Add IPC information to perf_sample
Date:   Mon, 20 May 2019 14:37:12 +0300
Message-Id: <20190520113728.14389-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add counts of instructions and cycles, in order to represent
instructions-per-cycle (IPC).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9e999550f247..1f1da6082806 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -204,6 +204,8 @@ struct perf_sample {
 	u64 period;
 	u64 weight;
 	u64 transaction;
+	u64 insn_cnt;
+	u64 cyc_cnt;
 	u32 cpu;
 	u32 raw_size;
 	u64 data_src;
-- 
2.17.1

