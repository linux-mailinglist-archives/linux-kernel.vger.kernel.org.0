Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39C0D5ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 07:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfJNFcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 01:32:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42333 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfJNFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:32:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so17998289wrw.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 22:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aiibnLb4ztqM4McCZf8ivuH47sJDCIoIvUY8u0wjWw8=;
        b=dZWm0bODxvVtd4jc+Sv3HEOR144u2b+ytObS+iiHa0aWE+7M86xnmZ1BQr3dL+y/R5
         I3dg+hkyPrT1CpIWzSYqJpSd2Nma1oDXyroJNgsTMmgMCkg0RNvghA5OatcRKRamhlAR
         ouV7VuiYPwRstXsmzg6/QPxOItKOWp87NucpAz6f83jY+B6Y1eUKdhamcDg77ueQ493/
         0KDj2K41P8eP9KCnV1adMmDtKATMNOaeUgxsv9Jn3QVk63xzvDSADv9g8ZCV1v04pB2p
         XPD1uo4Vb30Uss7PrWno0cArt2kbvguVeN+qqYP/D068ydIxqj7ohAYke5/KQ/WZpbQP
         DImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aiibnLb4ztqM4McCZf8ivuH47sJDCIoIvUY8u0wjWw8=;
        b=EuvmDdB0QMrzC1uDaajseR5XzK/tKcCYIOB962D7UI2fUm1ogMchHW7AKmWGvp3JXD
         xwh1F+wmHGaVetZYEe4wqX1fLXxaB8HVivEvqkhHbyPP8kQQjeYPcSj6WpYzBWpwSfeC
         47rc/McUwguroptbMfSjhIQy0NIK/hizIdi/qfqrjr5FDV7errhXIvRHPIBk3abhvtN4
         D9S+ocJUEsZPNxFZzd91fmLvEc+JdxRUhwD+l6LHaASg2TXOxl/P7BUx62CVRNfYzZqE
         Y4Cda4Ws/ZEouPHIhxYT7xbQ0bxsTEloeIFH2/Enc1hnOYCQ9Q7wH+ivHhlh1nMnF8/2
         vOZg==
X-Gm-Message-State: APjAAAWMIboL94KFfjEweetWfLcVSk3nnhv8uu9KQMI/4QVPLVBvJXU9
        tGbCG8jBambQQPXX3gfNz+l3aA==
X-Google-Smtp-Source: APXvYqzwgYyla5i+WdGDH9uV7L7OrlHDKcef3vSlLkS/1w30Ak08EC3dys/X03T3BQUy1jWogl3vYA==
X-Received: by 2002:a5d:6984:: with SMTP id g4mr9280068wru.43.1571031125748;
        Sun, 13 Oct 2019 22:32:05 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id o18sm44238772wrw.90.2019.10.13.22.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 22:32:05 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/4] MAINTAINERS: Add myself as maintainer of amlogic crypto
Date:   Mon, 14 Oct 2019 05:31:42 +0000
Message-Id: <1571031104-6880-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
References: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain the amlogic crypto driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36c5d6ee01f9..a8487a0999ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1477,6 +1477,13 @@ F:	drivers/soc/amlogic/
 F:	drivers/rtc/rtc-meson*
 N:	meson
 
+ARM/Amlogic Meson SoC Crypto Drivers
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/amlogic/
+F:	Documentation/devicetree/bindings/crypto/amlogic*
+
 ARM/Amlogic Meson SoC Sound Drivers
 M:	Jerome Brunet <jbrunet@baylibre.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.21.0

