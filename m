Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011D8F928C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 15:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKLO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 09:28:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39084 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:28:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACESrEY099172;
        Tue, 12 Nov 2019 08:28:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568933;
        bh=gFtqraInLCN31hWThjbNLQzPYYJVszVoh1otsRZfXMg=;
        h=From:To:CC:Subject:Date;
        b=DEJbyrXPGGOEJplbz/y8AKuM9D2QS9MtWKzBRrnaMQ+RziQ809bVdxkbAyjiH0GT1
         SwsjJUyF1DSoFjgPSEeERAcJmqJH0YTg/xjI0lrKXZFNbWS+AC3mZYnZi0qRlvweKP
         T9IKNTlRIhw/DfiXlm007mveh38IWtiN5hM5Vzp8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESr7i037686;
        Tue, 12 Nov 2019 08:28:53 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:35 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriC044422;
        Tue, 12 Nov 2019 08:28:53 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 00/20] media: ti-vpe: cal: maintenance
Date:   Tue, 12 Nov 2019 08:31:32 -0600
Message-ID: <20191112143152.23176-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This a collection of backlog patches I have been carrying for the CAL
driver.

- Add support for SoC variants.

- Switches to syscon/regmap to access a system controller register for
the DPHY configuration. This register has different bit layout depending
on the SoC version.

- It adds supports for pre ES2.0 silicon errata.

- Reworked the DPHY initialization sequence to match the technical
reference manual and provide a more robust restartability.

- Adds the missing ability to power subdevice.

- Update the devicetree binding and then converts it to dt-schema 

Changes since v2:
- Added a patch which converts all BIT_MASK() into BIT().
- Constify stuct cal_data.
- Remove blank line.
- Fix to use BIT() instead of BIT_MASK() in "add CSI2 PHY LDO errata
  support" patch
- Fix commit description related to v4l2 power management:
- Add missing binding update from v2
- Merge dt-binding and maintainer patch

Changes since v1:
- Removed unneeded "items/max/min".
- Add a ref for ti,camerrx-control type
- Move compatible description as comment in the schemas
- Simplify 'endpoint' syntax
- Removed clocks description
- Added ti,cal.yaml to MAINTAINERS as a separate patch.
- Added Rob's ack
- Remove 'inline' from cal_runtime_get()
- Switch to use of_device_get_match_data
- Reworked the syscon_regmap_lookup_by_phandle() section
- Updated the binding to use ti,camerrx-control instead of sycon_camerrx
- Updated the binding to use ti,camerrx-control instead of sycon_camerrx

Benoit Parrot (19):
  dt-bindings: media: cal: update binding to use syscon
  dt-bindings: media: cal: update binding example
  media: ti-vpe: cal: switch BIT_MASK to BIT
  media: ti-vpe: cal: Add per platform data support
  media: ti-vpe: cal: Enable DMABUF export
  dt-bindings: media: cal: update binding to add PHY LDO errata support
  media: ti-vpe: cal: add CSI2 PHY LDO errata support
  media: ti-vpe: cal: Fix ths_term/ths_settle parameters
  media: ti-vpe: cal: Fix pixel processing parameters
  media: ti-vpe: cal: Align DPHY init sequence with docs
  dt-bindings: media: cal: update binding to add DRA76x support
  media: ti-vpe: cal: Add DRA76x support
  dt-bindings: media: cal: update binding to add AM654 support
  media: ti-vpe: cal: Add AM654 support
  media: ti-vpe: cal: Add subdev s_power hooks
  media: ti-vpe: cal: Properly calculate max resolution boundary
  media: ti-vpe: cal: Fix a WARN issued when start streaming fails
  media: ti-vpe: cal: fix enum_mbus_code/frame_size subdev arguments
  dt-bindings: media: cal: convert binding to yaml

Nikhil Devshatwar (1):
  media: ti-vpe: cal: Restrict DMA to avoid memory corruption

 .../devicetree/bindings/media/ti,cal.yaml     | 202 +++++
 .../devicetree/bindings/media/ti-cal.txt      |  72 --
 MAINTAINERS                                   |   1 +
 drivers/media/platform/Kconfig                |   2 +-
 drivers/media/platform/ti-vpe/cal.c           | 773 ++++++++++++++----
 drivers/media/platform/ti-vpe/cal_regs.h      | 221 ++---
 6 files changed, 937 insertions(+), 334 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,cal.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/ti-cal.txt

-- 
2.17.1

