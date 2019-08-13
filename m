Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3A8AE16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 06:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHMEtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 00:49:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:10591 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfHMEtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:49:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 21:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; 
   d="scan'208";a="260015356"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2019 21:49:17 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
Cc:     kyung.min.park@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Add Atom Tremont (Elkhart Lake)
Date:   Mon, 12 Aug 2019 21:43:38 -0700
Message-Id: <1565671419-5257-1-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Atom Tremont model number to the Intel family list.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0278aa6..02d675d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -79,6 +79,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
 
 #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
+#define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
 
 /* Xeon Phi */
 
-- 
2.7.4

