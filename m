Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0E135B43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgAIOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 09:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgAIOXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:23:12 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922B420661;
        Thu,  9 Jan 2020 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578579792;
        bh=NNCzD1lmxUFsxcsEkZYkrNX1RV1NIrNRacx8C8F8324=;
        h=Date:From:To:cc:Subject:From;
        b=b2Jssm/QMAFHhGUBvBvC5kpmsGjW6Rm2+jF6vX38o4oHHHCD3//7gUesKAZrmlMai
         PuNHGQr4YSw+2T5YWKfFJYm0ZFRmI5CclYu0ARMlwP2W5gSwP8rEfvj/T6nLUPOJVw
         asdTdTlwipSK5FnVkM3S/3OwkIJ6sdaX27fpWkYE=
Date:   Thu, 9 Jan 2020 15:23:09 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to get fixes for HID subsystem:

=====
- fix for OOB in hiddev, from Dmitry Torokhov
- _poll API fixes for hidraw, from Marcel Holtmann
- functional fix for Steam driver, from Rodrigo Rivas Costa
- a few new device IDs / device-specific quirks and other assorted
  smaller fixes
=====

Thanks.

----------------------------------------------------------------
Aaron Ma (1):
      HID: multitouch: Add LG MELF0410 I2C touchscreen support

Alan Stern (1):
      HID: Fix slab-out-of-bounds read in hid_field_extract

Dmitry Torokhov (2):
      HID: hid-input: clear unmapped usages
      HID: hiddev: fix mess in hiddev_open()

Even Xu (1):
      HID: intel-ish-hid: ipc: add CMP device id

Hans de Goede (2):
      HID: ite: Add USB id match for Acer SW5-012 keyboard dock
      HID: asus: Ignore Asus vendor-page usage-code 0xff events

Jason Gerecke (1):
      HID: wacom: Recognize new MobileStudio Pro PID

Marcel Holtmann (2):
      HID: hidraw: Fix returning EPOLLOUT from hidraw_poll
      HID: uhid: Fix returning EPOLLOUT from uhid_char_poll

Pan Zhang (1):
      drivers/hid/hid-multitouch.c: fix a possible null pointer access.

Pavel Balan (1):
      HID: Add quirk for incorrect input length on Lenovo Y720

Priit Laes (1):
      HID: Add quirk for Xin-Mo Dual Controller

Rodrigo Rivas Costa (1):
      HID: steam: Fix input device disappearing

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Add Tiger Lake PCI device ID

 drivers/hid/hid-asus.c                  |  3 +-
 drivers/hid/hid-core.c                  |  6 ++
 drivers/hid/hid-ids.h                   |  3 +
 drivers/hid/hid-input.c                 | 16 ++++--
 drivers/hid/hid-ite.c                   |  3 +
 drivers/hid/hid-multitouch.c            |  5 +-
 drivers/hid/hid-quirks.c                |  1 +
 drivers/hid/hid-steam.c                 |  4 ++
 drivers/hid/hidraw.c                    |  4 +-
 drivers/hid/i2c-hid/i2c-hid-core.c      | 16 +++++-
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |  2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  2 +
 drivers/hid/uhid.c                      |  2 +-
 drivers/hid/usbhid/hiddev.c             | 97 ++++++++++++++-------------------
 drivers/hid/wacom_wac.c                 |  6 +-
 15 files changed, 101 insertions(+), 69 deletions(-)

-- 
Jiri Kosina
SUSE Labs

