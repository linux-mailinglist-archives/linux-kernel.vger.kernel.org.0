Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F74AF0046
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfKEOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:49:44 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:41496 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fmCmuOAiEUwEwfeCcX
        FYBqOu7taXOPv5Mn5DJrGyiqw=; b=S55SVB4XKcW2KybHxCblxfDEYjf39VXJHa
        9PxmKcMsjybQcsDcQjhwRDdgN6mLTwVVNX4CTcbIApI9QLE3jRBQZADnNtizuIkh
        bGbz570JGl7Ns+z6jp2Rj1ub4+do+qBEKtdk51uzr4WLAIuGDQDSiZhGQP2W92Be
        +6L1Zee4k=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgD3iCLvi8FdNofqJw--.256S3;
        Tue, 05 Nov 2019 22:49:23 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] staging: rtl8192e: fix potential use after free
Date:   Tue,  5 Nov 2019 22:49:11 +0800
Message-Id: <1572965351-6745-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgD3iCLvi8FdNofqJw--.256S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr48JF48Ww4fAw1xXrWxXrb_yoW8Jw1UpF
        4rGwnIyrWUZr48u3ykAFWIgryFka1SgF9agay3X3yrZrZxCw1rXryqvFyjqr45CrZ3CF4a
        qFn5Kr15uan8WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXeOXUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBURNkclaD5I2j7AAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable skb is released via kfree_skb() when the return value of
_rtl92e_tx is not zero. However, after that, skb is accessed again to
read its length, which may result in a use after free bug. This patch
fixes the bug by moving the release operation to where skb is never
used later.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f932cb15e4e5..cdcb22f96ed9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1616,14 +1616,15 @@ static void _rtl92e_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 	memcpy((unsigned char *)(skb->cb), &dev, sizeof(dev));
 	skb_push(skb, priv->rtllib->tx_headroom);
 	ret = _rtl92e_tx(dev, skb);
-	if (ret != 0)
-		kfree_skb(skb);
 
 	if (queue_index != MGNT_QUEUE) {
 		priv->rtllib->stats.tx_bytes += (skb->len -
 						 priv->rtllib->tx_headroom);
 		priv->rtllib->stats.tx_packets++;
 	}
+
+	if (ret != 0)
+		kfree_skb(skb);
 }
 
 static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.7.4

