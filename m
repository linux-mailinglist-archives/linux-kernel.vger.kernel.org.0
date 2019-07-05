Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DFC601F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGEINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 04:13:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54686 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGEINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:13:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so4845131wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjan+KgEz9G9OvUs3jK6RJyAXdEJ9Zg2rmXTwLxZscI=;
        b=LyTNlF16UwaW5NFWqEzepKuRWuQocXI0SgtwlvU3mh+zAL9Vq4QN4s1ygMPYtuJ0NH
         ZFwDzjtklZhj3sCVsDX9W10zt/IPpTTTsBReujQ6bSZPLZ9RGZwg3/D7+BABMF+imhOZ
         FVxhHehT/2pBDyv6H7jlry0KBNhplx5kSKZQfDm5fK/veT5FyPKbFC5MW1FmS+CIRaMz
         KqmF3mFIuZ8H57Z9L/TBfQrIFITk2pZZeesGZmbsTNO6c/VWdeJGWYwGvfhlb41esEyx
         tuCOxuUCJGNmnF/tarwzpscNxV3OdABQkA0Zo+ED3KF6p5+ptafQikyppiyz+FtuQ0Jr
         LTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjan+KgEz9G9OvUs3jK6RJyAXdEJ9Zg2rmXTwLxZscI=;
        b=qLn8tyX6XIbIrhrqgUiP688DZVxw1LUGqleOp0n4fgqFXuzE2jAdDP3kz8UJMBHZFj
         iokwbzCzUTbfttseDMVJHxUOeLJJDLGmz4gb59BDe1OuDRUVLTEYr8JwpgoduWyICFci
         O9GcP+9P1YD2tCzg9qXivBh9dKwL0tW7EIWXm/Z7fRQnQVobMXsjU89lsK8J/dcqqQ4T
         XsTMsdlHATIgeHdrP3G731NIRUL/NSpOBG0HzQasl2qwq/j3rfagsURtfbCK/XSRISuh
         H8tg++Hio5w6BjrvUg8iSEjPOdNP+kgLnngsh69POTnzga0BT9rnpzUYtqal1VPuywlh
         nj1w==
X-Gm-Message-State: APjAAAXdCDxNvSiDsfpvliWEIVDBQjh1VN0jWiLSoE0wXdxhAmtJRRxn
        LoumVjVSqNF/bbkvHckUvAUxFA==
X-Google-Smtp-Source: APXvYqwrJ/NYs7YXVeBDTXDxbUDf6yxKeslCdp5qOdtg6t4mPFARrNEcPKiscicmRvax+bMdF/sd+w==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74mr2295203wme.9.1562314387308;
        Fri, 05 Jul 2019 01:13:07 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id 18sm7847141wmg.43.2019.07.05.01.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jul 2019 01:13:06 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] misc: fastrpc: fix memory leak
Date:   Fri,  5 Jul 2019 10:13:03 +0200
Message-Id: <20190705081303.14170-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the necessary house-keeping if the allocated memory wont be used

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 98603e235cf0..c790585da14c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -279,8 +279,11 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 
 	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
 				       GFP_KERNEL);
-	if (!buf->virt)
+	if (!buf->virt) {
+		mutex_destroy(&buf->lock);
+		kfree(buf);
 		return -ENOMEM;
+	}
 
 	if (fl->sctx && fl->sctx->sid)
 		buf->phys += ((u64)fl->sctx->sid << 32);
-- 
2.21.0

