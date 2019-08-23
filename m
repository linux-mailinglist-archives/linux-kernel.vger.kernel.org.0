Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2576F9A937
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbfHWH5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:57:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391564AbfHWH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:57:43 -0400
X-UUID: 3635cfb3b0474c80935ef7990a2e66bc-20190823
X-UUID: 3635cfb3b0474c80935ef7990a2e66bc-20190823
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 398184174; Fri, 23 Aug 2019 15:57:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 23 Aug 2019 15:57:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Aug 2019 15:57:22 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH next v10 02/11] dt-bindings: connector: add optional properties for Type-B
Date:   Fri, 23 Aug 2019 15:57:12 +0800
Message-ID: <1566547041-20804-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DD5837F928CF669EDAFCBCD5D94B0709AABC197EEA56CD9489DEDFE789CECE922000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
usb-b-connector

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v6~v10 no changes

v5 changes:
 1. add reviewed by Rob

v4 no changes

v3 changes:
 1. add GPIO direction, and use fixed-regulator for GPIO controlled
    VBUS regulator suggested by Rob;

v2 changes:
 1. describe more clear for vbus-gpios and vbus-supply suggested by Hans
---
 .../bindings/connector/usb-connector.txt           | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index cef556d4e5ee..d357987181ee 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -17,6 +17,20 @@ Optional properties:
 - self-powered: Set this property if the usb device that has its own power
   source.
 
+Optional properties for usb-b-connector:
+- id-gpios: an input gpio for USB ID pin.
+- vbus-gpios: an input gpio for USB VBUS pin, used to detect presence of
+  VBUS 5V.
+  see gpio/gpio.txt.
+- vbus-supply: a phandle to the regulator for USB VBUS if needed when host
+  mode or dual role mode is supported.
+  Particularly, if use an output GPIO to control a VBUS regulator, should
+  model it as a regulator.
+  see regulator/fixed-regulator.yaml
+- pinctrl-names : a pinctrl state named "default" is optional
+- pinctrl-0 : pin control group
+  see pinctrl/pinctrl-bindings.txt
+
 Optional properties for usb-c-connector:
 - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
   connector has power support.
-- 
2.23.0

