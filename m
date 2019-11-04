Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB7EE2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfKDPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 10:01:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46273 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:01:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so11691434wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1ClJD7qHHTGYOoAGZcm92C1EBgrR1Y66qzK4bPRJVg=;
        b=WW2g8g9kjHYD6d7n9gPACYe4sD8R00xk11RgzesniVwm3iVvFcjFHCGmNYtIgCZ26F
         dzIqT0+CW38uzIfOQk+JTPeLpfxM3xq1jf9HAArYobKNo8h4sJaHF2zumnOhwZgt5IWT
         9mJ7AXQIhShah0Tmxo8Wt/b79r38/Rj/UimJkbyfUHv0BGBvO/OaxlaRj0wRcWRNjhQs
         DwVA0uDvPEW3r8fQvZgePAQYUZAjrp0McYyQvKFnPPDAMgP87Gv+ApkLh3yDM5zwyNfS
         ofHLGCc538ZXVwinSZoE4TkddzX5nJsL/VC8b9cq4NmZedekeCWozjO7n4gmaqBDRXkP
         EBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1ClJD7qHHTGYOoAGZcm92C1EBgrR1Y66qzK4bPRJVg=;
        b=ZhOZ/w+7jGY1RnosA0TwlGzjOCdzJH5T4pYDfrq1jTfmAczyhsdY82/Ksm/zH884NR
         9ISk31LPbNfEjYLLK6OCm2jZvPJH3hLmJ/Jo7btJP7bLIOGLpKKEO2oRv0OSi6xV0CkI
         EIjliNcJBj/KAY1paYrV53j+Wa6B6IkX6j7aLULGKlAwGFeDwc/WUwhlWjEsabgaTf1L
         JfEOnfMp/uWYWkrdjpfQSojjfQIcW/ZhQxzlbOfw2Ix/j2lIuqgmNCKWoZmzMf/f7GxN
         gLitX3lejJouMHo2j0JobSmW3+zssd9NKxfLE7k5x1SvNy5bj61FF1oSEi4hownAMZj0
         Q+AQ==
X-Gm-Message-State: APjAAAXyfcJ4PxwJc2C9CI6eKCu0l0xRGzDEEv2HjEaLNSODYXgauIKd
        W+tEJCtY9Sc1GFhoLCOyh/EKapJahPk=
X-Google-Smtp-Source: APXvYqxedQjBcxaxhbDh/Nq/GJR9l/4UGh09Sup0C7VI37910lKIQapWqqBVFJoZYIKdcfWwmEEf9Q==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr22100564wrc.113.1572879673073;
        Mon, 04 Nov 2019 07:01:13 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id l18sm21808043wrn.48.2019.11.04.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:01:12 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] phy: cadence: sierra: add missed clk_disable_unprepare in remove
Date:   Mon,  4 Nov 2019 23:01:02 +0800
Message-Id: <20191104150102.6424-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to disable and unprepare clk when remove.
Add a call to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index de10402f2931..81a987ca54a5 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -291,6 +291,7 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
 	int i;
 
+	clk_disable_unprepare(phy->clk);
 	reset_control_assert(phy->phy_rst);
 	reset_control_assert(phy->apb_rst);
 	pm_runtime_disable(&pdev->dev);
-- 
2.23.0

