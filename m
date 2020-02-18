Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0216302D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBRTd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:33:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36013 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgBRTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so4223705wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VageqtOZsyobFYSRSb56IHHuxmKRjwjLuogyKVcC/80=;
        b=WP2Nb5X/iHvjuhfX0cwqp5/S+DDSlybv2/MDC9JZm2aK9z5yGFSkpHx57q5uiUdYiJ
         KwewSKKAaRkL3LT8E2oFQWrq461FqCi3owPfKK+YB5XVVVpBOM09lZ3LoNXefY57mLp2
         OmYd2uHXYgO8xZdP0b+0EwWp0DzuAqEJF2SbZX2CTkHPvD9o49xkHtiYdN8FMHhWEprT
         m6B/m3ZZTrFOmfRNlCoDpaoo4NdLBfHvZpyC8eAeRJQtxFnM2QMdi9I6CtlTWn55BZAl
         +VPqu/lch8gT7TQLG39ouZcfjHI/ttrEwAaE5WhUyf5wqsO9G0Rl8X8DmGxyvzQffBgR
         US0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VageqtOZsyobFYSRSb56IHHuxmKRjwjLuogyKVcC/80=;
        b=Nfw7K5Fy93mnwDeKZW/lBmfgkH8u3wBYyU2G00GyMPlEYp9DSdJ56S+aOT4RZCS+87
         7QqCShouL19OMBU+N+WYTqjolMYIssNKKJ5f7jTl5UwgpGoqlSLoH3hY9uuJddmfHDJ6
         4lpsiBepnMcyqvrkO3fHw9ECx9YQ0SInHBr5CaaFq0DKqNNzbQcmeC/pwSH+e4QBql4w
         apSwtD7FURckCYUVSx1W44OOa2cdVJdK+cOXzHDB8Zq82ut/p1sQN6wudO2BIba9svg6
         mnNXBcxoUHkIU/TNqkMp79QwC1cPeYzZZ0ao2mQlUJC0230e83WBrvMwqIWdPqv23vhT
         Cx5g==
X-Gm-Message-State: APjAAAXXYxNT/JtqFpDf0AFbRFF12RH2RQVOT+hLda07MTq3GzBD0wHs
        eqdHvFuj9Ca5OZc0jGXjRTYBdw==
X-Google-Smtp-Source: APXvYqwQ/UXHl72OmZruSflpc5eioVTKPp3ANMMmirpPpsbjMqwaBn7VaVg9yPcWpx5E4upI/oajNw==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr4738998wmu.149.1582054408923;
        Tue, 18 Feb 2020 11:33:28 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:28 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 15/20] usb: host: ehci-pci: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:58 +0000
Message-Id: <1582054383-35760-16-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_driver name is const char pointer, so it not useful to cast
hcd_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/host/ehci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index b0882c13a1d1..1a48ab1bd3b2 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -384,7 +384,7 @@ MODULE_DEVICE_TABLE(pci, pci_ids);
 
 /* pci driver glue; this is a "new style" PCI driver module */
 static struct pci_driver ehci_pci_driver = {
-	.name =		(char *) hcd_name,
+	.name =		hcd_name,
 	.id_table =	pci_ids,
 
 	.probe =	ehci_pci_probe,
-- 
2.24.1

