Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758F57E401
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbfHAUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 16:18:08 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:11040
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388959AbfHAUR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:17:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ9TlOllq0k/XtXqh/UkImAP/KbWpr6qfoNVBsRu90irdmhMfuOklO2H3AkA3eZtq/Jd5UuLZs2iRaLqmbfGngkKExS5Qowo+77Mk6ruR8NwT9pDD4W4w6SyBkn0TuCIVP7LpIgIoDa+lruHUpAvqv8Bmn7oiWWOFJ/EOGVGkv/areCGTcxM07jLu3YvEwb8qzlZ6y4VjXGYM2Kg5i3nUoQ05lkX1egyzs7E1E4YJ0KEPcwdvQKW4sCWPzAWlv9dKpM/Dnopi7EIvQAh1wDamzLauKrLXeG/KYKQzJSa9V2ABNX1EePzpMyUICnf6ePnYw+wa4DOOMv4AifZsx87xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYSM7so9/8u+3YQaxWGf4sxY+TpdoBO5KrBkhvUkDbU=;
 b=g9sdU060FmebmnSU8BhmKkFUkkBf+4o1HVMfnMnnAEERmlRNwnITCLvqQaYmL+wDeaZf8dLhPPzV8Btw4rYTi/L6RKKYEuWebgqzwF2lOPSW5KdrxES68q+79wY3h0zrGfxIhjMVtjA+7e3zOKPPG3oWsBGfDQJS/2h9rFsfwub8WExXHtgNqO3P8F9cYkwqxKMJ3Lwzp9SZXnPKPWN1jdveqBDrMPuOroUEn2AXVU3BJ3PoUCKqPW11YBYdKqDM30bfODmDvuXTMXOQKDu4ZPQ0er6ZoAsaegc1p81cYVoI8A8+f4Q1wCsUNGcroxU5o5byzMc5eiLuK4g7qBv4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYSM7so9/8u+3YQaxWGf4sxY+TpdoBO5KrBkhvUkDbU=;
 b=cbUDs9Wu103WRzkQybuyJtSnMN0lIAMlC/qHTrVLNXDsvqj4Lm3kmothBpGwANTu+DyXkOFzieBWzir6lbOBexgCQHEzLnBn2hQAe1qGYo7AasNO6Q8PKGDXkmmBvXA4IET+H28+1dDHaUcQCKTi0VDK1YxG4sFgAmZeZ4bBkSM=
