Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B388B22
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHJLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 07:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfHJLxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:53:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4FE20880;
        Sat, 10 Aug 2019 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565437983;
        bh=ET+i5nnSXbSIdaHFhUwXEe4VzaNWa6TPUsmIiO0OrCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=kowEqam0QaS77JKii1yVnV3g449T5oTxsWIPGEQYWmYfbQp6bIGJ8dipQE4IyjYIs
         28X8q7ErSlBPktEhbcSfS1/7czt0IfpNoAae9wfvccq04eGUlseiQhjxKPDdhpOjZX
         0RmsxSdso4y7eP/VTM9AQFAsIZh3T46ZKTyEh27c=
Date:   Sat, 10 Aug 2019 13:53:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.3-rc4
Message-ID: <20190810115301.GA6047@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc4

for you to fetch changes up to 8097c43bcbec56fbd0788d99e1e236c0e0d4013f:

  Revert "kernfs: fix memleak in kernel_ops_readdir()" (2019-08-08 08:39:35 +0200)

----------------------------------------------------------------
Driver core fixes for 5.3-rc4

Here are 2 small fixes for some driver core issues that have been
reported.  There is also a kernfs "fix" here, which was then reverted
because it was found to cause problems in linux-next.

The driver core fixes both resolve reported issues, one with gpioint
stuff that showed up in 5.3-rc1, and the other finally (and hopefully)
resolves a very long standing race when removing glue directories.  It's
nice to get that issue finally resolved and the developers involved
should be applauded for the persistence it took to get this patch
finally accepted.

All of these have been in linux-next for a while with no reported
issues.  Well, the one reported issue, hence the revert :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrea Arcangeli (1):
      kernfs: fix memleak in kernel_ops_readdir()

Brian Norris (1):
      driver core: platform: return -ENXIO for missing GpioInt

Greg Kroah-Hartman (1):
      Revert "kernfs: fix memleak in kernel_ops_readdir()"

Muchun Song (1):
      driver core: Fix use-after-free and double free on glue directory

 drivers/base/core.c     | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/base/platform.c |  9 +++++++--
 2 files changed, 59 insertions(+), 3 deletions(-)
