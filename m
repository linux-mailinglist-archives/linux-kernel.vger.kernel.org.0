Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04B7B5207
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfIQPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 11:55:13 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43912 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfIQPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:10 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LNxLS6OulxgRW3JiWtrRflI2Z+nragxcSAoB77SYuO5+DNeFT+f3NM/41YIVGqHUFRy+oATGvB
 p8Gy2Qkzx9AFfXVYchInJHABkuZYzavwvodD4U5MZNORSlUqZB0viFYf2vLThXkcLA0wb5qGPu
 6KiBQ9dMl1N7KxRJzdCm5xMu7yT3LYlKrLUUIcIZ72pj7U7dM6V2oJCMmuH1u7uGQV0D4dbQZS
 /vWoL55Pro7q0C3V1/PZ1lICcZ4Gsy+hTANd1ba5nQNM3ZAcomIrjKf+cLg65PiXBB+e/0RVtn
 vjY=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="48252396"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:54:50 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:54:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRkcwNPjNLwNm8fGYPU7mvF2CxL+vE7HpDFPbbCSiXLfDHyD+V5vyHGXMmOUl0TuP00htkknCjdDd3JeH4phO0iCHNC0CKHvFp4VC7v0xVRqzKW5RjHfQR9kLx1aTb5XLO0YQTdxTtKlx1OEeC5fm080JuHsCJN65W2kPdsC3kSux9kbDuxGGhpmEfQeMZA/vTvBSGkdl/YJa3Uf7CrXHZXEo2B1boc0ramdhhqdNMqbyJX1PBlVFjHJRufSDWc8Ak4Ob44uHwpGOtRzSbpuSegyZIrAxUaOxHZFw6k0XBAOeSnObJ8zQJVGfqJR/kJWxOp39jNJ2V4FQ5RYFOJNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYSuV3rNSK2cyD0B8kBJl5bzSvj8OrKoGlU8G+Pysuk=;
 b=lF64cLY+emsH6Ws3jk96Lx/PhUDDyFA/ON6U1eThXcwXdmGNGjdNqBCW64OTdGH9Ytz0/Q7TGjs1kJL6naYgIWyg4lqgvrRgFJ/ehqE+1sh0/bukgARtpj0m94mdrwkoHy4eNOKuMAeORJwE9BAuLTaHtYVNN9rWLe2liTvK8t0v7kAhVZmNXggq985dBtc97gOjhWBF0zfEgyucbMOQ2l6crI+7oH6pb9o/LRtpWn+6bVRGnoVbbHwatlPXuGrwLQV5PpTkZQAFqfbwZ2M8VC9H2EoNxN5qrhYi4dh3dDqAMOWW3uok8kbTXwIGh4Wrb0/GR/bInUMBRBML318U1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYSuV3rNSK2cyD0B8kBJl5bzSvj8OrKoGlU8G+Pysuk=;
 b=tcC/Lk1bdSt/T+l51DY7rxyXQzvwWpeNULeJFPPoK9b5DtrBqQLIhEuWcx84UT7pKi4Fkr1dWUhAFgukHw9JLhNF+QREXGwMTOaDMtEf+LNuC6U0aBbgAtlZdNRll2dD21iVUerfBkOVsDsV2oYb5sX4gmuAUmVQsp+PoafROuE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:54:47 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:54:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 02/23] mtd: spi-nor: Introduce 'struct spi_nor_controller_ops'
Thread-Topic: [PATCH 02/23] mtd: spi-nor: Introduce 'struct
 spi_nor_controller_ops'
