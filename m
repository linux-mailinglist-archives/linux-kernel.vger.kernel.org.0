Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86ADC16B0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgBXU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 15:26:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38973 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBXU0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:26:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so712343wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFJFMPloKOQ/IG47taQgRmVN4tJaMKxeC+zVgEVtvZE=;
        b=BNfZNGy7WdEPe3PKPsg9YivRp+RUhv0+ve6J8VFZEmqTUOfoLrH7KYhCvGR2g01D4a
         Pb2Qd2nnV24DKXlrAiHclHT9p98ECp/bhL/RJPy8WzBhzoWZXL9q7Tx/NpJ+sjQyaXTA
         AytsgDPB+Jh/1R1K6frQ4plfMfnPujtX5tYQufhsqIeCteqiqsPSCbqxu7xebcQ+K3h/
         AKmdd19qKkwx/PXzTZWPeQh4qYXyKesalj0rkwsCXvgOelKj1nfxpxOlufrBMS1Ddes8
         /igORiPavhgkBbvaF3Y0jaWDYsD3UvKoVGAKJnelrQpDPSE8TSOtb0nSK1pgx0YyVmWQ
         2+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFJFMPloKOQ/IG47taQgRmVN4tJaMKxeC+zVgEVtvZE=;
        b=WzmXiLk4F6AQmibZYMi+isnH0ZJP+/l3vJh5L3GboUaNiyp4jInkWQQmYevi5WWjOH
         b5sVH7JX6eBTIOLaHP4zoHfpZ6YUz31CNNaOs00+1b/0coENPp0MtRllGOvPY+KFvhVK
         wo9H0LzSHehV0hErXL/OU/2Rs7ke73JwKMVeTISWGZ0+bq0DUtdmQKLVyx/Sl8GOiqwH
         1W3i1Dq26xcviZa0UV5Q8QAQ+msKlPP0MLBt6crqo0McQT4slfoTbaORR3ie/sukpDIl
         FsbxSBt83LNajzm/OlA5/hCAYTHhU+T5fViac1S23KZyrxtRFKV6pnM+dJ4HvzF8crRl
         /qeg==
X-Gm-Message-State: APjAAAW4zChRXvv9ehZzg/q6dGtelWfbPyS9JVQHxnpg4yGBpoUOgE5e
        FwDq6WafoWsjDsnsvD/jtkpjzQ==
X-Google-Smtp-Source: APXvYqz6tJk9pKs3DlwhvMLLlWxvdmWF7oCGr0eqdeFZlTpXS6ZQYBkZW/MD5mv+P/ZNP0JEtY3uqw==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr183019wmj.43.1582575969920;
        Mon, 24 Feb 2020 12:26:09 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a7sm13356602wrm.29.2020.02.24.12.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 12:26:09 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] crypto: sun8i-ce: fix description of stat_fb
Date:   Mon, 24 Feb 2020 20:26:03 +0000
Message-Id: <1582575963-27649-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582575963-27649-1-git-send-email-clabbe@baylibre.com>
References: <1582575963-27649-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of stat_fb was wrong, let's fix it
Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 8f8404c84a4d..0e9eac397e1b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -214,7 +214,7 @@ struct sun8i_cipher_tfm_ctx {
  *			this template
  * @alg:		one of sub struct must be used
  * @stat_req:		number of request done on this template
- * @stat_fb:		total of all data len done on this template
+ * @stat_fb:		number of request which has fallbacked
  */
 struct sun8i_ce_alg_template {
 	u32 type;
-- 
2.24.1

