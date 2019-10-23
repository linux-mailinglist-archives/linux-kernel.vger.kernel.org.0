Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2533BE1B81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404375AbfJWM6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 08:58:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59204 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390108AbfJWM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw8xU047913;
        Wed, 23 Oct 2019 07:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835488;
        bh=sECd/uFdwzMoCMf0uldBu7VsoVmQR5rzVIKvyhIOXls=;
        h=From:To:CC:Subject:Date;
        b=jQYWfkSPNPOaiOhxsFdoKA5J+Vnn+jOf04vOoplZAKXCBWFZKx9zRB1mWAs0mYuAg
         vrp8QZyUISMIL22brq9wzHosiTowA6Ma8pMkYyUBzAPbaXYPfJoLxhWzqVgg590qb7
         W6BJsbRbrdK54BGNOtW9ArYvNeFqH1c+49GWBluw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw8tn064267;
        Wed, 23 Oct 2019 07:58:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:57:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:57:58 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5o4061147;
        Wed, 23 Oct 2019 07:58:05 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 00/14] PHY: Add support for SERDES in TI's J721E SoC
Date:   Wed, 23 Oct 2019 18:27:21 +0530
Message-ID: <20191023125735.4713-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's J721E SoC uses Cadence Sierra SERDES for USB, PCIe and SGMII.
TI has a wrapper named WIZ to control input signals to Sierra and
Torrent SERDES.

This patch series:
 1) Add support to WIZ module present in TI's J721E SoC
 2) Adapt Cadence Sierra PHY driver to be used for J721E SoC

Changes from v1:
 *) Change the dt binding Documentation of WIZ wrapper to YAML format
 *) Fix an issue in Sierra while doimg rmmod

Anil Varughese (1):
  phy: cadence: Sierra: Configure both lane cdb and common cdb registers
    for external SSC

Kishon Vijay Abraham I (13):
  dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
  phy: cadence: Sierra: Make "phy_clk" and "sierra_apb" optional
    resources
  phy: cadence: Sierra: Use "regmap" for read and write to Sierra
    registers
  phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
  phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
  phy: cadence: Sierra: Modify register macro names to be in sync with
    Sierra user guide
  phy: cadence: Sierra: Get reset control "array" for each link
  phy: cadence: Sierra: Check for PLL lock during PHY power on
  phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
  phy: cadence: Sierra: Set cmn_refclk/cmn_refclk1 frequency to 25MHz
  phy: cadence: Sierra: Use correct dev pointer in
    cdns_sierra_phy_remove()
  dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
  phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC

 .../bindings/phy/phy-cadence-sierra.txt       |  13 +-
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 159 +++
 drivers/phy/cadence/phy-cadence-sierra.c      | 697 +++++++++++---
 drivers/phy/ti/Kconfig                        |  15 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-j721e-wiz.c                | 904 ++++++++++++++++++
 6 files changed, 1650 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
 create mode 100644 drivers/phy/ti/phy-j721e-wiz.c

-- 
2.17.1

