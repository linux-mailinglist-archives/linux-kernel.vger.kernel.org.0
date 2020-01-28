Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6140014BFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA1Sbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 13:31:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:52516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgA1Sbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:31:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 10:31:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="217704584"
Received: from otc-lr-04.jf.intel.com ([10.54.39.26])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2020 10:31:40 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/msr: Add Tremont support
Date:   Tue, 28 Jan 2020 10:31:19 -0800
Message-Id: <1580236279-35492-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580236279-35492-1-git-send-email-kan.liang@linux.intel.com>
References: <1580236279-35492-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Tremont is Intel's successor to Goldmont Plus. SMI_COUNT MSR is also
supported.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 6f86650..a949f6f 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -75,8 +75,9 @@ static bool test_intel(int idx, void *data)
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:
-
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+	case INTEL_FAM6_ATOM_TREMONT_D:
+	case INTEL_FAM6_ATOM_TREMONT:
 
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
-- 
2.7.4

