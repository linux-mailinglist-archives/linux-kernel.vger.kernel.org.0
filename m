Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA81954DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfHTDNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 23:13:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34448 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:13:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so2347693pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFH5jva/OE203un4N8xBzjPDuYVpmA9pAoQ7Ehj/aec=;
        b=EdcZaaaDZaM2VztWA+t44FMuIL/ZIR+uyq3NMxQprjpw9xRFXNpnVYCld8dWHVj75k
         S8M0f+VRMyE/mQ9DpDuIEV4ZtVdL2uIdGuAnYp+EdQjeYsvksObGWGKsEIZ1eX8BXKxM
         /VO8XxU3xoA0g1i4hE4LK3S6ITaaFZwD09Zq6SCfNU9LYVRklCok9hkypMHkM4dQvk9+
         qab71+2iRARRUIDefd9czxoeSkG9njKwcLVXvMyCyQa1akHUJBf4nbv+6+CSaKliJ+u/
         yBY5iFv/z3uFMkbu7tswRU9RkP7AO+QMFHoZxK2xBdhpu9xtfxfQnFWZIo9pbrbSTzA8
         fjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFH5jva/OE203un4N8xBzjPDuYVpmA9pAoQ7Ehj/aec=;
        b=WVZgbvkNkv4qJ9nzpJTnwhvm9DdX5rcKiPogw1un7OgiYm86N7i53Yxbl0ZwdQcHX8
         GVVmlzinfxhdHRKnbcHGObk6yKL3LAAzItskV4Mkos+hyDT4q5tcXHZMdmfPRK6iiHKs
         mG2TE5gqCffRMpI9ic8ZVkPp2qL5qygaBDifleEsPgjx+aoNCruax4GqNiGvthBfiXUy
         Dd9Z7Mw+wfTnE3p4nL85UwyXqqI/dsz9odyy7byIBfSEUtzCj7WxnfmOF75jxR32Ak6V
         Wzsdl4QpoXVog71OuLMLftGCyXXJDZE/t5TK7Blb+L0dpg+kSv+xd++OubmcYeuHwLST
         EeaQ==
X-Gm-Message-State: APjAAAVec7mJuhtCVN9SMavFDXtGoMZhr21GfsJIO4pcdI6suq/uczMI
        uqlI/hk/2Joz+qRoF/ceen4=
X-Google-Smtp-Source: APXvYqwBieQOotgQYt2lM+Bx7jMH5oINwpP51n4NcZYPXJz9H6HYkAX8V4XrBWh/od2dSrmz0N4g9Q==
X-Received: by 2002:a17:90a:bf82:: with SMTP id d2mr13508669pjs.121.1566270788098;
        Mon, 19 Aug 2019 20:13:08 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id x10sm15100884pjo.4.2019.08.19.20.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:13:07 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-scu4-aib: Drop "rs485-rts-delay" property
Date:   Mon, 19 Aug 2019 20:13:01 -0700
Message-Id: <20190820031301.11172-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPUART driver does not support specifying "rs485-rts-delay"
property. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index 666ec27a73e3..d8c38ef6a98a 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -685,7 +685,6 @@
 	linux,rs485-enabled-at-boot-time;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-	rs485-rts-delay = <0 200>;
 	status = "okay";
 };
 
@@ -693,7 +692,6 @@
 	linux,rs485-enabled-at-boot-time;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-	rs485-rts-delay = <0 200>;
 	status = "okay";
 };
 
-- 
2.21.0

