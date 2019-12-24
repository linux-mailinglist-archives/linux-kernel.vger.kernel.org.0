Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6384312A37D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfLXRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 12:35:09 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:40449
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbfLXRfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnB80cckWBIAQafLN0IPF91ce+g5Ht7qeutJ2eb+7QU=;
 b=zyDkZaj/EkSLpTmgA9/jx5/nb6hn2b7SpmXBsSySpUBORTWe2sQFUxjZ2AYj7hvyMqHkambLDenV/FocPhTDHtBU0SclhtF3KvTi9kan0dwSWy174Eo88nZfnWTDwUX8uBI38YFpNps9oK3CE4PLxg9zcd8QSA3jlDncCLteo24=
Received: from VI1PR08CA0151.eurprd08.prod.outlook.com (2603:10a6:800:d5::29)
 by VI1PR0802MB2622.eurprd08.prod.outlook.com (2603:10a6:800:b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15; Tue, 24 Dec
 2019 17:34:56 +0000
Received: from AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0151.outlook.office365.com
 (2603:10a6:800:d5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:56 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT063.mail.protection.outlook.com (10.152.16.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:56 +0000
Received: ("Tessian outbound 4f3bc9719026:v40"); Tue, 24 Dec 2019 17:34:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c55a258e76e13e4b
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.15
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E889DE88-3357-410B-81E4-B1EB10EFCCBC.1;
        Tue, 24 Dec 2019 17:34:51 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.15
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHk/oocB6h1FOsJSSs4UzP9K1stzn/RX3TbP7O2+c01egkXDrc2qrhORNnOW7G1uElB1zYQiD/PRJls2GDRGRx76g7gFK/ZTg5uZlxLrf+VHE1sMVId41OZk8eiHuDTbBe9HfCsoLQO7OPNU1UDvQhGvaTHMLOHLQch/UICKkNu1LfPggnHJGPmq4tYGcEBaV5AiO2pvQZ5eMjiJd+qTGzdWYkf+rJMcxTuzeUCfzWMO6QA+TvjzGdWn+wxQiufQbto9b15XDYloPEYXP0j62lDSZr5bgniyyqhdfqgBatfvWaMEE+1MUV7xpTdwtjskWxiy98RgiOjYl7uSXAmtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnB80cckWBIAQafLN0IPF91ce+g5Ht7qeutJ2eb+7QU=;
 b=en+jesXrQmcbU9OoE5PFL+SCCWT6sotl8PDJqfGL8Q0KLXBFZGohrLXrC24ZIipLLUGoYapso0a8KnbOjah8nkzkOa/S20JS2wH9F7nvCN1ZVxtsJM/R5LK/OuVOjlMUAynfP8128Whoq0K/BbKx+a3T4ybh2ETPBwPRxmjQbuAXCBbmDawKw/yxdsZIn/e24qQQZMYNRaRe9rcqlUgB9v2IN2v1j/bZT3fqAWZAYayPcCtQ4dn46G30wjbV73VYXFjVCDQpzN9uD8hkpZhRCeKsmmZqOYK4wANWSil/i7At47PZFbQPozgQisIkOX8kN8ZxjroaOQbpZ+5rbxspLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnB80cckWBIAQafLN0IPF91ce+g5Ht7qeutJ2eb+7QU=;
 b=zyDkZaj/EkSLpTmgA9/jx5/nb6hn2b7SpmXBsSySpUBORTWe2sQFUxjZ2AYj7hvyMqHkambLDenV/FocPhTDHtBU0SclhtF3KvTi9kan0dwSWy174Eo88nZfnWTDwUX8uBI38YFpNps9oK3CE4PLxg9zcd8QSA3jlDncCLteo24=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:45 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:45 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 27/35] drm/bridge: ti-sn65dsi86: Use drm_bridge_init()
Thread-Topic: [PATCH v3 27/35] drm/bridge: ti-sn65dsi86: Use drm_bridge_init()
Thread-Index: AQHVuoBueFK3izZu8Uauiq2d8cLB6g==
Date:   Tue, 24 Dec 2019 17:34:45 +0000
Message-ID: <20191224173408.25624-28-mihail.atanassov@arm.com>
References: <20191224173408.25624-1-mihail.atanassov@arm.com>
In-Reply-To: <20191224173408.25624-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.24.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50b16c54-544b-49d7-3550-08d788979806
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|VI1PR0802MB2622:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2622B4C8F8179A4467EA139D8F290@VI1PR0802MB2622.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pRgUrvrRb5q66klerm2j6rTE05IkB6ogY2B9OirsyQ1M6O22YfI5Nkybof7kreoitje8/YFaQsKmvRh28QuKhquvkfcWp1HuR4aaoxggB46DhcK2F/QV6qzMPqh0YKK79h0r8eByu/2BANIKxnxi0kX3ICjQViZm7Ne0RGpxRrtbS9NtnHxTqp6KR6tqVlImbFMlemIpMfWO6ca0gFizq6KtxZY/6hznaOIVrcahTqfHQ3P9PWmFijKXMKmohl8aTncVw3LT8hw1j+W/jXguFfiKeX3cvT8Tc780flP26OVMFwYzzMMe/s49q6hMED4pb9NW6xI8FlT8jKIpnlIDSoAd28Vl+gdWizR3oUkYFmp9MVgtys5rqlZRaWnayqXauoIif3gy3aZzOkAoUGgdRMW8uS6u7TUJSaNtt+TRE9b6rJHJVgvFf5Dbl6GQeuus
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(81166006)(26826003)(356004)(336012)(2616005)(8676002)(107886003)(478600001)(5660300002)(81156014)(4326008)(76130400001)(54906003)(4744005)(6862004)(70586007)(70206006)(6506007)(6512007)(36906005)(6486002)(26005)(316002)(36756003)(1076003)(2906002)(186003)(86362001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2622;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8edd6c70-46e0-4be5-7331-08d7889790ff
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e85F+WtcRBxy+SguEnyYen7s5vzGM+S6qqLQV2FKNW+/RlSeAj9yUBxvsDmThJiZc1BUVGzmBrPbTBn/FE08AV3P2qlZPJn1AQ2MwjB6s2mryOCvsjutaUc+ONJMEJ3E2ELwvbWGjvU1YxXciO+ka8ozu0ePUKDMDC0kwp21yg2WpqRM4nrgcmeWpnfP4DqXzssrMKfYYrmbQKc/3pGKwYoLzPPcX5RFdCkTKbFhTn/3wjvDmvsMy8wtvMcCTfqIfiCOl4McZPRf61ga2kmCIwsHNRaBjrlB8GHdcibd1f57/pv1jdJvJMY0OaHaZHOF4yaQwohIpK2yEM9y7KHy/17Kf/2bjwdZZ/Ho8KTdZu/xrJg0tkeFKvL5A+GUUpUKiPCeSkQ1XAqmUWYi1BsO9V0ljIwTg9BsVstFMMc5rJ18i9Bq/hYFef47gckAX9ol
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:56.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b16c54-544b-49d7-3550-08d788979806
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge=
/ti-sn65dsi86.c
index 8a4e64cfca1e..b1d2690fc218 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -765,9 +765,8 @@ static int ti_sn_bridge_probe(struct i2c_client *client=
,
 	pdata->aux.transfer =3D ti_sn_aux_transfer;
 	drm_dp_aux_register(&pdata->aux);
=20
-	pdata->bridge.funcs =3D &ti_sn_bridge_funcs;
-	pdata->bridge.of_node =3D client->dev.of_node;
-
+	drm_bridge_init(&pdata->bridge, &client->dev, &ti_sn_bridge_funcs,
+			NULL);
 	drm_bridge_add(&pdata->bridge);
=20
 	ti_sn_debugfs_init(pdata);
--=20
2.24.0

