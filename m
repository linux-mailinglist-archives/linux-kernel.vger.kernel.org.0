Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE011178F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLIWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 17:00:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46144 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfLIWA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:00:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id y14so7899295pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmSFLr+tHs6Mw5x0YoU7ewKo0pzNEADd7F+PT0RTF9w=;
        b=SBqfoDW1wHdULJCkfeE9+tHwFn8CKdjjeNWENWvFyiBDueWh6zgCqYioruFUb1g4J9
         mppx6PrU7iTgEge5oCEubOcOrrtxe0r1fJhvMGsTAKabZfJKPdhNDm4IYCYup6Dc47R6
         wgbwlUeqBELwn12H2+nT3NJytfhZ6jbgfo6xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmSFLr+tHs6Mw5x0YoU7ewKo0pzNEADd7F+PT0RTF9w=;
        b=UvgJIIiU9aQoOw/K/04xI2AXmzykQLy9ibyu89x4WSDSdRs/iH7kecWooKmz8Z1UY5
         +2zuUJgRW2DfqoClArHN49BzOoPNBuDqLFqnCH6dcrZbFQQUVDNUTmSdHu3/LVid31PZ
         6nC72Thp8KB9AAgmwuwc2v/lKxjBbomtJVVp+1aBMlXWhxJ27Yn6T0zlRTjYmgcpSwiH
         yyH5Q0ZO6zGZd9+wOOA6RV84TFksbZcz/XN2OLX8o73kNywX2oD/X/L/Yz7njaqpwMU5
         NBqyDxCBFG4I6rErsf5WcEtu7A2ka+wXsGIPlQHF6JkwxIJiu8yJ/P3h8iMTiCbZ3f2l
         Vosw==
X-Gm-Message-State: APjAAAW8MGSoOVEnc6eyutbkrx2AiPrNe2FKK0kyLhseuKDqDLv/HmkP
        EjIo2FLpJy8NOlDKp4wSunEUSw==
X-Google-Smtp-Source: APXvYqyORjj+Abls7PjxItJE0P59u54wNgNM9bKPcftHXnslnyLl1+eNOLqLpY8Z5oMIlGV/ViZuRg==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr32973317pfh.182.1575928827975;
        Mon, 09 Dec 2019 14:00:27 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id f13sm450355pfa.57.2019.12.09.14.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 14:00:27 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] phy: ufs-qcom: Invert PCS ready logic for SDM845 UFS
Date:   Mon,  9 Dec 2019 14:00:12 -0800
Message-Id: <20191209135934.1.Iaaf3ad8a27b00f2f2bc333486a1ecc9985bb5170@changeid>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDM845 UFS phy seems to want to do a low transition to become
ready, rather than a high transition. Without this, I am unable to
enumerate UFS on SDM845 when booted from USB.

Fixes: 14ced7e3a1a ('phy: qcom-qmp: Correct ready status, again')

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Bjorn,
At this point I'm super confused on what the correct behavior
should be. Lack of documentation doesn't help. I'm worried that this
change breaks UFS on some other platforms, so I'm hoping you or some
PHY folks might have some advice on what the right thing to do is.

---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 091e20303a14d..c4f4294360b6e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1657,7 +1657,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 	if (cfg->type == PHY_TYPE_UFS) {
 		status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
 		mask = PCS_READY;
-		ready = PCS_READY;
+		ready = 0;
 	} else {
 		status = pcs + cfg->regs[QPHY_PCS_STATUS];
 		mask = PHYSTATUS;
-- 
2.21.0

