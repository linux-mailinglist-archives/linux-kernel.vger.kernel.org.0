Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7477F54
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfG1L7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 07:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfG1L7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:59:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515472075E;
        Sun, 28 Jul 2019 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564315170;
        bh=WJlyT460EUhNGiA4JYlmJGNUH6qou2CmDkk/ihQx9VQ=;
        h=Date:From:To:Cc:Subject:From;
        b=U+J333FIPz72+jSZ1pALhyx0ZODwaUyQqKuiSPjeP7LBclmjy9FQmXptP6Od1qBEV
         BFoxv9m4/A7TVQwQKFK1NU4LGSc6BWVu3PJRR/yLYhWQx97gYRVGrP8x7LIYhd2pwe
         M9fePhOYVr5Rvr+uS3TtBCdPDaqx/Ma8Dy4qCThw=
Date:   Sun, 28 Jul 2019 13:59:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.3-rc2
Message-ID: <20190728115928.GA15888@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc2

for you to fetch changes up to d39b5bad8658d6d94cb2d98a44a7e159db4f5030:

  xhci: Fix crash if scatter gather is used with Immediate Data Transfer (IDT). (2019-07-25 11:26:42 +0200)

----------------------------------------------------------------
USB fixes for 5.3-rc2

Here are some small fixes for 5.3-rc2.  All of these resolve some
reported issues, some more than others :)

Included in here is:
	- xhci fix for an annoying issue with odd devices
	- reversion of some usb251xb patches that should not have been
	  merged
	- usb pci quirk additions and fixups
	- usb storage fix
	- usb host controller error test fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      usb/hcd: Fix a NULL vs IS_ERR() bug in usb_hcd_setup_local_mem()

Lucas Stach (3):
      Revert "usb: usb251xb: Add US lanes inversion dts-bindings"
      Revert "usb: usb251xb: Add US port lanes inversion property"
      usb: usb251xb: Reallow swap-dx-lanes to apply to the upstream port

Mathias Nyman (1):
      xhci: Fix crash if scatter gather is used with Immediate Data Transfer (IDT).

Phong Tran (1):
      usb: wusbcore: fix unbalanced get/put cluster_id

Ryan Kennedy (2):
      usb: pci-quirks: Correct AMD PLL quirk detection
      usb: pci-quirks: Minor cleanup for AMD PLL quirk

Yoshihiro Shimoda (1):
      usb-storage: Add a limitation for blk_queue_max_hw_sectors()

 Documentation/devicetree/bindings/usb/usb251xb.txt |  6 +--
 drivers/usb/core/hcd.c                             |  4 +-
 drivers/usb/host/ehci-pci.c                        |  4 +-
 drivers/usb/host/hwa-hc.c                          |  2 +-
 drivers/usb/host/ohci-pci.c                        |  2 +-
 drivers/usb/host/pci-quirks.c                      | 45 +++++++++++++---------
 drivers/usb/host/pci-quirks.h                      |  2 +-
 drivers/usb/host/xhci-pci.c                        |  2 +-
 drivers/usb/host/xhci.h                            |  3 +-
 drivers/usb/misc/usb251xb.c                        | 15 ++++----
 drivers/usb/storage/scsiglue.c                     | 11 ++++++
 11 files changed, 57 insertions(+), 39 deletions(-)
