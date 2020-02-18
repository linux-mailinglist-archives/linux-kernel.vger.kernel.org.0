Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3716242D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 11:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBRKFI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Feb 2020 05:05:08 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:39110 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgBRKFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:05:07 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id C294467A8C9;
        Tue, 18 Feb 2020 11:05:05 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 18 Feb
 2020 11:05:05 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.005; Tue, 18 Feb 2020 11:05:05 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Jeff Kletsky <git-commits@allycomm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Richard Weinberger" <richard@nod.at>
Subject: [PATCH v3 0/3] mtd: spinand: Fix reading and writing of bad block
 markers
Thread-Topic: [PATCH v3 0/3] mtd: spinand: Fix reading and writing of bad
 block markers
Thread-Index: AQHV5kLklyjvbjA0n0+NOcSxtTmLCw==
Date:   Tue, 18 Feb 2020 10:05:05 +0000
Message-ID: <20200218100432.32433-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: C294467A8C9.AC44A
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, git-commits@allycomm.com,
        liaoweixiong@allwinnertech.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

We were pointed to the issue of bad block markers not being saved to flash on
one of our boards with SPI NAND flash. After a bit of investigation it seems
like there are two overlapping bugs in the original framework that cause silent
failure when writing a bad block marker.

This set contains fixes for both of these issues and one more fix (patch 2) that
should not affect the actual behavior of the driver.

Changes in v3:
 * Patch 1: Correct "SPI MEM" to "SPI NAND" in commit message
 * Patch 3: Fix the subject line and the commit message
 * Patch 3: Add Boris' R-b tag

Changes in v2:
 * Patch 1: Incorporate small improvements proposed by Boris
 * Patch 1: Add Boris' R-b tag
 * Patch 2: Add Boris' R-b tag
 * Patch 3: Instead of waiting for the erase operation to finish,
            just don't do an erase at all, as it is not needed.

Frieder Schrempf (3):
  mtd: spinand: Stop using spinand->oobbuf for buffering bad block
    markers
  mtd: spinand: Explicitly use MTD_OPS_RAW to write the bad block marker
    to OOB
  mtd: spinand: Do not erase the block before writing a bad block marker

 drivers/mtd/nand/spi/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.17.1
