Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B011F4FF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 00:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLNXGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 18:06:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44272 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 18:06:17 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so3266369iof.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 15:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wOp75n88mMM3YUNrKjhCWhA9PYsgmXSi0rsbjs2+ri8=;
        b=V8y8pZU884AbR1LaOYpGQsw4OmzhUtnVJrIfMkPLlIc7MGL0L3FICsxxJOT1bYSJ8v
         qAratMNX39A0EtLhg9dnlHLi+KObTJvYrB7xTe2uzxCDTJUtLJru+wK6dOrKhMXQp5T6
         ExEXm9g7NGPLd+T5gfd7/bGZA7HR7/RDO6ve487aW/49/EnoZ81jdiToNS7tOq5/3u8m
         c2YXmzAeVxAH1LU+Ib02/6XgQEUEiJi3m9maoJMoeiLFWkW9e9uZis8xOtm1vIYissSB
         Xo2taoHt96wizAMoUjXsfHBFTa++U8+f0KebxcoADSWUuEf7qk5oU6x4J5CPwIh5v+j1
         igXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wOp75n88mMM3YUNrKjhCWhA9PYsgmXSi0rsbjs2+ri8=;
        b=V2zPlKIoy6iFWUbU/MVWuaWECjhnMVCx7H2xhZn4fFrZCtHb4ie6ZQBa9f0FjuBP/P
         Ywd4nmasURaAzQ7j/XQ40Bpj0ZY+i1eX+mpj8BsNRmj1j3aFApR5LsGL634xvALBIcOa
         Ty29Nlt98bVvYpixTSY52lYtE07hutfIP5ylAydet+zV6lfRVZQhjwrW0cxTlavQUnjM
         0zivUTgp6mx89KFmaSBsdr/iOeEj5JoD19b6OyzML/CTi/4YcaVTojzJG75yao/3w9LL
         DskEom9A8hw5/nG89cLMuR8il0xAJ+JepPVW4dmE3Ekj7IO3wrwcQp2im9Ovc1SI5Tek
         GMOA==
X-Gm-Message-State: APjAAAVfpeLrbzKb8YCWo5P9/kYa2CK1XJNC6Q2rS+yreYMr/CB6fDCE
        xOk+VkD8OxuTaNanNnR4s+o=
X-Google-Smtp-Source: APXvYqzv5riKF2f6s+GAiQgXDUK4PdkDbWOnQ/fIQXoMXCazqIYoWnG47zR64ADnMqBzCF0Pp0B+zA==
X-Received: by 2002:a6b:7616:: with SMTP id g22mr13753417iom.192.1576364776367;
        Sat, 14 Dec 2019 15:06:16 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id w21sm3208834ioc.34.2019.12.14.15.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 15:06:15 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        =?UTF-8?q?Hildo=20Guillardi=20J=C3=BAnior?= <hildogjr@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu
Subject: [PATCH] staging: rtl8192e: rtllib_module: Fix memory leak in alloc_rtllib
Date:   Sat, 14 Dec 2019 17:05:58 -0600
Message-Id: <20191214230603.15603-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of alloc_rtllib() the allocated dev is leaked in
case of ieee->pHTInfo allocation failure. Release via free_netdev(dev).

Fixes: 6869a11bff1d ("Staging: rtl8192e: Use !x instead of x == NULL")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 64d9feee1f39..18d898714c5c 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 
 	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
 	if (!ieee->pHTInfo)
-		return NULL;
+		goto failed;
 
 	HTUpdateDefaultSetting(ieee);
 	HTInitializeHTInfo(ieee);
-- 
2.17.1

