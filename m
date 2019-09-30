Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D839C244B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfI3P2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 11:28:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40264 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfI3P2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:28:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so11840872wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKNYJ+YfKpvtJJY2vQQUQXqOjR+zsvfM3h1aXu/ISL4=;
        b=H0TYWQ03EdNmCsa24PTRi/DaCpOIJ2BI1utBui9MEd6CPIO/n5FgXT5QaM7G8Byflr
         IjsUq8JljCgaDgVaAzD8uiJnP7WloIUMKN3Yd5GolIFvfw42I7kWeQ7msUUyIHgOoxmT
         qeUrgV6e8QoColLYaPZ/uWYidkmbwcECRLvj5XlCZ0prajHp0UTdR+4boOIhRHPLDq9o
         eI824KIalBfpNDFfEvSm74rwpvE1rV4I603AEVMf/nzPzkTM2snjOj9N/Ljknq6V3HMf
         EzAsVE3O+DX/VeOsQ2BL9njgaV5cZo/FxQolaudcPZx++VjdnnlQNQcuc+vizfk+Urhx
         Nb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKNYJ+YfKpvtJJY2vQQUQXqOjR+zsvfM3h1aXu/ISL4=;
        b=h7AyX6QL/2RT6EuN8uoiiFry/eFnDNTVM55tZs+bPli2LS9/8MwyMEoTlG64KWgSNg
         HNRy6kP20qcjpsUlThQByNWs0HMR1VR/ORf0ghJgxiMEN6KTLRpqnqv2sAGr1Ck5n0NX
         rbznxmQpg/AS4AA5dgBSje+XFzpeZgshGRIL4rh/XB9Ltf8+cr2wBVbvqCeBZMCYi2vt
         HdmS6OUV6fBmwtinUsPl1gQR154AuS5CeLrcqu7PS6eiVY7ItgpoifQS0IA6/uI2TEiZ
         CrxeXj2yiiAVIiIH7Uyn8pozrpvRMsOkCq/eJgvqBNa4VnXr+LLNsp80rgukLQXFEUha
         XRHA==
X-Gm-Message-State: APjAAAWr6sxiM3Bp5OSD4aq6dtL2jLbrXZPX0hbw7RBqXRKJ5tTNlF0D
        NeIEB/H9+j9FO/EF9TMwOc+Dxw==
X-Google-Smtp-Source: APXvYqzP1+989rANQG2Lck5S3rwS82kAY9NARdWl/o2qRDBdRfMkejnRZIf/tpixmscYbkuO/ufQZA==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr13698975wru.190.1569857329714;
        Mon, 30 Sep 2019 08:28:49 -0700 (PDT)
Received: from radium.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o19sm12420949wro.50.2019.09.30.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:28:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, wsa@the-dreams.de, qii.wang@mediatek.com,
        drinkcat@chromium.org, hsinyi@chromium.org, tglx@linutronix.de,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date:   Mon, 30 Sep 2019 17:28:46 +0200
Message-Id: <20190930152846.5062-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit abf4923e97c3 ("i2c: mediatek: disable zero-length transfers
for mt8183"), there is a NULL pointer dereference for all the SoCs
that don't have any quirk. mtk_i2c_functionality is not checking that
the quirks pointer is not NULL before starting to use it.

This commit add a call to i2c_check_quirks which will check whether
the quirks pointer is set, and if so will check if the IP has the
NO_ZERO_LEN quirk.

Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for mt8183")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v2:
	* use i2c_check_quirks to check the quirks

---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 29eae1bf4f86..2152ec5f535c 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -875,7 +875,7 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 
 static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 {
-	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
+	if (i2c_check_quirks(adap, I2C_AQ_NO_ZERO_LEN))
 		return I2C_FUNC_I2C |
 			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 	else
-- 
2.23.0

