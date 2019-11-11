Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F6F760E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 09:12:23 -0500
Received: from foss.arm.com ([217.140.110.172]:45768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKOMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:12:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4EB831B;
        Mon, 11 Nov 2019 06:12:22 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DDD83F534;
        Mon, 11 Nov 2019 06:12:21 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 0/2] arm64: Workaround for Cortex-A55 erratum 1530923
Date:   Mon, 11 Nov 2019 14:11:55 +0000
Message-Id: <20191111141157.55062-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables a workaround for Cortex-A55 erratum 1530923. The
erratum potentially allows TLB entries to be allocated as a result of a
speculative AT instruction. This may happen in the middle of a guest
world switch while the relevant VMSA configuration is in an inconsistent
state, leading to erroneous content being allocated into TLBs.

The existing workaround for Cortex-A76 erratum 1165522 is the same, so
the first patch renames this workaround to a generic name
(SPECULATIVE_AT), the second patch then adds the detection for the
Cortex-A55 erratum 1530923.

Steven Price (2):
  arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT
  arm64: Workaround for Cortex-A55 erratum 1530923

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 17 +++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  2 +-
 arch/arm64/include/asm/kvm_host.h      |  2 +-
 arch/arm64/include/asm/kvm_hyp.h       |  7 +++----
 arch/arm64/kernel/cpu_errata.c         | 23 ++++++++++++++++++-----
 arch/arm64/kvm/hyp/switch.c            |  6 +++---
 arch/arm64/kvm/hyp/tlb.c               |  8 ++++----
 8 files changed, 49 insertions(+), 18 deletions(-)

-- 
2.20.1

