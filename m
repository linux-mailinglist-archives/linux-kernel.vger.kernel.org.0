Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF721C9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfENN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 09:56:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38619 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfENN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:56:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id f2so2928642wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86654d179AmYQd0W155rp/5r8oXi5m1uO9ZO93VNkFk=;
        b=0/8LCAaGJNktegVp5hvXEJKrCJyGBEztPbgPxBjNprn70liAooiXylCnf9NmSqffJu
         6FdNYMu0hUEVzlblwjLVxsyZ8sqmvPUCzZw++tMu1JOPxtF4KZKCFxkf0vly9g9zOMmA
         muv/ksRVk1QZN3Oq8Q7wcRclQveCNtgDCG2ImYKhGbPoICiZBtNnXzsVLpyeoVTKYAIC
         v/j5fNPYfuosfBhVnuYHWpR/K5uzQehrOSM97xnq4XlAnUZpZbKxAqOn/gB6Px/arZV0
         eHECJ4cl9S8YY0QpVdpchL31zC9aGTuWDlThXekNtMU9yvVq9wXfZTdoqVLpz1bkp97L
         tzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86654d179AmYQd0W155rp/5r8oXi5m1uO9ZO93VNkFk=;
        b=WkGJYV7WcJZOmfkRdSBeI20E70waUi3c4v6PwHbJppr0KjEs9PS9bjLNlOfUWlSMoM
         82+wX11H/Du1BN+Grz2qkVtQIBK9Ce4F4R4rgEkRo3LKs7HfFdYFaLu+OwpYfrqGM6q5
         A6Xhnri0JqXW43HVRiJWsQzJqy6eSuqJ7ZDYniUi8P1CwLywirAr40VvI+6BhZrRz566
         KhbO5qAuskDlNh20oZtUjNygpcR1OtM6IZS+5TTYsrgDFw9deWV0LvedgNYqjVixct0+
         cWic9FYhs7ygfJi0JDW/UTWfI0FHkJs/It/u7vBYwnGpXKydTo5B6oBiqeHL4EdB+jJu
         Vfcw==
X-Gm-Message-State: APjAAAVPQhmijyLwlqAKRQq5VaZAjWma3BLJm74dyGlZHRrHpKh7k87y
        h1HOchrbb4ADueXKdxTEJ2Y6vQ==
X-Google-Smtp-Source: APXvYqwb3bU1jO/QwSVdfeHhtnBJGUvDAKBhKSKwgt+bw0bfGUlasyzQ02SmuLaRek4uISPMHzwBng==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr18652009wmj.32.1557842181297;
        Tue, 14 May 2019 06:56:21 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id d72sm1375764wmd.12.2019.05.14.06.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:56:20 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 4/4] MAINTAINERS: Add meson video decoder
Date:   Tue, 14 May 2019 15:56:12 +0200
Message-Id: <20190514135612.30822-5-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514135612.30822-1-mjourdan@baylibre.com>
References: <20190514135612.30822-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the meson video decoder for amlogic SoCs.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878588cfb453..87c1e469ed63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10057,6 +10057,14 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/meson_*
 F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media@lists.freedesktop.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+F:	drivers/media/platform/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 METHODE UDPU SUPPORT
 M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
-- 
2.21.0

