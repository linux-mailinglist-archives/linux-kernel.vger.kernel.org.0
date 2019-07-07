Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15889610CC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfGFN0p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 Jul 2019 09:26:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59843 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfGFN0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 09:26:45 -0400
Received: from [192.168.0.171] (188.146.228.97.nat.umts.dynamic.t-mobile.pl [188.146.228.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0968ECF12E;
        Sat,  6 Jul 2019 15:35:14 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Marvell HCI fixes and serdev support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190614072351.17390-1-s.hauer@pengutronix.de>
Date:   Sat, 6 Jul 2019 15:26:42 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>, kernel@pengutronix.de
Content-Transfer-Encoding: 8BIT
Message-Id: <E4537E64-ABE7-4D05-AF6F-E0DD57557178@holtmann.org>
References: <20190614072351.17390-1-s.hauer@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Sascha,

> First two patches are a fix for the Marvell HCI driver which fails to
> properly upload the firmware. Third patch adds simple serdev support
> to the driver.
> 
> Sascha
> 
> Sascha Hauer (3):
>  Bluetooth: hci_ldisc: Add function to wait for characters to be sent
>  Bluetooth: hci_mrvl: Wait for final ack before switching baudrate
>  Bluetooth: hci_mrvl: Add serdev support
> 
> .../bindings/net/marvell-bluetooth.txt        | 25 +++++++
> drivers/bluetooth/Kconfig                     |  1 +
> drivers/bluetooth/hci_ldisc.c                 |  8 +++
> drivers/bluetooth/hci_mrvl.c                  | 72 ++++++++++++++++++-
> drivers/bluetooth/hci_uart.h                  |  1 +
> 5 files changed, 106 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/devicetree/bindings/net/marvell-bluetooth.txt

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

