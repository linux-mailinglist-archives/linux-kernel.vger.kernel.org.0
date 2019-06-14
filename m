Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7B455E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFNHYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 03:24:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34645 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfFNHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:03 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0000qT-RB; Fri, 14 Jun 2019 09:23:53 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hbgYz-0006Nh-2M; Fri, 14 Jun 2019 09:23:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/3] Marvell HCI fixes and serdev support
Date:   Fri, 14 Jun 2019 09:23:48 +0200
Message-Id: <20190614072351.17390-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First two patches are a fix for the Marvell HCI driver which fails to
properly upload the firmware. Third patch adds simple serdev support
to the driver.

Sascha

Sascha Hauer (3):
  Bluetooth: hci_ldisc: Add function to wait for characters to be sent
  Bluetooth: hci_mrvl: Wait for final ack before switching baudrate
  Bluetooth: hci_mrvl: Add serdev support

 .../bindings/net/marvell-bluetooth.txt        | 25 +++++++
 drivers/bluetooth/Kconfig                     |  1 +
 drivers/bluetooth/hci_ldisc.c                 |  8 +++
 drivers/bluetooth/hci_mrvl.c                  | 72 ++++++++++++++++++-
 drivers/bluetooth/hci_uart.h                  |  1 +
 5 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-bluetooth.txt

-- 
2.20.1

