Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8148130B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 02:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgAFBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 20:35:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40246 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgAFBfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:35:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so35348747lfo.7;
        Sun, 05 Jan 2020 17:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arvMuYwhC6kmGPqHAkymvpsO/QkvwuD8ZdbKq/fROtw=;
        b=SPToMhG8xkcHN3DpqL+yC+h8j/VRBtyTdvNPnTRp3Pmti8jOZD5xhKMxOozTu7vV35
         z34D1EeQWpdisk7i2L5GSsLd10l0UDYGbju3ibG08bu+M9ttvMu8Q2z5KoFnRufNh+bg
         09jPba8Z1LN+cQtq/d0PcCtlmydZut3IYQPSDWeWff/u6LKMi7gfQ/8RvLPzF0gOFKDN
         6i7mYSyTyFwrg3VUBQ47RoxLyBCsqxOzIWLf1TVTjasd11prS4yitY6zWDXkeB8s3EJb
         DZjr2qrLjIo3qgAjSPVK5APKeMwJ07tP2vVgdk6Lii87vV6R9Q9LHTRkRsQ1ORl7QfAc
         SJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arvMuYwhC6kmGPqHAkymvpsO/QkvwuD8ZdbKq/fROtw=;
        b=EU4N+iXl4esZahWs8vjaJZa6asWAYQiGF4FQ1pKKEnX/CJaNPFWVdGP+omtOqkocgC
         QX8D6ig6DYqwrDEdVseEAnSpK+dLTMDdc41WHTDAIChthhTY9v5+TYajXuN96MrO/Btx
         3gd8wxQm+HJdplVvZS/smY3ToobpehKVPhsDufmj1A5dHIq+fNS/phBJ/ieJVlcqiEvF
         y52q/hcaT1r4abeeWfkOvK+93UfySgV5Z5JZAqOCueaOdVG3tzqqdY/qXtb/XScG9p12
         HEjnZqKPR99WgZP4vvPhqPY6nqtSBO+eFLUD7f6Mjpu5G1WYz+gf7f7sMXRwa79eZVdH
         FArQ==
X-Gm-Message-State: APjAAAW+Cdo+nVtNhiZ6lM842Zvmd99DI0YZKaDOt0eBlyRocJiLR7rY
        E2GgJUGsZ6TppRZgCVDHDuU=
X-Google-Smtp-Source: APXvYqxsh92kdjazmb0pr3lkYmWjoMIy8rIrxs0GKYd9+ZEhHUT9jphMz0O6WndobxVN7VNt02JRrQ==
X-Received: by 2002:a19:e011:: with SMTP id x17mr36980429lfg.59.1578274498236;
        Sun, 05 Jan 2020 17:34:58 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/20] usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd
Date:   Mon,  6 Jan 2020 04:34:16 +0300
Message-Id: <20200106013416.9604-21-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few stale fields in tegra_ehci_hcd structure, let's remove them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/host/ehci-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 1eb94205a5ac..d6433f206c17 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -42,12 +42,10 @@ struct tegra_ehci_soc_config {
 };
 
 struct tegra_ehci_hcd {
-	struct tegra_usb_phy *phy;
 	struct clk *clk;
 	struct reset_control *rst;
 	int port_resuming;
 	bool needs_double_reset;
-	enum tegra_usb_phy_port_speed port_speed;
 };
 
 static int tegra_reset_usb_controller(struct platform_device *pdev)
-- 
2.24.0

