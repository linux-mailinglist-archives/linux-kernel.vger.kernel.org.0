Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A93114705
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 19:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfLESlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 13:41:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:4158 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbfLESlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:41:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 10:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="214263511"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2019 10:41:07 -0800
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
Subject: [PATCH 0/3] Fix small issues in XSAVES
Date:   Thu,  5 Dec 2019 10:26:45 -0800
Message-Id: <20191205182648.32257-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches in this series are split from my supervisor xstate
patches [1].  The third is to fix a vital issue in __fpu_restore_sig(),
and more RFC than the others.  All three are not directly related to
supervisor xstates or CET, split them out and submit first.  I will
re-submit supervisor xstate patches shortly.

When__fpu_restore_sig() fails, partially cleared FPU registers still belong
to the previous owner task.  That causes that task to use corrupted xregs.
Fix it by doing __cpu_invalidate_fpregs_state() in functions that copy into
fpregs.  Further details are in the commit log of patch #3.

[1] Support XSAVES supervisor states
    https://lkml.kernel.org/r/20190925151022.21688-1-yu-cheng.yu@intel.com/

[2] CET patches:
    https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

Yu-cheng Yu (3):
  x86/fpu/xstate: Fix small issues before adding supervisor xstates
  x86/fpu/xstate: Make xfeature_is_supervisor()/xfeature_is_user()
    return bool
  x86/fpu/xstate: Invalidate fpregs when __fpu_restore_sig() fails

 arch/x86/include/asm/fpu/internal.h | 14 ++++++++++++++
 arch/x86/kernel/fpu/core.c          | 15 +++++++++++++--
 arch/x86/kernel/fpu/xstate.c        | 22 ++++++++++------------
 3 files changed, 37 insertions(+), 14 deletions(-)

-- 
2.17.1

