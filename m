Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF3906C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfHPRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:24:17 -0400
Received: from foss.arm.com ([217.140.110.172]:59374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfHPRYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:24:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E2D28;
        Fri, 16 Aug 2019 10:24:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EE173F694;
        Fri, 16 Aug 2019 10:24:15 -0700 (PDT)
Date:   Fri, 16 Aug 2019 18:24:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.3-rc5
Message-ID: <20190816172411.GA36979@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 30e235389faadb9e3d918887b1f126155d7d761d:

  arm64: mm: add missing PTE_SPECIAL in pte_mkdevmap on arm64 (2019-08-08 18:38:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b6143d10d23ebb4a77af311e8b8b7f019d0163e6:

  arm64: ftrace: Ensure module ftrace trampoline is coherent with I-side (2019-08-16 17:40:03 +0100)

----------------------------------------------------------------
arm64 fixes:

- Don't taint the kernel if CPUs have different sets of page sizes
  supported (other than the one in use).

- Issue I-cache maintenance for module ftrace trampoline.

----------------------------------------------------------------
Will Deacon (2):
      arm64: cpufeature: Don't treat granule sizes as strict
      arm64: ftrace: Ensure module ftrace trampoline is coherent with I-side

 arch/arm64/kernel/cpufeature.c | 14 +++++++++++---
 arch/arm64/kernel/ftrace.c     | 22 +++++++++++++---------
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
Catalin
