Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CCC6E3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 12:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfGSKFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 06:05:47 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:10046
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbfGSKFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjoZsa0RMV9JGFR7vMzSsPdFAHqqyQhlIhIsz+C/KlyWndJfKUBQsJNPr4U2cJyUeq7DxfGpEa1l43ogflBQBB/iQvRglSZd6d4dxrPq+8Oe7TdOlfhBOzUJttRvvGDsO1NgoPU4HbP85mEBjsSKPrjyFkPVszPWYvz/eIJ8pdHFif/bsMLyHpHrTRoL7Ku85H446f0lTtieZ5oci2kHv8BDKiYoEy0KOLmYnh7fZDSB7beU8Y2GVy+MPwMuBxYoWv8Yu0eKneJlzG833ys1pQEl2wnL/MJ1ruh06sPHmPPVS35cRMSiuZT/UXKOHSkDUyoVCFUdXRdGwrLh7MrPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koq0CKddyZm2mfqkFPbj4WrPzE2dqUucDVLLxp5WBtk=;
 b=C4wwS5Nd92X1kqMfI7f1+rNXyTyHpTxB0AfstMXeUsIao1YV7B/EtLjWcduzqhg+qTmfiRfAXQNBgQexJTyJwQCVZGa0lfB5OB5/ExheJFYPzZ5H8T1IoHOEynaEPUw48Anrz9Kzg6PIoblWtC/5oZBkDs7pT7cr1/yn8ogfz/Oc3t+I2e3W/+zE/UpIAUVTNm/X6MkOj3fZ7ZIaKWiCNM0/CQqHxYEn+KY0HCgKYjUYdJ6/HFTVI6uOosGsVJQ+m9Tk1E6kRbrAsezNwpOClaYE/9OF4HXNYRmvKyopdMfEsTCftnNT+3qG4XbHIMGAJoOMqB5iqmRmCQCN/vRftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koq0CKddyZm2mfqkFPbj4WrPzE2dqUucDVLLxp5WBtk=;
 b=EHnLM8M7zXibs/SSSzJ+2XryzxOKO8jnsJ2NLnKS32qZxnap44yGAiMuBmMavWOqxLR5uQtDnMAetfiP6s0qFdzsOg/N/B/SZetMXshJSjy36kfsvnyX40Z3N/usRMeyS8fCjNLUoHSqnbZlgkj7p4pPvWj4YWKi8E+zjo2KcQw=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5925.eurprd05.prod.outlook.com (20.179.0.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 10:05:37 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2094.011; Fri, 19 Jul 2019
 10:05:37 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 6/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Topic: [PATCH v6 6/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Index: AQHVPhmDKAGkLrCq2kum0p6xuKjV/w==
Date:   Fri, 19 Jul 2019 10:05:37 +0000
Message-ID: <20190719100524.23300-7-oleksandr.suvorov@toradex.com>
References: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:207::23)
 To AM6PR05MB6535.eurprd05.prod.outlook.com (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74f73370-2ed0-415f-7721-08d70c30a5a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5925;
x-ms-traffictypediagnostic: AM6PR05MB5925:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR05MB5925CA6F93D56B5A608C5B9CF9CB0@AM6PR05MB5925.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(14454004)(68736007)(8676002)(50226002)(6486002)(8936002)(54906003)(305945005)(7736002)(71190400001)(71200400001)(6436002)(81156014)(186003)(99286004)(66476007)(66446008)(66556008)(64756008)(1411001)(81166006)(2906002)(6306002)(476003)(36756003)(66946007)(446003)(256004)(6512007)(86362001)(6916009)(26005)(966005)(478600001)(66066001)(11346002)(52116002)(53936002)(486006)(76176011)(2616005)(25786009)(1076003)(6506007)(4326008)(44832011)(3846002)(6116002)(316002)(5660300002)(102836004)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5925;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SDVHdJ8TDLcNF/2T5Hpmk7+CYNiEpn+ILZESOY0qVqO2mSEMNpmG/Zm9HA9kONhWZ6nVzh9M4pKZDbcpCf7cgb8oeYScYu2W+2Em5bQyQB1vAeOtdS/HK6Hcc5ahIakPpApHHb2wbFaaT+zHUsB7Ka0i8B5VfkJGplViD5x2MVsYacKsbbMI3He3o8IvxfL2miYKwK9oWBZHurE9xIOgjFalBIgMQQmFa2aYkmWM/SHLivny32ThK0Ylu3u376pdnvldvKZxQ2emzrLbtoMlUZP3spQCR5ka7AbnpMznvFuDyUYXcg4Fd4eDJS5bSakFryQLAn+jnqxnn9mQ+y0X8DP06SnpfJ89QM52pGJRvIJx6BrbZdhZPV522H7nA0bTSbDmlI7nM/6IGufrV4Zfu4HAjqmLtqu0OKrXvOLP3Ao=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f73370-2ed0-415f-7721-08d70c30a5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 10:05:37.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If VDDA !=3D VDDIO and any of them is greater than 3.1V, charge pump
source can be assigned automatically [1].

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message
- Fix multi-line comment format

Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 23f4ae2f0723..aa1f9637d895 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1338,12 +1338,17 @@ static int sgtl5000_set_power_regs(struct snd_soc_c=
omponent *component)
 					SGTL5000_INT_OSC_EN);
 		/* Enable VDDC charge pump */
 		ana_pwr |=3D SGTL5000_VDDC_CHRGPMP_POWERUP;
-	} else if (vddio >=3D 3100 && vdda >=3D 3100) {
+	} else {
 		ana_pwr &=3D ~SGTL5000_VDDC_CHRGPMP_POWERUP;
-		/* VDDC use VDDIO rail */
-		lreg_ctrl |=3D SGTL5000_VDDC_ASSN_OVRD;
-		lreg_ctrl |=3D SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		/*
+		 * if vddio =3D=3D vdda the source of charge pump should be
+		 * assigned manually to VDDIO
+		 */
+		if (vddio =3D=3D vdda) {
+			lreg_ctrl |=3D SGTL5000_VDDC_ASSN_OVRD;
+			lreg_ctrl |=3D SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+				    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		}
 	}
=20
 	snd_soc_component_write(component, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
--=20
2.20.1

