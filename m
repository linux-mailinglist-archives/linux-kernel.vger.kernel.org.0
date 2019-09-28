Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6BDC1044
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfI1I4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 04:56:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfI1I4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 04:56:11 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 521D5E4610E89206989F;
        Sat, 28 Sep 2019 16:55:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 16:55:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] regulator: pcap-regulator: remove unused variable 'SW3_table'
Date:   Sat, 28 Sep 2019 16:55:40 +0800
Message-ID: <20190928085540.45332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/regulator/pcap-regulator.c:89:27: warning:
 SW3_table defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/pcap-regulator.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/pcap-regulator.c b/drivers/regulator/pcap-regulator.c
index c246926..0345f38 100644
--- a/drivers/regulator/pcap-regulator.c
+++ b/drivers/regulator/pcap-regulator.c
@@ -86,10 +86,6 @@ static const unsigned int SW1_table[] = {
 
 #define SW2_table SW1_table
 
-static const unsigned int SW3_table[] = {
-	4000000, 4500000, 5000000, 5500000,
-};
-
 struct pcap_regulator {
 	const u8 reg;
 	const u8 en;
-- 
2.7.4


