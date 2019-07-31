Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A437BDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfGaKAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 06:00:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43724 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfGaKAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:00:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so31588857pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MmBOwwNeN+W1dC0nmIPZG6LtIHwgJLZWSo5QrSMSqcg=;
        b=F2cmNKe82FILmNf5yBHDnTc0fv/W9P8ElxWyX9nD9eNEddHhrjcVcMripReHGh+S0v
         tSNdYbOTYj5QQBmbdLKklAfAnbsGhNRFF8O/+LB3M71Jf26oCbFHGBxBwHSsBhGdqxyA
         +KxTVK8klRgp4/pNwu9f2ux4WWomzu+suJyXaCfOMITmKuJ2rNjMgyJNtefNtQk/6Ced
         +G4XQdEfuvog8fX/p/pcnavzvF0fv3pGjJxnKPAJzsT26oHgPzE1HZaAb08cu8XimFcy
         Ot89rgQl1jDKVtz6fQ/61d+80sPzURiNrw0u2ctVaFEOZ6aLQg8LP6zliTaQ5zR/CcnX
         jBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MmBOwwNeN+W1dC0nmIPZG6LtIHwgJLZWSo5QrSMSqcg=;
        b=oJJgog/3Nl65Yhhtrn3VADu/DS59/JHmDVQG9IqFv2Ko7sPycdxLeT4AztUmFeh5wC
         U/Hu8WQZT68Rx/g9w8mqKmFUDnDyLwpmqS6h94s7OGlmENtLfk1E84uBvHda920rB8NY
         j3n7pZAmLCHNgCd2KTY9jGIqow1d6dnPb3vhDBi6aJPCBDyN4NzNTZCUmz/3HFmd7e0V
         CiLWPfpHDi0Frd7lUs5oxg3FyUNSxk3I2XSyj07n93J+tEe0zHHaEyIG0+JD7FeSHqvk
         MClYsNpVP6hXbXKzpUw3mJm+G7rRoCRZ2WT/SG5JP1Xsht9gCSwnWaAmvcvrKUY5x55w
         VH/A==
X-Gm-Message-State: APjAAAWdMCrLHr3t/2UQaVTkDpFcSjYCAOVcXcyVOtdfqmQm6c1qBh9m
        XckZapi0b2fIHqBxT5QvCcMl8Q==
X-Google-Smtp-Source: APXvYqwtDG50+CDnx8yHTX0XWjamhJQ0wzyuOwxWwmAtlyxz5NNOSYgypMSGVytueAL/Ooa0yoUJyA==
X-Received: by 2002:a63:d555:: with SMTP id v21mr90143798pgi.179.1564567253116;
        Wed, 31 Jul 2019 03:00:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] power: supply: sc27xx: Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN attribute
Date:   Wed, 31 Jul 2019 18:00:23 +0800
Message-Id: <a48b8acd5111120e3effe71e05d5f8166470f725.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN attribute to provide the battery's
design capacity for charger manager to calculate the charging counter.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 24895cc..2fe97ae 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -587,6 +587,10 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value * 1000;
 		break;
 
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = data->total_cap * 1000;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -644,6 +648,7 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 };
 
 static const struct power_supply_desc sc27xx_fgu_desc = {
-- 
1.7.9.5