Thread-Index: AQHVbXA7VfKVpMUx1UqOLh4+dBdplg==
Date:   Tue, 17 Sep 2019 15:54:47 +0000
Message-ID: <20190917155426.7432-3-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7764ee2-1571-4d73-76ab-08d73b875d63
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984CFF2B316F8F9E40E772EF08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(14444005)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(30864003)(2906002)(446003)(52116002)(2201001)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MOnpv1QbMDAmqivoGtXLUcNVYtyH283pFL2TQ5KKcWSZBjhoSZL4T3c1vLSkKEh5N/t5mKaQ6yguOqrrn/xSL1hMh3/L4Vxk9jhQrAIPawuSSpAnIlYHf4kkBtHDYRwloi71MIwHQf7BLmgDntvDw6lExX9SQAC+jbZVDYLMtptDsveuH99Ja1ujXIBR04hg4G9NdB2CrMPuFqmG4cOlrSQc+LSKACm0Ab9wnZaMbvCbOgTSdvEeFszcr8TFoAFSVkCr8Akq88vgeJ/M4KVnDLU4upDnHL6Zn9KEgx6JtpoCzz8eli5/5V8aSTLiL8MSBuhGw23zdNZQbwqyDWKbWNTYPqKjG8I40dlFLEYexpVy/MejbTmnVIMhEB6tFjlJcS/Riml5ZZmOSQ4cY8xUY4yHMvPgQk52ptIgnDRgjnU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f7764ee2-1571-4d73-76ab-08d73b875d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:54:47.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5elzTgLpwiDlc4wVtDvKmn0wGXWe8NpLYr4PzpyTzAxzHugEC/mSOsvTN8wPOmbSxUOUN6Zp/bAVFkqFJv3bT83hNDL+Lmo7ofNmH96rPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Move all SPI NOR controller driver specific ops in a dedicated
structure. 'struct spi_nor' becomes lighter.

Use size_t for lengths in 'int (*write_reg)()' and 'int (*read_reg)()'.
Rename wite/read_buf to buf, the name of the functions are
suggestive enough. Constify buf in int (*write_reg). Comply with these
changes in the SPI NOR controller drivers.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/aspeed-smc.c      | 23 ++++++-----
 drivers/mtd/spi-nor/cadence-quadspi.c | 39 ++++++++++--------
 drivers/mtd/spi-nor/hisi-sfc.c        | 22 +++++-----
 drivers/mtd/spi-nor/intel-spi.c       | 24 ++++++-----
 drivers/mtd/spi-nor/mtk-quadspi.c     | 25 +++++++-----
 drivers/mtd/spi-nor/nxp-spifi.c       | 23 +++++++----
 drivers/mtd/spi-nor/spi-nor.c         | 76 ++++++++++++++++++++-----------=
----
 include/linux/mtd/spi-nor.h           | 51 +++++++++++++----------
 8 files changed, 166 insertions(+), 117 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-=
smc.c
index 009c1da8574c..2b7cabbb680c 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -320,7 +320,8 @@ static void aspeed_smc_unprep(struct spi_nor *nor, enum=
 spi_nor_ops ops)
 	mutex_unlock(&chip->controller->mutex);
 }
=20
-static int aspeed_smc_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, in=
t len)
+static int aspeed_smc_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+			       size_t len)
 {
 	struct aspeed_smc_chip *chip =3D nor->priv;
=20
@@ -331,8 +332,8 @@ static int aspeed_smc_read_reg(struct spi_nor *nor, u8 =
opcode, u8 *buf, int len)
 	return 0;
 }
=20
-static int aspeed_smc_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
-				int len)
+static int aspeed_smc_write_reg(struct spi_nor *nor, u8 opcode, const u8 *=
buf,
+				size_t len)
 {
 	struct aspeed_smc_chip *chip =3D nor->priv;
=20
@@ -746,6 +747,15 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_=
smc_chip *chip)
 	return 0;
 }
=20
+static const struct spi_nor_controller_ops aspeed_smc_controller_ops =3D {
+	.prepare =3D aspeed_smc_prep,
+	.unprepare =3D aspeed_smc_unprep,
+	.read_reg =3D aspeed_smc_read_reg,
+	.write_reg =3D aspeed_smc_write_reg,
+	.read =3D aspeed_smc_read_user,
+	.write =3D aspeed_smc_write_user,
+};
+
 static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller=
