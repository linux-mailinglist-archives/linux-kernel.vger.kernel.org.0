Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824C288B23
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 13:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHJLxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 07:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfHJLxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A83820880;
        Sat, 10 Aug 2019 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565438001;
        bh=RTxFcDGRuo9WwvrVI5Z4lmShg90Vt3TyIjB2eQYIJ/E=;
        h=Date:From:To:Cc:Subject:From;
        b=bX9F6B2p+lm8yF8IIfXELRlCbPddXbpcvV6RtSDAjX1UY5rtnws/a8ckcqCYuQ4+y
         i2hLgpo577aw+zIlSVNWN2vOiJo5JzdJDNUHZnqBAO17Hek3BkphL4FNMJgBMkRoI6
         Jb+APAv8dAfqFeDJ9UdZcNeAZ541mJrQkZ8rIBOo=
Date:   Sat, 10 Aug 2019 13:53:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.3-rc4
Message-ID: <20190810115318.GA6103@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc4

for you to fetch changes up to 5511c0c309db4c526a6e9f8b2b8a1483771574bc:

  coresight: Fix DEBUG_LOCKS_WARN_ON for uninitialized attribute (2019-08-01 20:51:34 +0200)

----------------------------------------------------------------
Char/misc fixes for 5.3-rc4

Here are some small char/misc driver fixes for 5.3-rc4.

Two of these are for the habanalabs driver for issues found when running
on a big-endian system (are they still alive?)  The others are tiny
fixes reported by people, and a MAINTAINERS update about the location of
the fpga development tree.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ben Segal (2):
      habanalabs: fix F/W download in BE architecture
      habanalabs: fix host memory polling in BE architecture

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2019-07-29' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next

Jean Delvare (1):
      nvmem: Use the same permissions for eeprom as for nvmem

Moritz Fischer (1):
      MAINTAINERS: Move linux-fpga tree to new location

Suzuki K Poulose (1):
      coresight: Fix DEBUG_LOCKS_WARN_ON for uninitialized attribute

 MAINTAINERS                                      |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c |  1 +
 drivers/misc/habanalabs/command_submission.c     |  2 +-
 drivers/misc/habanalabs/firmware_if.c            | 22 ++++------------------
 drivers/misc/habanalabs/goya/goya.c              |  5 +++--
 drivers/misc/habanalabs/habanalabs.h             | 16 ++++++++++++++--
 drivers/nvmem/nvmem-sysfs.c                      | 15 +++++++++++----
 7 files changed, 35 insertions(+), 28 deletions(-)
