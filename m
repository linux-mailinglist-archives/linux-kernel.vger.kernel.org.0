Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B51452F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 11:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgAVKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 05:46:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34883 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgAVKpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so6740823wro.2;
        Wed, 22 Jan 2020 02:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFk6HyWuJiVLCGeJdqAeRNr747mUSUy7WV52UkfDFzg=;
        b=nh4V8kN1DQ0V+SZNyGIFD0vsfENzTl54nbI5wPlIaAHa99ct2k7P5oTEzomt8FFx0h
         sTf6JhdhBFGWOb3u8FHFZTRcPYLq20x6neKn5/J81l56XH5OVnxwWHjG8R6gMhTrvtrb
         6WaSVFEc7Ecm+ArWphMtPpplt47QAHfU156O9Lzo4GmcoFKbBGU5CtdMXgzCmYljPsU9
         GxQXzTeMqHBtHDCD7tHT5NAeLU1ehq9eVOFZnwBF4n8mZJYSGTW4H8xjooVws0/5coIN
         UHd5a9MFg2IMtB68T8iFHhbjGZzKWECSnhPY4hUB47d9KBkI1/fpfk34zguUbjpGAqun
         IZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFk6HyWuJiVLCGeJdqAeRNr747mUSUy7WV52UkfDFzg=;
        b=r2Tq+Nv7PyhhRjBpL6uIk2Z3fnNz4gNibK46pGyYpZHgLH5JpfgMZHalwcU7ZEpQOW
         1I9wq2Ux4ZpQz3xBh7pf3EYaYAZvGXVNiBEaBwxMdvCgjZDb+0JQS6rw0Z6rDta3Fpya
         WMElVihhvFGbWPoivNVOzW2fVazvCWAknSBOsL7rFWOf/H31V1SQjcE79mBVUPy20CCT
         7SJdIdr1E76xjNxdngt/0lAIGWpbD3+u7NeBmrbArRAtOBbL7spGW81QoRQ7gzv/nI8p
         shi4+UCoA9Bi7b3Eu71lHqxrp8um1osGdOfIlnBDXMR+IJ5zzhfwPxKZX4b5XmmHq3gR
         bAJQ==
X-Gm-Message-State: APjAAAVzX1XF/gdGVTPLAcAUIz35B2Ew8dpb9/jaoivr6f6/Jdc22oRK
        bbHtciZHagPf0guuKEjNo3X5Hx75
X-Google-Smtp-Source: APXvYqzUJ6amFuxmvaVTDvoMRi1W7SWqh+QZ/uQqLstgRZMg10hr9CevSG9DyNj2PIUrkCqozaZhkw==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr9951911wrq.243.1579689942098;
        Wed, 22 Jan 2020 02:45:42 -0800 (PST)
Received: from Red.localdomain ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id n3sm3443953wmc.27.2020.01.22.02.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:45:41 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org, iuliana.prodan@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/9] crypto: engine: get rid of cur_req_prepared
Date:   Wed, 22 Jan 2020 11:45:21 +0100
Message-Id: <20200122104528.30084-3-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122104528.30084-1-clabbe.montjoie@gmail.com>
References: <20200122104528.30084-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want cryptoengine to support handling more than one request, we
need to remove cur_req_prepared.
It is used only to choose if we need to unprepare() in
crypto_finalize_request().
This choice is needed only in case of error, so let's handle error
without crypto_finalize_request.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 crypto/crypto_engine.c  | 17 ++++++++++-------
 include/crypto/engine.h |  2 --
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index feb0d82dd454..dfcb00e92e09 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -36,7 +36,7 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 
 	if (finalize_cur_req) {
 		enginectx = crypto_tfm_ctx(req->tfm);
-		if (engine->cur_req_prepared &&
+		if (enginectx->op.prepare_request &&
 		    enginectx->op.unprepare_request) {
 			ret = enginectx->op.unprepare_request(engine, req);
 			if (ret)
@@ -44,7 +44,6 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 		}
 		spin_lock_irqsave(&engine->queue_lock, flags);
 		engine->cur_req = NULL;
-		engine->cur_req_prepared = false;
 		spin_unlock_irqrestore(&engine->queue_lock, flags);
 	}
 
@@ -118,7 +117,7 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 		ret = engine->prepare_crypt_hardware(engine);
 		if (ret) {
 			dev_err(engine->dev, "failed to prepare crypt hardware\n");
-			goto req_err;
+			goto req_err2;
 		}
 	}
 
@@ -129,9 +128,8 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 		if (ret) {
 			dev_err(engine->dev, "failed to prepare request: %d\n",
 				ret);
-			goto req_err;
+			goto req_err2;
 		}
-		engine->cur_req_prepared = true;
 	}
 	if (!enginectx->op.do_one_request) {
 		dev_err(engine->dev, "failed to do request\n");
@@ -146,7 +144,13 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 	return;
 
 req_err:
-	crypto_finalize_request(engine, async_req, ret);
+	if (enginectx->op.unprepare_request) {
+		ret = enginectx->op.unprepare_request(engine, async_req);
+		if (ret)
+			dev_err(engine->dev, "failed to unprepare request\n");
+	}
+req_err2:
+	async_req->complete(async_req, ret);
 	return;
 
 out:
@@ -398,7 +402,6 @@ struct crypto_engine *crypto_engine_alloc_init(struct device *dev, bool rt)
 	engine->rt = rt;
 	engine->running = false;
 	engine->busy = false;
-	engine->cur_req_prepared = false;
 	engine->priv_data = dev;
 	snprintf(engine->name, sizeof(engine->name),
 		 "%s-engine", dev_name(dev));
diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index 7e7cbd9ca3b5..4d8a2602c9ed 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -23,7 +23,6 @@
  * @name: the engine name
  * @busy: request pump is busy
  * @running: the engine is on working
- * @cur_req_prepared: current request is prepared
  * @list: link with the global crypto engine list
  * @queue_lock: spinlock to syncronise access to request queue
  * @queue: the crypto queue of the engine
@@ -43,7 +42,6 @@ struct crypto_engine {
 	char			name[ENGINE_NAME_LEN];
 	bool			busy;
 	bool			running;
-	bool			cur_req_prepared;
 
 	struct list_head	list;
 	spinlock_t		queue_lock;
-- 
2.24.1

