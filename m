Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333F8ADBAB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfIIPCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 11:02:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIIPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so14247231wrd.3;
        Mon, 09 Sep 2019 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iM24Xqh+JVeQjH/gEqv6pKww+oCucmMlXYCmlb+bvZY=;
        b=kFqDCDwgBoIfXwhtYQ6/ilOsVtf3vYSU4aDGpSG5KOx3xbwdd3uFqJHdPt1Az/54fM
         QrBdNhGk+fn+dXBrO9kqnQy0NLugK+yiEneasep3dzOieEf1Y/C7DWQFx/zmMRFDCOwV
         04NpVNZDNxntwNnul6/twEUEXPr2Y4vV8Twuo0wkN3d3OO/bjyBGBaE06zUpXlO4Gcfa
         kbJFgtyASRRnJm4woG1IecYu70TIiF/i1sdsCOjd2nZnGmGbxlhV7jK0s+5DMHgEG8tn
         VhtE0H3leKdWLOun9Y1jTvpQhCK/aXSMecTBjJElZ5Nkog2xUCcR99SWD4uI3nKU755p
         UbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iM24Xqh+JVeQjH/gEqv6pKww+oCucmMlXYCmlb+bvZY=;
        b=cFRGFSEBRbAV/QTcnWhMZ//mN/4GvUDmNMADrdh7Ll04H6bBnhBwLZ+lv+TIgXWmVr
         c3syoG4c9pn68ry/4CMgIxeobedg0daxdP3urHNSvi9tmJjbdl+7jCkqzevNU5kLc3ac
         aDZQ2ww9syg/+KMarwC/yjlK8uW2t3vetIjBjyD2OLFuUMt4/Yvs7TShk8HituyaB4nP
         ruUyHRBS6PZr8cJ2U7RMTUqC9VRfIf7DpMSez0c05nI/Ssu0gmFuWDmf9/kcInYRKz23
         C4rV/HHbzTtgxoIASXRDNqHLs3b5I+dVLuyIB3J0iyrySBhZj+fOhovblLKRicJ8ZOFw
         upGA==
X-Gm-Message-State: APjAAAWuSh4j8xEiWUBlwjGnLF6L+MozoeSa/dBXn6ACM0zQWs3jsSex
        InJUj/ooqSr8M9Jb/I8nQTM=
X-Google-Smtp-Source: APXvYqy74EB9OisVuGpM0UgxPNiOr7/Cny9fMiGEMbtujXq97LrJM2vVpw9MiIyqiZUXVsdNQh98LQ==
X-Received: by 2002:adf:dd0c:: with SMTP id a12mr18478863wrm.289.1568041347640;
        Mon, 09 Sep 2019 08:02:27 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:27 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 4/6] arm64: dts: meson: libretech-ac: update model description
Date:   Mon,  9 Sep 2019 19:01:25 +0400
Message-Id: <1568041287-7805-5-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the model description to improve readability in some app GUIs
that show the string.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 82b1c48..4d59494 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -14,7 +14,7 @@
 / {
 	compatible = "libretech,aml-s805x-ac", "amlogic,s805x",
 		     "amlogic,meson-gxl";
-	model = "Libre Computer Board AML-S805X-AC";
+	model = "Libre Computer AML-S805X-AC";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.7.4