,
 				  struct device_node *np, struct resource *r)
 {
@@ -805,12 +815,7 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_co=
ntroller *controller,
 		nor->dev =3D dev;
 		nor->priv =3D chip;
 		spi_nor_set_flash_node(nor, child);
-		nor->read =3D aspeed_smc_read_user;
-		nor->write =3D aspeed_smc_write_user;
-		nor->read_reg =3D aspeed_smc_read_reg;
-		nor->write_reg =3D aspeed_smc_write_reg;
-		nor->prepare =3D aspeed_smc_prep;
-		nor->unprepare =3D aspeed_smc_unprep;
+		nor->controller_ops =3D &aspeed_smc_controller_ops;
=20
 		ret =3D aspeed_smc_chip_setup_init(chip, r);
 		if (ret)
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/ca=
dence-quadspi.c
index 7bef63947b29..ebda612641a4 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -356,18 +356,19 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqsp=
i, unsigned int reg)
=20
 static int cqspi_command_read(struct spi_nor *nor,
 			      const u8 *txbuf, const unsigned n_tx,
-			      u8 *rxbuf, const unsigned n_rx)
+			      u8 *rxbuf, size_t n_rx)
 {
 	struct cqspi_flash_pdata *f_pdata =3D nor->priv;
 	struct cqspi_st *cqspi =3D f_pdata->cqspi;
 	void __iomem *reg_base =3D cqspi->iobase;
 	unsigned int rdreg;
 	unsigned int reg;
-	unsigned int read_len;
+	size_t read_len;
 	int status;
=20
 	if (!n_rx || n_rx > CQSPI_STIG_DATA_LEN_MAX || !rxbuf) {
-		dev_err(nor->dev, "Invalid input argument, len %d rxbuf 0x%p\n",
+		dev_err(nor->dev,
+			"Invalid input argument, len %zu rxbuf 0x%p\n",
 			n_rx, rxbuf);
 		return -EINVAL;
 	}
@@ -404,19 +405,19 @@ static int cqspi_command_read(struct spi_nor *nor,
 }
=20
 static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
-			       const u8 *txbuf, const unsigned n_tx)
+			       const u8 *txbuf, size_t n_tx)
 {
 	struct cqspi_flash_pdata *f_pdata =3D nor->priv;
 	struct cqspi_st *cqspi =3D f_pdata->cqspi;
 	void __iomem *reg_base =3D cqspi->iobase;
 	unsigned int reg;
 	unsigned int data;
-	u32 write_len;
+	size_t write_len;
 	int ret;
=20
 	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
 		dev_err(nor->dev,
-			"Invalid input argument, cmdlen %d txbuf 0x%p\n",
+			"Invalid input argument, cmdlen %zu txbuf 0x%p\n",
 			n_tx, txbuf);
 		return -EINVAL;
 	}
@@ -1050,7 +1051,7 @@ static int cqspi_erase(struct spi_nor *nor, loff_t of=
fs)
 		return ret;
=20
 	/* Send write enable, then erase commands. */
-	ret =3D nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
+	ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 	if (ret)
 		return ret;
=20
@@ -1080,7 +1081,7 @@ static void cqspi_unprep(struct spi_nor *nor, enum sp=
i_nor_ops ops)
 	mutex_unlock(&cqspi->bus_mutex);
 }
=20
-static int cqspi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len=
)
+static int cqspi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, size_t =
len)
 {
 	int ret;
=20
@@ -1091,7 +1092,8 @@ static int cqspi_read_reg(struct spi_nor *nor, u8 opc=
ode, u8 *buf, int len)
 	return ret;
 }
=20
-static int cqspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int le=
n)
+static int cqspi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
+			   size_t len)
 {
 	int ret;
=20
@@ -1216,6 +1218,16 @@ static void cqspi_request_mmap_dma(struct cqspi_st *=
cqspi)
 	init_completion(&cqspi->rx_dma_complete);
 }
=20
+static const struct spi_nor_controller_ops cqspi_controller_ops =3D {
+	.prepare =3D cqspi_prep,
+	.unprepare =3D cqspi_unprep,
+	.read_reg =3D cqspi_read_reg,
+	.write_reg =3D cqspi_write_reg,
+	.read =3D cqspi_read,
+	.write =3D cqspi_write,
+	.erase =3D cqspi_erase,
+};
+
 static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *n=
p)
 {
 	struct platform_device *pdev =3D cqspi->pdev;
@@ -1265,14 +1277,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi,=
 struct device_node *np)
 		nor->dev =3D dev;
 		spi_nor_set_flash_node(nor, np);
 		nor->priv =3D f_pdata;
-
-		nor->read_reg =3D cqspi_read_reg;
-		nor->write_reg =3D cqspi_write_reg;
-		nor->read =3D cqspi_read;
-		nor->write =3D cqspi_write;
-		nor->erase =3D cqspi_erase;
-		nor->prepare =3D cqspi_prep;
-		nor->unprepare =3D cqspi_unprep;
+		nor->controller_ops =3D &cqspi_controller_ops;
=20
 		mtd->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s.%d",
 					   dev_name(dev), cs);
diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/hisi-sfc.=
c
index c99ed9cdbf9c..a1258216f89d 100644
--- a/drivers/mtd/spi-nor/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/hisi-sfc.c
@@ -177,7 +177,7 @@ static void hisi_spi_nor_unprep(struct spi_nor *nor, en=
um spi_nor_ops ops)
 }
=20
 static int hisi_spi_nor_op_reg(struct spi_nor *nor,
-				u8 opcode, int len, u8 optype)
+				u8 opcode, size_t len, u8 optype)
 {
 	struct hifmc_priv *priv =3D nor->priv;
 	struct hifmc_host *host =3D priv->host;
@@ -200,7 +200,7 @@ static int hisi_spi_nor_op_reg(struct spi_nor *nor,
 }
=20
 static int hisi_spi_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
-		int len)
+				 size_t len)
 {
 	struct hifmc_priv *priv =3D nor->priv;
 	struct hifmc_host *host =3D priv->host;
@@ -215,7 +215,7 @@ static int hisi_spi_nor_read_reg(struct spi_nor *nor, u=
8 opcode, u8 *buf,
 }
=20
 static int hisi_spi_nor_write_reg(struct spi_nor *nor, u8 opcode,
-				u8 *buf, int len)
+				  const u8 *buf, size_t len)
 {
 	struct hifmc_priv *priv =3D nor->priv;
 	struct hifmc_host *host =3D priv->host;
@@ -311,6 +311,15 @@ static ssize_t hisi_spi_nor_write(struct spi_nor *nor,=
 loff_t to,
 	return len;
 }
=20
+static const struct spi_nor_controller_ops hisi_controller_ops =3D {
+	.prepare =3D hisi_spi_nor_prep,
+	.unprepare =3D hisi_spi_nor_unprep,
+	.read_reg =3D hisi_spi_nor_read_reg,
+	.write_reg =3D hisi_spi_nor_write_reg,
+	.read =3D hisi_spi_nor_read,
+	.write =3D hisi_spi_nor_write,
+};
+
 /**
  * Get spi flash device information and register it as a mtd device.
  */
@@ -357,13 +366,8 @@ static int hisi_spi_nor_register(struct device_node *n=
p,
 	}
 	priv->host =3D host;
 	nor->priv =3D priv;
+	nor->controller_ops =3D &hisi_controller_ops;
=20
-	nor->prepare =3D hisi_spi_nor_prep;
-	nor->unprepare =3D hisi_spi_nor_unprep;
-	nor->read_reg =3D hisi_spi_nor_read_reg;
-	nor->write_reg =3D hisi_spi_nor_write_reg;
-	nor->read =3D hisi_spi_nor_read;
-	nor->write =3D hisi_spi_nor_write;
 	ret =3D spi_nor_scan(nor, NULL, &hwcaps);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/spi-nor/intel-spi.c b/drivers/mtd/spi-nor/intel-sp=
i.c
index 43e55a2e9b27..dc38f19ac7ae 100644
--- a/drivers/mtd/spi-nor/intel-spi.c
+++ b/drivers/mtd/spi-nor/intel-spi.c
@@ -426,7 +426,7 @@ static int intel_spi_opcode_index(struct intel_spi *isp=
i, u8 opcode, int optype)
 	return 0;
 }
=20
-static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, int len)
+static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t le=
n)
 {
 	u32 val, status;
 	int ret;
@@ -469,7 +469,7 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi, u=
8 opcode, int len)
 	return 0;
 }
=20
-static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, int len,
+static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t le=
n,
 			      int optype)
 {
 	u32 val =3D 0, status;
@@ -535,7 +535,8 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u=
8 opcode, int len,
 	return 0;
 }
=20
-static int intel_spi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int=
 len)
+static int intel_spi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+			      size_t len)
 {
 	struct intel_spi *ispi =3D nor->priv;
 	int ret;
@@ -555,7 +556,8 @@ static int intel_spi_read_reg(struct spi_nor *nor, u8 o=
pcode, u8 *buf, int len)
 	return intel_spi_read_block(ispi, buf, len);
 }
=20
-static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, in=
t len)
+static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *b=
uf,
+			       size_t len)
 {
 	struct intel_spi *ispi =3D nor->priv;
 	int ret;
@@ -864,6 +866,14 @@ static void intel_spi_fill_partition(struct intel_spi =
*ispi,
 	}
 }
