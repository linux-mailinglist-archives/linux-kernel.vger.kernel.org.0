Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231A217C164
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCFPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 10:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgCFPMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:12:25 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940DD2073D;
        Fri,  6 Mar 2020 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583507544;
        bh=UQeODx1wp4BqMIAVR0zSKtHv0AGBddff2t3nWTesA/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=pd7TM5m2KanjZIsnsLqrg9eMqY3ne2LV//mj+WvBitRL8KIXd6ZZ9VVJyuIB+TXFq
         P17sMqLIUcDHmvAggDqk5OWRrXI5Dz9OdKVLvl39inxQ8S5EpolX+jtRt4uISOgRsj
         sQQX4Vta4BhX8TWpq2ctuXPO/0MDGURYrWrGufiA=
Date:   Fri, 6 Mar 2020 15:12:20 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, catalin.marinas@arm.com
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20200306151219.GA8409@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are another three arm64 fixes for 5.6. Summary in the tag, but all
pretty minor. Main thing is fixing a silly bug in the fsl_imx8_ddr PMU
driver where we would zero the counters when disabling them.

Please pull.

Will

--->8

The following changes since commit dcde237319e626d1ec3c9d8b7613032f0fd4663a:

  mm: Avoid creating virtual address aliases in brk()/mmap()/mremap() (2020-02-20 10:03:14 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 9abd515a6e4a5c58c6eb4d04110430325eb5f5ac:

  arm64: context: Fix ASID limit in boot messages (2020-03-02 12:10:38 +0000)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix misreporting of ASID limit when KPTI is enabled

- Fix busted NULL pointer checks for GICC structure in ACPI PMU code

- Avoid nobbling the "fsl_imx8_ddr" PMU counters when disabling them

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      arm64: context: Fix ASID limit in boot messages

Joakim Zhang (1):
      drivers/perf: fsl_imx8_ddr: Correct the CLEAR bit definition

luanshi (1):
      drivers/perf: arm_pmu_acpi: Fix incorrect checking of gicc pointer

 arch/arm64/mm/context.c          | 20 +++++++++++++++-----
 drivers/perf/arm_pmu_acpi.c      |  7 ++-----
 drivers/perf/fsl_imx8_ddr_perf.c | 10 ++++++----
 3 files changed, 23 insertions(+), 14 deletions(-)
