Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D08191376
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgCXOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 10:43:49 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42624 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCXOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:43:49 -0400
Received: by mail-qt1-f173.google.com with SMTP id t9so11143190qto.9;
        Tue, 24 Mar 2020 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hZ3mKFxh7nBErS5Qg4UsC0Q2wGLsvJidQirvrTzzSQ=;
        b=cObX7ajULHqU7zTNfhCt1smSq/VvkzTYK65I2TiJW95LK/16Fy2gnAdCMz31/4qcA+
         H2aHXvog8Z1S7P9k0RvGOr4Rv+XktKW/7KIq6A8Ww/ABuDDEObyr9KKoBn1yENOydz02
         fU6qS4jz7xl892/+H+yiwY4xj3vXMwHafjRR3bBOJP5xNb/tBwK2s6fksrL67g1aTswU
         FhmCxxNkY7ssCMxN9Dak7cAd2TLud8QKQmltq6w5GXJwQKAEXwGYV8aB7dmbth4WKq4e
         KTliUCGSxux7Y6OefDxXVvas/QoYjkC/b3GH2ofs5ydt8tWCamLiAlcU/+KsCl0uNFmz
         8qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hZ3mKFxh7nBErS5Qg4UsC0Q2wGLsvJidQirvrTzzSQ=;
        b=cIC1EFE151zy7yBFLOJnNhMfAOnH50PrvAIZ5dni8bm2szNpi5OFoWBePgAJDbSpdQ
         XIrkk4gIZD2Z6YAO3YCv9cHtPM/5VLHr4xDVyd+u5bNgV1YDuslmMOOydmhMadNtxG/4
         wMULYDpauSqyt8+bMPXRGJgWT96gKlr1+fGe/r5ePZhOWvBZ8JkLfIORfQ/WnmIrg0yK
         x2X32FcHAe9UznfUfd4RokvSiXXog4zRato+wc9XmZuufUiSaPyyNAcWPVS5jOeI2FwX
         0PUeA4QBsNc54q4/C2qOVi8M7GXaTGqikLAjspyZ62aHhWF9IBrX7f+16l8PFcXiv/5c
         jwLQ==
X-Gm-Message-State: ANhLgQ131bkCKbyCQNb6eF3kwS1lH4yJkZtb0ixn/VYIDUQ1M6hZn0sl
        Z15kPvmEkMYRI1XcR8nmG5CcCg5J9k8=
X-Google-Smtp-Source: ADFU+vtqb2HjPXS6RLREfTrVNSOCGBWkXzFhUbc9muoSfFghXzvbywcda2wPQplRdBZenYOtgOBE7Q==
X-Received: by 2002:ac8:1611:: with SMTP id p17mr22233916qtj.300.1585061025878;
        Tue, 24 Mar 2020 07:43:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id y41sm14749800qtc.72.2020.03.24.07.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:43:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Beacon vendor prefix
Date:   Tue, 24 Mar 2020 09:43:22 -0500
Message-Id: <20200324144324.21178-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beacon EmebeddedWorks is the brand owned by Compass Electronics Group,
LLC based out of the United States.
https://beaconembedded.com/

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 4c8eaa11daff..7ee772b1840a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -141,6 +141,8 @@ patternProperties:
     description: Shenzhen AZW Technology Co., Ltd.
   "^bananapi,.*":
     description: BIPAI KEJI LIMITED
+  "^beacon,.*":
+    description: Compass Electronics Group, LLC
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
-- 
2.25.1

