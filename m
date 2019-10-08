Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C815CFE27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfJHPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:52:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:21581 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbfJHPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:52:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 08:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="277135029"
Received: from otc-lr-04.jf.intel.com ([10.54.39.120])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 08:52:16 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/9] perf/x86/msr: Add more CPU model number for Ice Lake
Date:   Tue,  8 Oct 2019 08:50:06 -0700
Message-Id: <1570549810-25049-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

PPERF and SMI_COUNT MSRs are also supported by Ice Lake desktop and
server.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index c177bbe..8515512 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -92,6 +92,9 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_COMETLAKE_L:
 	case INTEL_FAM6_COMETLAKE:
 	case INTEL_FAM6_ICELAKE_L:
+	case INTEL_FAM6_ICELAKE:
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_D:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.7.4

