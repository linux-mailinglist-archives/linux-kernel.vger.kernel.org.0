Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5179C76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 00:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfG2WcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 18:32:02 -0400
Received: from gateway23.websitewelcome.com ([192.185.47.80]:41386 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbfG2WcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:32:01 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6A9F78DE3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 17:10:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sDqVhk5zH3Qi0sDqVhUrSg; Mon, 29 Jul 2019 17:10:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zI2BPF1rCx4kgmch41TwqXqWJbVYDCBh5wwiwteyPR8=; b=YXEHllLZgIABYTSio8T6iN4oRb
        YKcqkGnD63KFpIqXhna4mlFN4xUcPesce8W6aZ0bEY3PREcK6BUCi34Gy1NMk3WtUXcXepodc68Kz
        AylBe3Q+1DoC7WgTOFoVZIUu9BKwSuqxnMdNIN6Uv5sHzdkh9bh2M6VMvOqpPjHwG174NEDhDW1VY
        /35+7pRPx+oZBeLjx6HgPJ85orMP2YoX0rGOOnLQxpTn1elEy7YQCOUCU0H8r5XWsynga8Y2QSYBA
        +jUhMdMaFoHUGHj6TReeexX78aqxV1mF27qQ2Lr7ZNr5LbGweuVTVO2CVlW9d5kOaqwIntQNR42QC
        Tnhb7U4Q==;
Received: from [187.192.11.120] (port=60826 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsDqU-001wfk-CO; Mon, 29 Jul 2019 17:10:18 -0500
Date:   Mon, 29 Jul 2019 17:10:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] net: smc911x: Mark expected switch fall-through
Message-ID: <20190729221016.GA17610@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsDqU-001wfk-CO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60826
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/net/ethernet/smsc/smc911x.c: In function ‘smc911x_phy_detect’:
drivers/net/ethernet/smsc/smc911x.c:677:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (cfg & HW_CFG_EXT_PHY_DET_) {
       ^
drivers/net/ethernet/smsc/smc911x.c:715:3: note: here
   default:
   ^~~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/smsc/smc911x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index bd14803545de..8d88e4083456 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -712,6 +712,7 @@ static void smc911x_phy_detect(struct net_device *dev)
 					/* Found an external PHY */
 					break;
 			}
+			/* Else, fall through */
 		default:
 			/* Internal media only */
 			SMC_GET_PHY_ID1(lp, 1, id1);
-- 
2.22.0

