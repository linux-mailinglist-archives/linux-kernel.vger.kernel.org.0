Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1662C975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfE1PEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:04:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfE1PD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:03:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F24E169E;
        Tue, 28 May 2019 08:03:57 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0060D3F5AF;
        Tue, 28 May 2019 08:03:55 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 7/7] Documentation: arm64: Document PMU counters access from userspace
Date:   Tue, 28 May 2019 16:03:20 +0100
Message-Id: <20190528150320.25953-8-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528150320.25953-1-raphael.gault@arm.com>
References: <20190528150320.25953-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation file to describe the access to the pmu hardware
counters from userspace

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 .../arm64/pmu_counter_user_access.txt         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/arm64/pmu_counter_user_access.txt

diff --git a/Documentation/arm64/pmu_counter_user_access.txt b/Documentation/arm64/pmu_counter_user_access.txt
new file mode 100644
index 000000000000..6788b1107381
--- /dev/null
+++ b/Documentation/arm64/pmu_counter_user_access.txt
@@ -0,0 +1,42 @@
+Access to PMU hardware counter from userspace
+=============================================
+
+Overview
+--------
+The perf user-space tool relies on the PMU to monitor events. It offers an
+abstraction layer over the hardware counters since the underlying
+implementation is cpu-dependent.
+Arm64 allows userspace tools to have access to the registers storing the
+hardware counters' values directly.
+
+This targets specifically self-monitoring tasks in order to reduce the overhead
+by directly accessing the registers without having to go through the kernel.
+
+How-to
+------
+The focus is set on the armv8 pmuv3 which makes sure that the access to the pmu
+registers is enable and that the userspace have access to the relevent
+information in order to use them.
+
+In order to have access to the hardware counter it is necessary to open the event
+using the perf tool interface: the sys_perf_event_open syscall returns a fd which
+can subsequently be used with the mmap syscall in order to retrieve a page of memory
+containing information about the event.
+The PMU driver uses this page to expose to the user the hardware counter's
+index. Using this index enables the user to access the PMU registers using the
+`mrs` instruction.
+
+Have a look `at tools/perf/arch/arm64/tests/user-events.c` for an example. It can be
+run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+./perf test -v
+
+About chained events
+--------------------
+When the user requests for an event to be counted on 64 bits, two hardware
+counters are used and need to be combined to retrieve the correct value:
+
+val = read_counter(idx);
+if ((event.attr.config1 & 0x1))
+	val = (val << 32) | read_counter(idx - 1);
-- 
2.17.1

