Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B145513AC79
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgANOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:40:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51621 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgANOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:40:37 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1irNMt-0006dY-Tg; Tue, 14 Jan 2020 14:40:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corey Minyard <cminyard@mvista.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        vadimp@mellanox.com, Asmaa Mnebhi <Asmaa@mellanox.com>,
        openipmi-developer@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: ipmi: fix off-by-one bounds check that leads to a out-of-bounds write
Date:   Tue, 14 Jan 2020 14:40:31 +0000
Message-Id: <20200114144031.358003-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The end of buffer check is off-by-one since the check is against
an index that is pre-incremented before a store to buf[]. Fix this
adjusting the bounds check appropriately.

Addresses-Coverity: ("Out-of-bounds write")
Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 9fdae83e59e0..382b28f1cf2f 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -279,7 +279,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
 		break;
 
 	case I2C_SLAVE_WRITE_RECEIVED:
-		if (ipmb_dev->msg_idx >= sizeof(struct ipmb_msg))
+		if (ipmb_dev->msg_idx >= sizeof(struct ipmb_msg) - 1)
 			break;
 
 		buf[++ipmb_dev->msg_idx] = *val;
-- 
2.24.0

