Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56ABFB91
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 00:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfIZW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 18:56:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36422 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfIZW4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:56:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so267109plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=de2iGU47iwZY8X3+AI24sgH5bLJEE7zPqcjn0UcDCCo=;
        b=AVtQn4GGbjFx7GByAuc6551iBTI4Lg4f5T9CWQJRuTuRcAoBGKA5CECQxEfGZgTAlK
         LU213dBXJLRq7eZsBVpTYVV994RaQDRoy9YcLTFOTmotGdrLl2jyPCD/yR+I1QJPlD3G
         aAsXJESByXKGaZ5+pSxnbKWaVY+IY44JDXBDd2X7xb4vD0tY3YBxrZx3nHU1I43jD0JG
         Oi1dI7kMurI2xAsDt59nfo8UPyTLKXEDPoi59HMKzeY5DSSnZ0LzGtsuAEYKwo0FauHH
         KyNJ7VR+i+fQzLKvox3wibNogJ/srgHB+ZfoCVPNBzPW51P0ASP891o5MKvQE3biaSEL
         hsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=de2iGU47iwZY8X3+AI24sgH5bLJEE7zPqcjn0UcDCCo=;
        b=s4XcumOSm74SZn3MalO7xEXuXH/y7IsuqFMQqlwvCv8Dp55OpygCQDGnKw+haLbG0H
         elWbLUz5nN3B/vTH6hVxCYrUwtLzUaE+WuyMm0AHZenJTQZTjdIhcrsyLfuTp+wwJR4M
         jqEmPjEkzzaKft5ebHJLmHWt3VILUy+Ur8hMXxunf14YZCluyFkhExs4jd5ugsSlz5wE
         APcjyHCUOc7i3dewzLs4rNHznVlvUC+aTPTI4FRhAJKcJiUeUZZvxwvoACa8Trqwq+2o
         ssz/4qzezROTWw7X/EvY9906kA+F3EX9ggTMjcBDj/DjUL/78LxdhfbxpRd83iUCmHms
         77xw==
X-Gm-Message-State: APjAAAVJEQY5UOFkDoJN8LdebCz3KsWsS5f8SV8lra2OaGUElMVBdtNF
        7jW7+1SCpI0G9Ssme/sH6z8=
X-Google-Smtp-Source: APXvYqwyAPahM0b+utI1XoHpSn/iDsaS9PktcJWoU4gjQVjz0EG66QGxJe1945lkV3AVqGQvgLRjww==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12mr1136958plo.2.1569538573390;
        Thu, 26 Sep 2019 15:56:13 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id r23sm2897598pjo.3.2019.09.26.15.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 15:56:13 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] arm64: defconfig: Enable QCA Bluetooth over UART
Date:   Thu, 26 Sep 2019 15:56:04 -0700
Message-Id: <20190926225604.46514-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables Bluetooth on the Lenovo Yoga C630.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e05c39eab08..0134a84481f8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -169,6 +169,7 @@ CONFIG_BT_HCIBTUSB=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_BCM=y
+CONFIG_BT_HCIUART_QCA=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_LEDS=y
-- 
2.17.1

