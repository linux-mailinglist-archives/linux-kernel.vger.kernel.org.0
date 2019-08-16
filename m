Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9090220
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfHPM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:59:45 -0400
Received: from foss.arm.com ([217.140.110.172]:56478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHPM7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:59:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A46344;
        Fri, 16 Aug 2019 05:59:45 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2E403F706;
        Fri, 16 Aug 2019 05:59:43 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        raph.gault+kdev@gmail.com, Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH v3 0/5] arm64: Enable access to pmu registers by user-space
Date:   Fri, 16 Aug 2019 13:59:29 +0100
Message-Id: <20190816125934.18509-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2:
* Rebased on linux-next/master again (next-20190814)
* Use linux/compiler.h header as suggested by Arnaldo

The perf user-space tool relies on the PMU to monitor events. It offers an
abstraction layer over the hardware counters since the underlying
implementation is cpu-dependent. We want to allow userspace tools to have
access to the registers storing the hardware counters' values directly.
This targets specifically self-monitoring tasks in order to reduce the
overhead by directly accessing the registers without having to go
through the kernel.
In order to do this we need to setup the pmu so that it exposes its registers
to userspace access.

The first patch add a test to the perf tool so that we can test that the
access to the registers works correctly from userspace.

The second patch add a capability in the arm64 cpufeatures framework in
order to detect when we are running on a heterogeneous system.

The third patch focuses on the armv8 pmuv3 PMU support and makes sure that
the access to the pmu registers is enable and that the userspace have
access to the relevent information in order to use them.

The fourth patch put in place callbacks to enable access to the hardware
counters from userspace when a compatible event is opened using the perf
API.

The fifth patch adds a short documentation about PMU counters direct
access from userspace.

Raphael Gault (5):
  perf: arm64: Add test to check userspace access to hardware counters.
  arm64: cpufeature: Add feature to detect heterogeneous systems
  arm64: pmu: Add function implementation to update event index in
    userpage.
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

 .../arm64/pmu_counter_user_access.txt         |  42 +++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 +
 arch/arm64/kernel/cpufeature.c                |  20 ++
 arch/arm64/kernel/perf_event.c                |  23 ++
 drivers/perf/arm_pmu.c                        |  38 +++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/perf/arch/arm64/include/arch-tests.h    |   7 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 tools/perf/arch/arm64/tests/user-events.c     | 254 ++++++++++++++++++
 13 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm64/pmu_counter_user_access.txt
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

-- 
2.17.1

