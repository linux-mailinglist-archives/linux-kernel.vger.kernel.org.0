Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603DB8FFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 12:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHPKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 06:23:17 -0400
Received: from vip.corpemail.net ([162.243.126.186]:41429 "EHLO
        vip.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfHPKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:23:16 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net (Antispam) with ASMTP (SSL) id HSG47528;
        Fri, 16 Aug 2019 18:16:28 +0800
Received: from localhost (10.100.1.52) by Jtjnmail201618.home.langchao.com
 (10.100.2.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 16 Aug
 2019 18:16:31 +0800
From:   John Wang <wangzqbj@inspur.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <trivial@kernel.org>,
        <linux@roeck-us.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <duanzhijia01@inspur.com>, <mine260309@gmail.com>, <joel@jms.id.au>
Subject: [PATCH v5 1/2] dt-bindings: Add ipsps1 as a trivial device
Date:   Fri, 16 Aug 2019 18:16:31 +0800
Message-ID: <20190816101631.3077-1-wangzqbj@inspur.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.1.52]
X-ClientProxiedBy: jtjnmail201605.home.langchao.com (10.100.2.5) To
 Jtjnmail201618.home.langchao.com (10.100.2.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipsps1 is an Inspur Power System power supply unit

Signed-off-by: John Wang <wangzqbj@inspur.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v5:
    - No changes
v4:
    - Rebased on 5.3-rc4 instead of 5.2, No changes
v3:
    - Fix adding entry to the inappropriate line
v2:
    - No changes.
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2e742d399e87..870ac52d2225 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -104,6 +104,8 @@ properties:
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

