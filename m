Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6ABEBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392864AbfIZGFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 02:05:02 -0400
Received: from foss.arm.com ([217.140.110.172]:39644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392638AbfIZGEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:04:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46FC81570;
        Wed, 25 Sep 2019 23:04:12 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 579973F836;
        Wed, 25 Sep 2019 23:06:46 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 0/4] arm64: vdso32: Address various issues
Date:   Thu, 26 Sep 2019 07:03:49 +0100
Message-Id: <20190926060353.54894-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

this patch series is meant to address the various compilation issues you
reported about arm64 vdso32.

Please let me know if there is still something missing.

Thanks,
Vincenzo

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>

Vincenzo Frascino (4):
  arm64: vdso32: Introduce COMPAT_CC_IS_GCC
  arm64: vdso32: Detect binutils support for dmb ishld
  arm64: vdso32: Fix compilation warning
  arm64: Remove gettimeofday.S

 arch/arm64/Kconfig                           |  5 ++++-
 arch/arm64/Makefile                          | 15 ++-------------
 arch/arm64/include/asm/memory.h              |  5 +++++
 arch/arm64/include/asm/vdso/compat_barrier.h |  2 +-
 arch/arm64/kernel/vdso/gettimeofday.S        |  0
 arch/arm64/kernel/vdso32/Makefile            |  5 ++++-
 6 files changed, 16 insertions(+), 16 deletions(-)
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S

-- 
2.23.0

