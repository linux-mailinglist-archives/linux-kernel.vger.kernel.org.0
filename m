Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F049389DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfFGMI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 08:08:57 -0400
Received: from foss.arm.com ([217.140.110.172]:39042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfFGMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:08:57 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 08:08:56 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3EE42B;
        Fri,  7 Jun 2019 05:01:18 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8F23F246;
        Fri,  7 Jun 2019 05:02:58 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Archer Yan <ayan@wavecomp.com>, Guo Ren <ren_guo@c-sky.com>,
        Heyi Guo <guoheyi@huawei.com>,
        Paul Burton <paul.burton@mips.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.2-rc4
Date:   Fri,  7 Jun 2019 13:01:05 +0100
Message-Id: <20190607120105.177891-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a bunch of fixes I've collected since the merge window. Most of
the diffstat is covered by the MIPS GIC fix and the ITS command queue
mess.

Please pull,

	M.

The following changes since commit 16e32c3cde7763ab875b9030b443ecbc8e352d8a:

  iommu/dma-iommu: Remove iommu_dma_map_msi_msg() (2019-05-03 15:30:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.2-2

for you to fetch changes up to a050fa5476d418fc16b25abe168b3d38ba11e13c:

  irqchip/gic-v3-its: Fix command queue pointer comparison bug (2019-06-05 14:57:59 +0100)

----------------------------------------------------------------
irqchip fixes for 5.2

- CSky mpintc: allow interrupts to be broadcast
- TI sci-inta: fix error handling
- MIPS GIC: Fix local interrupt mapping
- ITS: Fix command queue wrapping

----------------------------------------------------------------
Guo Ren (1):
      irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus

Heyi Guo (1):
      irqchip/gic-v3-its: Fix command queue pointer comparison bug

Paul Burton (1):
      irqchip/mips-gic: Use the correct local interrupt map registers

Peter Ujfalusi (1):
      irqchip/ti-sci-inta: Fix kernel crash if irq_create_fwspec_mapping fail

 arch/mips/include/asm/mips-gic.h  | 30 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-csky-mpintc.c | 15 +++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c  | 35 ++++++++++++++++++++++++-----------
 drivers/irqchip/irq-mips-gic.c    |  4 ++--
 drivers/irqchip/irq-ti-sci-inta.c |  4 ++--
 5 files changed, 71 insertions(+), 17 deletions(-)
