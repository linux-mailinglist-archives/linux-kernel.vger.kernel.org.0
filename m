Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AED2BA44
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfE0Si6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 14:38:58 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.61]:27534 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfE0Si6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:38:58 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 1E96451D9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:38:57 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VKWPhWyao90onVKWPhaO79; Mon, 27 May 2019 13:38:57 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=37440 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hVKWO-0039DI-6Q; Mon, 27 May 2019 13:38:56 -0500
Date:   Mon, 27 May 2019 13:38:55 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] macvlan: Replace strncpy() by strscpy()
Message-ID: <20190527183855.GA32553@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hVKWO-0039DI-6Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:37440
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warning:

"Calling strncpy with a maximum size argument of 16 bytes on destination
array ifrr.ifr_ifrn.ifrn_name of size 16 bytes might leave the destination
string unterminated."

Notice that, unlike strncpy(), strscpy() always null-terminates the
destination string.

Addresses-Coverity-ID: 1445537 ("Buffer not null terminated")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/macvlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 61550122b563..0ccabde8e9c9 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -831,7 +831,7 @@ static int macvlan_do_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	struct ifreq ifrr;
 	int err = -EOPNOTSUPP;
 
-	strncpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
+	strscpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
 	ifrr.ifr_ifru = ifr->ifr_ifru;
 
 	switch (cmd) {
-- 
2.21.0

