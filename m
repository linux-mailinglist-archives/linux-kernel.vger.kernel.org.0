Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444304D11A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfFTPA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:00:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38847 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfFTPAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so3503248wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYe7DDXQIL9cgrU/J6+VemHeiSBNByBQZKqrYUm/eeo=;
        b=SZ6V1yjLoHGVxYhYdXZ8SkshTMpt0KSi4NFSU2/xx/+B0QFCZ/xBQx3++HsNUvz09q
         f8371/tpFqWte+O1B0mJZDY/m+oXsJXHnkEbSDAAnhNkUO8PnzGSlg4II9sJ3hdcTjOd
         J9WFwVcXw1Db8/Z5WDM1EbNM6t7arljsdr1fNxbt9cblHpMLQs1tfjOgBG2COUK6/X/6
         7OSdVHmMLNv3VZoB/VKHC6lVJjxUgqUX9LPBujDSjUYkKdwn8GW7yX10YVjW2J9tabmQ
         cir+m7HPer+bOdYUNrInyBmC6SndMtZN6uaPzr+/1Qtquu9r+rrXslmH7bFbqZz3QtqX
         JdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYe7DDXQIL9cgrU/J6+VemHeiSBNByBQZKqrYUm/eeo=;
        b=q+p2NetBvb6vZvUVkLMz1Qo/wD/6vyctePrrinTn32dSqNHt2gaj0cGU2rXRT5Bmij
         BxCjSJCngGgZyN9VndveBrLc6iiW4QdZk2qiUUx7uPAkhxedLlO5C3O9wXlhpP3MTO34
         BNFdfp9JpeetXnfas4eOmMT7qTdNLX/FeotzGBAD+l7eSxejaOmKtyUJvmARv3fv3eNR
         j9bqhHIqqdfPn/SzoslzQMSbFFhx3uAS688LDdzN/kSGjmPu5sn9AC33R5ndz530mJ/o
         djcssLD0J3EY2SBoBcJIViY9ZqFz1ReWpvbesZ6t2aOH3/JAqDHnmreHGSVSJhKoU67H
         ysjg==
X-Gm-Message-State: APjAAAUei+k5mjkOFbb7YGlwa7LbZpcsh85fdV07zpK9EC50zGdaB4PP
        0hh4O91bLhQkuKHjTdFRz4Yi2Q==
X-Google-Smtp-Source: APXvYqyNNg0N3Vh+whUhU6uiroJxzDG3nOrILtRfiPwOSwkxjLjsRkVzUds9/M79qG+gl3Xaq9YOhg==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr69933wma.90.1561042821614;
        Thu, 20 Jun 2019 08:00:21 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 01/14] pinctrl: meson-g12a: add pwm_a on GPIOE_2 pinmux
Date:   Thu, 20 Jun 2019 17:00:00 +0200
Message-Id: <20190620150013.13462-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150013.13462-1-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing pinmux for the pwm_a function on the GPIOE_2 pin.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-g12a.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 3475cd7bd2af..582665fd362a 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -801,6 +801,9 @@ static const unsigned int remote_ao_input_pins[]	= { GPIOAO_5 };
 /* ir_out */
 static const unsigned int remote_ao_out_pins[]		= { GPIOAO_4 };
 
+/* pwm_a_e */
+static const unsigned int pwm_a_e_pins[]		= { GPIOE_2 };
+
 /* pwm_ao_a */
 static const unsigned int pwm_ao_a_pins[]		= { GPIOAO_11 };
 static const unsigned int pwm_ao_a_hiz_pins[]		= { GPIOAO_11 };
@@ -888,6 +891,7 @@ static struct meson_pmx_group meson_g12a_aobus_groups[] = {
 	GROUP(i2c_ao_slave_sda,		3),
 	GROUP(remote_ao_input,		1),
 	GROUP(remote_ao_out,		1),
+	GROUP(pwm_a_e,			3),
 	GROUP(pwm_ao_a,			3),
 	GROUP(pwm_ao_a_hiz,		2),
 	GROUP(pwm_ao_b,			3),
@@ -1192,6 +1196,10 @@ static const char * const remote_ao_out_groups[] = {
 	"remote_ao_out",
 };
 
+static const char * const pwm_a_e_groups[] = {
+	"pwm_a_e",
+};
+
 static const char * const pwm_ao_a_groups[] = {
 	"pwm_ao_a", "pwm_ao_a_hiz",
 };
@@ -1290,6 +1298,7 @@ static struct meson_pmx_func meson_g12a_aobus_functions[] = {
 	FUNCTION(i2c_ao_slave),
 	FUNCTION(remote_ao_input),
 	FUNCTION(remote_ao_out),
+	FUNCTION(pwm_a_e),
 	FUNCTION(pwm_ao_a),
 	FUNCTION(pwm_ao_b),
 	FUNCTION(pwm_ao_c),
-- 
2.21.0

