Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6DE6318
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfJ0Om6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 10:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfJ0Om6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:42:58 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC9C214AF;
        Sun, 27 Oct 2019 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187376;
        bh=Z87iQ8r/Zs8QcHm3AWQm907d97xyGfDqeydhOv6+qW0=;
        h=From:To:Cc:Subject:Date:From;
        b=lY2qHe/iLt950wPLoFxO3l+pqV07HyjzDcZOOSGPuoTg2qpjUodwg/p6vq6ZV82E3
         LDg8F45yQf1Twd30WPOHlGJduXqVa/X584wgbYFmqF2MASA/VH0UREfNpM7BS3JJGI
         ymIEj8EX9q/MBXSmohYdvehoXOJDBx/N6trlOwM8=
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 00/36] irqchip/gic-v4: GICv4.1 architecture support
Date:   Sun, 27 Oct 2019 14:41:58 +0000
Message-Id: <20191027144234.8395-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rather long series expands the existing GICv4 support to deal with the
new GICv4.1 architecture, which comes with a set of major improvements
compared to v4.0:

- One architectural doorbell per vcpu, instead of one doorbell per VLPI

- Doorbell entirely managed by the HW, with an "at most once" delivery
  guarantee per non-residency phase and only when requested by the
  hypervisor

- A shared memory scheme between ITSs and redistributors, allowing for an
  optimised residency sequence (the use of VMOVP becomes less frequent)

- Support for direct virtual SGI delivery (the injection path still involves
  the hypervisor), at the cost of losing the active state on SGIs. It
  shouldn't be a big deal, but some guest operating systems might notice
  (Linux definitely won't care)

On the other hand, public documentation is not available yet, so that's a
bit annoying...

The series is roughly organised in 5 parts:

(1) A bunch of reworks to make the checking of some features more
    straightforward,
(2) VPE table allocation, new flavours of VMAPP/VMOVP commands
(3) v4.1 doorbell management
(4) Virtual SGI support
(5) Plumbing of virtual SGIs in KVM

Notes:

  - This series has uncovered a behaviour that looks like a HW bug on
    the Cavium ThunderX (aka TX1) platform (see patch #10). I'd very
    much welcome some clarification from the Marvell/Cavium folks on
    Cc, as well as an official erratum number if this happens to be an
    actual bug

  - I plan to take the first seven patches into 5.5 in order to reduce
    the size of the backlog:

    * patch #1 and #3 are good performance optimisations
    * patches #4 through to #7 are nice cleanups

    Do shout if you see any issue with this.

* From v1:
  - A bunch of minor reworks after Zenghui Yu's review
  - A workaround for what looks like a new and unexpected TX1 bug
  - A subtle reorder of the series so that some patches can go in early

Marc Zyngier (36):
  KVM: arm64: vgic-v4: Move the GICv4 residency flow to be driven by
    vcpu_load/put
  irqchip/gic-v3-its: Factor out wait_for_syncr primitive
  irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface
  irqchip/gic-v3-its: Make is_v4 use a TYPER copy
  irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
  irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead
  irqchip/gic-v3-its: Add get_vlpi_map() helper
  irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
  irqchip/gic-v3: Add GICv4.1 VPEID size discovery
  irqchip/gic-v3: Workaround Cavium TX1 erratum when reading GICD_TYPER2
  irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation
  irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP
  irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set
  irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
  irqchip/gic-v4.1: Plumb skeletal VPE irqchip
  irqchip/gic-v4.1: Add mask/unmask doorbell callbacks
  irqchip/gic-v4.1: Add VPE residency callback
  irqchip/gic-v4.1: Add VPE eviction callback
  irqchip/gic-v4.1: Add VPE INVALL callback
  irqchip/gic-v4.1: Suppress per-VLPI doorbell
  irqchip/gic-v4.1: Allow direct invalidation of VLPIs
  irqchip/gic-v4.1: Advertise support v4.1 to KVM
  irqchip/gic-v4.1: Map the ITS SGIR register page
  irqchip/gic-v4.1: Plumb skeletal VSGI irqchip
  irqchip/gic-v4.1: Add initial SGI configuration
  irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
  irqchip/gic-v4.1: Plumb get/set_irqchip_state SGI callbacks
  irqchip/gic-v4.1: Plumb set_vcpu_affinity SGI callbacks
  irqchip/gic-v4.1: Move doorbell management to the GICv4 abstraction
    layer
  irqchip/gic-v4.1: Add VSGI allocation/teardown
  irqchip/gic-v4.1: Add VSGI property setup
  irqchip/gic-v4.1: Eagerly vmap vPEs
  KVM: arm64: GICv4.1: Let doorbells be auto-enabled
  KVM: arm64: GICv4.1: Add direct injection capability to SGI registers
  KVM: arm64: GICv4.1: Configure SGIs as HW interrupts
  KVM: arm64: GICv4.1: Expose HW-based SGIs in debugfs

 arch/arm/include/asm/arch_gicv3.h      |    2 +
 arch/arm64/include/asm/arch_gicv3.h    |    1 +
 drivers/irqchip/irq-gic-v3-its.c       | 1102 +++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3.c           |   46 +-
 drivers/irqchip/irq-gic-v4.c           |  143 ++-
 include/kvm/arm_vgic.h                 |    5 +-
 include/linux/irqchip/arm-gic-common.h |    2 +
 include/linux/irqchip/arm-gic-v3.h     |   75 +-
 include/linux/irqchip/arm-gic-v4.h     |   45 +-
 virt/kvm/arm/arm.c                     |   12 +-
 virt/kvm/arm/vgic/vgic-debug.c         |   14 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c       |   15 +-
 virt/kvm/arm/vgic/vgic-mmio.c          |   88 +-
 virt/kvm/arm/vgic/vgic-v3.c            |    5 +
 virt/kvm/arm/vgic/vgic-v4.c            |  106 ++-
 virt/kvm/arm/vgic/vgic.c               |    4 -
 virt/kvm/arm/vgic/vgic.h               |    2 -
 17 files changed, 1492 insertions(+), 175 deletions(-)

-- 
2.20.1

