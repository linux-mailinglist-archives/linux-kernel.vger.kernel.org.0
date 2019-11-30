Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2297610DDF0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfK3O6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 09:58:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35474 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfK3O6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:58:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so6424137wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUD5FdR6g2ASiBzE14YJrcmNzasb1Y2tz62iUE7N/xc=;
        b=UBvp/ytW4dLm9uvAfDdpEY+sIk0DHBNJsf9eC1RyWRYMIsvDbpmkW8ofy4BC422sTB
         +M1vbn1upImJvydQUcRb4uFJUGQ1E5v6u5UUXQmjkpNllnVCIKwLpd/Loc1l0imHGbNh
         vGOWZTXZ/SHfuhcvMyCAtqoL3oewv7FnK3qiAL4MVjFYXNpK7qUD09bx+r6UDzuqvVqT
         7Q/uxFF/rrWw9q3VcXMdweNFjbc4ehrHVXkXTRN6bX7tGo6FHh3ZqvzJNv9vbfG29tl7
         3TUbqM4XsXs+xz8ovggd2m9Mvwlk81d855Xx9aBSCZjxWhua+JIFgMgcO0zHtV8/riLJ
         MaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUD5FdR6g2ASiBzE14YJrcmNzasb1Y2tz62iUE7N/xc=;
        b=obYCl3ZDfVNwCfWlKOtLOshiygViHOP3EEhAMOgEY8xxkMDI9XBXlzvcw3zRhwqUQI
         CDBnNsPVFjVPch1FrI+uc6IfMN1IK4kYciquQ32XsUCKFOazsW0t0lXysMN96PYgOVNI
         XkYmZsbcSc/DAPhpGqfXMMgs+qP2S9ehmRWauySF5MZOh9i+0gPaHlUZB33sr8FSgWJL
         ZK/lh8LlFjVGMYW8ZY7SFDXcJywhgdXKvfuv2E9ctA0iEaRCzqridBanze/9GSjyNqmI
         KfmWqC7P8Ka3zpsspnj+zni2QVDxTuJ7mZP8MtCQNdZ18vgBJ+gBiUrOYH+si91ma573
         1H0w==
X-Gm-Message-State: APjAAAVN179UzsropXZocTdyHxd8obgyjdw4ELUoakfTgKyzDonsKCCK
        lY7VVUgpKcdKIytYswi+TtM=
X-Google-Smtp-Source: APXvYqw7/FFUtU7ZgBNzxnCt5W3VfthKgCKSSFdtQHPDyIi7xYUPTHYjqDMaMOPtQVwn54Dr0WNesQ==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr42788144wrl.307.1575125909679;
        Sat, 30 Nov 2019 06:58:29 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm3510202wmc.47.2019.11.30.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 06:58:28 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RESEND v1 2/2] soc: amlogic: meson-ee-pwrc: propagate errors from pm_genpd_init()
Date:   Sat, 30 Nov 2019 15:58:21 +0100
Message-Id: <20191130145821.1490349-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
References: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_genpd_init() can return an error. Propagate the error code to prevent
the driver from indicating that it successfully probed while there were
errors during pm_genpd_init().

Fixes: eef3c2ba0a42a6 ("soc: amlogic: Add support for Everything-Else power domains controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index df734a45da56..3f0261d53ad9 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -323,6 +323,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 				     struct meson_ee_pwrc *pwrc,
 				     struct meson_ee_pwrc_domain *dom)
 {
+	int ret;
+
 	dom->pwrc = pwrc;
 	dom->num_rstc = dom->desc.reset_names_count;
 	dom->num_clks = dom->desc.clk_names_count;
@@ -368,15 +370,21 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
          * prepare/enable counters won't be in sync.
          */
 	if (dom->num_clks && dom->desc.get_power && !dom->desc.get_power(dom)) {
-		int ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
+		ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
 		if (ret)
 			return ret;
 
-		pm_genpd_init(&dom->base, &pm_domain_always_on_gov, false);
-	} else
-		pm_genpd_init(&dom->base, NULL,
-			      (dom->desc.get_power ?
-			       dom->desc.get_power(dom) : true));
+		ret = pm_genpd_init(&dom->base, &pm_domain_always_on_gov,
+				    false);
+		if (ret)
+			return ret;
+	} else {
+		ret = pm_genpd_init(&dom->base, NULL,
+				    (dom->desc.get_power ?
+				     dom->desc.get_power(dom) : true));
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.24.0

