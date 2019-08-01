Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D977E008
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbfHAQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:22:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47084 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfHAQWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:22:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x71GM2Jc123625;
        Thu, 1 Aug 2019 11:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564676522;
        bh=zWbkatx0IfHL4ytXCT+nuKdGHgjjpQH55L93XjCsfk4=;
        h=From:To:CC:Subject:Date;
        b=QiHLZW0+D6IMwfELJPu72lV78UohZ6u8vep5YSAYQgoa4mwANo07d5EuduYuQManh
         OAhvXwqeT0U71RRB4VqWeSttu8I1W6wD1DCs+65PpMTVwt70nC3O9I/S41+u6EAD9S
         m1oER7p6PsZy1OjLLbYpI1NDIQv2uQzUFvFORAUA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x71GM28W092699
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Aug 2019 11:22:02 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 1 Aug
 2019 11:22:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 1 Aug 2019 11:22:02 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x71GLxdA097075;
        Thu, 1 Aug 2019 11:22:00 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 0/3] Merge m25p80 into spi-nor
Date:   Thu, 1 Aug 2019 21:52:26 +0530
Message-ID: <20190801162229.28897-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is repost of patch 6 and 7 split from from Boris Brezillon's X-X-X
mode support series[1]

Background from cover letter for RFC[1]:
m25p80 is just a simple SPI NOR controller driver (a wrapper around the
SPI mem API). Not only it shouldn't be named after a specific SPI NOR
chip, but it also doesn't deserve a specific driver IMO, especially if
the end goal is to get rid of SPI NOR controller drivers found in
drivers/mtd/spi-nor/ and replace them by SPI mem drivers (which would
be placed in drivers/spi/). With this solution, we declare the SPI NOR
driver as a spi_mem_driver, just like the SPI NAND layer is declared as
a spi_mem driver (patch 1/2).
This solution also allows us to check at a fined-grain level (thanks to
the spi_mem_supports_op() function) which operations are supported and
which ones are not, while the original m25p80 logic was basing this
decision on the SPI_{RX,TX}_{DUAL,QUAD,OCTO} flags only (patch 2/2).

[1] https://patchwork.ozlabs.org/cover/982926/

Tested on TI' DRA7xx EVM with TI QSPI controller (a spi-mem driver) with
DMA (s25fl256) flash. I don't see any performance regression due to
bounce buffer copy introduced by this series
Also tested with cadence-quadspi (a spi-nor driver) driver

Boris Brezillon (2):
  mtd: spi-nor: Move m25p80 code in spi-nor.c
  mtd: spi-nor: Rework hwcaps selection for the spi-mem case

Vignesh Raghavendra (1):
  mtd: spi-nor: always use bounce buffer for register read/writes

 drivers/mtd/devices/Kconfig   |  18 -
 drivers/mtd/devices/Makefile  |   1 -
 drivers/mtd/devices/m25p80.c  | 347 ---------------
 drivers/mtd/spi-nor/Kconfig   |   2 +
 drivers/mtd/spi-nor/spi-nor.c | 806 +++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  24 +-
 6 files changed, 773 insertions(+), 425 deletions(-)
 delete mode 100644 drivers/mtd/devices/m25p80.c

-- 
2.22.0

