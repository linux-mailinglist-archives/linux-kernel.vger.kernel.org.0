Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541F2147D19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbgAXJ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 04:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388592AbgAXJ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:56:58 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DD12087E;
        Fri, 24 Jan 2020 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859817;
        bh=6/hyzRvS7G1HpN3Vz3v09c1ywVLJBX/PO3nqiyUMehY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjL25FwBWuXo1ZBMAxj50bL4uGcl5Pygk+MlIrczJ1i8udxG1uFYSenIPq6J3YVg4
         DKV63PvvBvvXapZtDugLlfqM/vZnlRxbWsvf38/ipDthUua85mdWIFIdT1m3o6azLM
         JZL/vjvB4suHAXSKbRBJCX2HkOvJKJPjidLJieRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Kiyanovski <akiyano@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 189/343] net: ena: fix: Free napi resources when ena_up() fails
Date:   Fri, 24 Jan 2020 10:30:07 +0100
Message-Id: <20200124092944.852074833@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit b287cdbd1cedfc9606682c6e02b58d00ff3a33ae ]

ena_up() calls ena_init_napi() but does not call ena_del_napi() in
case of failure. This causes a segmentation fault upon rmmod when
netif_napi_del() is called. Fix this bug by calling ena_del_napi()
before returning error from ena_up().

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d22b138c2b096..518ff393a026b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1796,6 +1796,7 @@ err_setup_rx:
 err_setup_tx:
 	ena_free_io_irq(adapter);
 err_req_irq:
+	ena_del_napi(adapter);
 
 	return rc;
 }
-- 
2.20.1



