Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E9F6888
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 11:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfKJKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 05:40:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfKJKk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:40:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9DE7C53EF28443017FD9;
        Sun, 10 Nov 2019 18:40:55 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sun, 10 Nov 2019 18:40:45 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <esben@geanix.com>, <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <zhengyongjun3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] net: ll_temac: Remove set but not used variable 'start_p'
Date:   Sun, 10 Nov 2019 18:39:37 +0800
Message-ID: <20191110103937.124600-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/xilinx/ll_temac_main.c: In function temac_start_xmit:
drivers/net/ethernet/xilinx/ll_temac_main.c:737:13: warning: variable start_p set but not used [-Wunused-but-set-variable]

start_p is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 21c1b4322ea7..b37433be6b7f 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -819,14 +819,13 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct temac_local *lp = netdev_priv(ndev);
 	struct cdmac_bd *cur_p;
-	dma_addr_t start_p, tail_p, skb_dma_addr;
+	dma_addr_t tail_p, skb_dma_addr;
 	int ii;
 	unsigned long num_frag;
 	skb_frag_t *frag;
 
 	num_frag = skb_shinfo(skb)->nr_frags;
 	frag = &skb_shinfo(skb)->frags[0];
-	start_p = lp->tx_bd_p + sizeof(*lp->tx_bd_v) * lp->tx_bd_tail;
 	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
 
 	if (temac_check_tx_bd_space(lp, num_frag + 1)) {
-- 
2.23.0