Received: from VE1PR04MB6463.eurprd04.prod.outlook.com (20.179.233.20) by
 VE1PR04MB6656.eurprd04.prod.outlook.com (20.179.235.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 1 Aug 2019 20:17:01 +0000
Received: from VE1PR04MB6463.eurprd04.prod.outlook.com
 ([fe80::8fc:e04c:fbb6:4f1f]) by VE1PR04MB6463.eurprd04.prod.outlook.com
 ([fe80::8fc:e04c:fbb6:4f1f%7]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 20:17:01 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v3 5/7] soc/fsl/qbman: Disable interrupts during portal
 recovery
Thread-Topic: [PATCH v3 5/7] soc/fsl/qbman: Disable interrupts during portal
 recovery
Thread-Index: AQHVSKYUT+eRL7IWx0q0ia/ZSerlpw==
Date:   Thu, 1 Aug 2019 20:17:01 +0000
Message-ID: <1564690599-29713-6-git-send-email-roy.pledge@nxp.com>
References: <1564690599-29713-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1564690599-29713-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SN4PR0501CA0130.namprd05.prod.outlook.com
 (2603:10b6:803:42::47) To VE1PR04MB6463.eurprd04.prod.outlook.com
 (2603:10a6:803:11d::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4afdc9e-e87e-4b79-2633-08d716bd3688
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6656;
x-ms-traffictypediagnostic: VE1PR04MB6656:
x-microsoft-antispam-prvs: <VE1PR04MB66569053EC4EA08F29D18D8A86DE0@VE1PR04MB6656.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(386003)(6506007)(305945005)(7736002)(71200400001)(71190400001)(68736007)(14454004)(36756003)(54906003)(316002)(110136005)(6116002)(3846002)(486006)(186003)(66066001)(6436002)(256004)(26005)(2201001)(6636002)(3450700001)(44832011)(6486002)(102836004)(2906002)(14444005)(446003)(476003)(2616005)(50226002)(64756008)(66446008)(66476007)(25786009)(81166006)(66946007)(52116002)(5660300002)(11346002)(76176011)(478600001)(66556008)(8676002)(86362001)(81156014)(8936002)(99286004)(6512007)(4326008)(2501003)(53936002)(43066004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6656;H:VE1PR04MB6463.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kGypcEyyEaHPXYy4G2LGyXAKO0ZP0tWL+aYquA8Ihpm7Wru8WVmLWaIGYoeDc0I4LfepVKlD8KFkti0fuaxI14WLFnxrNbRMAUG1MHldEOLgLwNNhGUdm/93l7Gy8UTVPz13FVBaYxQsj6mwldBoRr0cJdglx/XdXOITx3rzxKukX8Wh90ZG8KcrUYeHi5rxBiyz1j34JSO1rn7mYirGMDcYzOHlvxYh2WO5+6k8de3w5hdgbqyhRPtw8eO+vpVXkRLn+LITdCP6t+SP+BL5hzAuv/0Ve94tD6D1FbnF9UKJKfpHUWE/eGbCjeUcjaW4WUT9Bwl7wpj3YhVW4RBsvdIS7D8M25aLiZj/myQXowys88g7qPRmcBKAxlzOSCB29UWaDuM29w+PXV3Itp7ii1GmXdhP8SDOfgDyzjf+ytQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4afdc9e-e87e-4b79-2633-08d716bd3688
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 20:17:01.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roy.pledge@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the QBMan interrupts during recovery.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c      | 22 +++++++++++++++++++---
 drivers/soc/fsl/qbman/qman_ccsr.c |  1 +
 drivers/soc/fsl/qbman/qman_priv.h |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 2989504..4a99ce5 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1070,6 +1070,20 @@ int qman_wq_alloc(void)
 	return 0;
 }
=20
+
+void qman_enable_irqs(void)
+{
+	int i;
+
+	for (i =3D 0; i < num_possible_cpus(); i++) {
+		if (affine_portals[i]) {
+			qm_out(&affine_portals[i]->p, QM_REG_ISR, 0xffffffff);
+			qm_out(&affine_portals[i]->p, QM_REG_IIR, 0);
+		}
+
+	}
+}
+
 /*
  * This is what everything can wait on, even if it migrates to a different=
 cpu
  * to the one whose affine portal it is waiting on.
@@ -1269,8 +1283,8 @@ static int qman_create_portal(struct qman_portal *por=
tal,
 	qm_out(p, QM_REG_ISDR, isdr);
 	portal->irq_sources =3D 0;
 	qm_out(p, QM_REG_IER, 0);
-	qm_out(p, QM_REG_ISR, 0xffffffff);
 	snprintf(portal->irqname, MAX_IRQNAME, IRQNAME, c->cpu);
+	qm_out(p, QM_REG_IIR, 1);
 	if (request_irq(c->irq, portal_isr, 0, portal->irqname,	portal)) {
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
@@ -1290,7 +1304,7 @@ static int qman_create_portal(struct qman_portal *por=
tal,
 	isdr &=3D ~(QM_PIRQ_DQRI | QM_PIRQ_MRI);
 	qm_out(p, QM_REG_ISDR, isdr);
 	if (qm_dqrr_current(p)) {
-		dev_err(c->dev, "DQRR unclean\n");
+		dev_dbg(c->dev, "DQRR unclean\n");
 		qm_dqrr_cdc_consume_n(p, 0xffff);
 	}
 	if (qm_mr_current(p) && drain_mr_fqrni(p)) {
@@ -1303,8 +1317,10 @@ static int qman_create_portal(struct qman_portal *po=
rtal,
 	}
 	/* Success */
 	portal->config =3D c;
+	qm_out(p, QM_REG_ISR, 0xffffffff);
 	qm_out(p, QM_REG_ISDR, 0);
-	qm_out(p, QM_REG_IIR, 0);
+	if (!qman_requires_cleanup())
+		qm_out(p, QM_REG_IIR, 0);
 	/* Write a sane SDQCR */
 	qm_dqrr_sdqcr_set(p, portal->sdqcr);
 	return 0;
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman=
_ccsr.c
index 709661b7b..157659f 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -744,6 +744,7 @@ int qman_requires_cleanup(void)
=20
 void qman_done_cleanup(void)
 {
+	qman_enable_irqs();
 	__qman_requires_cleanup =3D 0;
 }
=20
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman=
_priv.h
index a8a35fe..fd1cf54 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -279,3 +279,4 @@ int qman_shutdown_fq(u32 fqid);
=20
 int qman_requires_cleanup(void);
 void qman_done_cleanup(void);
+void qman_enable_irqs(void);
--=20
2.7.4

