Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E642C127643
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLTHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfLTHIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:08:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF0F2467F;
        Fri, 20 Dec 2019 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576825725;
        bh=3ob1RaqJHOmqEgGvlMWw3bXiCPnw8pblxB/VDlM2ax4=;
        h=Date:From:To:Cc:Subject:From;
        b=gpYGlX+7dgXiUsMDLkmaEREbx+klJdtAT9Pve3xR12bZNWQVxK3mkWXPWaXIMm5MP
         IzNsvxlhetV+mYHwyfe71v6AueJR85Brqogrp6byHbEDPe6F2BuLXjBwntc8NgFgvV
         0nrNLb56dY0eCVR7TYa/2IPwaowOKVjiVksjx768=
Date:   Fri, 20 Dec 2019 08:08:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.5-rc3
Message-ID: <20191220070843.GA2190439@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc3

for you to fetch changes up to 4aa37c463764052c68c5c430af2a67b5d784c1e0:

  random: don't forget compat_ioctl on urandom (2019-12-17 19:19:24 +0100)

----------------------------------------------------------------
Char/misc driver fixes for 5.5-rc3

Here are some small char and other driver fixes for 5.5-rc3.

The most noticable one is a much-reported fix for a random driver issue
that came up from 5.5-rc1 compat_ioctl cleanups.  The others are a chunk
of habanalab driver fixes and intel_th driver fixes and new device ids.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (4):
      intel_th: pci: Add Comet Lake PCH-V support
      intel_th: pci: Add Elkhart Lake SOC support
      intel_th: Fix freeing IRQs
      intel_th: msu: Fix window switching without windows

Chen Wandun (1):
      habanalabs: remove variable 'val' set but not used

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2019-12-14' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus

Jason A. Donenfeld (1):
      random: don't forget compat_ioctl on urandom

Oded Gabbay (1):
      habanalabs: rate limit error msg on waiting for CS

 drivers/char/random.c                        |  1 +
 drivers/hwtracing/intel_th/core.c            |  7 ++++---
 drivers/hwtracing/intel_th/intel_th.h        |  2 ++
 drivers/hwtracing/intel_th/msu.c             | 14 +++++++++-----
 drivers/hwtracing/intel_th/pci.c             | 10 ++++++++++
 drivers/misc/habanalabs/command_submission.c |  5 +++--
 drivers/misc/habanalabs/context.c            |  2 +-
 drivers/misc/habanalabs/goya/goya.c          | 15 +++++++--------
 8 files changed, 37 insertions(+), 19 deletions(-)
