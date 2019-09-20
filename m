Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37E2B8ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 08:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437454AbfITGKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 02:10:01 -0400
Received: from mail-eopbgr770094.outbound.protection.outlook.com ([40.107.77.94]:45526
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437368AbfITGKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8wkcfH7AV3Mq94ozsweglhwfYgBvgUC22VQB+QOYMbR7fQjyHnip4uYZ6kkI6LfeqRJjFgVlhXho4JPXjTgZeyAqf312tKM2ebm/ufcr8LfthWP0bK+/F1nImOt8N2aR9AZDwNTJ0rCo0N6Y2c4fxggKhyckCB8BgAlLS3O0ZjqiiPRW90MS88Q4PDAKiGFMYM6FlxVBaEsMbNUMtrFhAivWz98n+t7fDeQ1/XjBV92bgSQFAFhnVPSx3jaYKu+D8sWWLKIaQ5x34xNtefNCZU9H4fa6Uft+K46KJa2EkAhyiYcOf3Dd0BBxphlGexLBAU5cDDmyXPDoi7eOKYz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiBUeMytGe2H5MkYqmU6RvQe6JnU7XjlCFhFw+pzafY=;
 b=Q8eg44klFGZ8wqc3tMbF+VBNSJqj4RvDlZXPmqZ2mL3sRKEE4Pueotjyc42yIqPqo4Cz0/Dquu24o5w5R7rV0avfRO1fP1j+DFNOs+jkdYjVSlLY/rzitb/qgeZheKM1QWo9FzFkuD/CZOPnI0e2HyMRwGh9RAn0Ug7Fhu8goI1RB/UojmhTjiWAtHkghjt4Nx2QU/juuCSbESVZGXcN+wAeFM5c4ugO5DA+8Icp4Yr3Oi3DlK7DVKt8E0kZUBaRH2XvulXvetZVZpCP65hQNnkuf00XU6egajacUK1LAVKr8Knxg6hs0J+Z0plc5sQHBa2Q7SpuLQSYMFyofIuQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiBUeMytGe2H5MkYqmU6RvQe6JnU7XjlCFhFw+pzafY=;
 b=3Y7K5XHL/V9ShmEvHindFYdgc2pTy4swaZYnoGdMpf3Qy2/A9+5vJXvm2gKl0FODbu8BGK+pR2NkP4NFVYtngX2MBM43t3/lWw5Qwg1Nlp4at9KHqMvRiJzqUy9RjVCwi633udkZYKNpStoGGPmZjhTO1bFOBijJpDFpaFQxIfU=
Received: from MN2PR04MB5886.namprd04.prod.outlook.com (20.179.22.213) by
 MN2PR04MB5647.namprd04.prod.outlook.com (20.179.21.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 06:09:56 +0000
Received: from MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd]) by MN2PR04MB5886.namprd04.prod.outlook.com
 ([fe80::8520:f80f:ae9:63cd%6]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 06:09:56 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v1 0/2] Add initial support for slimport anx7625
Thread-Topic: [PATCH v1 0/2] Add initial support for slimport anx7625
Thread-Index: AQHVb3oGgGDh16C3uESSEg10z5x9Ew==
Date:   Fri, 20 Sep 2019 06:09:56 +0000
Message-ID: <cover.1568957788.git.xji@analogixsemi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To MN2PR04MB5886.namprd04.prod.outlook.com
 (2603:10b6:208:a3::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aba42eed-bd6b-4ca5-853c-08d73d9128c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5647;
x-ms-traffictypediagnostic: MN2PR04MB5647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5647CE0AF8AD31B1BCB9068AC7880@MN2PR04MB5647.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39850400004)(346002)(136003)(189003)(199004)(53754006)(66946007)(386003)(4326008)(107886003)(14444005)(14454004)(6486002)(7736002)(6436002)(25786009)(256004)(305945005)(36756003)(71190400001)(71200400001)(7416002)(478600001)(66556008)(66446008)(5660300002)(476003)(52116002)(2616005)(64756008)(8936002)(66476007)(81166006)(8676002)(2501003)(26005)(66066001)(81156014)(86362001)(6512007)(186003)(99286004)(316002)(6506007)(102836004)(6116002)(3846002)(110136005)(4744005)(2906002)(54906003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5647;H:MN2PR04MB5886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bc5ikVPi5JG8KbVqQtF7LTDJyZwvLkFLmtSSAssPoFHhLLwaxh1ioM9DLuqWWOxbgCbhqNm6HwRjpQKzpf1827HlY+3zcvdPeeGXEdE/BTIT4NDbYNvrBe0KhapmhZcHZzNES3mdzul+/MPbd+fyJU/mwfHxi3Yvwc5NxRnxGwOgyFBZHTLKTapRjVQJGFf66/qp6f8MLy6eM9SNWwNZ0WxZ8BIpOczaKEVs1wzCRzLLXej6G3qEvYMaT+cbX8wcIk6ke5Hr8wneHQMFZVDuCk0j8ldt2shYrTtiDYZPA902QT/eemNQSKMrUfOTQMZ2SUc+w6f0xy6HljhIjAL3qLLiQ7ZwBt8xc/jxxm6wGRAstNSCT2oi33okOoqHspsXRwSQR6MSMeBi06FasboyA0FQNsBJCVoE/VDRxBYZUyo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <390CB1780B5B05498754EE9C43F4B189@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba42eed-bd6b-4ca5-853c-08d73d9128c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 06:09:56.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7i0/Fd8GU62Ut2gea0I2V0SHI3R8oiTJsUUIf8vG6pnp5Yqarp01+1CiE8jNhw+QZAFTgCBifL0z7VRfIKL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following series add initial support for the Slimport ANX7625 transmitt=
er, a
ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable dev=
ice.

This is the first version upload, any mistakes, please let me know, I will =
fix
it in the next series.

Thanks,
Xin


Xin Ji (2):
  dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter binding
  drm/bridge: anx7625: Add anx7625 MIPI to DP bridge driver

 .../bindings/display/bridge/anx7625.yaml           |   84 +
 drivers/gpu/drm/bridge/Makefile                    |    2 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
 drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 2085 ++++++++++++++++=
++++
 drivers/gpu/drm/bridge/analogix/anx7625.h          |  397 ++++
 6 files changed, 2574 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx762=
5.yaml
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h

--=20
2.7.4

