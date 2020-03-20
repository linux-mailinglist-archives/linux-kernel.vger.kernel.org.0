Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D882518D2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCTPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgCTPfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:35:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426E92070A;
        Fri, 20 Mar 2020 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584718513;
        bh=vokPQstkXgxFr5sGvZb+kbRNuePjovDVn9LKFBHtdTU=;
        h=Date:From:To:Cc:Subject:From;
        b=vMrRyUwZhI0GQyf9cX14oERx/4NHSInVqyycNzifFRO5h2V0OM2y3AndeLrPB7FWm
         L7Zp6bzwXnwRJVAZNST4hxltuPzShB9u6TZUOf9xEFmw1JYNTqXcSReZrR4KliM7fT
         e5qIlOOraCDg2qFeCDEqaqgyMxOjL4yDDi3QAUIY=
Date:   Fri, 20 Mar 2020 15:35:09 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, catalin.marinas@arm.com
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20200320153508.GA6815@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these four arm64 fixes for -rc7. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 9abd515a6e4a5c58c6eb4d04110430325eb5f5ac:

  arm64: context: Fix ASID limit in boot messages (2020-03-02 12:10:38 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3568b88944fef28db3ee989b957da49ffc627ede:

  arm64: compat: Fix syscall number of compat_clock_getres (2020-03-19 19:23:46 +0000)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix panic() when it occurs during secondary CPU startup

- Fix "kpti=off" when KASLR is enabled

- Fix howler in compat syscall table for vDSO clock_getres() fallback

----------------------------------------------------------------
Cristian Marussi (2):
      arm64: smp: fix smp_send_stop() behaviour
      arm64: smp: fix crash_smp_send_stop() behaviour

Vincenzo Frascino (1):
      arm64: compat: Fix syscall number of compat_clock_getres

Will Deacon (1):
      arm64: kpti: Fix "kpti=off" when KASLR is enabled

 arch/arm64/include/asm/mmu.h          |  4 +---
 arch/arm64/include/asm/pgtable-prot.h |  6 ++++--
 arch/arm64/include/asm/unistd.h       |  2 +-
 arch/arm64/kernel/smp.c               | 25 ++++++++++++++++++++-----
 4 files changed, 26 insertions(+), 11 deletions(-)

