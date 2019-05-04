Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340781367E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEDARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 20:17:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43308 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEDARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:17:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id e67so3671221pfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T0GFsU5iTOyCwj8QNb5BtH0GpMGDHOczgY1Uj/CZHXk=;
        b=oeQsoIXnKAJoKnIszLlOgMj6J9duncW8mzUEey2yO4oNzCVnmVL0XX+8v9FM5pIy2s
         lj2aO3Aoo+Ij4241jr1fnMBi8z2hYk1KgQr7A2eOY8hTzfApsR4JhFNawomFUYNI1rzI
         8kKJt+eaMdWlosvTyjoMnPmu5jUASwgPiJ2D49QPZe5GVpAGEHSdgtJ2pp0tvNrK8/nP
         YD0IxCHRQojMDUkPcZQrUq/fYJcRrENPVAf7wOFaRMVYXyqZsqNu2kP0a1NL/B9+izSu
         WMuD+dGAQClX7s8+hSZr27NH9SDNlHuoEMnsc31/PEFQyzW5OUmzcrzHkI6/MnOawgA/
         VMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T0GFsU5iTOyCwj8QNb5BtH0GpMGDHOczgY1Uj/CZHXk=;
        b=TQpbt3/aFfk5bsz/WKk5FtbwjUWOpws/a5HyC67N8mCrLhThzR7/o1Tc2jTP38VIJ3
         DPVTL70S7/CH5TmCgM/CHmK/xsQ4cXYO2RYw0IYC0uXwBJ93WmlrXjteY96HZBEcZORD
         JZX84Bcxz/Qth14yec3olBAZ1xa+uaZhEmB1M/WNQt3RiyZ500JprFbIhAbFHyJWAOaj
         GVhGVSMTb0eIa4WAHm5zLULj1BgyCvSxXwEwm8VoC1mbtp/bRaSHlR5CZEcmY1BYC8Pn
         AP+5jwgB/1809R/BTV75FNzsIvGSP2gdwfaXf44xNrDZWi+ful7Yu3f8tRmlZNGF6DR3
         l3aw==
X-Gm-Message-State: APjAAAUFAaIGCs51cSkdRegBxPdU9XvvmvP2ohAiXmoywNekW1Yn9+oF
        li5JVyUGOvclg5uBioDzaYCZ5A==
X-Google-Smtp-Source: APXvYqyEjLXIJyLHnBMCT+wiJSfzdTRGABuxSLtEAXX8MsYrKBxK/Ma8r1oNRsXOlNMqaMEy5XECgw==
X-Received: by 2002:a62:4690:: with SMTP id o16mr15035772pfi.166.1556929060198;
        Fri, 03 May 2019 17:17:40 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm4364785pfy.49.2019.05.03.17.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 17:17:38 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gdsc: WARN when failing to toggle
Date:   Fri,  3 May 2019 17:17:36 -0700
Message-Id: <20190504001736.8598-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failing to toggle a GDSC as the driver core is attaching the
power-domain to a device will cause a silent probe deferral. Provide an
explicit warning to the developer, in order to reduce the amount of time
it take to debug this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index dd63aa36b092..6a8a4996dde3 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -149,7 +149,9 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 		udelay(1);
 	}
 
-	return gdsc_poll_status(sc, status);
+	ret = gdsc_poll_status(sc, status);
+	WARN(ret, "%s status stuck at 'o%s'", sc->pd.name, status ? "ff" : "n");
+	return ret;
 }
 
 static inline int gdsc_deassert_reset(struct gdsc *sc)
-- 
2.18.0

