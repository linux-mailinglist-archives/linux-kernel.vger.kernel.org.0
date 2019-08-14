Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E702D8D5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfHNO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:29:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfHNO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so4655013wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUFWU8WRwKUHyk9ysO+UmRCQeGUsUo2OQ9jgnTI2jL4=;
        b=YJSPRRPsYt1E+0kskqo2KZ0KxRuwzI/W9tCkTvb3Fl4k3tVgHSeayxDVMwK2u217zw
         dKCEqtUh3BB6kSd2VdPtiMUQXJRMHSx6lEsLu6rUKW4UBOXYa3Hxdo2U74Gqi4pmQZ3O
         Xf9ttr2ab0I6QeusmmoGDOAjhi8NOrMLpRo0nR6NAgS4c9kMLHMEu2ShEEKuYTY05/Ok
         5ITY8pruPDLDS7L+oR0FPN3RuniTe3Oy8nFNtmzhcp/OS0HPbtIr4GXxN70EN/EBpg9H
         nDHytwOkIPtVQl6tpffjapKu5u5yYNHNw+yD/hP8oADDNc2H19dE/jJvqC+kORZu1q49
         E1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUFWU8WRwKUHyk9ysO+UmRCQeGUsUo2OQ9jgnTI2jL4=;
        b=g8/qyo7O21Do8lGMXL/1wA/GZ5IMJ4Il2mXg++ZdznsJyDi7ZUeqOpA+W0NbHZUFdX
         kiNqVvL/7rVAV9U1zCEam2nHXj0mJvWMw++GsrBerlqizyztni/yejC/q7+3+Fv6ji63
         YnyCrMbDzvTQSbbwW313imRSYb1HdTfOBzlk9tx8Zr9rlcY1CUaRbH4TP4H686ioXLQO
         npVCiUf0M7lSuDZyb8R6woqv4/86CLroXq5Crt9ILezBleh+ldsPLCEIZPquoGiU2i1u
         oGmiUMWg4xuZ44zIUf8FDZIy9qtK9llXh82uT2KSdVooDOh6/zXqcea6kKdSjbAE8NoI
         d+WA==
X-Gm-Message-State: APjAAAUyCGjHJvptmCpHUNCwnxvKY2IMsq8WdoZEEA+QxRyZ1gl8Lns2
        8GcNLe6r1Xx6LJpc/nggBE0hcw==
X-Google-Smtp-Source: APXvYqxqvbPnJJU4Qrefo71FvnKlnfM7Pqexf4YSOuUSz/kpp13wICGyBK5R/P51oNug04Y1SiNdnw==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr8257964wmd.122.1565792964953;
        Wed, 14 Aug 2019 07:29:24 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 02/14] arm64: dts: meson-gx: drop the vpu dmc memory cell
Date:   Wed, 14 Aug 2019 16:29:06 +0200
Message-Id: <20190814142918.11636-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814142918.11636-1-narmstrong@baylibre.com>
References: <20190814142918.11636-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxl-s805x-libretech-ac.dt.yaml: vpu@d0100000: reg-names: Additional items are not allowed ('dmc' was unexpected)
meson-gxl-s805x-libretech-ac.dt.yaml: vpu@d0100000: reg-names: ['vpu', 'hhi', 'dmc'] is too long

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index faff77175486..c2d3fffea8a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -528,9 +528,8 @@
 		vpu: vpu@d0100000 {
 			compatible = "amlogic,meson-gx-vpu";
 			reg = <0x0 0xd0100000 0x0 0x100000>,
-			      <0x0 0xc883c000 0x0 0x1000>,
-			      <0x0 0xc8838000 0x0 0x1000>;
-			reg-names = "vpu", "hhi", "dmc";
+			      <0x0 0xc883c000 0x0 0x1000>;
+			reg-names = "vpu", "hhi";
 			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.22.0

