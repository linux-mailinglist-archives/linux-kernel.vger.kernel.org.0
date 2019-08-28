Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41A89FC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfH1IAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:00:17 -0400
Received: from shell.v3.sk ([90.176.6.54]:40601 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfH1IAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:00:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 771B8D8339;
        Wed, 28 Aug 2019 10:00:07 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rI3QCcU_MYZa; Wed, 28 Aug 2019 09:59:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 90E85D832A;
        Wed, 28 Aug 2019 09:59:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R9xUsqNyz4m0; Wed, 28 Aug 2019 09:59:45 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 31212D8330;
        Wed, 28 Aug 2019 09:59:42 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/5] dt-bindings: display: armada: Document bus-width property
Date:   Wed, 28 Aug 2019 09:59:38 +0200
Message-Id: <20190828075938.318028-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828075938.318028-1-lkundrak@v3.sk>
References: <20190828075938.318028-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to choose a different pixel format for the
endpoint. Modelled after what other LCD controllers use, including
marvell,pxa2xx-lcdc and atmel,hlcdc-display-controller and perhaps more.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Collected the Reviewed-by tag

 .../devicetree/bindings/display/marvell,armada-lcdc.txt     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/marvell,armada-lcd=
c.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
index 0ea4cbe5a32ee..d1dadaaeee734 100644
--- a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
+++ b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
@@ -25,6 +25,11 @@ Required child nodes:
=20
 - port: video output port with endpoints, as described by
   Documentation/devicetree/bindings/graph.txt
+  The endpoints can optionally specify the following property:
+
+  - bus-width: recognized values are <12>, <16>, <18> and <24>, that
+    select "rgb444", "rgb565", "rgb666" or "rgb888" pixel format
+    respectively. Defaults to <24> if unspecified.
=20
 Example:
=20
@@ -37,6 +42,7 @@ Example:
=20
 		lcd0_port: port {
 			lcd0_rgb_out: endpoint {
+				bus-width =3D <24>;
 				remote-endpoint =3D <&encoder_rgb_in>;
 			};
 		};
--=20
2.21.0

