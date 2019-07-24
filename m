Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCA7272B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGXFIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 01:08:53 -0400
Received: from mail-eopbgr1320072.outbound.protection.outlook.com ([40.107.132.72]:37221
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfGXFIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhjxk1F8z/cB7Nf0vWqmMW98uRYsTdwryPLfkd/L6lO3P1hw3/t8Dt/uMAxFukpVpFiq19K94GqZazxK+eRgQYuLAOIstIxoVDxMDqECYHdHd3nLt3dWXa68mXMFacM5oI92c7MXW/iDVXj/20Xh3rDsMeUmZQaizH7gtM3SCS3XGLyctSjtnChBqThNDj9cV1jyoebNYDmlBACKCnyICi2SlZqW/zjN1ITrDUs0m5ckzDtd3YMevWI4B5YxCYfx2PvNzIAho9qIQsLtAIJouzYdvSgybdFOWiKJU7EUR8JzIr7yGEOgmfhk7C9g83PDYbhNtHyJTm2/lY7PrKhsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5bjQoY2dZ0i8iQmOexOhz23kTM0xz7SkYWZK5oHnVA=;
 b=EF0v/seYRIw+IGMQHzG1FkUqIx4zqw9AT2n3oZQjSxJs92GMgEztzUtnlSnqFVEWPfuKR7xRFSivP79TuKF3PierlmMs80SWq+VO22zdLENzD9OtT2UZJp+ltdJXNn2Kqv5OVhCTHHOBcv/jXeUrsxyShOjhBtziyrUO5MEOMlrqwlPeCAe4p7hJc9V1JFdHdMXpBxe9SKyfcKRUzaZxQbwlZ3DYigAqtUibZk+vFNtIfvkcC7l9FQ/Ani5LB3nTK9Bj8HTsyFCExybB9IO5S+rhnIxCMk/Wy7k6NT25HesO+3PCMQhJRARh+B4T20kf+jM/fW9s6wZbnyCvNTJMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=teo-en-ming-corp.com;dmarc=pass action=none
 header.from=teo-en-ming-corp.com;dkim=pass
 header.d=teo-en-ming-corp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5bjQoY2dZ0i8iQmOexOhz23kTM0xz7SkYWZK5oHnVA=;
 b=eP9Ejo3xdjzeMXTj9nJll04X3U/6xolL2HLZuNtQUZqTfa+7TkuX1+0IgJH+tqNeNnv36AiZi1CF+9RMNQXz2GJgCn3FJ8loz7lGyQRTvhvM+tKxssJ4G6YYM1Bu4z+5Togfv0jFWleRLawI8M4phI+tHtyHpHG5wIXKIvhklVE=
Received: from KU1PR01MB2134.apcprd01.prod.exchangelabs.com (10.170.174.138)
 by KU1PR01MB1957.apcprd01.prod.exchangelabs.com (52.133.201.12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Wed, 24 Jul
 2019 05:08:46 +0000
Received: from KU1PR01MB2134.apcprd01.prod.exchangelabs.com
 ([fe80::7d19:b2d7:95fd:1820]) by KU1PR01MB2134.apcprd01.prod.exchangelabs.com
 ([fe80::7d19:b2d7:95fd:1820%3]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 05:08:46 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Great News: National Heart Center Singapore CT Coronary Calcium Score
 18 July 2019
Thread-Topic: Great News: National Heart Center Singapore CT Coronary Calcium
 Score 18 July 2019
Thread-Index: AdVB3cuGkyzgg5EkQJ6eG6g3C8HWMA==
Date:   Wed, 24 Jul 2019 05:08:46 +0000
Message-ID: <KU1PR01MB21340221F97AF6F854DE6E4E87C60@KU1PR01MB2134.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76943012-dde0-4871-3fb3-08d70ff501a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:KU1PR01MB1957;
x-ms-traffictypediagnostic: KU1PR01MB1957:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <KU1PR01MB1957F8EA7AEDA88E763A070987C60@KU1PR01MB1957.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39830400003)(366004)(346002)(136003)(189003)(199004)(14454004)(8676002)(7736002)(81166006)(2351001)(9686003)(53936002)(71190400001)(8936002)(14444005)(107886003)(256004)(71200400001)(99286004)(33656002)(74316002)(4326008)(2501003)(486006)(305945005)(68736007)(6506007)(102836004)(5660300002)(66556008)(64756008)(6916009)(66946007)(6436002)(7696005)(476003)(966005)(66066001)(508600001)(2906002)(26005)(3846002)(25786009)(186003)(5640700003)(6306002)(6116002)(66446008)(86362001)(81156014)(55016002)(66476007)(52536014)(316002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:KU1PR01MB1957;H:KU1PR01MB2134.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3MI6WDlXwCv9NwCieAyMJc/iF5qaqTrPdnf2Mmad/HiOIj2vIFYiSduq2G8NXiAiKOVFKNs+/BnWAcSNGo8RWC0TzXOtqGLkHg/a45ObcWG2/bMcIkPA4K9D9Nojy4A3nBzyCXhzandGFAigaUhQMRUHfbJumEtZQMSYlQA1cedGL8hMsJ+8BqYspbg02mh1HUcFsrKU+v/V7uKiYciyqM26BAKimMHXt30OZRoqufxVlWet05846s6auZAXjr8RC3kLvKhKp6CxdzcM9SsAPvPKo6FaDYHu5xHfSpnCjhvaY74kMgkJq/gAA4hSsOF3kHdTI5J1Ipzm/0mOBqZ0vlzlDPx46QvCB+5epjhsTl6rA1WibjWRCkzVu0dH0Ui2CEIA2BTNajtKyqnH3SINFpj660v+lS0Q6E6nzSyXjMA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76943012-dde0-4871-3fb3-08d70ff501a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 05:08:46.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR01MB1957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Great News: National Heart Center Singapore CT Coronary Calcium Sc=
ore 18 July 2019

Good day from Singapore,

This is good news for trillions and trillions of years to come!

1. My weight/mass is 123.5 kg (taken on 23 July 2019).

2. My height is 1.79 meters (taken on 23 July 2019).

3. My Body Mass Index (BMI) is 38.56 kg/m2 (as at 23 July 2019)

4. I have been living with random, intermittent, and chronic mild chest pai=
n for the past 10 years since the year 2009.

5. I have seen countless (lost count) doctors in Singapore over the past 10=
 years. The diagnoses were always atypical chest pain (ie. nothing to do wi=
th the heart). All the doctors I have seen did not think it is angina pecto=
ris.

6. I have done countless (lost count) cardiac tests in Singapore over the p=
ast 10 years, including electrocardiogram (ECG), treadmill stress test, MIB=
I heart perfusion test, and CT coronary angiogram. All the test results wer=
e either normal or perfect.

7. I have high cholesterol (hypercholesterolemia) for many years, according=
 to doctors.

8. My pulse rate is consistently around 100 beats per minute for many years=
.

9. Recently, I went for CT coronary calcium scoring at National Heart Cente=
r Singapore (NHCS) on 18 July 2019. The following is a transcript of the CT=
 coronary calcium scoring report obtained on 23 July 2019.

-----BEGIN NHCS CT Coronary Calcium Scoring Report 18 July 2019-----

National Heart Centre Singapore

Patient Results

Requested By: Chan Lihua Laura (Doctor)                          23-Jul-201=
9 05:54 PM

TURRITOPSIS DOHRNII TEO EN MING (ZHANG ENMING)                Sex: M      A=
ge: 41y    DOB: *****

MRN / Visit No.: ***** / H119042968E0003                        Locn: NHC-C=
ardiac Clinic B

18-Jul-2019 11:07              CT Coronary Calcium Scoring                 =
HCCT195011991718            Final

Additional Info	              Verified Date/Time: 18/07/2019 12:02         =
                            Final
                              Verified Person: Dr. Narayan Lath
                              Verified Section: NHC CT
                              Performed at : National Heart Centre Singapor=
e
                              Level 5, 5D, 5 Hospital Drive Singapore 16960=
9

CT Coronary Calcium                                                        =
                            Final
Scoring
   HISTORY
   to reassess risk profile
   TECHNIQUE
   Calcium Scan was prospectively gated. Images were reconstructed at 3.0 m=
m slice thickness.
   Assessment was done using Vitrea Calcium software and Agatston scoring s=
chema.
   REPORT
   Calcium Score: Agatston 0 , Volume score 0 mm3, LM 0 , RCA 0 , LAD 0 , L=
CX 0.
   The calcium score is between 0 th and 25 th percentile for [men between =
the ages=20
   of 40 and 44.
   Normal coronary origins.
   EXTRACARDIAC FINDINGS
   No incidental significant abnormalities in the included lungs or mediast=
inum.
   Report Indicator:   Normal
   Finalised by:        Narayan Lath, Senior Consultant, 12598I
   Finalised Date/Time: 18/07/2019 12:02
Report Link                                                                =
                            Final






Printed from: National Heart Centre Singapore                    End of Rep=
ort                         Page: 1 of 1

-----END NHCS CT Coronary Calcium Scoring Report 18 July 2019-----

For scanned image of the original CT coronary calcium scoring report from N=
ational Heart Center Singapore, please visit my RAID 1 mirroring redundant =
Blogger and Wordpress blogs at

https://tdtemcerts.blogspot.sg

https://tdtemcerts.wordpress.com

On how to interpret CT Coronary Calcium Score, please visit the website of =
the Radiological Society of North America, Inc. (RSNA) at

https://www.radiologyinfo.org/en/info.cfm?pg=3Dct_calscoring




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

