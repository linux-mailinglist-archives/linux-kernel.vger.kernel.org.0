Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B0733B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGXQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:25:48 -0400
Received: from foss.arm.com ([217.140.110.172]:43326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfGXQZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:25:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3172428;
        Wed, 24 Jul 2019 09:25:47 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B58EA3F71F;
        Wed, 24 Jul 2019 09:25:45 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 00/15] kvm/arm: Align the VMID allocation with the arm64 ASID one
Date:   Wed, 24 Jul 2019 17:25:19 +0100
Message-Id: <20190724162534.7390-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series is moving out the ASID allocator in a separate file in order
to re-use it for the VMID. The benefits are:
    - CPUs are not forced to exit on a roll-over.
    - Context invalidation is now per-CPU rather than
      broadcasted.

There are no performance regression on the fastpath for ASID allocation.
Actually on the hackbench measurement (300 hackbench) it was .7% faster.

The measurement was made on a Seattle based SoC (8 CPUs), with the
number of VMID limited to 4-bit. The test involves running concurrently 40
guests with 2 vCPUs. Each guest will then execute hackbench 5 times
before exiting.

The performance difference (on 5.1-rc1) between the current algo and the
new one are:
    - 2.5% less exit from the guest
    - 22.4% more flush, although they are now local rather than broadcasted
    - 0.11% faster (just for the record)

The ASID allocator rework to make it generic has been divided in multiple
patches to make the review easier.

A branch with the patch based on 5.3-rc1 can be found:

http://xenbits.xen.org/gitweb/?p=people/julieng/linux-arm.git;a=shortlog;h=refs/heads/vmid-rework/v3

For all the changes see in each patch.

Best regards,

Cc: Russell King <linux@armlinux.org.uk>

Julien Grall (15):
  arm64/mm: Introduce asid_info structure and move
    asid_generation/asid_map to it
  arm64/mm: Move active_asids and reserved_asids to asid_info
  arm64/mm: Move bits to asid_info
  arm64/mm: Move the variable lock and tlb_flush_pending to asid_info
  arm64/mm: Remove dependency on MM in new_context
  arm64/mm: Store the number of asid allocated per context
  arm64/mm: Introduce NUM_ASIDS
  arm64/mm: Split asid_inits in 2 parts
  arm64/mm: Split the function check_and_switch_context in 3 parts
  arm64/mm: Introduce a callback to flush the local context
  arm64: Move the ASID allocator code in a separate file
  arm64/lib: Add an helper to free memory allocated by the ASID
    allocator
  arm/kvm: Introduce a new VMID allocator
  arch/arm64: Introduce a capability to tell whether 16-bit VMID is
    available
  kvm/arm: Align the VMID allocation with the arm64 ASID one

 arch/arm/include/asm/kvm_asm.h    |   2 +-
 arch/arm/include/asm/kvm_host.h   |   5 +-
 arch/arm/include/asm/kvm_hyp.h    |   1 +
 arch/arm/include/asm/kvm_mmu.h    |   3 +-
 arch/arm/include/asm/lib_asid.h   |  79 +++++++++++++++
 arch/arm/kvm/Makefile             |   1 +
 arch/arm/kvm/hyp/tlb.c            |   8 +-
 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/kvm_asid.h |   8 ++
 arch/arm64/include/asm/kvm_asm.h  |   2 +-
 arch/arm64/include/asm/kvm_host.h |   5 +-
 arch/arm64/include/asm/kvm_mmu.h  |   7 +-
 arch/arm64/include/asm/lib_asid.h |  79 +++++++++++++++
 arch/arm64/kernel/cpufeature.c    |   9 ++
 arch/arm64/kvm/hyp/tlb.c          |  10 +-
 arch/arm64/lib/Makefile           |   2 +
 arch/arm64/lib/asid.c             | 190 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/context.c           | 200 +++++---------------------------------
 virt/kvm/arm/arm.c                | 125 +++++++++---------------
 19 files changed, 458 insertions(+), 281 deletions(-)
 create mode 100644 arch/arm/include/asm/lib_asid.h
 create mode 100644 arch/arm64/include/asm/kvm_asid.h
 create mode 100644 arch/arm64/include/asm/lib_asid.h
 create mode 100644 arch/arm64/lib/asid.c

-- 
2.11.0

