Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECF8163E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBSIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:00:35 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35424 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgBSIAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:00:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EEFDAE0028;
        Wed, 19 Feb 2020 08:00:45 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id puz4RNlyY5RV; Wed, 19 Feb 2020 08:00:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3B1B9E0051;
        Wed, 19 Feb 2020 08:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SUdoU6w6TsmE; Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8B854DFCA2;
        Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] irqchip/mmp: Avoid overflowing icu_data[]
Date:   Wed, 19 Feb 2020 09:00:24 +0100
Message-Id: <20200219080024.4002-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219080024.4002-1-lkundrak@v3.sk>
References: <20200219080024.4002-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case someone messes up and adds too many interrupt muxes in the device
tree, icu_data would overflow into things that follow it in bss, likely
mmp_icu2_base and mmp_icu_base.

Let's add a safeguard, so that we fail gracefully instead of panicking
at some later point for reasons that are then not immediately clear.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/irqchip/irq-mmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index f597d96409a1f..c7ef2cea1c020 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -505,6 +505,11 @@ static int __init mmp2_mux_of_init(struct device_nod=
e *node,
 		return -ENODEV;
=20
 	i =3D max_icu_nr;
+	if (i >=3D MAX_ICU_NR) {
+		pr_err("Too many interrupt muxes\n");
+		return -EINVAL;
+	}
+
 	ret =3D of_property_read_u32(node, "mrvl,intc-nr-irqs",
 				   &nr_irqs);
 	if (ret) {
--=20
2.24.1

