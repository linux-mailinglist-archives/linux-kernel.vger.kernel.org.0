Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96E1130BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgAFBfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 20:35:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38515 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgAFBez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so35370410lfm.5;
        Sun, 05 Jan 2020 17:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wai/IBa7xwSSxkZALdhcvS+HcXKSmruVdy9OLgrA8Wk=;
        b=ItqQEaqyXUmzvU/jvIe3qhXtXMgjThlwNa2tgEylWtWLGDMth/AXM7ZlWtF/6yVb/h
         VGkhW2UMNjJQffKXovzmS5LY+/UO/JH26qL7hdmfGNcNvdAIyTjRsC7mO05Jh09gDNur
         kC+bdYVBB5Atp7EM/HTRXpTNaPfQY2j3mapyQ7+IfUmGYUl609MLSMQ4qf/qvzBDTghR
         Quc93mS82f0aTJDBzqSfGyoe24UBh/M6joBHBLNpeRCrY8Lumw/W6FY9047Qay5NC4xK
         QqLd8zwTW4LnjWhTwpdYmieGp+8GcxDWus/c22Popvl3huRiuVra5ZFeacj7ouAvONO3
         +7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wai/IBa7xwSSxkZALdhcvS+HcXKSmruVdy9OLgrA8Wk=;
        b=jW7c7bbmEp6zAefWoCIAyM7t92ri+7er8hbCoxRDTAvahx/41C6XqV9eh5eu+qZKWj
         p8sPr0prVPlciqDIF05Q6MUCjhEM118j6+Egd3IWmmAf3Efe9Hd1cGv2B/3+AxjszIBn
         1MzzdB1VPu+u/PvryeWWU+0RyHdTcbxgVXw+LGqSQ3DB+Io0QBCQ4pUImMxDh1wWvCa5
         asjoq06FmQGbSdf5Krt/8chYI8y79Co4Lpz6aGtBGincr4ESP0XJTUCuGDxWQP+DcRNo
         +ojFzv+o80SnzZOkyZMjg4162HxyxXhhrs7Is4MjdhT+svTeJNPVOfWCfNV4/skJo6On
         cLnA==
X-Gm-Message-State: APjAAAVddpgcTyN3di/+WjRpBqGJ7b1QW+YRvMzNVnWTx6w4cycj/7BI
        pieIA66PF9Qa9SMjuz7Gi14=
X-Google-Smtp-Source: APXvYqx7vTuQbwJiqWPtDuOvsV/KoGyFfXeb0igKd/ikCy0C/e6KcP2osqD2nB1hMKC1FhfcF9Dzpw==
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr56942352lff.144.1578274493274;
        Sun, 05 Jan 2020 17:34:53 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/20] usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
Date:   Mon,  6 Jan 2020 04:34:10 +0300
Message-Id: <20200106013416.9604-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VBUS regulator should be turned off in a case of error.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index c431968d0433..90b42e963a1e 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -864,20 +864,20 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 		dev_err(phy->u_phy.dev, "Invalid pll_u parent rate %ld\n",
 			parent_rate);
 		err = -EINVAL;
-		goto fail;
+		goto disable_clk;
 	}
 
 	err = regulator_enable(phy->vbus);
 	if (err) {
 		dev_err(phy->u_phy.dev,
 			"Failed to enable USB VBUS regulator: %d\n", err);
-		goto fail;
+		goto disable_clk;
 	}
 
 	if (!phy->is_ulpi_phy) {
 		err = utmip_pad_open(phy);
 		if (err)
-			goto fail;
+			goto disable_vbus;
 	}
 
 	err = tegra_usb_phy_power_on(phy);
@@ -889,7 +889,11 @@ static int tegra_usb_phy_init(struct usb_phy *u_phy)
 close_phy:
 	if (!phy->is_ulpi_phy)
 		utmip_pad_close(phy);
-fail:
+
+disable_vbus:
+	regulator_disable(phy->vbus);
+
+disable_clk:
 	clk_disable_unprepare(phy->pll_u);
 
 	phy->freq = NULL;
-- 
2.24.0

