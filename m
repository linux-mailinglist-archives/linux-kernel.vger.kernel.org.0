Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1914B446
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 13:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgA1Mjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 07:39:32 -0500
Received: from foss.arm.com ([217.140.110.172]:56236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1Mjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:39:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1BDB101E;
        Tue, 28 Jan 2020 04:39:31 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E8FE3F52E;
        Tue, 28 Jan 2020 04:39:27 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
Date:   Tue, 28 Jan 2020 18:09:03 +0530
Message-Id: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is primarily motivated from an adhoc list from Mark Rutland
during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
which does macro replacement for various open bits shift encodings in
various CPU ID registers. This series is based on linux-next 20200124.

[1] https://patchwork.kernel.org/patch/11287805/

Is there anything else apart from these changes which can be accommodated
in this series, please do let me know. Thank you.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  arm64/cpufeature: Introduce ID_PFR2 CPU register
  arm64/cpufeature: Add DIT and CSV2 feature bits in ID_PFR0 register
  arm64/cpufeature: Add remaining feature bits in ID_MMFR4 register
  arm64/cpufeature: Define an explicit ftr_id_isar0[] for ID_ISAR0 register
  arm64/cpufeature: Drop TraceFilt feature exposure from ID_DFR0 register
  arm64/cpufeature: Replace all open bits shift encodings with macros

 arch/arm64/include/asm/cpu.h    |  1 +
 arch/arm64/include/asm/sysreg.h | 51 +++++++++++++++++++
 arch/arm64/kernel/cpufeature.c  | 87 ++++++++++++++++++++++-----------
 arch/arm64/kernel/cpuinfo.c     |  1 +
 arch/arm64/kvm/sys_regs.c       |  2 +-
 5 files changed, 112 insertions(+), 30 deletions(-)

-- 
2.20.1

