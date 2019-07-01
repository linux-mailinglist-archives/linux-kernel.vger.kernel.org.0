Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE914BAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfFSOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 10:16:01 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51295 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:16:00 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6C9761C0020;
        Wed, 19 Jun 2019 14:15:54 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v6 0/6] Add CPU clock support for Armada 7K/8K
Date:   Wed, 19 Jun 2019 16:15:33 +0200
Message-Id: <20190619141539.16884-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the sixth version of a series allowing to manage the cpu clock
for Armada 7K/8K.

For these SoCs, the CPUs share the same clock by cluster, so actually
the clock management is done at cluster level.

As for the other Armada 7K/8K clocks it is possible to have multiple
AP so here again we need to have unique name: the purpose of the second
patch is to share a common code which will be used in 3 drivers.

The last 2 patch enable the driver at dt and platform level and will
be applied through the mvebu subsystem.

Changelog v5->v6:

   - Restraint the reg property for the child node to not overlap the
     other node.
   - Give a specific compatible to ap_syscon1.

Changelog v4->v5:

 - As requested by the device tree maintainer make the reg property
   mandatory

 - Updated the device tree files accordingly with the new binding

Changelog v3->v4:
 - Rebased on v5.1-rc1
 - Mention in the binding that a reg property can be used to make the
   device tree maintainer happy in the hope that there will be finally
   a review on this patch blocking the whole series.

Changelog v2->v3:
 - Add back the first patch documenting the binding

Changelog v1->v2:
 - Header cleanup
 - Use unsigned int instead of it for cluster member of the ap_cpu_clk struct
 - Use clk_hw instead of clk
 - Use regmap_read_poll_timeout
 - Use for_each_of_cpu_node
 - Remove unnecessary WARN_ON()
 - Remove headers from armada_ap_cp_helper.h
 - Few other minor cleanup

Gregory CLEMENT (6):
  dt-bindings: ap806: add the cluster clock node in the syscon file
  clk: mvebu: add helper file for Armada AP and CP clocks
  clk: mvebu: add CPU clock driver for Armada 7K/8K
  clk: mvebu: ap806: Fix clock name for the cluster
  arm64: marvell: enable the  Armada 7K/8K CPU clk driver
  arm64: dts: marvell: Add cpu clock node on Armada 7K/8K

 .../arm/marvell/ap806-system-controller.txt   |  25 ++
 arch/arm64/Kconfig.platforms                  |   1 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |   4 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   7 +
 drivers/clk/mvebu/Kconfig                     |   8 +
 drivers/clk/mvebu/Makefile                    |   2 +
 drivers/clk/mvebu/ap-cpu-clk.c                | 259 ++++++++++++++++++
 drivers/clk/mvebu/ap806-system-controller.c   |  24 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c       |  30 ++
 drivers/clk/mvebu/armada_ap_cp_helper.h       |  11 +
 drivers/clk/mvebu/cp110-system-controller.c   |  32 +--
 11 files changed, 361 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h

-- 
2.20.1

