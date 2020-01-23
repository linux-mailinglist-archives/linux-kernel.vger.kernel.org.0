Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC214636A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 09:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAWIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 03:23:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57282 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726135AbgAWIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:23:39 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N8DfUn017496;
        Thu, 23 Jan 2020 09:23:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=v2rNH4Gsw0bzUghfyGUw+uoKwXzibWz9pq9H3oEz7bQ=;
 b=B1qARC/kP+m68l3RIC3OE6xFWuO4hUxfbL9cUkfn2YW57LnXOqBB8SUJNsmrn91P2fTd
 0h0xHn+Jc3ekuiajiilRpYjrQqk0e8hKKrToyrUalnWsqbL+hv+4/oTknEbr35rnoSsO
 RIno2e0Z4jOum+2O21AfF7qB6U1P7ndkFQyTFUs96UKY4lZsWrNLApZ2vqpGsmXzb8di
 TVOcjNaySGjBhi70Lm+zT+yRRdS7pATwSldb3YNJ85XCMtxmGl1526YTJv+j+LOcZlmT
 VhCG8naFSmDqaCDBvUB4nXNiANarXYEpG4TQ5gnWsnJsTBwiQKNI2rHX7ifA4sEBDcLC QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkssp8r8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 09:23:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BA75100038;
        Thu, 23 Jan 2020 09:23:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E9A4320EDDA;
        Thu, 23 Jan 2020 09:23:16 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Jan 2020 09:23:16
 +0100
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: mtd: rawnand: free the nand_device object
Date:   Thu, 23 Jan 2020 09:22:48 +0100
Message-ID: <1579767768-32295-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch releases the resources allocated in nanddev_init function.

Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/nand_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f64e3b6..47c6396 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5907,6 +5907,8 @@ void nand_cleanup(struct nand_chip *chip)
 	    chip->ecc.algo == NAND_ECC_BCH)
 		nand_bch_free((struct nand_bch_control *)chip->ecc.priv);
 
+	nanddev_cleanup(&chip->base);
+
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	kfree(chip->data_buf);
-- 
1.9.1

