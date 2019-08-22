Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE44798F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfHVJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 05:34:01 -0400
Received: from shell.v3.sk ([90.176.6.54]:35853 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733284AbfHVJd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:33:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 42491D749F;
        Thu, 22 Aug 2019 11:33:57 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fRdB2mApLZv0; Thu, 22 Aug 2019 11:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 030CCD7548;
        Thu, 22 Aug 2019 11:32:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EN6T64Sm9TiR; Thu, 22 Aug 2019 11:27:29 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4239DD7561;
        Thu, 22 Aug 2019 11:26:49 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 09/20] irqchip/mmp: coexist with GIC root IRQ controller
Date:   Thu, 22 Aug 2019 11:26:32 +0200
Message-Id: <20190822092643.593488-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MMP3, the GIC can be set as a root IRQ interrupt controller. If the
device tree indicated that GIC is enabled, avoid hooking up
mmp2_handle_irq().

The interrupt muxes are still being used.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/irqchip/irq-mmp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25848d73f6792..c8e7b098ccf71 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -470,7 +470,12 @@ static int __init mmp3_of_init(struct device_node *n=
ode,
 	icu_data[0].conf_disable =3D mmp3_conf.conf_disable;
 	icu_data[0].conf_mask =3D mmp3_conf.conf_mask;
 	icu_data[0].conf2_mask =3D mmp3_conf.conf2_mask;
-	set_handle_irq(mmp2_handle_irq);
+
+	if (!parent) {
+		/* This is the main interrupt controller. */
+		set_handle_irq(mmp2_handle_irq);
+	}
+
 	max_icu_nr =3D 1;
 	return 0;
 }
--=20
2.21.0

