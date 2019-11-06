Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4BF1929
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfKFOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 09:54:17 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:44066 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727321AbfKFOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:54:16 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xA6ErXXG026781;
        Wed, 6 Nov 2019 16:53:33 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 65DCC60275; Wed,  6 Nov 2019 16:53:33 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 0/3] reset: npcm: add NPCM reset driver support
Date:   Wed,  6 Nov 2019 16:53:28 +0200
Message-Id: <20191106145331.25740-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds reset controller support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

Apart of controlling all NPCM BMC reset module lines the NPCM reset driver
support NPCM BMC software reset to restarting the NPCM BMC.

Supporting NPCM USB-PHY reset as follow:

NPCM BMC USB-PHY connected to two modules USB device (UDC) and USB host.

If we will restart the USB-PHY at the UDC probe and later the 
USB host probe will restart USB-PHY again it will disable the UDC
and vice versa.

The solution is to reset the USB-PHY at the reset probe stage before 
the UDC and the USB host are initializing.

NPCM reset driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Philipp Zabel

Changes since version 4:
 - Check for stored GCR string in the of_device_id->data to gain
   GCR regmap access. 
 - Adding check if the user used undefined reset pins
   in the of_xlate function.
 - Remove nr_resets initialization since it of_xlate replaced 
   with the custom version.

Changes since version 3:
 - Modify to dt-bindings in the commit subject.
 - Remove footer from all the sent patches.
 
Changes since version 2:
 - Remove unnecessary details in the dt-binding documentation.
 - Modify device tree binding constants.
 - initialize gcr_regmap parameter to NULL.
 - Add of_xlate support.
 - Enable NPCM reset driver by default.
 - Remove unused header include.
 - Using devm_platform_ioremap_resource instead of_address_to_resource 
	and devm_ioremap_resource.
 - Modify number of resets.
 - Using devm_reset_controller_register instead reset_controller_register.
 - Remove unnecessary probe print.
  
Changes since version 1:
 - Check if gcr_regmap parameter initialized before using it.

Tomer Maimon (3):
  dt-bindings: reset: add NPCM reset controller documentation
  dt-bindings: reset: Add binding constants for NPCM7xx reset controller
  reset: npcm: add NPCM reset controller driver

 .../bindings/reset/nuvoton,npcm-reset.txt     |  32 ++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-npcm.c                    | 291 ++++++++++++++++++
 .../dt-bindings/reset/nuvoton,npcm7xx-reset.h |  91 ++++++
 5 files changed, 422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
 create mode 100644 drivers/reset/reset-npcm.c
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h

-- 
2.22.0

