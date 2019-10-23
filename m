Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85484E14A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfJWItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 04:49:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390553AbfJWIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:49:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N8nRor085350;
        Wed, 23 Oct 2019 03:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571820567;
        bh=gR7OAXsQc4OiOhV7DWYE58CP8SVL3y7X8+jWjC3qNZ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jNUlaw1DqfYHX8dAttAr0l+BIvyYssXG6zN7BBS2xur1mqQNT6GCZXqudNpnZl70b
         OIZ+6QoePoHJL5ZIvqPuAsYzC06pZSdeLPDm7s9W/oNvBprzoYnCIkkyYPfRZBG1sf
         bxbbErB3ZeAQDQ7rHG+u7JU0jOzvyBX/tUPHRo24=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N8nQUV011800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 03:49:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 03:49:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 03:49:14 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N8nHVv061069;
        Wed, 23 Oct 2019 03:49:21 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
Date:   Wed, 23 Oct 2019 11:49:15 +0300
Message-ID: <20191023084916.26895-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023084916.26895-1-rogerq@ti.com>
References: <20191023084916.26895-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an optional GPIO, if specified will be used to
swap lane 0 and lane 1 based on GPIO status. This is required
to achieve plug flip support for USB Type-C.

Type-C companions typically need some time after the cable is
plugged before and before they reflect the correct status of
Type-C plug orientation on the DIR line.

Type-C Spec specifies CC attachment debounce time (tCCDebounce)
of 100 ms (min) to 200 ms (max).

Allow the DT node to specify the time (in ms) that we need
to wait before sampling the DIR line.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.txt         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
index 19b4c3e855d6..253535a8819f 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.txt
@@ -24,6 +24,15 @@ Optional properties:
 assigned-clocks and assigned-clock-parents: As documented in the generic
 clock bindings in Documentation/devicetree/bindings/clock/clock-bindings.txt
 
+ - typec-dir-gpios: GPIO to signal Type-C cable orientation for lane swap.
+     If GPIO is active, lane 0 and lane 1 of SERDES will be swapped to
+     achieve the funtionality of an exernal type-C plug flip mux.
+
+ - typec-dir-debounce: Number of milliseconds to wait before sampling
+     typec-dir-gpio. If not specified, the GPIO will be sampled ASAP.
+     Type-C spec states minimum CC pin debounce of 100 ms and maximum
+     of 200 ms.
+
 Required subnodes:
  - Clock Subnode: WIZ node should have '3' subnodes for each of the clock
      selects it supports. The clock subnodes should have the following names
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

