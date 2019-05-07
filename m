Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8B16461
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEGNQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 09:16:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:45965 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfEGNQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:16:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 06:16:42 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga001.jf.intel.com with ESMTP; 07 May 2019 06:16:42 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf vendor events intel: Add uncore_upi JSON support
Date:   Tue,  7 May 2019 06:16:31 -0700
Message-Id: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf cannot parse UPI events.

    #perf stat -e UPI_DATA_BANDWIDTH_TX
    event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
    Run 'perf list' for a list of valid events

The JSON lists call the box UPI LL, while perf calls it upi.
Add conversion support to json to convert the unit properly.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 68c92bb..daaea50 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -235,6 +235,7 @@ static struct map {
 	{ "iMPH-U", "uncore_arb" },
 	{ "CPU-M-CF", "cpum_cf" },
 	{ "CPU-M-SF", "cpum_sf" },
+	{ "UPI LL", "uncore_upi" },
 	{}
 };
 
-- 
2.7.4

