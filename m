Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BDC1646B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 15:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBSOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 09:18:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37334 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgBSOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:18:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so751908wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6wyWMfpOh6h06xGncQF4ABfwmrzTVZCtOS7mfMUTXc=;
        b=rGhtHgzFPVIvyePVL2F0QQtaCcH4EzshdF9w0AcP3bP+qg/nXW7c5fAKfs2P25yueG
         4bb6aNJhWh1zKuAPO102lIhF21/Lk9yOH3MX0kFyPZ2ReASa6Gs/10VKmhL/tG0KbYEh
         V4tOeMBent5Wu+nTrWZnOdVbFCTOxyq6LUCKI4o6dd/3hK++uzi0Fz6LFdDxifACcNfz
         W3N1tAbaKECcJn2uP1zKP2rDFnKHqfNJiSXUbiYwU2wa5N1YgTK4+qqYwES9U4cY/8N5
         Bexd5TZ/Wl5Q+y2ALcLJ7B7rqTyJ6pDoXlq72g/HgWCnZ7oO0rP9QTxGCTkkLpFT+9mf
         a/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6wyWMfpOh6h06xGncQF4ABfwmrzTVZCtOS7mfMUTXc=;
        b=Rahtgbri7oNZsBeHg1VX+POOsE7A3fngPTpLQapItiqaYilWwmTxcdmmmpIT1eHJp9
         B1/zasd5AYS8he2SsFajphDL0m5TaysZnm2rzHChT6at+EMuqpeO0Wqf8idzZ3PeVKmR
         2lIyUvMhb+g8KffzDNSpZoaTtztVmObkkxFMkz6e60B0ec6n/etFEoMJwoBAnbgEGlnw
         74/xmQdC7OGpXDkN9rcWkeYBbct3i/WhXzbrRw0tHU7qFfiozrT31p+7zAQsvi7FgQ1G
         vlQd72nZeAXA25haGavjDBTvSO+OoB7TgKkdYLXYZzUmYZhSGA5ZSKuW7U41cSe7ZVeg
         pCVQ==
X-Gm-Message-State: APjAAAX8ebfh5lpyb/TzZwIeS2kW368f4F1ZHjmWreOpRHy1lFFFPci+
        heBS75YEhC3WjzSookagClU1/Q==
X-Google-Smtp-Source: APXvYqxeF5cOXe12PQNqxlBBpiCnT3qQh/DDAtJr/M+esSQV0pKaEEHHxg3jUK5q+JMyj65o7WMEsA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr36849595wri.317.1582121904379;
        Wed, 19 Feb 2020 06:18:24 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:510e:e29a:93ab:74c3])
        by smtp.gmail.com with ESMTPSA id b11sm3337772wrx.89.2020.02.19.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:18:23 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: [PATCH v3 3/3] arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3 controller
Date:   Wed, 19 Feb 2020 15:18:17 +0100
Message-Id: <20200219141817.24521-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200219141817.24521-1-narmstrong@baylibre.com>
References: <20200219141817.24521-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When high load on the DWC3 SuperSpeed port, the controller crashes with:
[  221.141621] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.157631] xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
[  221.157635] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
[  221.159901] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.159961] hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
[  221.160076] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
[  221.165946] usb 2-1.1-port1: cannot reset (err = -22)

Setting the parkmode_disable_ss_quirk quirk fixes the issue.

CC: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index abe04f4ad7d8..87b9a47a51b9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2220,6 +2220,7 @@
 				dr_mode = "host";
 				snps,dis_u2_susphy_quirk;
 				snps,quirk-frame-length-adjustment;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
-- 
2.22.0

