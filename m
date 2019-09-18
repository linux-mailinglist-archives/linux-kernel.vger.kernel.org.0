Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE645B618A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfIRKiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 06:38:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39855 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfIRKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:38:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so1962059wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYuOfi6SRpI0pisf6okbAWwjxdq6TT7Dd4t8NehGj3k=;
        b=P8PJaeWyFpty1cB9YHCqKvCTTWMWK0nWXQ+nzYkZdFv0c9YfzcSZGX6CJ7KYmTtUDF
         liF3SCWikSVOf4EiWOrUEY463Tt7EGH6/SWNIa1yChhgvRNOzBFZUNH8kLE4ZgMKnx/+
         TCaNRDfKDUQqVO0caACcS9V6xUwNMLj1ApPIn7zHdMP0MMkj4cVKWzGZt7Xj6FITUuml
         LzK8n7fOHGaEAwU6mncYnFuMt7EIDEL2iI3Xiq4oG2pmV/ycr5l5pVTku0ItoDzb7Fyd
         9pK9d/3a0E/jBIy3sYbXF90d/coyoH3lDfZFCL+qsF3RFHhv6UsAuWHwUhnvHNw4erMq
         rnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYuOfi6SRpI0pisf6okbAWwjxdq6TT7Dd4t8NehGj3k=;
        b=J0I5MKkpQdkN1j3SJrQ6kxiReqFAwRxxUk6MfLhC//QZdWHiTqCP8nN9ptvU9C822V
         SLpsvYhx7kgJvIEojaPZOsQfOn5WVTSK+JLTOEVQ3o3qlz5VjJQrCceZB7SME1trhmL+
         WufVeeqHxb61zqJwZUBlwezqTdO4a88pEfRocao2WCsugcpzKPp5n4iMvoYTpeBaZugP
         b7BMU2PgezihWDl5VaxC9WjKHDTKOq/4ChkpN17qeUJye81pceq7pBeLwTXAHmh3Sg0/
         tJSlj9Gl5zGIPSG2FAIjI5xOisl2le6cgzTgJ11yLMqJHEV5pO2/C/x27CDDSWaBUFul
         gawA==
X-Gm-Message-State: APjAAAWPu9ztbupAtDtmuSBHfrAUHrHR77CW8w1Z2Gvaq8ZfflrhvByU
        wVeGy78QjpQJSXNeLPb4S+uXyWFhskisbw==
X-Google-Smtp-Source: APXvYqyiY17RMt+LzMSEzkyulXEt5507TcTU9m37clIy3bS1NeFO+C7SqXCv51y3xJGJDfG+KnoKfQ==
X-Received: by 2002:a1c:c189:: with SMTP id r131mr2301208wmf.153.1568803132510;
        Wed, 18 Sep 2019 03:38:52 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id a13sm12721867wrf.73.2019.09.18.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 03:38:52 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Fix implicit unsigned to signed conversion
Date:   Wed, 18 Sep 2019 11:38:28 +0100
Message-Id: <20190918103828.257631-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An unsigned integer variable may be assigned negative values, and is
returned by the function with an implicit conversion to signed.  Besides
the implicit conversion at return time for which the variable
representation is fine and there is no variable manipulation that may
lead to bugs in the current code base, this is a conceptual error.

Fix by changing the variable type from unsigned to signed.

Signed-off-by: Alessio Balsini <balsini@android.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6bd1e3b082d8..c76c25c45869 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -496,7 +496,8 @@ EXPORT_SYMBOL(blk_queue_stack_limits);
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment, ret = 0;
+	unsigned int top, bottom, alignment;
+	int ret = 0;
 
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
-- 
2.23.0.237.gc6a4ce50a0-goog

