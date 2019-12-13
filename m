Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4811DE80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 08:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLMHSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 02:18:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfLMHSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:18:12 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 882569D7A5C5C710FA0A;
        Fri, 13 Dec 2019 15:18:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Dec 2019 15:17:59 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <stefanr@s5r6.in-berlin.de>
CC:     <linux1394-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH] firewire: net: remove set but not used variables 'guid'
Date:   Fri, 13 Dec 2019 15:15:10 +0800
Message-ID: <20191213071510.177751-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/firewire/net.c: In function fwnet_finish_incoming_packet:
drivers/firewire/net.c:488:9: warning: variable guid set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/firewire/net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 715e491..2878564 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -490,7 +490,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 {
 	struct fwnet_device *dev;
 	int status;
-	__be64 guid;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -512,7 +511,6 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 	 * Parse the encapsulation header. This actually does the job of
 	 * converting to an ethernet-like pseudo frame header.
 	 */
-	guid = cpu_to_be64(dev->card->guid);
 	if (dev_hard_header(skb, net, ether_type,
 			   is_broadcast ? net->broadcast : net->dev_addr,
 			   NULL, skb->len) >= 0) {
-- 
2.7.4

