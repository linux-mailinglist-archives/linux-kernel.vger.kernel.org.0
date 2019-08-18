Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9B915F0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfHRJfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:35:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfHRJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so559463wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tg1DLOMsJQjiTIKri8X/vwSYJc+QAfp9dprhf0452G0=;
        b=yLBQ4i/biurw25qA7X6sHOSPqNtYLI43MAHC8JZkBazu8MLujF0P3WT9P6RlqJYbC7
         ywsGzZpa8QJS6MKn3DThuYJN65fzYU0eAHntHj3NPx2R7uzIo5SIDc2tYkdE9M50cZ2n
         GmW+Z3MH5bY70uZE3nbaebaDbTsRXz+u+xDtbYodSDBLaStU2MFafFpGcVpHqRy+v7+5
         YtvPHXlgdIzR8FZobqRO+m1ADjVGN0G9uFXhV53JuFEDfLtSvo/JKoTvjVvnBzfhhmgp
         JCo9NW80Fa7n6AzGPv54xrgxSwuy5Jsb14Sh51/drB8DLfm3JJYfWmVLEF3jkpl53yJA
         F6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tg1DLOMsJQjiTIKri8X/vwSYJc+QAfp9dprhf0452G0=;
        b=OFJN7ex0gT3hVBYwUPwfbix7VpBFhuSkiXJTfqSSqtiqoxGFt3kHDWT8GKMejeCzjc
         wb4NfBr/r2fVj05Vevcz8e5+Cc+k3mMQETCcl32l579CKTklm8u8OAR1DQIhNNJRc/AI
         hG11eRrUA916IFESkoyvgT5wf2cRNEoZJ6nPECl+W7RkOy22h1EBBQgvFGqLUauVXcee
         z0Dof5WX4JbxiojgqvRjOBEexNAtCY6XU4K+yLOwEgZ/EdSg6VPzuWiimo1seeEQLj1u
         RN5NRwN/akL9SlBC1h1pX/YZa+SBBxnq609o0KHYgafhiHdMkDl0Cak6yJIRv1LqzjKL
         rT4w==
X-Gm-Message-State: APjAAAWIGIpjmHrltK9vkjgfwyTwtSMSIhZBGSsEeyZAVdfwAfphvVn6
        C9QsrunfTm6Qopm01cRXsISiKzmt+I4=
X-Google-Smtp-Source: APXvYqyCN2/BZ3on3ZHB7/3Yn8kPyuhUgUqho2UORZ6i2L5YTsiufP6zutTPhouSih4Wq6r20BY0Nw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr15532747wmk.90.1566120879060;
        Sun, 18 Aug 2019 02:34:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stefan Mavrodiev <stefan@olimex.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] nvmem: sunxi_sid: fix A64 SID controller support
Date:   Sun, 18 Aug 2019 10:33:41 +0100
Message-Id: <20190818093345.29647-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Mavrodiev <stefan@olimex.com>

Like in H3, A64 SID controller doesn't return correct data
when using direct access. It appears that on A64, SID needs
8 bytes of word_size.

Workaround is to enable read by registers.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a079a80ddf2c..e26ef1bbf198 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -186,6 +186,7 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
+	.need_register_readout = true,
 };
 
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
-- 
2.21.0

