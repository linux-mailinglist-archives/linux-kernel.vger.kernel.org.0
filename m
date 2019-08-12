Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267E58A43E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfHLR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 13:27:25 -0400
Received: from mail-sy3aus01hn2080.outbound.protection.outlook.com ([52.103.199.80]:37243
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfHLR1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:27:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2fFcP9QX5nZXqg0tOVzTi9pLaLe4GsEwOO04MxJ1kSz3VJzhYm0wYNY1apRHfPcTl3KnenYo8Bq9dx98XEpQi1zRd+gHPExgGnHTioQwqB7InkUVQOys/b4flk213c85RW5drALe5s2puSiWzDfIMQNBQG3hNj9Gh5ePyI9HWmc2E7ZKNaaFvH2JyJysAZ6BeA0vD5EmItMwpWt42jsgOJVu+rBi4z0ME1WdAfINCj9fPI3fkLJAACtgme7ZdLYCPlfucwCECbuToJU00PlRLIGrp61kWBkvLz+77S9gXGNiaFvr60yoXXlsNnNSWT0FwzIPgFP8Is9830LLgZIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VFidb23qiM+TupwPfDpCFe6+g/KHhHfeSfUJDYG/Ls=;
 b=RzmFqbkN+ji96Q3J1Ky1kXK3doz4HK0ny3yB7g9sbJcShr+LnaVO1e9DTU726gxjkCwVi5O28pUietQp/OcLAA3l+oJVyyGotz1U/6Spa9EhJBiJCTX+c4ZyfslwIZeIKmPa+QitiU0fdy40bmYBUCUgM+EDUFObQw3vNj155e+WZ2l5WRBpAwrFdZZkFAAxkdOaq49sxyV5yvihWlm9qyoAIF3ogK8UWO6DSb8ZER0f2dRAfVivNU1Q+S5mN10bBv8EF3KO5FgFZoIgb4cw879g+H4esh4infljIUJUrZAQbNY1gIFc+COnhlxZa0Rx120qHun4g9AQnmGYdMJ7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alumni.uts.edu.au; dmarc=pass action=none
 header.from=student.uts.edu.au; dkim=pass header.d=student.uts.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentutsedu.onmicrosoft.com; s=selector2-studentutsedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VFidb23qiM+TupwPfDpCFe6+g/KHhHfeSfUJDYG/Ls=;
 b=U2kb/B4HuBrMF7EDIqeCDJpOqX5YvPYfWn+mRAHYYRaJiETNd/LlYyXcXfzfYxlQAzvEA2KvEXQXn1TS3BQ3hXajAb/XIDufyaXR7Ld9/ose1ySwqjwB0A7BhE1bnjbdjGEP5wDESB8LGIsXxuqFCKf0iOO6COJL5ENZ9s3xtDs=
Received: from SY2PR01MB2378.ausprd01.prod.outlook.com (52.134.168.148) by
 SY2PR01MB3033.ausprd01.prod.outlook.com (52.134.188.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 17:27:21 +0000
Received: from SY2PR01MB2378.ausprd01.prod.outlook.com
 ([fe80::2002:4868:8e88:9014]) by SY2PR01MB2378.ausprd01.prod.outlook.com
 ([fe80::2002:4868:8e88:9014%7]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 17:27:21 +0000
From:   Mrs Elizabeth <12414951@student.uts.edu.au>
To:     Jia Yi Lim <JiaYi.Lim@alumni.uts.edu.au>
Subject: Spende
Thread-Topic: Spende
Thread-Index: AQHVUTMybBIk6tPCaUOxl8EyDrd7yg==
Date:   Mon, 12 Aug 2019 17:27:21 +0000
Message-ID: <SY2PR01MB23781AB51C895F8D5CCF3A48A0D30@SY2PR01MB2378.ausprd01.prod.outlook.com>
Reply-To: "maunoveutileina@gmail.com" <maunoveutileina@gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0001.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::13)
 To SY2PR01MB2378.ausprd01.prod.outlook.com (2603:10c6:1:21::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JiaYi.Lim@alumni.uts.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-antivirus: Avast (VPS 190812-2, 08/12/2019), Outbound message
x-antivirus-status: Clean
x-originating-ip: [185.248.13.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a76cd214-a705-427c-5068-08d71f4a54db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SY2PR01MB3033;
x-ms-traffictypediagnostic: SY2PR01MB3033:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SY2PR01MB303311F5A3DC063FA65E47C6E0D30@SY2PR01MB3033.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(43066004)(102836004)(26005)(55016002)(8796002)(71200400001)(8936002)(2171002)(53936002)(71190400001)(6436002)(476003)(88552002)(7116003)(25786009)(186003)(2906002)(6862004)(7696005)(99286004)(52116002)(33656002)(6116002)(386003)(6506007)(3846002)(486006)(478600001)(561924002)(7366002)(7336002)(66806009)(5003540100004)(4744005)(5660300002)(305945005)(14444005)(7736002)(256004)(52536014)(7416002)(7406005)(7276002)(66574012)(2860700004)(3480700005)(786003)(8676002)(316002)(966005)(42882007)(81156014)(81166006)(221733001)(22416003)(9686003)(6306002)(66066001)(66476007)(66446008)(74316002)(64756008)(66556008)(66946007)(14454004)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:SY2PR01MB3033;H:SY2PR01MB2378.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:de;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: alumni.uts.edu.au does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nTl17ReFpEor2+fho7D0oSwGn3KkwNSkOHkPD9b0k6z9aC6q6mG8VMi21+SCYDspccT/VIPwpVvXZ8eayB7VDbZY6gYn/A0qaFppscWpSvJ97Sibh3oa6burRvpyiDD/DCzzadfm4sKA/TbYrV0+Xc6NFQRlyhNahV/MaPXthQb7i7Ry8fBsKpoysVEXSQtGeZhLHjVdh76913ebs4TqjSJfmXs4kOYYBqJoAtt9E+9HW1WG2fjr5apvUtdiwl/k0/UFWQwwqDESZbIxjLzIfvPLGomai1P5d0Q45mhYcKLvlh53UW0UOd3HX7oFClB9kPy3w/9/sMbj7gH87xOU722XUjhCLy2x3W9Hdt6opV2CXkJrAXurk5eV0ikouYyBJudynLTXMEi6OknOMRo7nAabNLwP70+ENq1M/yh424o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <398E89D1FAE5B1428391D33F24ED7D74@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uts.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: a76cd214-a705-427c-5068-08d71f4a54db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 17:27:21.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8911c26-cf9f-4a9c-878e-527807be8791
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AeouavKhm+wmN43DQduOde04OOZqmKDD2DPC9J2CH5chJcAe0QVa9CKIKtqQTWla8IfG3HpOuNqGCAhE8mFCNQr2Qjwnh0cvYQEF19UVrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PR01MB3033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mein lieber Freund

Ich bin Frau Elizabeth Kerli James aus Deutschland. Ich lebe mein ganzes Le=
ben in
Die Vereinigten Staaten.
Ungef=E4hr zwei Jahre lang wurde bei mir Krebs diagnostiziert und jetzt l=
=FCge ich die
krankes Bett, ich m=F6chte, dass du mir hilfst, meinen letzten Wunsch auf E=
rden zu erf=FCllen, der
wird f=FCr Sie sehr profitabel sein. Ich w=FCrde diese gerne spenden
6.470.000,00 EUR an Sie, ich m=F6chte, dass Sie teilen
es zu einer Wohlt=E4tigkeitsorganisation nach Hause.
F=FCr Ihre G=FCte in dieser Arbeit, die Sie durchf=FChren sollten, biete ic=
h Ihnen
40% wile der andere
60% des Fonds gehen an Wohlt=E4tigkeitsorganisationen Ihrer Wahl
Bitte kontaktieren Sie meinen Anwalt =FCber diese E-Mail f=FCr weitere Info=
rmationen.
maunoveutileina@gmail.com
respektvoll

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

