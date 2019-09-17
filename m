Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A251BB48C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404641AbfIQIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:09:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59186 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfIQIJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:09:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 857501A0AE8;
        Tue, 17 Sep 2019 10:09:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 55D8B1A0B3B;
        Tue, 17 Sep 2019 10:09:12 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D9358402C4;
        Tue, 17 Sep 2019 16:09:06 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, geert+renesas@glider.be,
        alexandre.belloni@bootlin.com, sam@ravnborg.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH] devicetree: property-units: Add kohms unit
Date:   Tue, 17 Sep 2019 15:58:50 +0800
Message-Id: <20190917075850.40039-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds kohms unit

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 Documentation/devicetree/bindings/property-units.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index e9b8360b3288..97feb8995d1f 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -27,6 +27,7 @@ Electricity
 -microamp	: microampere
 -microamp-hours : microampere hour
 -ohms		: ohm
+-kohms		: kiloohm
 -micro-ohms	: microohm
 -microwatt-hours: microwatt hour
 -microvolt	: microvolt
-- 
2.17.1

