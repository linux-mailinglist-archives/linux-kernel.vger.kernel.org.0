Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0816B0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBXU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 15:26:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33836 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBXU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:26:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so674320wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F7a1q9zaXkmFSVJOCg0lehp0yKULwcs/09ZgYtgpjUU=;
        b=Wv4HPspEJkZrX2QzJQyje7IucGzsS7rUzgqxdGPdIZWOw1o+1CJE/ZaSrRAZVcUsgq
         u0j8BUdO73nFXL1/pYTcP03ju/oNFNmclaeoU4sE5jx59swnUqq8lX+q5zeRQOgpwNQY
         dFxFHil6Ke115v+VbH7j/GGwfwh02Vv2m9TeR8MErXOIQJClm7N9pouprrxsoSuxpdfh
         9n5nrirbEHkIHINMuriwUoxe7dcdO1DCgXZn1ETFNHbqUMoxNK/Nh8bQoYKFxhXU9UFn
         du5hl+eRew+oYMtTvMnfJ1Q6C+t/JSLZNFZfKD4Eoy8tklMrTY0Lif0/u89udl/fcTSl
         oA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F7a1q9zaXkmFSVJOCg0lehp0yKULwcs/09ZgYtgpjUU=;
        b=Y908iwrf/h9cV7mqfMCZA2NAijwqbM3slA+RZ7nndsiJ1Wq4RF6o9kymB113XrniFu
         VLHbwxTBrgkJVxpXZ8JmBNhyE2BrrtufcX3gvsp8qjF58JQr1Ome8nsptzgLegi1PrY9
         3bbRd+H4FTaWyw/W96A1EuL59jqd4Oaj9UytNGi8U3pop3PoSsNrMEMuSq2xoShs1g0G
         1/jxIzbbyVKkM70CV14xoWsCV7h0qK650xReV/9yoglTxchrPGYkRAzJeHPi+qlA0qUX
         WZx+/ApWNjBoJ0dn0HJcAPlxhw7F9YKANEMBf1ec/I6uWMOn6YQo0KHWGQKi+8MuEi7b
         kWqQ==
X-Gm-Message-State: APjAAAWoZdfO3OCvQka2boZlyfe0sQPsu6C3fcdTNVsv2nezu1mTZ1kT
        G7NSmCDAG2+yZiNwX8M9Ts2u/Q==
X-Google-Smtp-Source: APXvYqzUO5DyKjGU4OIrt+jNB0R1fsRpxxtROEgWMHzOWaT3f8jOiJ25/0nAzMg/rQtuhxQqHJnnmA==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr748049wmf.124.1582575968969;
        Mon, 24 Feb 2020 12:26:08 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a7sm13356602wrm.29.2020.02.24.12.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 12:26:08 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] crypto: sun8i-ss: fix description of stat_fb
Date:   Mon, 24 Feb 2020 20:26:02 +0000
Message-Id: <1582575963-27649-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of stat_fb was wrong, let's fix it.

Fixes: f08fcced6d00 ("crypto: allwinner - Add sun8i-ss cryptographic offloader")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 5ca8da9311b8..66c78c03e376 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -205,7 +205,7 @@ struct sun8i_ss_rng_tfm_ctx {
  *			this template
  * @alg:		one of sub struct must be used
  * @stat_req:		number of request done on this template
- * @stat_fb:		total of all data len done on this template
+ * @stat_fb:		number of request which has fallbacked
  */
 struct sun8i_ss_alg_template {
 	u32 type;
-- 
2.24.1

