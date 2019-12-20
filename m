Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D292127290
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 01:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLTAvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 19:51:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35381 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTAvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:51:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so4256796pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOcPFNf2vX0/BY8Sft5h0txWxIib2Ekx0BekGv4rKT8=;
        b=Lz51U0QI0OgK6Qj5WmzoQvNIGP4CNPWEYzgHpnhPem/ApUZzq9fpsuh4efxpqxpLC8
         AomHskpcZgljqvzpJ7UDmUVDmKs9QxmlDGQapttcc3GKAwJkVqsQzJtVFxRpyPwPDeKU
         4mI/OaP29a3yrqQWiJVpybc2z2ttYiTSl6/rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOcPFNf2vX0/BY8Sft5h0txWxIib2Ekx0BekGv4rKT8=;
        b=ASHX50fh2BO4Th6RRZBnJWTOliJD8GgN7WLmhd6nIkd3TZhMmBhmC/5pTtDn/h3Gic
         bhbpukfjfKJVZYmeglgZaz91qf00ZUTapcCxbWhZ5tyI6DWYFOmoEqHhBD9bt/3tss+U
         Av/XEbuCzRao/DsjTIA6qt5uBlk+8PmrdoaFSD2cz++/NACLmOhmioGAdOpnkPla4lWT
         qCfV6V0piZ1Aj67HNVXo9EZqOoMnvWdrHInWMKgL11IMbee460V9PIVXuH8uDkRfesgM
         JuEaYyFVRjmQwtEziv0RJeGRjJ0EGvBu9pEaapfBAuYBjNfrDqGoaEwDvf1VA+psFdUy
         r+mw==
X-Gm-Message-State: APjAAAXRg00mRekDTwFNRzaJ6xmLMGkWLnFzZK4SddJx2Kchjctvjdzm
        QEr35zLpHz/3hOOUfYYlnfihoA==
X-Google-Smtp-Source: APXvYqx0zMwXaFm3Ll6uQnl1zySKniwcSnnlHZJRpdZrbbpWoYT0xnd3kTkZAlmnuc9dsa5CoVNtUA==
X-Received: by 2002:a63:d406:: with SMTP id a6mr12217402pgh.264.1576803064022;
        Thu, 19 Dec 2019 16:51:04 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id w8sm9466116pfn.186.2019.12.19.16.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:51:03 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v2 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
Date:   Thu, 19 Dec 2019 16:49:47 -0800
Message-Id: <20191220004946.113151-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
subdevice on non-ACPI platforms.

This driver allows other cros-ec devices to receive PD event
notifications from the Chrome OS Embedded Controller (EC) via a
notification chain.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Removed auto-generated Change-Id.

 drivers/mfd/cros_ec_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index c4b977a5dd966..1dde480f35b93 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
 static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-charger", },
 	{ .name = "cros-usbpd-logger", },
+#ifndef CONFIG_ACPI
+	{ .name = "cros-usbpd-notify", },
+#endif
 };
 
 static const struct cros_feature_to_cells cros_subdevices[] = {
-- 
2.24.1.735.g03f4e72817-goog

