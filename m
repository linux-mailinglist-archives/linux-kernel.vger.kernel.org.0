Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFED10AE42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0Kz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 05:55:27 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53869 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfK0Kz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:55:27 -0500
X-Originating-IP: 90.76.211.102
Received: from localhost.localdomain (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 109B1FF803;
        Wed, 27 Nov 2019 10:55:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 0/4] MTD concat
Date:   Wed, 27 Nov 2019 11:55:18 +0100
Message-Id: <20191127105522.31445-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A year ago Bernhard Frauendienst started an effort to bring MTD
devices concatenation generic [1]. Today I also need this
concatenation to be possible in order to support configurations where
two MTD devices are treated like one bigger in order to be able to
define partitions across chip boundaries.

After having talked with Mark Brown, Boris Brezillon and Rob Herring,
the only approach which seems acceptable is to add a property in the
partitions nodes to describe which partitions should be concatenated
in a virtual device.

At first I changed a bit the code logic and style, keeping the logic
from the original version. Since the last bindings change, I rewrote
almost all the driver, so I took ownership on it, keeping Bernhard in
a 'Suggested-by' tag.

I would like to add another way to concatenate devices: with module
parameters/arguments on the cmdline. This is easily doable in a second
time.

Thanks,
Miquèl

[1] https://lwn.net/ml/linux-kernel/20180907173515.19990-1-kernel@nospam.obeliks.de/


Bernhard Frauendienst (1):
  mtd: Add get_mtd_device_by_node() helper

Miquel Raynal (3):
  dt-bindings: mtd: Describe MTD partitions concatenation
  mtd: concat: Fix a comment referring to an unknown symbol
  mtd: Add driver for concatenating devices

 .../devicetree/bindings/mtd/partition.txt     |   1 +
 drivers/mtd/Kconfig                           |   8 +
 drivers/mtd/Makefile                          |   1 +
 drivers/mtd/mtd_virt_concat.c                 | 240 ++++++++++++++++++
 drivers/mtd/mtdconcat.c                       |   5 +-
 drivers/mtd/mtdcore.c                         |  38 +++
 include/linux/mtd/mtd.h                       |   2 +
 7 files changed, 291 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mtd/mtd_virt_concat.c

-- 
2.20.1

