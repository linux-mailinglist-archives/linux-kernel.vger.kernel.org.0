Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37C889805
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfHLHlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:41:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55235 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHLHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:41:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so11220860wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5zoubVUV7rcyu+sBMkjoQHPoTk823dweMgA9I2pxu8A=;
        b=oj9xKQN5weLDrqGdF33wfALNO3pP2/toQ8ihq2z12eGgkb7nIKBTAhb1z62fNBievH
         w+FC56ne3nMMIbgkjnqmNsSoBKBq3243EppMCqtrAFAyVvhShunPmRpQegeQVx1EbijU
         2CkywgxpFnV2UtQs6B639luHHpqN8iFcxs6Hx+smiTJI2rkNDied/gjELW0vWDNSL2Vp
         98OejKvyd9WagvJuLP5JH4m8AD8tLPpH6d7GAGTNIRV1GCnO94fIu7qDIKGZddOyyVKh
         nVU0KYT1ZBdEG0pXX8G3/UfpL8SZs6aCrralF94EUXJY3ZtUeTHRuSoITooxkhj/ispe
         LYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5zoubVUV7rcyu+sBMkjoQHPoTk823dweMgA9I2pxu8A=;
        b=j3zKvn6t8BGDmoW0IVjj9BnORPgy0UHNVQj18SssP5dcu28D157V4VPmByyAdcTwJv
         RC/FSoU2gm7u2ivhUuFxN43agmO4t5Q7x8tQflMuvMMStTJ171UEj9RuX1MANas9Rx30
         wbHPNTMqLtw4bZTEygXzWOX0R6/2/VCjNvLwJQVasejCqpwF7yScmcE5LxrONrWuHQKx
         HzDIe8T4/wkT0Sx7N2qr4eRWlIeGVQfgCky0uQsXbhZ+hyhkki35rE9qHOLEY9sL3svW
         Ys5xbyH00lLf1U1eXpAYnzJ9NwdNHP1XjVw5VZ2HGvIMNkywnm3q5CTo4Kmwc3YAvDLr
         TAtQ==
X-Gm-Message-State: APjAAAUgoKrpCZqAAFz6Tf1uw4PZMa1aJm7OXpApU0zTcyQp3fGUAy7p
        5nKJmJeg58/TqOJX4xIIM7yhIwCDUSo=
X-Google-Smtp-Source: APXvYqymdGbXEoss25R1NwbTNVOmcO5rbBlEmAade8bilZxtwTiG+AKucOl5+iPcvIY/eXC68SvBlA==
X-Received: by 2002:a1c:c018:: with SMTP id q24mr19092793wmf.162.1565595712986;
        Mon, 12 Aug 2019 00:41:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id g14sm11370268wrb.38.2019.08.12.00.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 00:41:52 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dotan Barak <dbarak@habana.ai>
Subject: [PATCH] habanalabs: explicitly set the queue-id enumerated numbers
Date:   Mon, 12 Aug 2019 10:41:44 +0300
Message-Id: <20190812074144.12630-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dotan Barak <dbarak@habana.ai>

When looking at kernel log messages and when debugging user applications,
we only see the queue id. This patch explicitly set the queue id in the
queue enumeration which will be helpful for finding the queue name when we
have its id.

Signed-off-by: Dotan Barak <dbarak@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a5a1d0e7ec82..6cf50177cd21 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -28,20 +28,20 @@
 
 enum goya_queue_id {
 	GOYA_QUEUE_ID_DMA_0 = 0,
-	GOYA_QUEUE_ID_DMA_1,
-	GOYA_QUEUE_ID_DMA_2,
-	GOYA_QUEUE_ID_DMA_3,
-	GOYA_QUEUE_ID_DMA_4,
-	GOYA_QUEUE_ID_CPU_PQ,
-	GOYA_QUEUE_ID_MME,	/* Internal queues start here */
-	GOYA_QUEUE_ID_TPC0,
-	GOYA_QUEUE_ID_TPC1,
-	GOYA_QUEUE_ID_TPC2,
-	GOYA_QUEUE_ID_TPC3,
-	GOYA_QUEUE_ID_TPC4,
-	GOYA_QUEUE_ID_TPC5,
-	GOYA_QUEUE_ID_TPC6,
-	GOYA_QUEUE_ID_TPC7,
+	GOYA_QUEUE_ID_DMA_1 = 1,
+	GOYA_QUEUE_ID_DMA_2 = 2,
+	GOYA_QUEUE_ID_DMA_3 = 3,
+	GOYA_QUEUE_ID_DMA_4 = 4,
+	GOYA_QUEUE_ID_CPU_PQ = 5,
+	GOYA_QUEUE_ID_MME = 6,	/* Internal queues start here */
+	GOYA_QUEUE_ID_TPC0 = 7,
+	GOYA_QUEUE_ID_TPC1 = 8,
+	GOYA_QUEUE_ID_TPC2 = 9,
+	GOYA_QUEUE_ID_TPC3 = 10,
+	GOYA_QUEUE_ID_TPC4 = 11,
+	GOYA_QUEUE_ID_TPC5 = 12,
+	GOYA_QUEUE_ID_TPC6 = 13,
+	GOYA_QUEUE_ID_TPC7 = 14,
 	GOYA_QUEUE_ID_SIZE
 };
 
-- 
2.17.1

