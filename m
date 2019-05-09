Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427C818E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfEIQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 12:29:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39081 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfEIQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:29:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so1499171wrl.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=msbkGlp4GOhLlJp7h+ns/oU8AGbAhiOw2cYUQ/XgHZU=;
        b=xS1VywjWrFyLh3lo+vb3RWdkkLAbJqqixS5IT4hU++kiORkBPbMTXfPcHMI2cmy5hn
         xdt0HWeHDA71R+9fSDwE/gIvuX+0SiMt0AtCaBv/APZ2/Oj+Vyb7I8ZbIYIf2F5dT7PC
         R1lokdKdcXy5XPtz/gYe2jRIBtYO5GG7KhgJfb/vYa1Ibyt2dV0SHJJHjSL+Oc6qzgBs
         wyIosNYKxTUV4SVmdJyEoTr6p/+giTmP2ib5uUkZeYL2kKfsy5GjspWcYVfLahbI4/zs
         DqUeYXI57tEJYSt6z4mjefpFXY0Zzp0D5VN4V3ErckH/5qfCcF4bri8usBdIuy2wXDMA
         52Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=msbkGlp4GOhLlJp7h+ns/oU8AGbAhiOw2cYUQ/XgHZU=;
        b=ETavZvCS7X9lqm+5p2TIKAZXr6/hR3efhgTM0bqt67Qrp3fJCyXQNRej4vKu9zBJ6s
         Tn87v3ChB6ZZak357ObrNIMO9Ea0ByDSgKl6+Lsw6N1YgO9goe+3R6Z7LY3yn9eY52vk
         4cFlyWq6YXM/qQmcUHkn3xRtOZfuA/ww9C0lAmwX4JFK6BSpWJuYDYPWmHN69u6b2/pz
         2sTqiPuqsCRuqGsR8qKz2t7eBRo0Ny0P09pB63RMdirK8QRBSJKAbQE/MfQBLKyOAErx
         q8hrOKE9515RPnbiPv/81OBOGPKfw0pLVFQxAS2wQ5g0H5TKWdYjn95Zbq/zc+vHW+1Q
         15rQ==
X-Gm-Message-State: APjAAAWRSk49sCk8wZMiz1wr8ljWatx5/I9X76CLdCYosqZxea88GGE0
        f+oyfbt3BvxSFakHIFxcBqZUXA==
X-Google-Smtp-Source: APXvYqy25nPIxDd/ADG4cOOYu38LaDBQ0Ds9yuOXNFSzMNSqOVbU35BiUtC2tVw26LO1v2rXUAa3Kg==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr3674909wru.211.1557419364665;
        Thu, 09 May 2019 09:29:24 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id k2sm4116297wrg.22.2019.05.09.09.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:29:24 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] pinctrl: generic: add new 'drive-strength-microamp' property support
Date:   Thu,  9 May 2019 18:29:16 +0200
Message-Id: <20190509162920.7054-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509162920.7054-1-glaroque@baylibre.com>
References: <20190509162920.7054-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drive-strength-microamp property support to allow drive strength in uA

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/pinconf-generic.c       | 2 ++
 include/linux/pinctrl/pinconf-generic.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index b4f7f8a458ea..d0cbdb1ad76a 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -39,6 +39,7 @@ static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_STRENGTH, "output drive strength", "mA", true),
+	PCONFDUMP(PIN_CONFIG_DRIVE_STRENGTH_UA, "output drive strength", "uA", true),
 	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "usec", true),
 	PCONFDUMP(PIN_CONFIG_INPUT_ENABLE, "input enabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL, false),
@@ -167,6 +168,7 @@ static const struct pinconf_generic_params dt_params[] = {
 	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
 	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
 	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
+	{ "drive-strength-microamp", PIN_CONFIG_DRIVE_STRENGTH_UA, 0 },
 	{ "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
 	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
 	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 6c0680641108..72d06d6a3099 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -55,6 +55,8 @@
  *	push-pull mode, the argument is ignored.
  * @PIN_CONFIG_DRIVE_STRENGTH: the pin will sink or source at most the current
  *	passed as argument. The argument is in mA.
+ * @PIN_CONFIG_DRIVE_STRENGTH_UA: the pin will sink or source at most the current
+ *	passed as argument. The argument is in uA.
  * @PIN_CONFIG_INPUT_DEBOUNCE: this will configure the pin to debounce mode,
  *	which means it will wait for signals to settle when reading inputs. The
  *	argument gives the debounce time in usecs. Setting the
@@ -112,6 +114,7 @@ enum pin_config_param {
 	PIN_CONFIG_DRIVE_OPEN_SOURCE,
 	PIN_CONFIG_DRIVE_PUSH_PULL,
 	PIN_CONFIG_DRIVE_STRENGTH,
+	PIN_CONFIG_DRIVE_STRENGTH_UA,
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_INPUT_ENABLE,
 	PIN_CONFIG_INPUT_SCHMITT,
-- 
2.17.1

