Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79213B398
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 15:25:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:11257 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANUZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:25:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 12:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="423274156"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2020 12:25:48 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Print "VMX disabled" error message iff KVM is enabled
Date:   Tue, 14 Jan 2020 12:25:45 -0800
Message-Id: <20200114202545.20296-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <157899701402.1022.5566010856636345851.tip-bot2@tip-bot2>
References: <157899701402.1022.5566010856636345851.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't print an error message about VMX being disabled by BIOS if KVM,
the sole user of VMX, is disabled.  E.g. if KVM is disabled and the
MSR is unlocked, the kernel will intentionally disable VMX when locking
feature control and then complain that "BIOS" disabled VMX.

Fixes: ef4d3bf19855 ("x86/cpu: Clear VMX feature flag if VMX is not fully enabled")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
Found a flaw when rebasing the SGX series on the feature control series.

The Fixes: tag references the commit in tip/x86/cpu, obviously should be
dropped if you can apply this as fixup instead of a patch on top.

 arch/x86/kernel/cpu/feat_ctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 24a4fdc1ab51..0268185bef94 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -133,8 +133,9 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 
 	if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
 	    (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
-		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
-			    tboot ? "inside" : "outside");
+		if (IS_ENABLED(CONFIG_KVM_INTEL))
+			pr_err_once("VMX (%s TXT) disabled by BIOS\n",
+				    tboot ? "inside" : "outside");
 		clear_cpu_cap(c, X86_FEATURE_VMX);
 	} else {
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
-- 
2.24.1

