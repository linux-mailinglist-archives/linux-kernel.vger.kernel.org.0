Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07341FD2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKOCbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 21:31:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33559 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfKOCbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:31:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id h27so5030577pgn.0;
        Thu, 14 Nov 2019 18:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cR0gnrmhbMOKM+lRTo6HMYyjWyd0V/IOlryadjiD5LE=;
        b=DlRWx4GkuZ611eGPy0M4ipPKCwRCTM1GWJpZkvQni7qSBrIuB76dGQkCRblfOmxS0g
         uVpdqW2DhYLc2yq0qaYRN+GqutCcC1RTRTzLfEKCLskCm8v6GuFWP/lkKr354gTHdeOP
         xgLkQYx2QKkMHHLSSS7l0K8F3jvH5wWVZN7yKp+7eGULeGQ9BSRTAoNTP6nkdqz/BBuD
         lwYhiPv/tnwt1ghpNh+6nSNB+iHjyfqTUABhhOZzZRHkMJuuXgR/wDmD25vGEcsV7LJP
         3Vysfw7wtay6MWZK6oTTLNoAqm3sIUsFKNOF7GBeSqXKdpRdR6Qze1BYCOSFZwklKquK
         +Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cR0gnrmhbMOKM+lRTo6HMYyjWyd0V/IOlryadjiD5LE=;
        b=Cm/GnY9p9EmO6fps/+U5G+IpoCsaRf9IZXlwLg+yHRaETGpVH84QPJUbPk9VIopt2y
         klS6ez491NV7Gmw+02CuxMAyneZzU3azHEWHntqG3Zx79EOMUuBe8lHNwCAlWwjuDYwA
         AsBJqEPr4qk+9lfIJUnkAq1nZlJ0Wk3+TXbvXY3Je0/FexfccyhIyGQZkDY7e7QOmnyy
         /6mUC4Y6chzhZOu0dv8Nw1Qud0ttagM5FWn8nx0ptehbepUf/ywDiFOlEKBSQ4wp53Cq
         uB9OR57BSUdymnmO0IaGFmQsUMYYsMntp9lGNHEtcFb7pnsnnhg1rduiKrJOT+0qq/87
         OX5Q==
X-Gm-Message-State: APjAAAVRZmgr0EuO+Ak8LEPn8HpvRgeump/hrq8TU2DaFDSQSiM2rgHJ
        tXCP0Ycx0nWO439HsR5t7R4=
X-Google-Smtp-Source: APXvYqz+unYf9pay+wRvfzQE8p/IF+5OKV960yTH+9GEgEMwPUq5afSEhqMWwz7SFJkukvrkNWRzQw==
X-Received: by 2002:a65:6145:: with SMTP id o5mr13239624pgv.38.1573785094807;
        Thu, 14 Nov 2019 18:31:34 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id k190sm9794626pga.12.2019.11.14.18.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 18:31:33 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jamie Iles <jamie@jamieiles.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] crypto: picoxcell: add missed tasklet_kill
Date:   Fri, 15 Nov 2019 10:31:16 +0800
Message-Id: <20191115023116.7070-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver forgets to kill tasklet when probe fails and remove.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/crypto/picoxcell_crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 3cbefb41b099..8d7c6bb2876e 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1755,6 +1755,7 @@ static int spacc_probe(struct platform_device *pdev)
 	if (!ret)
 		return 0;
 
+	tasklet_kill(&engine->complete);
 	del_timer_sync(&engine->packet_timeout);
 	device_remove_file(&pdev->dev, &dev_attr_stat_irq_thresh);
 err_clk_disable:
@@ -1771,6 +1772,7 @@ static int spacc_remove(struct platform_device *pdev)
 	struct spacc_alg *alg, *next;
 	struct spacc_engine *engine = platform_get_drvdata(pdev);
 
+	tasklet_kill(&engine->complete);
 	del_timer_sync(&engine->packet_timeout);
 	device_remove_file(&pdev->dev, &dev_attr_stat_irq_thresh);
 
-- 
2.24.0