=20
+static const struct spi_nor_controller_ops intel_spi_controller_ops =3D {
+	.read_reg =3D intel_spi_read_reg,
+	.write_reg =3D intel_spi_write_reg,
+	.read =3D intel_spi_read,
+	.write =3D intel_spi_write,
+	.erase =3D intel_spi_erase,
+};
+
 struct intel_spi *intel_spi_probe(struct device *dev,
 	struct resource *mem, const struct intel_spi_boardinfo *info)
 {
@@ -897,11 +907,7 @@ struct intel_spi *intel_spi_probe(struct device *dev,
=20
 	ispi->nor.dev =3D ispi->dev;
 	ispi->nor.priv =3D ispi;
-	ispi->nor.read_reg =3D intel_spi_read_reg;
-	ispi->nor.write_reg =3D intel_spi_write_reg;
-	ispi->nor.read =3D intel_spi_read;
-	ispi->nor.write =3D intel_spi_write;
-	ispi->nor.erase =3D intel_spi_erase;
+	ispi->nor.controller_ops =3D &intel_spi_controller_ops;
=20
 	ret =3D spi_nor_scan(&ispi->nor, NULL, &hwcaps);
 	if (ret) {
diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-qu=
adspi.c
index 34db01ab6cab..b1691680d174 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -151,9 +151,9 @@ static int mtk_nor_execute_cmd(struct mtk_nor *mtk_nor,=
 u8 cmdval)
 }
=20
 static int mtk_nor_do_tx_rx(struct mtk_nor *mtk_nor, u8 op,
-			    u8 *tx, int txlen, u8 *rx, int rxlen)
+			    const u8 *tx, size_t txlen, u8 *rx, size_t rxlen)
 {
-	int len =3D 1 + txlen + rxlen;
+	size_t len =3D 1 + txlen + rxlen;
 	int i, ret, idx;
=20
 	if (len > MTK_NOR_MAX_SHIFT)
@@ -193,7 +193,7 @@ static int mtk_nor_do_tx_rx(struct mtk_nor *mtk_nor, u8=
 op,
 }
=20
 /* Do a WRSR (Write Status Register) command */
-static int mtk_nor_wr_sr(struct mtk_nor *mtk_nor, u8 sr)
+static int mtk_nor_wr_sr(struct mtk_nor *mtk_nor, const u8 sr)
 {
 	writeb(sr, mtk_nor->base + MTK_NOR_PRGDATA5_REG);
 	writeb(8, mtk_nor->base + MTK_NOR_CNT_REG);
@@ -354,7 +354,7 @@ static ssize_t mtk_nor_write(struct spi_nor *nor, loff_=
t to, size_t len,
 	return len;
 }
=20
-static int mtk_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int l=
en)
+static int mtk_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, size_=
t len)
 {
 	int ret;
 	struct mtk_nor *mtk_nor =3D nor->priv;
@@ -376,8 +376,8 @@ static int mtk_nor_read_reg(struct spi_nor *nor, u8 opc=
ode, u8 *buf, int len)
 	return ret;
 }
=20
-static int mtk_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
-			     int len)
+static int mtk_nor_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf=
,
+			     size_t len)
 {
 	int ret;
 	struct mtk_nor *mtk_nor =3D nor->priv;
@@ -419,6 +419,13 @@ static int mtk_nor_enable_clk(struct mtk_nor *mtk_nor)
 	return 0;
 }
=20
+static const struct spi_nor_controller_ops mtk_controller_ops =3D {
+	.read_reg =3D mtk_nor_read_reg,
+	.write_reg =3D mtk_nor_write_reg,
+	.read =3D mtk_nor_read,
+	.write =3D mtk_nor_write,
+};
+
 static int mtk_nor_init(struct mtk_nor *mtk_nor,
 			struct device_node *flash_node)
 {
@@ -438,12 +445,8 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
 	nor->dev =3D mtk_nor->dev;
 	nor->priv =3D mtk_nor;
 	spi_nor_set_flash_node(nor, flash_node);
+	nor->controller_ops =3D &mtk_controller_ops;
=20
-	/* fill the hooks to spi nor */
-	nor->read =3D mtk_nor_read;
-	nor->read_reg =3D mtk_nor_read_reg;
-	nor->write =3D mtk_nor_write;
-	nor->write_reg =3D mtk_nor_write_reg;
 	nor->mtd.name =3D "mtk_nor";
 	/* initialized with NULL */
 	ret =3D spi_nor_scan(nor, NULL, &hwcaps);
diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spif=
i.c
index 4a871587392b..9a5b1a7c636a 100644
--- a/drivers/mtd/spi-nor/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/nxp-spifi.c
@@ -123,7 +123,8 @@ static int nxp_spifi_set_memory_mode_on(struct nxp_spif=
i *spifi)
 	return ret;
 }
