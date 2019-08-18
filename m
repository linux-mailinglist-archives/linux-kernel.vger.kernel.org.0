Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F6915A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHRI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 04:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHRI5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 04:57:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979AE2086C;
        Sun, 18 Aug 2019 08:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566118655;
        bh=Cau3Zz0u//CNqaOJykdGGZACsGq53Wlpzy3o8VoJMVw=;
        h=Date:From:To:Cc:Subject:From;
        b=a/b1K59YgkKjSebjhBQH//McbvLtjsIJGvnkCHgHdrv3GI5DCNScQOkz446XSLr7c
         lHyaIp0QyVkKhsmy3srjaUJuxoLrwtDFWQtKdoYMQqc/GkCCWzTsI88/ReXmfqhiEm
         gGBQQPt1t3YhvCnjaFQcA81Di3F+FSS5mK2YqT+Q=
Date:   Sun, 18 Aug 2019 10:57:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.3-rc5
Message-ID: <20190818085732.GA28776@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc5

for you to fetch changes up to 9cd02b09a0f4439e5323c20b710331771c2b6341:

  Merge tag 'soundwire-5.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-linus (2019-08-16 12:35:56 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.3-rc5

Here are some small char and misc driver fixes for 5.3-rc5.

These are two different subsystems needing some fixes, the habanalabs
driver which is has some more big endian fixes for problems found.  The
other are some small soundwire fixes, including some Kconfig
dependencies needed to resolve reported build errors.

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ben Segal (3):
      habanalabs: fix endianness handling for packets from user
      habanalabs: fix completion queue handling when host is BE
      habanalabs: fix device IRQ unmasking for BE host

Greg Kroah-Hartman (2):
      Merge tag 'misc-habanalabs-fixes-2019-08-12' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'soundwire-5.3-rc5' of git://git.kernel.org/.../vkoul/soundwire into char-misc-linus

Oded Gabbay (1):
      habanalabs: fix endianness handling for internal QMAN submission

Pierre-Louis Bossart (3):
      soundwire: cadence_master: fix register definition for SLAVE_STATE
      soundwire: cadence_master: fix definitions for INTSTAT0/1
      soundwire: fix regmap dependencies and align with other serial links

Randy Dunlap (1):
      misc: xilinx-sdfec: fix dependency and build error

Tomer Tayar (2):
      habanalabs: Avoid double free in error flow
      habanalabs: fix DRAM usage accounting on context tear down

 drivers/base/regmap/Kconfig                        |  2 +-
 drivers/misc/Kconfig                               |  1 +
 drivers/misc/habanalabs/device.c                   |  5 +-
 drivers/misc/habanalabs/goya/goya.c                | 72 ++++++++++++++--------
 drivers/misc/habanalabs/goya/goyaP.h               |  2 +-
 drivers/misc/habanalabs/habanalabs.h               |  9 ++-
 drivers/misc/habanalabs/hw_queue.c                 | 14 ++---
 .../misc/habanalabs/include/goya/goya_packets.h    | 13 ++++
 drivers/misc/habanalabs/irq.c                      | 27 ++++----
 drivers/misc/habanalabs/memory.c                   |  2 +
 drivers/soundwire/Kconfig                          |  7 +--
 drivers/soundwire/Makefile                         |  2 +-
 drivers/soundwire/cadence_master.c                 |  8 +--
 13 files changed, 98 insertions(+), 66 deletions(-)
