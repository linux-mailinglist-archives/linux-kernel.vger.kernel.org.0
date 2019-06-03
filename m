Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77883314B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfFCNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:42:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:13096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfFCNmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:42:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 06:42:31 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2019 06:42:30 -0700
From:   kan.liang@linux.intel.com
To:     mingo@redhat.com, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     qiuxu.zhuo@intel.com, tony.luck@intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] x86/CPU: Add more Icelake model number
Date:   Mon,  3 Jun 2019 06:41:20 -0700
Message-Id: <20190603134122.13853-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add the CPUID model number of Icelake (ICL) desktop and server
processors to the Intel family list.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9f15384c504a..310118805f57 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,6 +52,9 @@
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
+#define INTEL_FAM6_ICELAKE_X		0x6A
+#define INTEL_FAM6_ICELAKE_XEON_D	0x6C
+#define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
 
 /* "Small Core" Processors (Atom) */
-- 
2.14.5

