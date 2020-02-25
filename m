Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14E416B9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgBYGqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 01:46:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33934 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgBYGqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:46:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 922281C22B672596022C;
        Tue, 25 Feb 2020 14:46:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 14:46:11 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <davem@davemloft.net>, <jiri@mellanox.com>, <krzk@kernel.org>,
        <gregkh@linuxfoundation.org>, <Jason@zx2c4.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] drivers: net: WIREGUARD depends on IPV6
Date:   Tue, 25 Feb 2020 14:39:30 +0800
Message-ID: <20200225063930.106436-1-chenzhou10@huawei.com>
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

If CONFIG_IPV6 is n, build fails:

drivers/net/wireguard/device.o: In function `wg_xmit':
device.c:(.text+0xb2d): undefined reference to `icmpv6_ndo_send'
make: *** [vmlinux] Error 1

Set WIREGUARD depending on IPV6 to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 25a8f93..824292e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -74,7 +74,7 @@ config DUMMY
 config WIREGUARD
 	tristate "WireGuard secure network tunnel"
 	depends on NET && INET
-	depends on IPV6 || !IPV6
+	depends on IPV6
 	select NET_UDP_TUNNEL
 	select DST_CACHE
 	select CRYPTO
-- 
2.7.4

