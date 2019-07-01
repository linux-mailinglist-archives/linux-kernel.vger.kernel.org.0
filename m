Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9143720778
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfEPNAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 09:00:53 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:56892
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfEPNAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M25hDT1I3ZxwMms/pM7xnaXpBXmkT2/AVLvSBif+c5A=;
 b=ObQQ/jfoC/9LnnYHQLyP2XQ78PR+e8bOhgyztHQ8tSQgoCwutojzfDtvgPyPdA/ApX4g9YbixeDwAZlfe1N+Ji/DlSStNiXdRzP5l68tS4s+shAHpr5C0pu5BZre1IkM+iie12ZCx4QXhIEPMW1UCcbls57hwajx2EWBlfIawOo=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5407.eurprd04.prod.outlook.com (20.178.121.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 13:00:49 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2ce8:d8f5:9745:99df]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2ce8:d8f5:9745:99df%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 13:00:49 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: [PATCH] ASoC: AK4458: add regulator for ak4458
Thread-Topic: [PATCH] ASoC: AK4458: add regulator for ak4458
Thread-Index: AQHVC+dix6gnGF9HoUCg65Wy4dJcvg==
Date:   Thu, 16 May 2019 13:00:48 +0000
Message-ID: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0217.eurprd07.prod.outlook.com
 (2603:10a6:802:58::20) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 390a5f3c-2e5c-4eca-9803-08d6d9fe8470
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5407;
x-ms-traffictypediagnostic: VI1PR04MB5407:
x-microsoft-antispam-prvs: <VI1PR04MB5407CA423B61784E5C3AE593920A0@VI1PR04MB5407.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(52116002)(8936002)(81166006)(36756003)(81156014)(6436002)(25786009)(2501003)(71200400001)(71190400001)(386003)(6506007)(8676002)(50226002)(102836004)(14444005)(256004)(53936002)(68736007)(54906003)(110136005)(316002)(6512007)(66446008)(5660300002)(66946007)(73956011)(64756008)(4326008)(6116002)(86362001)(2616005)(476003)(66556008)(186003)(2201001)(478600001)(26005)(486006)(2906002)(44832011)(14454004)(7736002)(6486002)(66066001)(305945005)(3846002)(66476007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5407;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oHGXLeZc9w8EbyL5L/K1W6GDS4KqFlu5SlFfli9rQXaTPi+E4XLxLC07KeDaSJb2rKdZflOaC/ZjHkf3cWZEu2XahcSkKw5o1045bG5ifj5bmygOE3LFbjWLv00LD7/pFxP2gCSqm2gfglAvoq9RUbpxJpqT3Ou7dGiI4PDjkMPKzCF1JrFSjrKhU6G98lj5JQTORjVvTiIG+GmRWayj0drKGqv8iEziZeCyXoEvBzkWD4EKWfbNgf3Y/gvfAwut9uOJQA7Iy0z6E8hMyTUIXdg+r4uXjGrD8QKgOI+qqqlmsfoRRGRJs+/Yq8rWxvfFeRZtCtzG7HcdCn2ImgvHXyiktRAXz5sD+JaxerOOjOgw2j5QUmZrt+n5KbIYB63zqZui2EFLBq+mTLnEHwAi2Q+V3mIeO27kGn63eapRnBg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <84B5814EB7C3584DB9AFC20C3093B2FF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390a5f3c-2e5c-4eca-9803-08d6d9fe8470
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 13:00:49.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Add regulator for ak4458.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/codecs/ak4458.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 7156215..06dcf13 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
@@ -21,6 +22,12 @@
=20
 #include "ak4458.h"
=20
+#define AK4458_NUM_SUPPLIES 2
+static const char *ak4458_supply_names[AK4458_NUM_SUPPLIES] =3D {
+	"DVDD",
+	"AVDD",
+};
+
 struct ak4458_drvdata {
 	struct snd_soc_dai_driver *dai_drv;
 	const struct snd_soc_component_driver *comp_drv;
@@ -37,6 +44,7 @@ struct ak4458_priv {
 	int fmt;
 	int slots;
 	int slot_width;
+	struct regulator_bulk_data supplies[AK4458_NUM_SUPPLIES];
 };
=20
 static const struct reg_default ak4458_reg_defaults[] =3D {
@@ -666,7 +674,7 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4458_priv *ak4458;
 	const struct ak4458_drvdata *drvdata;
-	int ret;
+	int ret, i;
=20
 	ak4458 =3D devm_kzalloc(&i2c->dev, sizeof(*ak4458), GFP_KERNEL);
 	if (!ak4458)
@@ -691,6 +699,23 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->mute_gpiod))
 		return PTR_ERR(ak4458->mute_gpiod);
=20
+	for (i =3D 0; i < ARRAY_SIZE(ak4458->supplies); i++)
+		ak4458->supplies[i].supply =3D ak4458_supply_names[i];
+
+	ret =3D devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies)=
,
+				      ak4458->supplies);
+	if (ret !=3D 0) {
+		dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D regulator_bulk_enable(ARRAY_SIZE(ak4458->supplies),
+				    ak4458->supplies);
+	if (ret !=3D 0) {
+		dev_err(ak4458->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	ret =3D devm_snd_soc_register_component(ak4458->dev, drvdata->comp_drv,
 					      drvdata->dai_drv, 1);
 	if (ret < 0) {
--=20
2.7.4

