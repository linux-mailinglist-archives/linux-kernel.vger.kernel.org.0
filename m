Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D460332261
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFBHRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 03:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFBHRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 03:17:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E51227733;
        Sun,  2 Jun 2019 06:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559457548;
        bh=O+3+OXsUykY6xtILDT723jPRKJIi/7RvARHMb53RRzI=;
        h=Date:From:To:Cc:Subject:From;
        b=bVDLlnKXdeOxpN00HkTCvXVd1RNVJsqhgWQUPNO+kmptrFPFoDSvgmQy6RJdj5zHb
         oxXabYrokmQSZOR68dcL+z/h96MbbLp87KGcslYQj/BOxwZqyYNcEjXstI781x0vJr
         qjz/RLVOFlYPVzHiKwCQ+gVxTKzJevc+GI4B8jvg=
Date:   Sun, 2 Jun 2019 08:39:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX update for 5.2-rc3 - round 2
Message-ID: <20190602063905.GA14513@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2f4c53349961c8ca480193e47da4d44fdb8335a8:

  Merge tag 'spdx-5.2-rc3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2019-05-31 08:34:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-2

for you to fetch changes up to 8e82fe2ab65a80b1526b285c661ab88cc5891e3a:

  treewide: fix typos of SPDX-License-Identifier (2019-06-01 18:29:58 +0200)

----------------------------------------------------------------
SPDX fixes for 5.2-rc3, round 2

Here are just two small patches, that fix up some found SPDX identifier
issues.

The first patch fixes an error in a previous SPDX fixup patch, that
causes build errors when doing 'make clean' on the tree (the fact that
almost no one noticed it reflects the fact that kernel developers don't
like doing that option very often...)

The second patch fixes up a number of places in the tree where people
mistyped the string "SPDX-License-Identifier".  Given that people can
not even type their own name all the time without mistakes, this was
bound to happen, and odds are, we will have to add some type of check
for this to checkpatch.pl to catch this happening in the future.

Both of these have passed testing by 0-day.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alex Xu (Hello71) (1):
      crypto: ux500 - fix license comment syntax error

Masahiro Yamada (1):
      treewide: fix typos of SPDX-License-Identifier

 arch/arm/kernel/bugs.c                | 2 +-
 drivers/crypto/ux500/cryp/Makefile    | 2 +-
 drivers/phy/st/phy-stm32-usbphyc.c    | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c | 2 +-
 lib/test_stackinit.c                  | 2 +-
 sound/soc/codecs/max9759.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
