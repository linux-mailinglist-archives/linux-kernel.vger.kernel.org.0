Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6E9FC73
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfH1IAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:00:05 -0400
Received: from shell.v3.sk ([90.176.6.54]:40588 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfH1IAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:00:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 885A9D833B;
        Wed, 28 Aug 2019 09:59:59 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id r6NofhyOXIlp; Wed, 28 Aug 2019 09:59:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3EC4BD8338;
        Wed, 28 Aug 2019 09:59:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cpeb35XJblvd; Wed, 28 Aug 2019 09:59:41 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 50102D832C;
        Wed, 28 Aug 2019 09:59:41 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: reserved-memory: Add binding for Armada framebuffer
Date:   Wed, 28 Aug 2019 09:59:34 +0200
Message-Id: <20190828075938.318028-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828075938.318028-1-lkundrak@v3.sk>
References: <20190828075938.318028-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the binding for memory that is set aside for allocation of Marvel=
l
Armada framebuffer objects.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Collected the Reviewed-by tag

Changes since v1:
- Moved from bindings/display/armada/
- Removed the marvell,dove-framebuffer string
- Added to the MAINTAINERS entry

 .../marvell,armada-framebuffer.txt            | 22 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mar=
vell,armada-framebuffer.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/marvell,ar=
mada-framebuffer.txt b/Documentation/devicetree/bindings/reserved-memory/=
marvell,armada-framebuffer.txt
new file mode 100644
index 0000000000000..ab243e2bad454
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/marvell,armada-fr=
amebuffer.txt
@@ -0,0 +1,22 @@
+Marvell Armada framebuffer reserved memory
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Memory set aside for allocation of Marvell Armada framebuffer objects.
+
+Required properties:
+
+ - compatible: must be "marvell,armada-framebuffer"
+
+Please refer to Documentation/devicetree/bindings/reserved-memory/reserv=
ed-memory.txt
+for common reserved memory binding usage.
+
+Example:
+
+	reserved-memory {
+		display_reserved: framebuffer {
+			compatible =3D "marvell,armada-framebuffer";
+			size =3D <0x02000000>;
+			alignment =3D <0x02000000>;
+			no-map;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd08..3d824ecf96229 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9621,6 +9621,7 @@ T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git=
 drm-armada-fixes
 F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
+F:	Documentation/devicetree/bindings/reserved-memory/marvell,armada-fram=
ebuffer.txt
=20
 MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
--=20
2.21.0

