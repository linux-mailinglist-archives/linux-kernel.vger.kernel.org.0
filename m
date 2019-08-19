Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE3922CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfHSLya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 07:54:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:56503 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSLya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:54:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="195521795"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 04:54:27 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        jwboyer@gmail.com, boris.brezillon@free-electrons.com,
        cyrille.pitchen@atmel.com, david.oberhollenzer@sigma-star.at,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 1/2] dt-bindings: mtd: cadence-qspi:add support for Intel lgm-qspi
Date:   Mon, 19 Aug 2019 19:54:23 +0800
Message-Id: <20190819115424.41479-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add vendor specific compatible string to disable DMA and auto
polling feature in the cadence-quadspi driver.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index 945be7d5b236..8ace832a2d80 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -5,6 +5,7 @@ Required properties:
 	Generic default - "cdns,qspi-nor".
 	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
 	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
+	For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
 - reg : Contains two entries, each of which is a tuple consisting of a
 	physical address and length. The first entry is the address and
 	length of the controller register set. The second entry is the
-- 
2.11.0

