Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF9137851
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgAJVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAJVIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:08:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4BF205F4;
        Fri, 10 Jan 2020 21:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578690532;
        bh=krz+Fo5CPvIpRgDBbneffb9nEQaQF58cdZqCforIrgw=;
        h=Date:From:To:Cc:Subject:From;
        b=gV2PEgKO52NCP6Mw47gjwxK8z46YcxMCSkwFpdqXy6BHma9YwS09HXhibEolPNx5h
         OBo7bs4D3XjIAtKZeKmw0Nlba01xYcU7ZAHaBRvVxf0hf0x8zcbGVwzabjSvnR6Ewp
         kP6yH4bpXyoc6oZ4ngdDHfazRoaWNOep7Ak1oMpw=
Date:   Fri, 10 Jan 2020 22:08:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.5-rc6
Message-ID: <20200110210850.GA1871133@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc6

for you to fetch changes up to 58dcc5bf4030cab548d5c98cd4cd3632a5444d5a:

  staging: rtl8188eu: Add device code for TP-Link TL-WN727N v5.21 (2020-01-03 11:47:00 +0100)

----------------------------------------------------------------
Staging fixes for 5.5-rc6

Here are some small staging driver fixes for 5.5-rc6.

Nothing major here, just some small fixes for a comedi driver, the
vt6656 driver, and a new device id for the rtl8188eu driver.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ian Abbott (1):
      staging: comedi: adv_pci1710: fix AI channels 16-31 for PCI-1713

Malcolm Priestley (5):
      staging: vt6656: Fix non zero logical return of, usb_control_msg
      staging: vt6656: correct return of vnt_init_registers.
      staging: vt6656: limit reg output to block size
      staging: vt6656: remove bool from vnt_radio_power_on ret
      staging: vt6656: set usb_set_intfdata on driver fail.

Michael Straube (1):
      staging: rtl8188eu: Add device code for TP-Link TL-WN727N v5.21

 drivers/staging/comedi/drivers/adv_pci1710.c |  4 ++--
 drivers/staging/rtl8188eu/os_dep/usb_intf.c  |  1 +
 drivers/staging/vt6656/baseband.c            |  4 ++--
 drivers/staging/vt6656/card.c                |  2 +-
 drivers/staging/vt6656/device.h              |  1 +
 drivers/staging/vt6656/main_usb.c            |  3 ++-
 drivers/staging/vt6656/usbpipe.c             | 25 +++++++++++++++++++++++--
 drivers/staging/vt6656/usbpipe.h             |  5 +++++
 drivers/staging/vt6656/wcmd.c                |  1 +
 9 files changed, 38 insertions(+), 8 deletions(-)