=20
-static int nxp_spifi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int=
 len)
+static int nxp_spifi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+			      size_t len)
 {
 	struct nxp_spifi *spifi =3D nor->priv;
 	u32 cmd;
@@ -145,7 +146,8 @@ static int nxp_spifi_read_reg(struct spi_nor *nor, u8 o=
pcode, u8 *buf, int len)
 	return nxp_spifi_wait_for_cmd(spifi);
 }
=20
-static int nxp_spifi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, in=
t len)
+static int nxp_spifi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *b=
uf,
+			       size_t len)
 {
 	struct nxp_spifi *spifi =3D nor->priv;
 	u32 cmd;
@@ -263,9 +265,18 @@ static int nxp_spifi_setup_memory_cmd(struct nxp_spifi=
 *spifi)
 static void nxp_spifi_dummy_id_read(struct spi_nor *nor)
 {
 	u8 id[SPI_NOR_MAX_ID_LEN];
-	nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
+	nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
+				      SPI_NOR_MAX_ID_LEN);
 }
=20
+static const struct spi_nor_controller_ops nxp_spifi_controller_ops =3D {
+	.read_reg  =3D nxp_spifi_read_reg,
+	.write_reg =3D nxp_spifi_write_reg,
+	.read  =3D nxp_spifi_read,
+	.write =3D nxp_spifi_write,
+	.erase =3D nxp_spifi_erase,
+};
+
 static int nxp_spifi_setup_flash(struct nxp_spifi *spifi,
 				 struct device_node *np)
 {
@@ -332,11 +343,7 @@ static int nxp_spifi_setup_flash(struct nxp_spifi *spi=
fi,
 	spifi->nor.dev   =3D spifi->dev;
 	spi_nor_set_flash_node(&spifi->nor, np);
 	spifi->nor.priv  =3D spifi;
-	spifi->nor.read  =3D nxp_spifi_read;
-	spifi->nor.write =3D nxp_spifi_write;
-	spifi->nor.erase =3D nxp_spifi_erase;
-	spifi->nor.read_reg  =3D nxp_spifi_read_reg;
-	spifi->nor.write_reg =3D nxp_spifi_write_reg;
+	spifi->nor.controller_ops =3D &nxp_spifi_controller_ops;
=20
 	/*
 	 * The first read on a hard reset isn't reliable so do a
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1d8621d43160..b8c7ded0f145 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -338,7 +338,7 @@ static ssize_t spi_nor_read_data(struct spi_nor *nor, l=
off_t from, size_t len,
 	if (nor->spimem)
 		return spi_nor_spimem_read_data(nor, from, len, buf);
=20
-	return nor->read(nor, from, len, buf);
+	return nor->controller_ops->read(nor, from, len, buf);
 }
=20
 /**
@@ -385,7 +385,7 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, =
loff_t to, size_t len,
 	if (nor->spimem)
 		return spi_nor_spimem_write_data(nor, to, len, buf);
=20
-	return nor->write(nor, to, len, buf);
+	return nor->controller_ops->write(nor, to, len, buf);
 }
=20
 /*
@@ -406,7 +406,8 @@ static int read_sr(struct spi_nor *nor)
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret =3D nor->read_reg(nor, SPINOR_OP_RDSR, nor->bouncebuf, 1);
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
+						    nor->bouncebuf, 1);
 	}
=20
 	if (ret < 0) {
@@ -435,7 +436,8 @@ static int read_fsr(struct spi_nor *nor)
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret =3D nor->read_reg(nor, SPINOR_OP_RDFSR, nor->bouncebuf, 1);
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
+						    nor->bouncebuf, 1);
 	}
=20
 	if (ret < 0) {
@@ -464,7 +466,8 @@ static int read_cr(struct spi_nor *nor)
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret =3D nor->read_reg(nor, SPINOR_OP_RDCR, nor->bouncebuf, 1);
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR,
+						    nor->bouncebuf, 1);
 	}
=20
 	if (ret < 0) {
@@ -492,7 +495,8 @@ static int write_sr(struct spi_nor *nor, u8 val)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->bouncebuf, 1);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+					      nor->bouncebuf, 1);
 }
=20
 /*
@@ -511,7 +515,7 @@ static int write_enable(struct spi_nor *nor)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 }
=20
 /*
@@ -529,7 +533,7 @@ static int write_disable(struct spi_nor *nor)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
=20
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
@@ -631,8 +635,9 @@ static int macronix_set_4byte(struct spi_nor *nor, bool=
 enable)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B,
-			      NULL, 0);
+	return nor->controller_ops->write_reg(nor, enable ? SPINOR_OP_EN4B :
+							    SPINOR_OP_EX4B,
+					      NULL, 0);
 }
=20
 static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
@@ -660,7 +665,8 @@ static int spansion_set_4byte(struct spi_nor *nor, bool=
 enable)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_BRWR, nor->bouncebuf, 1);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
+					      nor->bouncebuf, 1);
 }
=20
 static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
@@ -677,7 +683,8 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 ea=
r)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
+					      nor->bouncebuf, 1);
 }
=20
 static int winbond_set_4byte(struct spi_nor *nor, bool enable)
@@ -712,7 +719,7 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr=
)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
+	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
 }
=20
 static int s3an_sr_ready(struct spi_nor *nor)
@@ -740,7 +747,7 @@ static int spi_nor_clear_sr(struct spi_nor *nor)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
 }
=20
 static int spi_nor_sr_ready(struct spi_nor *nor)
@@ -774,7 +781,7 @@ static int spi_nor_clear_fsr(struct spi_nor *nor)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
 }
=20
 static int spi_nor_fsr_ready(struct spi_nor *nor)
@@ -871,7 +878,8 @@ static int erase_chip(struct spi_nor *nor)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
+					      NULL, 0);
 }
=20
 static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops ops=
)
@@ -880,10 +888,9 @@ static int spi_nor_lock_and_prep(struct spi_nor *nor, =
enum spi_nor_ops ops)
=20
 	mutex_lock(&nor->lock);
=20
-	if (nor->prepare) {
-		ret =3D nor->prepare(nor, ops);
+	if (nor->controller_ops &&  nor->controller_ops->prepare) {
+		ret =3D nor->controller_ops->prepare(nor, ops);
 		if (ret) {
-			dev_err(nor->dev, "failed in the preparation.\n");
 			mutex_unlock(&nor->lock);
 			return ret;
 		}
@@ -893,8 +900,8 @@ static int spi_nor_lock_and_prep(struct spi_nor *nor, e=
num spi_nor_ops ops)
=20
 static void spi_nor_unlock_and_unprep(struct spi_nor *nor, enum spi_nor_op=
s ops)
 {
-	if (nor->unprepare)
-		nor->unprepare(nor, ops);
+	if (nor->controller_ops && nor->controller_ops->unprepare)
+		nor->controller_ops->unprepare(nor, ops);
 	mutex_unlock(&nor->lock);
 }
=20
@@ -935,8 +942,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u3=
2 addr)
=20
 	addr =3D spi_nor_convert_addr(nor, addr);
=20
-	if (nor->erase)
-		return nor->erase(nor, addr);
+	if (nor->controller_ops && nor->controller_ops->erase)
+		return nor->controller_ops->erase(nor, addr);
=20
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -957,8 +964,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u3=
2 addr)
 		addr >>=3D 8;
 	}
=20
-	return nor->write_reg(nor, nor->erase_opcode, nor->bouncebuf,
-			      nor->addr_width);
+	return nor->controller_ops->write_reg(nor, nor->erase_opcode,
+					      nor->bouncebuf, nor->addr_width);
 }
=20
 /**
@@ -1678,7 +1685,8 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr=
)
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret =3D nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     sr_cr, 2);
 	}
=20
 	if (ret < 0) {
@@ -1873,7 +1881,7 @@ static int spi_nor_write_sr2(struct spi_nor *nor, u8 =
*sr2)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
 }
=20
 static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
@@ -1888,7 +1896,7 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *=
sr2)
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
=20
-	return nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
+	return nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
 }
=20
 /**
@@ -2520,8 +2528,8 @@ static const struct flash_info *spi_nor_read_id(struc=
t spi_nor *nor)
=20
 		tmp =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		tmp =3D nor->read_reg(nor, SPINOR_OP_RDID, id,
-				    SPI_NOR_MAX_ID_LEN);
+		tmp =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
+						    SPI_NOR_MAX_ID_LEN);
 	}
 	if (tmp < 0) {
 		dev_err(nor->dev, "error %d reading JEDEC ID\n", tmp);
@@ -2722,9 +2730,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_=
t to, size_t len,
 static int spi_nor_check(struct spi_nor *nor)
 {
 	if (!nor->dev ||
-	    (!nor->spimem &&
-	    (!nor->read || !nor->write || !nor->read_reg ||
-	      !nor->write_reg))) {
+	    (!nor->spimem && nor->controller_ops &&
+	    (!nor->controller_ops->read ||
+	     !nor->controller_ops->write ||
+	     !nor->controller_ops->read_reg ||
+	     !nor->controller_ops->write_reg))) {
 		pr_err("spi-nor: please fill all the necessary fields!\n");
 		return -EINVAL;
 	}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fc0b4b19c900..d1d736d3c8ab 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -466,6 +466,34 @@ enum spi_nor_pp_command_index {
 struct spi_nor;
=20
 /**
+ * struct spi_nor_controller_ops - SPI NOR controller driver specific
+ *                                 operations.
+ * @prepare:		[OPTIONAL] do some preparations for the
+ *			read/write/erase/lock/unlock operations.
+ * @unprepare:		[OPTIONAL] do some post work after the
+ *			read/write/erase/lock/unlock operations.
+ * @read_reg:		read out the register.
+ * @write_reg:		write data to the register.
+ * @read:		read data from the SPI NOR.
+ * @write:		write data to the SPI NOR.
+ * @erase:		erase a sector of the SPI NOR at the offset @offs; if
+ *			not provided by the driver, spi-nor will send the erase
+ *			opcode via write_reg().
+ */
+struct spi_nor_controller_ops {
+	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
+	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
+	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, size_t len);
+	int (*write_reg)(struct spi_nor *nor, u8 opcode, const u8 *buf,
+			 size_t len);
+
+	ssize_t (*read)(struct spi_nor *nor, loff_t from, size_t len, u8 *buf);
+	ssize_t (*write)(struct spi_nor *nor, loff_t to, size_t len,
+			 const u8 *buf);
+	int (*erase)(struct spi_nor *nor, loff_t offs);
+};
+
+/**
  * struct spi_nor_locking_ops - SPI NOR locking methods
  * @lock:	lock a region of the SPI NOR.
  * @unlock:	unlock a region of the SPI NOR.
@@ -549,17 +577,7 @@ struct flash_info;
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
- * @prepare:		[OPTIONAL] do some preparations for the
- *			read/write/erase/lock/unlock operations
- * @unprepare:		[OPTIONAL] do some post work after the
- *			read/write/erase/lock/unlock operations
- * @read_reg:		[DRIVER-SPECIFIC] read out the register
- * @write_reg:		[DRIVER-SPECIFIC] write data to the register
- * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
- * @write:		[DRIVER-SPECIFIC] write data to the SPI NOR
- * @erase:		[DRIVER-SPECIFIC] erase a sector of the SPI NOR
- *			at the offset @offs; if not provided by the driver,
- *			spi-nor will send the erase opcode via write_reg()
+ * @controller_ops:	SPI NOR controller driver specific operations.
  * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
  *			the SPI NOR Status Register.
  * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
@@ -588,16 +606,7 @@ struct spi_nor {
 	bool			sst_write_second;
 	u32			flags;
=20
-	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
-	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
-	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
-	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
-
-	ssize_t (*read)(struct spi_nor *nor, loff_t from,
-			size_t len, u_char *read_buf);
-	ssize_t (*write)(struct spi_nor *nor, loff_t to,
-			size_t len, const u_char *write_buf);
-	int (*erase)(struct spi_nor *nor, loff_t offs);
+	const struct spi_nor_controller_ops *controller_ops;
=20
 	int (*clear_sr_bp)(struct spi_nor *nor);
 	struct spi_nor_flash_parameter params;
--=20
2.9.5

