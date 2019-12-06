Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2F1159B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 00:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLFX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 18:28:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:15752 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfLFX2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:28:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 15:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="263717725"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Dec 2019 15:28:50 -0800
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
Subject: [PATCH] x86/fpu/xstate: Export fpu_fpregs_owner_ctx
Date:   Fri,  6 Dec 2019 15:17:09 -0800
Message-Id: <20191206231709.15398-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying my "Invalidate fpregs when __fpu_restore_sig() fails"
patch [1], the following happens:

    ERROR: "fpu_fpregs_owner_ctx" [arch/x86/kvm/kvm.ko] undefined!

Fix it by exporting the symbol.  I apologize for missing this!

[1] https://lkml.kernel.org/r/20191205182648.32257-4-yu-cheng.yu@intel.com/

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/fpu/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 743ff5ea4076..4e5151e43a2c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -42,6 +42,7 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  * Track which context is using the FPU on the CPU:
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
+EXPORT_SYMBOL_GPL(fpu_fpregs_owner_ctx);
 
 static bool kernel_fpu_disabled(void)
 {
-- 
2.17.1

