Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE287D494
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 06:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfHAEau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 00:30:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42408 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHAEau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:30:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x714URNY036505;
        Wed, 31 Jul 2019 23:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564633827;
        bh=6eCnu4Zjun8nw4N6qO0xUjWUxk3QpQEqnz5dqYHSCYw=;
        h=From:To:CC:Subject:Date;
        b=sgFmKQoaKX0Aoxfi28lp1p0YhLgN+VKYxU55ocpeQsbDdwMB3upolSO+2dePioRxk
         mF9BzEXwsyThGkPHrG5NomvxWf6nL4L06zOxFyZxGHHU+mXBPDqtWbwyrh9MQXlPFR
         zTTK1GPJvLOSSbbF6OxLTIB/9c1injZkwHzwwymE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x714UR0U120408
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Jul 2019 23:30:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 31
 Jul 2019 23:30:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 31 Jul 2019 23:30:27 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x714UObp010110;
        Wed, 31 Jul 2019 23:30:24 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH v3 0/3] Merge m25p80 into spi-nor
Date:   Thu, 1 Aug 2019 10:00:49 +0530
Message-ID: <20190801043052.30192-1-vigneshr@ti.com>
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
 drivers/mtd/spi-nor/spi-nor.c | 802 +++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  24 +-
 6 files changed, 769 insertions(+), 425 deletions(-)
 delete mode 100644 drivers/mtd/devices/m25p80.c

-- 
2.22.0

