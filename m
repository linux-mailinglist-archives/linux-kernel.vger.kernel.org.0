Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A3FDA71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 11:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfKOKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 05:05:01 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:50804 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727132AbfKOKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:05:00 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 15 Nov 2019 18:04:59 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id xAFA4rk0031796;
        Fri, 15 Nov 2019 18:04:53 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 15 Nov 2019 18:04:54 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: Add vendor prefix for ITE Tech. Inc.
Date:   Fri, 15 Nov 2019 17:52:17 +0800
Message-ID: <1573811564-320-2-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573811564-320-1-git-send-email-allen.chen@ite.com.tw>
References: <1573811564-320-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw xAFA4rk0031796
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITE Tech. Inc. (abbreviated as ITE ) is a professional fabless IC
design house. ITE's core technology includes PC and NB Controller chips,
Super I/O, High Speed Serial Interface, Video Codec, Touch Sensing,
Surveillance, OFDM, Sensor Fusion, and so on.

more information on: http://www.ite.com.tw/

Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f45..552f5ef 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -463,6 +463,8 @@ patternProperties:
     description: Intersil
   "^issi,.*":
     description: Integrated Silicon Solutions Inc.
+  "^ite,.*":
+    description: ITE Tech. Inc.
   "^itead,.*":
     description: ITEAD Intelligent Systems Co.Ltd
   "^iwave,.*":
-- 
1.9.1

