Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8D136049
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 19:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbgAISku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 13:40:50 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48039 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgAISkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:40:49 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2883220002;
        Thu,  9 Jan 2020 18:40:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 1/2] dt-bindings: display: simple: Add Satoz panel
Date:   Thu,  9 Jan 2020 19:40:36 +0100
Message-Id: <20200109184037.9091-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Satoz is a Chinese TFT manufacturer.
Website: http://www.sat-sz.com/English/index.html

Add the compatible for its SAT050AT40H12R2 5.0 inch LCD panel.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v4:
* Drop the satoz,sat050at40h12r2.yaml file in favor of the very new
  panel-simple.yaml common file. Just add the compatible there.

Changes since v3:
* Added the missing ".yaml" suffix in the $id.
* Removed the unnecessary "contains" assertion about the compatible.
* Added a precision : there is no public specification for this panel
  (known for the moment).
* Bindings checked with "make dt_binding_check"

Changes since v2:
* None.

Changes since v1:
* New patch

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 090866260f4f..8a9c37640dc0 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -33,6 +33,8 @@ properties:
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
       - ampire,am800480r3tmqwa1h
+        # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
+      - satoz,sat050at40h12r2
 
   backlight: true
   enable-gpios: true
-- 
2.20.1

