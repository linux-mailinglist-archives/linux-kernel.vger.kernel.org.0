Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6932710C1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 02:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfK1BnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 20:43:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:14337 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfK1BnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:43:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="410537887"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 27 Nov 2019 17:43:19 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Andre Przywara" <Andre.Przywara@arm.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 01/13] selftests/resctrl: Add README for resctrl tests
Date:   Wed, 27 Nov 2019 16:39:32 -0800
Message-Id: <1574901584-212957-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
References: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl tests will be implemented. README is added for the tool first.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/README | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/README

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
new file mode 100644
index 000000000000..6e5a0ffa18e8
--- /dev/null
+++ b/tools/testing/selftests/resctrl/README
@@ -0,0 +1,53 @@
+resctrl_tests - resctrl file system test suit
+
+Authors:
+	Fenghua Yu <fenghua.yu@intel.com>
+	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+
+resctrl_tests tests various resctrl functionalities and interfaces including
+both software and hardware.
+
+Currently it supports Memory Bandwidth Monitoring test and Memory Bandwidth
+Allocation test on Intel RDT hardware. More tests will be added in the future.
+And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
+as well.
+
+BUILD
+-----
+
+Run "make" to build executable file "resctrl_tests".
+
+RUN
+---
+
+To use resctrl_tests, root or sudoer privileges are required. This is because
+the test needs to mount resctrl file system and change contents in the file
+system.
+
+Executing the test without any parameter will run all supported tests:
+
+	sudo ./resctrl_tests
+
+OVERVIEW OF EXECUTION
+---------------------
+
+A test case has four stages:
+
+  - setup: mount resctrl file system, create group, setup schemata, move test
+    process pids to tasks, start benchmark.
+  - execute: let benchmark run
+  - verify: get resctrl data and verify the data with another source, e.g.
+    perf event.
+  - teardown: umount resctrl and clear temporary files.
+
+ARGUMENTS
+---------
+
+Parameter '-h' shows usage information.
+
+usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
+        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
+        -n no_of_bits: run cache tests using specified no of bits in cache bit mask
+        -p cpu_no: specify CPU number to run the test. 1 is default
+        -h: help
-- 
2.19.1

