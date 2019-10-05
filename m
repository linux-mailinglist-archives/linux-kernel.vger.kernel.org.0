Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B07ACC94F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfJEKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 06:16:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33977 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfJEKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:16:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so4360005pll.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By/tkFXpcovd+/oyN3ineSJ0gYN93wEee4C2ekIO2Ic=;
        b=oKYr8rvm7PDDnBB0z2S6/KdLSYzcUNHwSOj1J9T/ChP0bnupJTdyM+SfvEPl1GzLPt
         NeFCQ/a7Nmqv03dECle5ic16CoB8H2UHbglD+VB4p79kmUVMZUNJtdq6rjozXagtM6Ez
         OIoz2fWoVuXD2zAk35AyB0F+h2mnTKUPFPMB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By/tkFXpcovd+/oyN3ineSJ0gYN93wEee4C2ekIO2Ic=;
        b=MXQEjLDGNTxa4O0VjCj0Pxg0WydcZVRmG8uRVuYN9xSurvlgbKlxWLAnTLB4EJo51Y
         ZaYxuAPQGVJP5SinMPXCH3aKjFBFWzjMl71YTm/7UciRooAQcP5mTfWtUg5H2vefDyJ0
         5gcNYelSl1w3llNFeqJxRrQhRbto3yRpSet6XRPwbUqldni3SKiyfN4BH9cb6oNWIZlf
         wSZlmq3jOqF/pdQRjeoIRan8+eiQNR2PEMmjLuNRuvg+dqphPXtQYPtncU34ilN2tRal
         M1wY4zYuNvR/rWAZVLz3bo+odJrheBC8lqJJTzWEkEDPsE/Jj1+mlCusdASjtZkrmgW7
         AQwg==
X-Gm-Message-State: APjAAAXeJ8orlud6i8uu3m1S881pUcLq48e/cbQtkFjVmBJBBVodynz0
        2tFHdnbRosDgDzIcTnx775reLA==
X-Google-Smtp-Source: APXvYqyx6DaEE0oraB7LAbHSkND2TJ8TnSGts/p6253FS+92EDlqSNGabp0guVGGBosi3GSyYCx/1w==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr20268276plb.328.1570270602686;
        Sat, 05 Oct 2019 03:16:42 -0700 (PDT)
Received: from ikjn-glaptop.roam.corp.google.com ([61.254.209.103])
        by smtp.gmail.com with ESMTPSA id v68sm10682279pfv.47.2019.10.05.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 03:16:42 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Ting Shen <phoenixshen@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 3/3] HID: google: whiskers: mask out extra flags in EC event_type
Date:   Sat,  5 Oct 2019 18:16:29 +0800
Message-Id: <20191005101629.146710-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whiskers needs to get notifications from EC for getting current base
attached state. EC sends extra bits in event_type field that receiver
should mask out.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index bf2b6c6c9787..91cb62afbc2b 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -96,8 +96,9 @@ static int cbas_ec_notify(struct notifier_block *nb,
 	struct cros_ec_device *ec = _notify;
 	unsigned long flags;
 	bool base_present;
+	const u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
 
-	if (ec->event_data.event_type == EC_MKBP_EVENT_SWITCH) {
+	if (event_type == EC_MKBP_EVENT_SWITCH) {
 		base_present = cbas_parse_base_state(
 					&ec->event_data.data.switches);
 		dev_dbg(cbas_ec.dev,
-- 
2.23.0.581.g78d2f28ef7-goog

