Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE68211EF0C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 01:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLNAOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 19:14:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:57956 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfLNAOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:14:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 16:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="216585272"
Received: from spandruv-mobl.jf.intel.com ([10.255.89.247])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2019 16:14:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] admin guide/pm: Admin guide for Intel Uncore Frequency limits
Date:   Fri, 13 Dec 2019 16:14:08 -0800
Message-Id: <20191214001408.4878-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191214001408.4878-1-srinivas.pandruvada@linux.intel.com>
References: <20191214001408.4878-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation for the attributes to control uncore frequency
selection.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_uncore.rst | 23 +++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/intel_uncore.rst

diff --git a/Documentation/admin-guide/pm/intel_uncore.rst b/Documentation/admin-guide/pm/intel_uncore.rst
new file mode 100644
index 000000000000..0986d9ab59d6
--- /dev/null
+++ b/Documentation/admin-guide/pm/intel_uncore.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================================
+Intel® Uncore Frequency Selection
+=========================================================
+
+The uncore frequency in the Intel(R) hardware is selected based on internal heuristics, which uses the current selected performance state and various system power constraints. In majority of the cases this selection is the most optimal, so there is no need for placing external constraints from the Operating System.
+
+But there are some customers who wants less jitters from dynamic uncore frequency selection. For them, power saving is much lower priority than consistent performance. Currently these customers uses MSR 0x620, to place hard limits on the maximum and the minimum uncore frequency. They can now use Linux sysfs to place these limits and also have additional capability to place hard limits under power constraint scenario.
+
+The Uncore frequency section attributes are present under "/sys/devices/system/cpu/intel_uncore_frequency".
+The scope of these attributes is per die in multi-die systems or package wide in non multi-die systems. There is a unique folder for each die or package. For example:
+"package_00_die_00" for package 0 and die 0.
+
+Attributes:
+
+power_up_max_freq_khz (READ ONLY): This is the power up value of the maximum uncore frequency in KHz. This is sampled during the driver initialization time. This is not the absolute maximum uncore frequency as there is no capability for the Operating System to read that. This can be used as a reference to roll back settings once user changed this limit.
+
+power_up_min_freq_khz (READ ONLY): This is the power up value of the minimum uncore frequency in KHz. This is not the absolute minimum uncore frequency. This can be used as a reference to roll back settings once user changed this limit.
+
+max_freq_khz (READ, WRITE): This presents current maximum uncore frequency. User can modify this attribute to change to a new maximum uncore frequency in KHz.
+
+min_freq_khz (READ, WRITE): This presents current minimum uncore frequency. User can modify this attribute to change to a new minimum uncore frequency in KHz.
diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentation/admin-guide/pm/working-state.rst
index fc298eb1234b..15094cf0a234 100644
--- a/Documentation/admin-guide/pm/working-state.rst
+++ b/Documentation/admin-guide/pm/working-state.rst
@@ -11,3 +11,4 @@ Working-State Power Management
    cpufreq
    intel_pstate
    intel_epb
+   intel_uncore
-- 
2.17.2

