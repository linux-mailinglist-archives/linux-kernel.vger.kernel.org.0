Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734D01815E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 11:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgCKKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 06:33:01 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57884 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:33:01 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B99C15F;
        Wed, 11 Mar 2020 11:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583922780;
        bh=fhyvcWFWuSvIM1UtzylvECxqVRvl+dvLVxwW7OX4PAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cF/Dr/Kpty3nuWxp8Mx2h3GJc7kuzSoB72lmzFnD66NLJzksuHMNoZPWUAe8jwP/Z
         Cqt6UwL2pM9DupgLnO8Q0/dCL6TCfK41zwaj7clx8TvfC3D1dREN0EfKEH5CMsHn1S
         jHI0AnTTenAKzsIAa6LYkxs8h+P2V8A434ozCug0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v6 0/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver
Date:   Wed, 11 Mar 2020 12:32:49 +0200
Message-Id: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch series adds a PHY driver for the Xilinx ZynqMP gigabit serial
transceivers (PS-GTR). The PS-GTR is a set of 4 PHYs that can be used by
the PCIe, USB 3.0, DisplayPort, SATA and Ethernet controllers that are
part of the Serial I/O Unit (SIOU).

The code is based on a previous version sent by Anurag Kumar Vulisha and
available at [1]. The DT bindings have been converted to YAML, and both
the bindings and the driver have been considerably reworked (and
simplified). The most notable changes is the removal of manual handling
of the reset lines of the PHY users (which belongs to the PHY users
themselves), and moving to the standard PHY .power_on() and .configure()
operations to replace functions that were previously exported by the
driver. Please see individual patches for a more detailed changelog.

The code is based on v5.6-rc4 and has been tested with DisplayPort on
the Xilinx ZC106 board.

[1] https://patchwork.kernel.org/cover/10735681/

Anurag Kumar Vulisha (2):
  dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
  phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver

Laurent Pinchart (1):
  arm64: dts: zynqmp: Add GTR transceivers

 .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 104 ++
 MAINTAINERS                                   |   9 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  10 +
 drivers/phy/Kconfig                           |   8 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-zynqmp.c                      | 995 ++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |   1 +
 7 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 create mode 100644 drivers/phy/phy-zynqmp.c

-- 
Regards,

Laurent Pinchart

