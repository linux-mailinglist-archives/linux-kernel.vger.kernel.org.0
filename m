Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2864B9E23
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 15:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437949AbfIUNvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 09:51:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437919AbfIUNvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 09:51:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0419A1570;
        Sat, 21 Sep 2019 06:51:07 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C57413F67D;
        Sat, 21 Sep 2019 06:51:01 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v8 0/3] fix double page fault on arm64
Date:   Sat, 21 Sep 2019 21:50:51 +0800
Message-Id: <20190921135054.142360-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we tested pmdk unit test vmmalloc_fork TEST1 in arm64 guest, there
will be a double page fault in __copy_from_user_inatomic of cow_user_page.

As told by Catalin: "On arm64 without hardware Access Flag, copying from
user will fail because the pte is old and cannot be marked young. So we
always end up with zeroed page after fork() + CoW for pfn mappings. we
don't always have a hardware-managed access flag on arm64."

Changes
v8: change cow_user_page's return type (Matthew)
v7: s/pte_spinlock/pte_offset_map_lock (Kirill)
v6: fix error case of returning with spinlock taken (Catalin)
    move kmap_atomic to avoid handling kunmap_atomic
v5: handle the case correctly when !pte_same
    fix kbuild test failed
v4: introduce cpu_has_hw_af (Suzuki)
    bail out if !pte_same (Kirill)
v3: add vmf->ptl lock/unlock (Kirill A. Shutemov)
    add arch_faults_on_old_pte (Matthew, Catalin)
v2: remove FAULT_FLAG_WRITE when setting pte access flag (Catalin)

Jia He (3):
  arm64: cpufeature: introduce helper cpu_has_hw_af()
  arm64: mm: implement arch_faults_on_old_pte() on arm64
  mm: fix double page fault on arm64 if PTE_AF is cleared

 arch/arm64/include/asm/cpufeature.h | 10 +++++
 arch/arm64/include/asm/pgtable.h    | 12 ++++++
 mm/memory.c                         | 67 ++++++++++++++++++++++++++---
 3 files changed, 83 insertions(+), 6 deletions(-)

-- 
2.17.1

