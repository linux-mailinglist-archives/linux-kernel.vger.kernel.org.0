Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664766D698
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGRVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 17:41:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36337 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:41:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so13472954pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXkPzSZf/fna3v9Du6552FbVJUMqyGEVvH1pVYvIMY4=;
        b=V5STNS/qoo+hoVZ84al1gz5fifOhZXi5TNLkAQyzXqvCHDez69Q42Gc1XWjzaNNbwG
         N7LT6lGx8NtDTUhplToKtR5wwYE6ctQpODx/wBZoo5gu5HBfYvoV6pcDfJt2GkeMitc3
         NQse+pSPY+bAuwZMPQRQ1+RWkkLvdMU80lmc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXkPzSZf/fna3v9Du6552FbVJUMqyGEVvH1pVYvIMY4=;
        b=afHXiWrGl7KLDd2NuaBV6SMo1RdYSVpdND0HiQjxsb8qD3Tb2JZPth7lYIsBBQ+4wI
         7DzwbIEw4vhuMKrKTo4t4Ivzmxn+TOcHpVDh05llOt1SJX/SM0X7eFlzcUoi1MC/Y58y
         1kyD4TSDnpTBcQJikW13t5Uy1LvYPgl0iRktEi1sf7tRt8rsClhpIKDZH9l/nkCWOgvs
         gTjzt4JVtRgVKV+pZpqw+FEiP9YDCTEksfFxRNeTgLytDAEFx7KelZRukkmbLtZklIgH
         nbYBjm3yYMYZbJ5QNcd84OUMKhqfRsntpu55QAJsZD5AP31wMBMf4xXMdTi9mgbc2mqI
         77Vg==
X-Gm-Message-State: APjAAAU8/nGWXbOkmSXAVmiepJGuYvAk7KVfOoF0hUNvqhaxBPTLohS3
        pjN0X7vYGIL6/bnRc8ghSNWyZg==
X-Google-Smtp-Source: APXvYqyHVzz82WKLnz3eIxpxYsyXxPYr1dGo2TBVXXV3yFi26z+3ibdtZ3ZK/+C5B+QnidGKJlAWOQ==
X-Received: by 2002:a63:f456:: with SMTP id p22mr23401451pgk.45.1563486109760;
        Thu, 18 Jul 2019 14:41:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e17sm16860239pgm.21.2019.07.18.14.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 14:41:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the internal I2C controller
Date:   Thu, 18 Jul 2019 14:41:35 -0700
Message-Id: <20190718214135.79445-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDC/CI protocol involves sending a multi-byte request to the
display via I2C, which is typically followed by a multi-byte
response. The internal I2C controller only allows single byte
reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
supported when the internal I2C controller is used. The I2C
transfers complete without errors, however the data in the response
is garbage. Abort transfers to/from slave address 0x37 (DDC) with
-EOPNOTSUPP, to make it evident that the communication is failing.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 045b1b13fd0e..e49402ebd56f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -35,6 +35,7 @@
 
 #include <media/cec-notifier.h>
 
+#define DDC_I2C_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
 #define HDMI_EDID_LEN		512
@@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
 	u8 addr = msgs[0].addr;
 	int i, ret = 0;
 
+	if (addr == DDC_I2C_ADDR)
+		/*
+		 * The internal I2C controller does not support the multi-byte
+		 * read and write operations needed for DDC/VCP.
+		 */
+		return -EOPNOTSUPP;
+
 	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
 
 	for (i = 0; i < num; i++) {
-- 
2.22.0.657.g960e92d24f-goog

