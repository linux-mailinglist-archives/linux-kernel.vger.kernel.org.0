Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2190113C08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLEG7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 01:59:40 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55790 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfLEG7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:59:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB56xEEd078510;
        Thu, 5 Dec 2019 00:59:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575529154;
        bh=p7gKLubv7D204H8MsVlcocPH5+pDPFuPXIUfcGx0XSk=;
        h=From:To:CC:Subject:Date;
        b=LM3f7r6hylhzrnrI05MmtDcqws04GznHzrHjxnUNxrTO0zu0NJaXlIizJlcR7DH3c
         sL9jEVl54DxTy+djw8Ik4StgJ3F/eK6sEBjx/sRvKIs3E8Hnwa9xe3OM9eAiE7wMW6
         csJld+IPEv24sItW3hYfUVGwFj/KBz/jge5w0PlY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB56xEBV006110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 00:59:14 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 00:59:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 00:59:14 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB56xBT1097002;
        Thu, 5 Dec 2019 00:59:12 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] mtd: spi-nor: Update mt25q/n25q entries
Date:   Thu, 5 Dec 2019 12:29:32 +0530
Message-ID: <20191205065935.5727-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch splits n25q512a and mt25qu512a into two as they are
different devices. Second patch adds support for more mt25q devices and
last patch adds USE_FSR flag for n25q entries where missing.

Tested with mt25qu512a flash

Vignesh Raghavendra (3):
  mtd: spi-nor: Split mt25qu512a (n25q512a) entry into two
  mtd: spi-nor: Add entries for mt25q variants
  mtd: spi-nor: Add USE_FSR flag for n25q* entries

 drivers/mtd/spi-nor/spi-nor.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.24.0

