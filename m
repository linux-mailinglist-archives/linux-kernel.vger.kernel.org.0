Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3352710F6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 06:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLCFXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 00:23:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43558 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfLCFXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:23:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so1231438pfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3jEZWcL7GDtf1dkrmxImtelr/uLTAn26FhaUYUisOhw=;
        b=ANH+ejgmPfpj3NzV3qtaOVx1ksjtj4W69naT7IoMuV1TjeGCfzrZrda08QEo0VfJoW
         PQDnpU2Ta8Q+V8e77eF2OsPDDY4DlStmUCh1zqAAMVnCeuoIArFe9a2yjeboqGUBPg/c
         1HG/HR+5jBsN8dyNCCq6daMvLh6b742dkK37EaponwduxnD0dYXqzAkF7PxRgz8pabV7
         0OwuJ17wONmLe4ZNQhmjFDTsMFm0lblFyZ3mqQGfnWwoUVJiyB7KHZjmeh59ZMYjR/Y9
         GXgXTFND0z5uh33fnzPx/WHvA0x2QbmlI1AP07kvsL2HnohhzXA5Vs9iIHmIPuoCHaSc
         J4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3jEZWcL7GDtf1dkrmxImtelr/uLTAn26FhaUYUisOhw=;
        b=L/lvLXIDq6MU/OqPqPmEv+e6mm9DDLkeagjrnWz0lW9SF5oxNewOKdQuJzbJYjJDgs
         3lIDoBGuQEjM73gwEBcC2+WWInH1QJkQYoJexvZOeB9Xf3GapKxeJuun444Um796/PBh
         iQ8YI/iy+mpcCQYYEK/5QdeTkVNFT7uVSv51WAfhciRclBStYNVlaKJDVCl27GnWvOQc
         zdTQ/fK0kCtVu19k12B7n7Jrn9X5X2mKvL+yzEK48fnrRAMYFqWozBPEWx7roHCrTG8i
         wb9WTMdPD6/vy6IvQgYQH6EHTuCUMc21iZO+JxReL/06eR37Z15PDot5L5KEq+ahTtYR
         +E1w==
X-Gm-Message-State: APjAAAUSE00OEYUqPei0O+dd5PI9mxHpELLBeS6u4fpafHMqRGP9VTHg
        5JBq9LzuOJmpacG4ewbXrWdw4qUy1FxByw==
X-Google-Smtp-Source: APXvYqxOpO0V31DdYipTMzgAyt2QeL+WNvprU5q1bpRDMfG5vQZjOpkOe3TyskN+E7PuiClBUGB5XA==
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr2901081pfo.248.1575350624411;
        Mon, 02 Dec 2019 21:23:44 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id p16sm1509689pgm.8.2019.12.02.21.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:43 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/9] drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
Date:   Tue,  3 Dec 2019 10:53:23 +0530
Message-Id: <1d24d634859bebd57e346c3ec4c726a01b7644ba.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the sensor data is initialised at init time. Lock it down by passing
it to functions as a constant.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c | 14 +++++++-------
 drivers/thermal/qcom/tsens.h        |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index a383a57cfbbcb..2a28a5af209ec 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -245,7 +245,7 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
-static int get_temp_8960(struct tsens_sensor *s, int *temp)
+static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 {
 	int ret;
 	u32 code, trdy;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c8d57ee0a5bb2..c2df30a08b9e4 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -128,7 +128,7 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
  * Return: Temperature in milliCelsius on success, a negative errno will
  * be returned in error cases
  */
-static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
+static int tsens_hw_to_mC(const struct tsens_sensor *s, int field)
 {
 	struct tsens_priv *priv = s->priv;
 	u32 resolution;
@@ -160,7 +160,7 @@ static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
  *
  * Return: ADC code or temperature in deciCelsius.
  */
-static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
+static int tsens_mC_to_hw(const struct tsens_sensor *s, int temp)
 {
 	struct tsens_priv *priv = s->priv;
 
@@ -275,7 +275,7 @@ static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
 }
 
 static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
-				struct tsens_sensor *s, struct tsens_irq_data *d)
+				const struct tsens_sensor *s, struct tsens_irq_data *d)
 {
 	int ret;
 
@@ -346,10 +346,10 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		bool trigger = false;
-		struct tsens_sensor *s = &priv->sensor[i];
+		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(priv->sensor[i].tzd))
+		if (IS_ERR(s->tzd))
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
@@ -457,7 +457,7 @@ void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
@@ -486,7 +486,7 @@ int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
 	return 0;
 }
 
-int get_temp_common(struct tsens_sensor *s, int *temp)
+int get_temp_common(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index be364bf1d5a63..70dc34c805377 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -67,7 +67,7 @@ struct tsens_ops {
 	/* mandatory callbacks */
 	int (*init)(struct tsens_priv *priv);
 	int (*calibrate)(struct tsens_priv *priv);
-	int (*get_temp)(struct tsens_sensor *s, int *temp);
+	int (*get_temp)(const struct tsens_sensor *s, int *temp);
 	/* optional callbacks */
 	int (*enable)(struct tsens_priv *priv, int i);
 	void (*disable)(struct tsens_priv *priv);
@@ -494,8 +494,8 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
-int get_temp_tsens_valid(struct tsens_sensor *s, int *temp);
-int get_temp_common(struct tsens_sensor *s, int *temp);
+int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
+int get_temp_common(const struct tsens_sensor *s, int *temp);
 int tsens_enable_irq(struct tsens_priv *priv);
 void tsens_disable_irq(struct tsens_priv *priv);
 int tsens_set_trips(void *_sensor, int low, int high);
-- 
2.17.1

