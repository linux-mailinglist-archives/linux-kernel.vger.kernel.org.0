Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8DE71C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfD2QAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 12:00:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfD2QAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:00:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC2380D;
        Mon, 29 Apr 2019 09:00:14 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8B283F5C1;
        Mon, 29 Apr 2019 09:00:12 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 0/5] arm64: IRQ priority masking and Pseudo-NMI fixes
Date:   Mon, 29 Apr 2019 17:00:02 +0100
Message-Id: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Changing the title to make it reflex more the status of the series.]

Version one[1] of this series attempted to fix the issue reported by
Zenghui[2] when using the function_graph tracer with IRQ priority
masking.

Since then, I realized that priority masking and the use of Pseudo-NMIs
was more broken than I thought.

* Patch 1 is just some rework
* Patch 2 replaces the previous irqflags tracing "simplification" with
  a proper fix when tracing Pseudo-NMI
* Patch 3 fixes the function_graph issue when using priority masking
* Patch 4 introduces some debug to hopefully avoid breaking things in
  the future
* Patch 5 is a rebased version of the patch sent by Wei Li[3] fixing
  an error that can happen during on some platform using the priority
  masking feature

Changes since V1 [1]:
- Fix possible race condition between NMI and trace irqflags
- Simplify the representation of PSR.I in the PMR value
- Include Wei Li's fix
- Rebase on v5.1-rc7

[1] https://marc.info/?l=linux-arm-kernel&m=155542458004480&w=2
[2] https://www.spinics.net/lists/arm-kernel/msg716956.html
[3] https://www.spinics.net/lists/arm-kernel/msg722171.html

Cheers,

Julien

-->

Julien Thierry (4):
  arm64: Do not enable IRQs for ct_user_exit
  arm64: Fix interrupt tracing in the presence of NMIs
  arm64: Fix incorrect irqflag restore for priority masking
  arm64: irqflags: Introduce explicit debugging for IRQ priorities

Wei Li (1):
  arm64: fix kernel stack overflow in kdump capture kernel

 arch/arm64/Kconfig                  | 11 +++++
 arch/arm64/include/asm/arch_gicv3.h |  4 +-
 arch/arm64/include/asm/assembler.h  |  9 ++++
 arch/arm64/include/asm/daifflags.h  | 31 +++++++++++---
 arch/arm64/include/asm/irqflags.h   | 83 +++++++++++++++++++------------------
 arch/arm64/include/asm/kvm_host.h   |  4 +-
 arch/arm64/include/asm/ptrace.h     | 10 ++++-
 arch/arm64/kernel/entry.S           | 76 +++++++++++++++++++++++++--------
 arch/arm64/kernel/irq.c             | 26 ++++++++++++
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kernel/smp.c             |  6 +--
 arch/arm64/kvm/hyp/switch.c         |  2 +-
 drivers/irqchip/irq-gic-v3.c        |  6 +++
 kernel/irq/irqdesc.c                |  8 +++-
 14 files changed, 202 insertions(+), 76 deletions(-)

--
1.9.1
