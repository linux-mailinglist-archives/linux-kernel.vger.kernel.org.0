Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634FD25682
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfEURVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 13:21:53 -0400
Received: from foss.arm.com ([217.140.101.70]:39086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfEURVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:21:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B619F15A2;
        Tue, 21 May 2019 10:21:52 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4BC3F718;
        Tue, 21 May 2019 10:21:50 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v5 0/3] arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state
Date:   Tue, 21 May 2019 18:21:36 +0100
Message-Id: <20190521172139.21277-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series keeps softirqs enabled while touching FPSIMD/SVE state.
For more details on the impact see patch #3.

This patch series has been benchmarked on Linux 5.1-rc4 with defconfig.

On Juno2:
    * hackbench 100 process 1000 (10 times)
    * .7% quicker

On ThunderX 2:
    * hackbench 1000 process 1000 (20 times)
    * 3.4% quicker

Note that while the benchmark has been done on 5.1-rc4, the patch series is
based on 5.2-rc1.

Cheers,

Julien Grall (3):
  arm64/fpsimd: Remove the prototype for sve_flush_cpu_state()
  arch/arm64: fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and
    use it
  arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state

 arch/arm64/include/asm/fpsimd.h |   5 +-
 arch/arm64/include/asm/simd.h   |  10 +--
 arch/arm64/kernel/fpsimd.c      | 139 +++++++++++++++++++++++++++-------------
 arch/arm64/kvm/fpsimd.c         |   4 +-
 4 files changed, 103 insertions(+), 55 deletions(-)

-- 
2.11.0

