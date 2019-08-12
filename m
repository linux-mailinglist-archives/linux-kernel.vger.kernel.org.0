Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5316C89578
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHLCwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 22:52:51 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:3491 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHLCwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 22:52:51 -0400
Received: from ([60.208.111.195])
        by unicom146.biz-email.net (Antispam) with ASMTP (SSL) id DKM53852;
        Mon, 12 Aug 2019 10:52:52 +0800
Received: from localhost (10.100.1.52) by Jtjnmail201618.home.langchao.com
 (10.100.2.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 12 Aug
 2019 10:52:43 +0800
From:   John Wang <wangzqbj@inspur.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <trivial@kernel.org>,
        <linux@roeck-us.net>, <venture@google.com>, <anson.huang@nxp.com>,
        <jgebben@sweptlaser.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <miltonm@us.ibm.com>,
        <mine260309@gmail.com>, <duanzhijia01@inspur.com>,
        <joel@jms.id.au>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 1/2] dt-bindings: Add ipsps1 as a trivial device
Date:   Mon, 12 Aug 2019 10:52:42 +0800
Message-ID: <20190812025242.15570-1-wangzqbj@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.1.52]
X-ClientProxiedBy: jtjnmail201603.home.langchao.com (10.100.2.3) To
 Jtjnmail201618.home.langchao.com (10.100.2.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipsps1 is an Inspur Power System power supply unit

Signed-off-by: John Wang <wangzqbj@inspur.com>
---
v3:
    - Fix adding entry to the inappropriate line
v2:
    - No changes.
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 747fd3f689dc..8f21498faa92 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -100,6 +100,8 @@ properties:
           - infineon,slb9645tt
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
+            # Inspur Power System power supply unit version 1
+          - inspur,ipsps1
             # Intersil ISL29028 Ambient Light and Proximity Sensor
           - isil,isl29028
             # Intersil ISL29030 Ambient Light and Proximity Sensor
-- 
2.17.1

