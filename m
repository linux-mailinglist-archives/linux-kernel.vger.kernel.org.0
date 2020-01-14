Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9560D13ACDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgANPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:01:57 -0500
Received: from ziggy.de (unknown [37.223.145.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00324222C4;
        Tue, 14 Jan 2020 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579014117;
        bh=EKZ04GQRi8dqPD2Yc0r+3XDTaU1NagsiYPBB02PkBhI=;
        h=From:To:Cc:Subject:Date:From;
        b=Wk9SNhsjJF93erhd7Z/mXsMb6aFubTKoMH4FrFB4fHLRjr/S7MTiMybCQHGYKYxkk
         ahxGBo1inF2ecZ7qxh3cBJ4WvRGSxIU2jDCGphEN2ufaJonrEnr2dtSxaHSYyNz/9Y
         Qn1vTU2ftdIpoiHiSKgS0ALRfP7uTgZktFjshmjs=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, broonie@kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rt5645: add suppliers
Date:   Tue, 14 Jan 2020 16:01:50 +0100
Message-Id: <20200114150151.8537-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The rt5645 and rt5650 have two suppliers, document them.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 Documentation/devicetree/bindings/sound/rt5645.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index a03f9a872a71..41a62fd2ae1f 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -10,6 +10,10 @@ Required properties:
 
 - interrupts : The CODEC's interrupt output.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Optional properties:
 
 - hp-detect-gpios:
-- 
2.24.0

