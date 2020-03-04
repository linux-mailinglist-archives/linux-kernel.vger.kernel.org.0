Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35605179C41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 00:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgCDXVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 18:21:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47058 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:21:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so1740604pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZljtzQThwDpecuM2vlainoXfY0GdB4JbRjrDIxKkqVw=;
        b=X51Ww4cDDQjtSGEQab5CxUFePA3E0q9Xltfz2iBi5F+pk4wUsdnT0FCh1zkeBK4AnZ
         fYRn2Eskf0+2NNe4UAm32iOlSeysmnqymYtkZRsygcXwZ7bEfiWKtzFDmDMODbnQa43D
         WwiaCy7APYH6WcGl674bvkuv+fV7UvKuWjX8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZljtzQThwDpecuM2vlainoXfY0GdB4JbRjrDIxKkqVw=;
        b=d2IwbxJ3Z31pG3qbYhJXoWEwHohp8dg6grrdio0gf3oMuRXxzjW3yZOCKxbyxHzuWO
         kWQ2DdCvt/5TRNMFWm5SPw/z3ekjMYMlPnO4+NdkVELluUEsMvTYlSNJqwbLE/mg+vcd
         SkNeVeBlg1zFahfReT/ni3OLrZhxPkyIrnUVlzR1W/TuIV9Ua3d7z+qM3GNsz7zr8+vB
         dUVAeFuG/pm6rQILKPrVvLDShbz5j7Ve+EoXY9ZPnpO6PfrmaMDYf7nNghAyGPTO+mbo
         4cBPNNVQdVVXeasblr1PV5Uab7LqEScPnI0sWTAHwqCGVqJ8I5/KlJuyj5iGStWZaVjl
         LXDw==
X-Gm-Message-State: ANhLgQ3GLwzin4BztGXqCiX0q1LazEjGj/O1Qs4VT1gvQhJ/p/+CTwmv
        ETl2/20MXAkQxCWdtzwraxuM0e5MYf0=
X-Google-Smtp-Source: ADFU+vvgdkBLE9X2UU51yS2ElBtkjpupgmMllO9c1/q4iOvO/vkpj4jEbDJVU/VkCcGaZr91hVU+UA==
X-Received: by 2002:a62:1d06:: with SMTP id d6mr2287675pfd.112.1583364072492;
        Wed, 04 Mar 2020 15:21:12 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id cq15sm3793261pjb.31.2020.03.04.15.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 15:21:11 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        jflat@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: chrome: Fix cros-usbpd-notify notifier
Date:   Wed,  4 Mar 2020 15:21:08 -0800
Message-Id: <20200304232108.149553-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros-usbpd-notify notifier was returning NOTIFY_BAD when no host event
was available in the MKBP message.
But MKBP messages are used to transmit other information, so return
NOTIFY_DONE instead, to allow other notifier to be called.

Fixes: ec2daf6e33f9f ("platform: chrome: Add cros-usbpd-notify driver")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 3851bbd6e9a39..ca2c0181a1dbf 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -84,7 +84,7 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
 	u32 host_event = cros_ec_get_host_event(ec_dev);
 
 	if (!host_event)
-		return NOTIFY_BAD;
+		return NOTIFY_DONE;
 
 	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
 		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
-- 
2.25.0.265.gbab2e86ba0-goog

