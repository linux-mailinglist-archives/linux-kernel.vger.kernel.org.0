Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2EFDC81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 12:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfKOLq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 06:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfKOLq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:46:28 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9892072D;
        Fri, 15 Nov 2019 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573818388;
        bh=0ghNXRxv0XQeQoTUBbtxGBMNkhSqvp2R6oRI3ThRTFY=;
        h=Date:From:To:Cc:Subject:From;
        b=T0MLys2PWf3E9IxL9JNS4kd1xgRhpnnkT5AK7kZyYHiMYj9LZ9U76dsuvoqMRp8VS
         UaRpzT4yEF60waHyxcMGDqTL6eyEUyIqaIbyB/tjJ4o0b57ujUQiZMg/3q8fX/aayf
         5iVGojPoXcT+GHRX63/0C3jg3fXYvgSU9f9aCDKc=
Date:   Fri, 15 Nov 2019 11:46:24 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arm64: Fix for -rc8 / final
Message-ID: <20191115114622.GA12198@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this one trivial fix for -rc8/final that ensures that the
script used to detect RELR relocation support in the toolchain works
correctly when $CC contains quotes. Although it fails safely (by failing
to detect the support when it exists), it would be nice to have this
fixed in 5.4 given that it was only introduced in the last merge window.

Thanks,

Will

--->8

The following changes since commit 6767df245f4736d0cf0c6fb7cf9cf94b27414245:

  arm64: Do not mask out PTE_RDONLY in pte_same() (2019-11-06 19:31:56 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 65e1f38d9a2f07d4b81f369864c105880e47bd5a:

  scripts/tools-support-relr.sh: un-quote variables (2019-11-13 10:52:05 +0000)

----------------------------------------------------------------
arm64 fix for -rc8 / final

- Handle CC variables containing quotes in tools-support-relr.sh script

----------------------------------------------------------------
Ilie Halip (1):
      scripts/tools-support-relr.sh: un-quote variables

 scripts/tools-support-relr.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

