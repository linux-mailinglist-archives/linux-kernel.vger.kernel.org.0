Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EC34D214
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfFTPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:24:40 -0400
Received: from shell.v3.sk ([90.176.6.54]:51762 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfFTPYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:24:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 30901CC540;
        Thu, 20 Jun 2019 17:24:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iA_7RQlh7XYt; Thu, 20 Jun 2019 17:24:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7D255CC54A;
        Thu, 20 Jun 2019 17:24:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wSrM4WSP_D_g; Thu, 20 Jun 2019 17:24:34 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C124FCC540;
        Thu, 20 Jun 2019 17:24:34 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RESEND] mmc: core: try to use an id from the devicetree
Date:   Thu, 20 Jun 2019 17:24:32 +0200
Message-Id: <20190620152432.1408278-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there's a mmc* alias in the device tree, take the device number from
it, so that we end up with a device name that matches the alias.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mmc/core/host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6a51f7a06ce7..4733ddb894da 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -411,7 +411,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct de=
vice *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable =3D 1;
=20
-	err =3D ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	/* prefer an alias */
+	err =3D of_alias_get_id(dev->of_node, "mmc");
+	if (err < 0)
+		err =3D 0;
+
+	err =3D ida_simple_get(&mmc_host_ida, err, 0, GFP_KERNEL);
 	if (err < 0) {
 		kfree(host);
 		return NULL;
--=20
2.21.0

