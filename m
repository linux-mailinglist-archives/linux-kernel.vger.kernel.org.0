Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E0136254
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgAIVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 16:17:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:44432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIVQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:16:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="212025752"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2020 13:16:58 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 1/3] x86/fpu/xstate: Fix last_good_offset in setup_xstate_features()
Date:   Thu,  9 Jan 2020 13:14:50 -0800
Message-Id: <20200109211452.27369-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109211452.27369-1-yu-cheng.yu@intel.com>
References: <20200109211452.27369-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function setup_xstate_features() uses CPUID to find each xfeature's
standard-format offset and size.  Since XSAVES always uses the compacted
format, supervisor xstates are *NEVER* in the standard-format and their
offsets are left as -1's.  However, they are still being tracked as
last_good_offset.

Fix it by tracking only user xstate offsets.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a1806598aaa4..3ef3603bcfc5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -265,22 +265,26 @@ static void __init setup_xstate_features(void)
 
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
+		xstate_sizes[i] = eax;
+
 		/*
 		 * If an xfeature is supervisor state, the offset
 		 * in EBX is invalid. We leave it to -1.
 		 */
-		if (xfeature_is_user(i))
+		if (xfeature_is_user(i)) {
 			xstate_offsets[i] = ebx;
 
-		xstate_sizes[i] = eax;
-		/*
-		 * In our xstate size checks, we assume that the
-		 * highest-numbered xstate feature has the
-		 * highest offset in the buffer.  Ensure it does.
-		 */
-		WARN_ONCE(last_good_offset > xstate_offsets[i],
-			"x86/fpu: misordered xstate at %d\n", last_good_offset);
-		last_good_offset = xstate_offsets[i];
+			/*
+			 * In our xstate size checks, we assume that the
+			 * highest-numbered xstate feature has the
+			 * highest offset in the buffer.  Ensure it does.
+			 */
+			WARN_ONCE(last_good_offset > xstate_offsets[i],
+				"x86/fpu: misordered xstate at %d\n",
+				last_good_offset);
+
+			last_good_offset = xstate_offsets[i];
+		}
 	}
 }
 
-- 
2.21.0

