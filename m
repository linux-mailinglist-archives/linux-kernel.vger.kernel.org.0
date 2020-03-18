Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29D4189DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 15:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCRO1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 10:27:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37352 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgCRO1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:27:00 -0400
Received: from [94.134.91.63] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jEZem-0004YX-T9; Wed, 18 Mar 2020 15:26:52 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de
Subject: [PATCH 0/7] serial: 8250: Add rs485 emulation to 8250_dw
Date:   Wed, 18 Mar 2020 15:26:33 +0100
Message-Id: <20200318142640.982763-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to revive the work of Giulio Benetti from 2018 [0]
which seemed to have stalled at that time.

The board I needed that on also had the additional caveat that it
uses non-standard pins for DE/RE so needed gpio mctrl layer as well
and even more special needed to control the RE pin manually not as
part of it being connected to the DE signal as seems to be the standard.

So I've marked the patch doing this as DTR pin as RFC but that patch
isn't needed for the other core functionality, so could also be left out.

Changes from the 2018 submission include:
- add timeout when waiting for fifos to clear using a new helper
- move on-boot enablement of the rs485 mode to after registering
  the port. This saves having to copy the em485 struct as done
  originally, which also ran into spinlock-debug warnings when testing
  and also makes it actually possible to use the mctrl gpio layer
  for non-standard gpios.

[0] Link: https://lore.kernel.org/linux-serial/20180601124021.102970-1-giulio.benetti@micronovasrl.com/

Giulio Benetti (4):
  serial: 8250: Make em485_rts_after_send() set mctrl according to rts
    state.
  serial: 8250: Handle case port doesn't have TEMT interrupt using
    em485.
  serial: 8250_dw: add em485 support
  serial: 8250_dw: allow enable rs485 at boot time

Heiko Stuebner (3):
  serial: 8250: add serial_in_poll_timeout helper
  serial: 8250: Start rs485 after registering port if rs485 is enabled
    in probe
  serial: 8250: handle DTR in rs485 emulation

 drivers/tty/serial/8250/8250.h      | 36 ++++++++++++++++++++-
 drivers/tty/serial/8250/8250_core.c |  9 ++++++
 drivers/tty/serial/8250/8250_dw.c   | 35 +++++++++++++++++++-
 drivers/tty/serial/8250/8250_of.c   |  2 +-
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c | 50 +++++++++++++++++++++++------
 include/linux/serial_8250.h         |  1 +
 7 files changed, 121 insertions(+), 14 deletions(-)

-- 
2.24.1

