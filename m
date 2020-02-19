Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEC164B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:01:10 -0500
Received: from muru.com ([72.249.23.125]:56040 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgBSRBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:09 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3B2D980F3;
        Wed, 19 Feb 2020 17:01:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/4] n_gsm serdev support and mfd driver for droid4 modem
Date:   Wed, 19 Feb 2020 09:01:02 -0800
Message-Id: <20200219170106.38543-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v3 set of n_gsm serdev support patches, and the related MFD
driver for the modem found on Motorola Mapphone phones and tablets
like droid4.

This series only adds basic character device support for the MFD
driver. Other serdev consumer drivers for specific devices will be
posted separately.

The patches are against v5.6-rc1.

Regards,

Tony


Changes since v2:
- Drop useless send_command indirection, use static motmdm_send_command

Changes since v1:

- Simplified usage and got rid of few pointless inline functions
- Added consumer MFD driver, devicetree binding, and dts changes


Tony Lindgren (4):
  tty: n_gsm: Add support for serdev drivers
  mfd: motmdm: Add Motorola TS 27.010 serdev modem driver for droid4
  dt-bindings: mfd: motmdm: Add binding for motorola-mdm
  ARM: dts: omap4-droid4: Enable basic modem support

 .../mfd/motorola,mapphone-mdm6600.yaml        |   37 +
 .../boot/dts/motorola-mapphone-common.dtsi    |    6 +
 drivers/mfd/Kconfig                           |    9 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/motorola-mdm.c                    | 1198 +++++++++++++++++
 drivers/tty/n_gsm.c                           |  372 +++++
 include/linux/serdev-gsm.h                    |  168 +++
 7 files changed, 1791 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
 create mode 100644 drivers/mfd/motorola-mdm.c
 create mode 100644 include/linux/serdev-gsm.h

-- 
2.25.1
