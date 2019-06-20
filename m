Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572C04C50A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 03:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfFTBnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 21:43:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:60110 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbfFTBnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:43:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 18:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="243484933"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2019 18:43:50 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 5/5] x86/umwait: Document umwait control sysfs interfaces
Date:   Wed, 19 Jun 2019 18:33:58 -0700
Message-Id: <1560994438-235698-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since two new sysfs interface files are created for umwait control, add
an ABI document entry for the files:
	/sys/devices/system/cpu/umwait_control/enable_c02
	/sys/devices/system/cpu/umwait_control/max_time

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1528239f69b2..d22cdadd3161 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -538,3 +538,24 @@ Description:	Intel Energy and Performance Bias Hint (EPB)
 
 		This attribute is present for all online CPUs supporting the
 		Intel EPB feature.
+
+What:		/sys/devices/system/cpu/umwait_control
+		/sys/devices/system/cpu/umwait_control/enable_c02
+		/sys/devices/system/cpu/umwait_control/max_time
+Date:		May 2019
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Umwait control
+
+		enable_c02: Read/write interface to control umwait C0.2 state
+			Read returns C0.2 state status:
+				0: C0.2 is disabled
+				1: C0.2 is enabled
+
+			Write 'Yy1' or [oO][nN] for on to enable C0.2 state.
+			Write 'Nn0' or [oO][fF] for off to disable C0.2 state.
+
+		max_time: Read/write interface to control umwait maximum time
+			  in TSC-quanta that the CPU can reside in either C0.1
+			  or C0.2 state. The time is an unsigned 32-bit number.
+			  Note that a value of zero means there is no limit.
+			  Low order two bits must be zero.
-- 
2.19.1

