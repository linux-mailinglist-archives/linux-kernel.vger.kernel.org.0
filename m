Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEACFE1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJHPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:52:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:21581 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfJHPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:52:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 08:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="277135006"
Received: from otc-lr-04.jf.intel.com ([10.54.39.120])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 08:52:12 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/9] x86/cpu: Add Comet Lake to Intel family
Date:   Tue,  8 Oct 2019 08:50:02 -0700
Message-Id: <1570549810-25049-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Comet Lake is the new 10th Gen Intel processor.
Add CPU model number for Comet Lake to the Intel family list.

The CPU model number is not published in SDM yet. It comes
from an authoritative internal source.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f046225..c606c0b 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -83,6 +83,9 @@
 #define INTEL_FAM6_TIGERLAKE_L		0x8C
 #define INTEL_FAM6_TIGERLAKE		0x8D
 
+#define INTEL_FAM6_COMETLAKE		0xA5
+#define INTEL_FAM6_COMETLAKE_L		0xA6
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.7.4

