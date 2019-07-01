Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE485BC4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGANCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 09:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:02:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2BD22146E;
        Mon,  1 Jul 2019 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561986136;
        bh=sItSBS86bM2QNimkExoFDOGOIdfJCF4iAiVQ1BjkyoE=;
        h=Date:From:To:Cc:Subject:From;
        b=EJFUkOTG3HOWhlO/+BTxJj3RFt0AwzSyh3aqBLlxVmMdH/OboCg8fgEftN+mX6Bbm
         Nzw1YnjEYn5H8T99SVPcXwxyNUFjXSlcAayBNmvZgib6frWVLYTryE480htoRoOa0B
         Zu2UaFQfQC32lqR1qQ9UzhVvlMx8jx2HMnOeioYY=
Date:   Mon, 1 Jul 2019 14:02:12 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org
Subject: [GIT PULL] arm64: fixes for 5.2
Message-ID: <20190701130212.ifn7d7p2mqvquq6u@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

When you get a chance, please can you pull these two arm64 fixes for 5.2?
They fix a build failure with the LLVM linker and a module allocation
failure when KASLR is active.

Thanks,

Will

--->8

The following changes since commit 615c48ad8f4275b4d39fa57df68d4015078be201:

  arm64/mm: don't initialize pgd_cache twice (2019-06-18 14:37:28 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to aa69fb62bea15126e744af2e02acc0d6cf3ed4da:

  arm64/efi: Mark __efistub_stext_offset as an absolute symbol explicitly (2019-06-26 11:40:20 +0100)

----------------------------------------------------------------
arm64 fixes for 5.2

- Fix module allocation when running with KASLR enabled

- Fix broken build due to bug in LLVM linker (ld.lld)

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: kaslr: keep modules inside module region when KASAN is enabled

Nathan Chancellor (1):
      arm64/efi: Mark __efistub_stext_offset as an absolute symbol explicitly

 arch/arm64/kernel/image.h  | 6 +++++-
 arch/arm64/kernel/module.c | 8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)
