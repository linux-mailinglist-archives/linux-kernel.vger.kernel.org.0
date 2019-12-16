Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6C12033E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfLPLB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:01:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727581AbfLPLB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:01:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 274824968288112DB766;
        Mon, 16 Dec 2019 19:01:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 19:01:48 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] crypto: remove unneeded semicolon
Date:   Mon, 16 Dec 2019 18:58:48 +0800
Message-ID: <20191216105848.10669-1-chenzhou10@huawei.com>
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

Fixes coccicheck warning:

./include/linux/crypto.h:573:2-3: Unneeded semicolon

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 include/linux/crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 23365a9..5446efe 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -570,7 +570,7 @@ static inline int crypto_wait_req(int err, struct crypto_wait *wait)
 		reinit_completion(&wait->completion);
 		err = wait->err;
 		break;
-	};
+	}
 
 	return err;
 }
-- 
2.7.4

