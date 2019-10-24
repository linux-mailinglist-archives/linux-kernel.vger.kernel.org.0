Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C196E3EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfJXWCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 18:02:01 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:43370 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbfJXWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:02:00 -0400
X-Greylist: delayed 804 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 18:02:00 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x9OLlm0R022490;
        Fri, 25 Oct 2019 00:47:48 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id E7FE56026D; Fri, 25 Oct 2019 00:47:47 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/3] reset: npcm: add NPCM reset driver support
Date:   Fri, 25 Oct 2019 00:47:43 +0300
Message-Id: <20191024214746.88431-1-tmaimon77@gmail.com>
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

Tomer Maimon (3):
  dt-binding: reset: add NPCM reset controller documentation
  dt-bindings: reset: Add binding constants for NPCM7xx reset controller
  reset: npcm: add NPCM reset controller driver

 .../bindings/reset/nuvoton,npcm-reset.txt     |  35 +++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-npcm.c                    | 273 ++++++++++++++++++
 .../dt-bindings/reset/nuvoton,npcm7xx-reset.h |  82 ++++++
 5 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
 create mode 100644 drivers/reset/reset-npcm.c
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h

-- 
2.22.0

