Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60ADAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 05:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfD2D0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 23:26:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40321 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfD2D0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:26:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so4389236plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjmbiwT3xx0O7Zw3eEqLKXpxbtx6F0HnsFgBh+Wws60=;
        b=CNgWhxrReeKSMttB9V3/AQpjze5DuX7cltNGhy/sDaNNUG7o+k1WqxOSMkKwKlDvW2
         /9n0hGXDpt/Or05jBZQIIJVwxeyltEgOjCn83ff0quxl9zoHmE2m3a1M1H44l1FkUIzz
         fYB61oYgVr8AOx3UNCWaSDCzPBsI7r0sSZzRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjmbiwT3xx0O7Zw3eEqLKXpxbtx6F0HnsFgBh+Wws60=;
        b=PlsXB20HvTQ3uOb2zZBEFa8X55MaEELRyIBqkB2FtRbCsCmeU+dv0uy5fKpmWlcRVD
         Q8hN2SIVLBaP6EI4YFetWoEhSspEVMvljS/xzSdSQhz8dz2FlBciMeXdKzhyHeviow/y
         RXvd+OYRZFG/ZC+W2T51D65B9nnVCK3Nq0SVwegLmNQQg+4uxNTZvF/BaLkpkZoCJInI
         EYCzEO6aTfleduFNY2BMnz1uRnVoDxhzDbENINRYm1YkBuFr1b8qBbW6KM8OCpd/mZ1s
         d96D27gSp+RkOhlpSb8t+s7pcQ6udWRzvIJBz9Q2Ve5ZKrrOSqrdDyjBd6PQADujc6gq
         2xzA==
X-Gm-Message-State: APjAAAVupxmsS6JJwVisCp64LX3dPA3kaMrOQ1qaqqR3hd9iWwWFPiuD
        yZnhGFEDOAT81dDFhtf3FqNjbQ==
X-Google-Smtp-Source: APXvYqy06pNWRUPq6DrNgZnE5+p+TnTL2fBYI+0TfPcqSXM5TfqsdN3IWuQyyVKhaxJhoe+spIIhgA==
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr59457611pla.111.1556508371342;
        Sun, 28 Apr 2019 20:26:11 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id a10sm41364938pfc.21.2019.04.28.20.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 20:26:10 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH 2/2] pinctrl: mediatek: mt8183: Add mtk_eint_pm_ops
Date:   Mon, 29 Apr 2019 11:25:51 +0800
Message-Id: <20190429032551.65975-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190429032551.65975-1-drinkcat@chromium.org>
References: <20190429032551.65975-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting this up will configure wake from suspend properly,
and wake only for the interrupts that are setup in wake_mask,
not all interrupts.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 2c7409ed16fae9c..ce93e55b79a435a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -583,6 +583,7 @@ static struct platform_driver mt8183_pinctrl_driver = {
 	.driver = {
 		.name = "mt8183-pinctrl",
 		.of_match_table = mt8183_pinctrl_of_match,
+		.pm = &mtk_eint_pm_ops,
 	},
 	.probe = mt8183_pinctrl_probe,
 };
-- 
2.21.0.593.g511ec345e18-goog

