Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A21714F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfGWJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 05:20:39 -0400
Received: from shell.v3.sk ([90.176.6.54]:54559 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfGWJUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:20:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 17B0057D75;
        Tue, 23 Jul 2019 11:20:36 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OmvVlQ5fC1eN; Tue, 23 Jul 2019 11:20:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1CF9857D77;
        Tue, 23 Jul 2019 11:20:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W48og1H3lQRH; Tue, 23 Jul 2019 11:20:32 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 35A7F57D75;
        Tue, 23 Jul 2019 11:20:32 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] Platform: OLPC: add SPI MODULE_DEVICE_TABLE
Date:   Tue, 23 Jul 2019 11:20:22 +0200
Message-Id: <20190723092022.1758072-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI bus creates a device with the modalias of "xo1.75-ec". This
fixes XO-1.75 EC driver autoloading

Fixes: 0c3d931b3ab9 ("Platform: OLPC: Add XO-1.75 EC driver")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/platform/olpc/olpc-xo175-ec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olp=
c/olpc-xo175-ec.c
index aee8975bea90d..8ec9092af0bed 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -749,6 +749,12 @@ static const struct of_device_id olpc_xo175_ec_of_ma=
tch[] =3D {
 };
 MODULE_DEVICE_TABLE(of, olpc_xo175_ec_of_match);
=20
+static const struct spi_device_id olpc_xo175_ec_id_table[] =3D {
+	{ "xo1.75-ec", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, olpc_xo175_ec_id_table);
+
 static struct spi_driver olpc_xo175_ec_spi_driver =3D {
 	.driver =3D {
 		.name	=3D "olpc-xo175-ec",
--=20
2.21.0

