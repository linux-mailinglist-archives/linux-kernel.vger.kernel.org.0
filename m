Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B944CCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfFTLUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 07:20:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:50943 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfFTLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:20:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5217DCBF3B;
        Thu, 20 Jun 2019 13:20:07 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zXqrAcrTZPav; Thu, 20 Jun 2019 13:20:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9FC7FCBF26;
        Thu, 20 Jun 2019 13:20:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Vnc8pR165BgE; Thu, 20 Jun 2019 13:20:00 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B9C22CBF0D;
        Thu, 20 Jun 2019 13:19:59 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RESEND] mfd: cs5535-mfd: remove ifdef OLPC noise
Date:   Thu, 20 Jun 2019 13:19:57 +0200
Message-Id: <20190620111957.1385008-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<asm/olpc.h> provides machine_is_olpc() stub for CONFIG_OLPC=3Dn,
compiler should just optimize the unneeded bits away.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mfd/cs5535-mfd.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 0b49940c490e..f1825c0ccbd0 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -100,22 +100,10 @@ static struct mfd_cell cs5535_mfd_cells[] =3D {
 	},
 };
=20
-#ifdef CONFIG_OLPC
-static void cs5535_clone_olpc_cells(void)
-{
-	static const char *acpi_clones[] =3D {
-		"olpc-xo1-pm-acpi",
-		"olpc-xo1-sci-acpi"
-	};
-
-	if (!machine_is_olpc())
-		return;
-
-	mfd_clone_cell("cs5535-acpi", acpi_clones, ARRAY_SIZE(acpi_clones));
-}
-#else
-static void cs5535_clone_olpc_cells(void) { }
-#endif
+static const char *olpc_acpi_clones[] =3D {
+	"olpc-xo1-pm-acpi",
+	"olpc-xo1-sci-acpi"
+};
=20
 static int cs5535_mfd_probe(struct pci_dev *pdev,
 		const struct pci_device_id *id)
@@ -145,7 +133,9 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
 		goto err_disable;
 	}
-	cs5535_clone_olpc_cells();
+
+	if (machine_is_olpc())
+		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_c=
lones));
=20
 	dev_info(&pdev->dev, "%zu devices registered.\n",
 			ARRAY_SIZE(cs5535_mfd_cells));
--=20
2.21.0

