Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C6DA67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 04:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfD2COl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 22:14:41 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:41528
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfD2COl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQDiwrLbGIW8ItErakXpB7jtI5UpewNrvEOfcniSTQ4=;
 b=L6OdGuIp16uSa6V6e5dyAcZGF+TtzLp0w5EEg6afHVurKqigCU9sRZGL0cjdsBaXRIbUisGjMYbfscA60MqlzAhROiOvJ96dLWljUOQD9B2LOPGQ6CSKj5D87S7lGNJWXuG4pKGKnSSZoGHIkiEu0JM0AdAZDvbjVkfopITNmXA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6068.eurprd04.prod.outlook.com (20.179.34.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 02:14:37 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 02:14:37 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: imx6sx: add MQS register definition for iomuxc gpr
Thread-Topic: [PATCH] mfd: imx6sx: add MQS register definition for iomuxc gpr
Thread-Index: AQHU/agjfPz5ks/OzEakw7KYMflrHaZSZf3g
Date:   Mon, 29 Apr 2019 02:14:37 +0000
Message-ID: <AM0PR04MB42117B7880B6FB6A4E9B104080390@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556445161-29477-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1556445161-29477-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 562033d2-8a84-42c3-f8b6-08d6cc486dfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6068;
x-ms-traffictypediagnostic: AM0PR04MB6068:
x-microsoft-antispam-prvs: <AM0PR04MB6068173BE195225896C87E5B80390@AM0PR04MB6068.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(25786009)(478600001)(3846002)(33656002)(558084003)(71200400001)(71190400001)(8936002)(81156014)(81166006)(8676002)(5660300002)(26005)(186003)(7736002)(4326008)(76176011)(6506007)(7696005)(102836004)(11346002)(446003)(14454004)(6246003)(44832011)(476003)(486006)(74316002)(52536014)(66066001)(305945005)(99286004)(97736004)(53936002)(2201001)(86362001)(55016002)(2906002)(6436002)(9686003)(229853002)(66446008)(2501003)(76116006)(66476007)(256004)(6116002)(64756008)(66556008)(73956011)(316002)(66946007)(110136005)(68736007)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6068;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 14Sg77AxQntUk0DZnyjKN+UgmwIRxrjZv3l0f8dDWg5kYJzDs67ICY+z+OuM4f64Lfs2hSwfNMZ4ay9ZsA3ezX6mU0UDKiEIhNqjAXdPXNLo2hbUCxYg9xVRejc3waidyVXAkdAOOoaFF6Jjv6T8WWWDX2PAYxX9SzAnaktNQ/5Htxcm2UjemgQ1dP0gVuzZASQnQBZjYhqr6KM2sI+oakGwmyHsvGLCJsM5vKOKVWpBVvaVV0NNbncU3kyXMq+9Ed9krtZxeEsHVopal5VQsSP1eTvFWHsBPlWCL8JzV6+TFrTq/jPvSkyN7jP3Dp+A93FoH6rl3zKgN/ifs4hRweXbxaqsHjCg1N3MCHO/H4p0W6SQGBi8E57QYgcTXcmqpselciKTI3bpXT4zONd9rxLVNXT2fl4zX2AcBUs5Qe4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562033d2-8a84-42c3-f8b6-08d6cc486dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 02:14:37.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTLmouIFdhbmcNCj4gU2VudDogU3VuZGF5LCBBcHJpbCAyOCwgMjAxOSA1OjUzIFBN
DQo+IA0KPiBBZGQgbWFjcm9zIHRvIGRlZmluZSBtYXNrcyBhbmQgYml0cyBmb3IgaW14NnN4IE1R
UyByZWdpc3RlcnMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1
LndhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25n
QG54cC5jbT4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQo=
