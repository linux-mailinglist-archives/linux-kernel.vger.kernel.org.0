Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54D719AB64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgDAML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDAML2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:11:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2B620776;
        Wed,  1 Apr 2020 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585743087;
        bh=nXg2q3C/JR3U7vgkBSpwLmR4cHFshKwDTJd+tr+jbp8=;
        h=Date:From:To:cc:Subject:From;
        b=UHgJmVpG+OUk04bkT+BFaxKCFfETuvkWxQPHzTebqR6aVSli4dMlnBSG/cettVqmg
         wX4vcqULvD/U4Z+7A6rY4i88SqKDYpjQr+qjIEjIK0Dbi/V6ZkaYqkEqFZNuIVI7Yk
         ktS5WBoj4LYlFmbanAtpzMTe6LDPlyrpEqVAgQxg=
Date:   Wed, 1 Apr 2020 14:11:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.7
Message-ID: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsytem patches for 5.7 merge window.

=====
- Logitech HID++ protocol support improvement from Filipe Laíns
- probe fix for Logitech-G* devices from Hans de Goede
- a few other small code cleanups and support for new device IDs
=====

Thanks.

----------------------------------------------------------------
Christophe JAILLET (1):
      HID: rmi: Simplify an error handling path in 'rmi_hid_read_block()'

Filipe Laíns (2):
      HID: logitech-dj: add debug msg when exporting a HID++ report descriptors
      HID: logitech-dj: add support for the static device in the Powerplay mat/receiver

Gustavo A. R. Silva (2):
      HID: intel-ish-hid: ishtp-dev.h: Replace zero-length array with flexible-array member
      HID: intel-ish-hid: hbm.h: Replace zero-length array with flexible-array member

Hans de Goede (2):
      HID: quirks: Remove ITE 8595 entry from hid_have_special_driver
      HID: lg-g15: Do not fail the probe when we fail to disable F# emulation

Lucas Tanure (2):
      HID: appleir: Remove unnecessary goto label
      HID: appleir: Use devm_kzalloc() instead of kzalloc()

Rishi Gupta (1):
      HID: mcp2221: add usb to i2c-smbus host bridge

Samuel Èavoj (1):
      HID: Add driver fixing Glorious PC Gaming Race mouse report descriptor

 MAINTAINERS                                 |   7 +
 drivers/hid/Kconfig                         |  17 +
 drivers/hid/Makefile                        |   2 +
 drivers/hid/hid-appleir.c                   |  12 +-
 drivers/hid/hid-glorious.c                  |  86 ++++
 drivers/hid/hid-ids.h                       |   5 +
 drivers/hid/hid-lg-g15.c                    |   6 +-
 drivers/hid/hid-logitech-dj.c               |  11 +-
 drivers/hid/hid-mcp2221.c                   | 742 ++++++++++++++++++++++++++++
 drivers/hid/hid-quirks.c                    |   3 -
 drivers/hid/hid-rmi.c                       |   1 -
 drivers/hid/intel-ish-hid/ishtp/hbm.h       |   2 +-
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h |   2 +-
 13 files changed, 878 insertions(+), 18 deletions(-)
 create mode 100644 drivers/hid/hid-glorious.c
 create mode 100644 drivers/hid/hid-mcp2221.c

-- 
Jiri Kosina
SUSE Labs

