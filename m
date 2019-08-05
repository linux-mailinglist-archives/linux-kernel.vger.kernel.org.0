Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E632E81054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 04:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfHECk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 22:40:29 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:46638 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHECk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:40:29 -0400
Received: from zhangzj?rock-chips.com (unknown [192.168.167.42])
        by regular1.263xmail.com (Postfix) with ESMTP id 06AC961B;
        Mon,  5 Aug 2019 10:40:17 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24736T140620542973696S1564972815649730_;
        Mon, 05 Aug 2019 10:40:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f1e0f7000e10a69ca974c5f7067f49d7>
X-RL-SENDER: zhangzj@rock-chips.com
X-SENDER: zhangzj@rock-chips.com
X-LOGIN-NAME: zhangzj@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elon Zhang <zhangzj@rock-chips.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     manivannan.sadhasivam@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, luowz@beiqicloud.com,
        Elon Zhang <zhangzj@rock-chips.com>
Subject: [PATCH v1 1/1] dt-bindings: Add Vendor prefix for Beiqi
Date:   Mon,  5 Aug 2019 10:39:53 +0800
Message-Id: <20190805023953.11231-1-zhangzj@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree vendor prefix for Beiqi.
http://www.beiqicloud.com/

Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1acf806b62bf..1092360d8868 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -135,6 +135,8 @@ patternProperties:
     description: Shenzhen AZW Technology Co., Ltd.
   "^bananapi,.*":
     description: BIPAI KEJI LIMITED
+  "^beiqi,.*":
+    description: Xiamen Beiqi Technology Co., Ltd.
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
-- 
2.17.1



