Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305FE207ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfEPNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 09:22:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45536 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfEPNWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:22:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA2D1715;
        Thu, 16 May 2019 06:22:22 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2993F703;
        Thu, 16 May 2019 06:22:21 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 0/6] arm64: Enable access to pmu registers by user-space
Date:   Thu, 16 May 2019 14:21:42 +0100
Message-Id: <20190516132148.10085-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf user-space tool relies on the PMU to monitor events. It offers an
abstraction layer over the hardware counters since the underlying
implementation is cpu-dependent. We want to allow userspace tools to have
access to the registers storing the hardware counters' values directly.
This targets specifically self-monitoring tasks in order to reduce the
overhead by directly accessing the registers without having to go
through the kernel.
In order to do this we need to setup the pmu so that it exposes its registers
to userspace access.

The first patch enables the tests for arm64 architecture in the perf
tool to be compiled systematically.

The second patch add a test to the perf tool so that we can test that the
access to the registers works correctly from userspace.

The third patch focuses on the armv8 pmuv3 PMU support and makes sure that
the access to the pmu registers is enable and that the userspace have
access to the relevent information in order to use them.

The fourth patch adds a hook to handle faulting access to the pmu
registers. This is necessary in order to have a coherent behaviour
on big.LITTLE environment.

The fifth patch put in place callbacks to enable access to the hardware
counters from userspace when a compatible event is opened using the perf
API.

Note:
This series is applied on top of this patch (already acked):
https://patchwork.kernel.org/patch/10896407/

*** BLURB HERE ***

Raphael Gault (6):
  perf: arm64: Compile tests unconditionally
  perf: arm64: Add test to check userspace access to hardware counters.
  arm64: pmu: Add function implementation to update event index in
    userpage.
  arm64: pmu: Add hook to handle pmu-related undefined instructions
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

 .../arm64/pmu_counter_user_access.txt         |  42 +++
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 +
 arch/arm64/kernel/perf_event.c                |  72 +++++
 drivers/perf/arm_pmu.c                        |  48 ++++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/perf/arch/arm64/Build                   |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h    |   6 +
 tools/perf/arch/arm64/tests/Build             |   3 +-
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 tools/perf/arch/arm64/tests/user-events.c     | 255 ++++++++++++++++++
 12 files changed, 454 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm64/pmu_counter_user_access.txt
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

-- 
2.17.1

