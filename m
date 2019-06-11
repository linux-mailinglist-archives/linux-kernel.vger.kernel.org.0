Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4183C757
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbfFKJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 05:38:22 -0400
Received: from foss.arm.com ([217.140.110.172]:56302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbfFKJiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CBD7337;
        Tue, 11 Jun 2019 02:38:21 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4FF13F73C;
        Tue, 11 Jun 2019 02:38:19 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 0/8] arm64: IRQ priority masking and Pseudo-NMI fixes
Date:   Tue, 11 Jun 2019 10:38:05 +0100
Message-Id: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version one[1] of this series attempted to fix the issue reported by
Zenghui[2] when using the function_graph tracer with IRQ priority
masking.

Since then, I realized that priority masking and the use of Pseudo-NMIs
was more broken than I thought.

* Patch 1-2 are just some cleanup
* Patch 3 fixes a potential issue with not clobbering condition flags
  in irqflags operations
* Patch 4 fixes an issue where calling C code in Pseudo-NMI before
  entering NMI enter could lead to potential races
* Patch 5 fixes the function_graph issue when using priority masking
* Patch 6 introduces some debug to hopefully avoid breaking things in
  the future
* Patch 7 is a rebased version of the patch sent by Wei Li[3] fixing
  an error that can happen during on some platform using the priority
  masking feature
* Patch 8 re-enables the Pseudo-NMI selection

Changes since V3 [4]:
- Rebase on v5.2-rc4
- Fix comments/typos/missed updates
- Use single condition evalution for nmi_enter and nmi_exit

Changes since V2 [5]:
- Rebase on v5.2-rc3
- clobber conditions flags for asm that needs it as pointed out by Marc Z.
  and Robin M.
- Fix the naming of the new PMR bit value
- Introduce some helper for the debug conditions
- use WARN_ONCE for debug that might be very noisy
- Reenable pseudo NMI.

Changes since V1 [1]:
- Fix possible race condition between NMI and trace irqflags
- Simplify the representation of PSR.I in the PMR value
- Include Wei Li's fix
- Rebase on v5.1-rc7

[1] https://marc.info/?l=linux-arm-kernel&m=155542458004480&w=2
[2] https://www.spinics.net/lists/arm-kernel/msg716956.html
[3] https://www.spinics.net/lists/arm-kernel/msg722171.html
[4] https://lkml.org/lkml/2019/6/6/280
[5] https://lkml.org/lkml/2019/4/29/643

Cheers,

Julien

-->

Julien Thierry (7):
  arm64: Do not enable IRQs for ct_user_exit
  arm64: irqflags: Pass flags as readonly operand to restore instruction
  arm64: irqflags: Add condition flags to inline asm clobber list
  arm64: Fix interrupt tracing in the presence of NMIs
  arm64: Fix incorrect irqflag restore for priority masking
  arm64: irqflags: Introduce explicit debugging for IRQ priorities
  arm64: Allow selecting Pseudo-NMI again

Wei Li (1):
  arm64: fix kernel stack overflow in kdump capture kernel

 arch/arm64/Kconfig                  | 12 +++++-
 arch/arm64/include/asm/arch_gicv3.h |  4 +-
 arch/arm64/include/asm/cpufeature.h |  6 +++
 arch/arm64/include/asm/daifflags.h  | 75 +++++++++++++++++++++------------
 arch/arm64/include/asm/irqflags.h   | 79 +++++++++++++++++-----------------
 arch/arm64/include/asm/kvm_host.h   |  7 ++--
 arch/arm64/include/asm/ptrace.h     | 10 ++++-
 arch/arm64/kernel/entry.S           | 84 +++++++++++++++++++++++++++++--------
 arch/arm64/kernel/irq.c             | 26 ++++++++++++
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kernel/smp.c             |  6 +--
 arch/arm64/kvm/hyp/switch.c         |  2 +-
 drivers/irqchip/irq-gic-v3.c        |  7 ++++
 kernel/irq/irqdesc.c                |  8 +++-
 14 files changed, 228 insertions(+), 100 deletions(-)

--
1.9.1
