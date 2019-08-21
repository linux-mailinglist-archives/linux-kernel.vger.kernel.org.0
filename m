Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A132B97C73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfHUOVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 10:21:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50332 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfHUOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so2337011wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BE56XeKlPm5JVcX8n3q5JNmJvyUhg1qETHFabaUvyfE=;
        b=Lnoj50t8bQ9bDRMRR2IVG3gDVVz+yPL5PUmwgYkRrDAf0BGZeBREwDCBPfdtWm9kBP
         tEDTpaYnE0C4mUW0R9BIBlTErQRUZ8IrJD7PcDvt4AlcV9EgfqSbelBCYHeEuFpUauqe
         OYlhTKrQLsz0bJBai3GlKXpR5/+kvGBQkw0mdQ0192//87LcnM2VaXxhPK5JzM4RxKcB
         O4oYr6/w1yguRxm96R0vxzXmCytT6V1e6eolbuH5KC7HvX6CybmVRKNzz0ZhfoXhQJfc
         FW1kCS3hd55lfc81CQv9KTtvkpS20Fu6j4qrhlMDGtBECabUJPAQ67+mboPQqUA2tqcn
         QL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BE56XeKlPm5JVcX8n3q5JNmJvyUhg1qETHFabaUvyfE=;
        b=a7yi1lAN1R1cG9M5lPk/Z17PuX3X0/w8Bu9G7CFm3aU9edjmepeLN5JPmfKQu+EvDB
         1oqAtn81MFyN+xB+HQU3rmfEUZUHXBKk7CLPfLoeUCgvqUoNzSCsWA9AOhp+C/SyXGaF
         eJGni+rs3TIiz5zB80j1AUBxjdwjEALNCqePYrKB5hymJUVQNqLEo3oT0jFTsU5NKVzC
         LXvnDCXCRiAJF7dgDr9MJ/qtBJIscfvVnLac+vP8Cz00u9YIFTtuvM3KiqIC9EWY2EqX
         BXkkIRyAhWWVfdaUzck6APAcCbWaKFL4h70xOAPHFap/dwV9JKiitkOmTWCzDxjHpvnV
         W68w==
X-Gm-Message-State: APjAAAXgynTVYrsOfwkoGXh0DNnGqIojsUosuHsmoZExegoq+s/zdPtS
        A5WMdSF/4mQGblqUB4/lSLqm9EZtxeDWPg==
X-Google-Smtp-Source: APXvYqzuHs2peSetC63p+jjntS+Mxj6i8Ywj33/Z22DI61wK6k8o4lDfUFeda2o6zo5i32KR9FA1Qw==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr313661wmb.108.1566397266758;
        Wed, 21 Aug 2019 07:21:06 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:21:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 12/14] arm64: dts: meson-gxbb-nanopi-k2: add missing model
Date:   Wed, 21 Aug 2019 16:20:41 +0200
Message-Id: <20190821142043.14649-13-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-nanopi-k2.dt.yaml: /: 'model' is a required property

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index c34c1c90ccb6..233eb1cd7967 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -10,6 +10,7 @@
 
 / {
 	compatible = "friendlyarm,nanopi-k2", "amlogic,meson-gxbb";
+	model = "FriendlyARM NanoPi K2";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.22.0

