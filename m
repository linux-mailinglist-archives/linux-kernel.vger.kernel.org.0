Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B6138FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 12:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 06:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMLNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:13:31 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F4B207E0;
        Mon, 13 Jan 2020 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578914010;
        bh=2dNo0A03VcIFSZvSVz5n249R91p3bkLWCwPae+CNXW0=;
        h=From:To:Cc:Subject:Date:From;
        b=IX+5b6/zaFTN4DBWq29kUL2XqxChB0YlXW59APXI9VbSvWpxMI2golVWfmN/xTNmw
         Gkv83m0zbhQ9eU2BPnGjQS2cDCExIFz4OeE/q2lCt70MQii1SemUn7XwSlV3Rr6HSs
         gJ1ol+7k77BtPl5GR2FLBxueLQnjS+tB6XbfrcLg=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
Date:   Mon, 13 Jan 2020 13:13:22 +0200
Message-Id: <20200113111323.10463-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is a part of clean up of the page table manipulation code that aims to
remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h

There is a single patch for both arm and arm64 because doing the conversion
separately would mean breaking the shared mmu bits in virt/kvm/arm.

v2:
* fix build error for arch/arm64/mm/dump.c
* simplify p4d unfolding in arch/arm64/mm/kasan_init.c

Mike Rapoport (1):
  arm/arm64: add support for folded p4d page tables

 arch/arm/include/asm/kvm_mmu.h          |   5 +-
 arch/arm/include/asm/pgtable.h          |   1 -
 arch/arm/include/asm/stage2_pgtable.h   |  15 +-
 arch/arm/lib/uaccess_with_memcpy.c      |   9 +-
 arch/arm/mach-sa1100/assabet.c          |   2 +-
 arch/arm/mm/dump.c                      |  29 +++-
 arch/arm/mm/fault-armv.c                |   7 +-
 arch/arm/mm/fault.c                     |  28 +++-
 arch/arm/mm/idmap.c                     |   3 +-
 arch/arm/mm/init.c                      |   2 +-
 arch/arm/mm/ioremap.c                   |  12 +-
 arch/arm/mm/mm.h                        |   2 +-
 arch/arm/mm/mmu.c                       |  35 +++-
 arch/arm/mm/pgd.c                       |  40 ++++-
 arch/arm64/include/asm/kvm_mmu.h        |  10 +-
 arch/arm64/include/asm/pgalloc.h        |  10 +-
 arch/arm64/include/asm/pgtable-types.h  |   5 +-
 arch/arm64/include/asm/pgtable.h        |  37 +++--
 arch/arm64/include/asm/stage2_pgtable.h |  48 ++++--
 arch/arm64/kernel/hibernate.c           |  46 +++++-
 arch/arm64/mm/dump.c                    |  29 +++-
 arch/arm64/mm/fault.c                   |   9 +-
 arch/arm64/mm/hugetlbpage.c             |  15 +-
 arch/arm64/mm/kasan_init.c              |  26 ++-
 arch/arm64/mm/mmu.c                     |  52 ++++--
 arch/arm64/mm/pageattr.c                |   7 +-
 virt/kvm/arm/mmu.c                      | 209 ++++++++++++++++++++----
 27 files changed, 550 insertions(+), 143 deletions(-)

-- 
2.24.0

