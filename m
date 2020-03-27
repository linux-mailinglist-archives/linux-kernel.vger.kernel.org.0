Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88980195923
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 15:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0OhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 10:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC0OhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:37:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0EA8206F2;
        Fri, 27 Mar 2020 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585319820;
        bh=YhxnLqESn5OJ6l0aP2+/xsbNdof7w2zmwZVpw4YJjhw=;
        h=Date:From:To:Cc:Subject:From;
        b=D82neLNeNnF3peNxO19ARovHHuLJ9IodxxTi6bsXOLbUBSgw4ETNpQKrqo+q8ZsGf
         crI556YvCMFcQ1Sl2EFLg8stV1+3ATz7PGifB7DHuq4sRLGXkdGGytvr/JVekh6deA
         4whECf7biyLTmVDqXReD58xnloZHqGNqecg68Zgk=
Date:   Fri, 27 Mar 2020 14:36:56 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fix for -rc8/final
Message-ID: <20200327143655.GA6205@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this arm64 fix for 5.6-rc8/final to resolve a defconfig build
failure when using Clang's integrated assembler.

Cheers,

Will

--->8

The following changes since commit 3568b88944fef28db3ee989b957da49ffc627ede:

  arm64: compat: Fix syscall number of compat_clock_getres (2020-03-19 19:23:46 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 6f5459da2b8736720afdbd67c4bd2d1edba7d0e3:

  arm64: alternative: fix build with clang integrated assembler (2020-03-20 10:01:28 +0000)

----------------------------------------------------------------
arm64 fix for -rc8/final

- Fix defconfig build when using Clang's integrated assembler

----------------------------------------------------------------
Ilie Halip (1):
      arm64: alternative: fix build with clang integrated assembler

 arch/arm64/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
