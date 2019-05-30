Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265462FFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfE3QLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 12:11:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfE3QLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:11:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4FF9341;
        Thu, 30 May 2019 09:11:29 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94B503F5AF;
        Thu, 30 May 2019 09:11:28 -0700 (PDT)
Date:   Thu, 30 May 2019 17:11:26 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ebiederm@xmission.com
Subject: [GIT PULL] arm64: fixes for -rc3
Message-ID: <20190530161126.GB16230@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The fixes are still trickling in for arm64, but the only really significant
one here is actually fixing a regression in the botched module relocation
range checking merged for -rc2. Hopefully we've nailed it this time.

Please pull.

Thanks,

Will

--->8

The following changes since commit edbcf50eb8aea5f81ae6d83bb969cb0bc02805a1:

  arm64: insn: Add BUILD_BUG_ON() for invalid masks (2019-05-24 14:58:30 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 1e29ab3186e33c77dbb2d7566172a205b59fa390:

  arm64: use the correct function type for __arm64_sys_ni_syscall (2019-05-29 13:46:00 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix implementation of our set_personality() system call, which wasn't
  being wrapped properly

- Fix system call function types to keep CFI happy

- Fix siginfo layout when delivering SIGKILL after a kernel fault

- Really fix module relocation range checking

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/module: revert to unsigned interpretation of ABS16/32 relocations

Catalin Marinas (1):
      arm64: Fix the arm64_personality() syscall wrapper redirection

Eric W. Biederman (1):
      signal/arm64: Use force_sig not force_sig_fault for SIGKILL

Sami Tolvanen (3):
      arm64: fix syscall_fn_t type
      arm64: use the correct function type in SYSCALL_DEFINE0
      arm64: use the correct function type for __arm64_sys_ni_syscall

 arch/arm64/include/asm/syscall.h         |  2 +-
 arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++--------
 arch/arm64/kernel/module.c               | 38 +++++++++++++++++++++++++-------
 arch/arm64/kernel/sys.c                  | 16 +++++++++-----
 arch/arm64/kernel/sys32.c                |  7 ++----
 arch/arm64/kernel/traps.c                |  5 ++++-
 6 files changed, 56 insertions(+), 30 deletions(-)

