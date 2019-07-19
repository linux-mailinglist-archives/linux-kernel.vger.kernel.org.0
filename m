Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174CA6EBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 23:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfGSU7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 16:59:05 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:59469
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731911AbfGSU7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUNyRFIn32TIDjOkny8pVt19Vlz5SCLlzmtqDnp8fWuBX9S4DcaUhNkcYs3lXy+aaa/qA3b7beqJqtXL+Mr/rv9t2RF5QTRj2lwRfWVR2DmcYtweXiEPaQjDUbUyUg8N4KF1IulDVUFn8LcPuD+Y276F9uITFf0iK1ZwzFJ1OQX9jxT7nHsKLYX8kYC87VryErZmdZQUYn2IJ5UBF8JwzeyAiE0ywJE40Oh2DVU1HVzrC+vaouDiGsMIWyeQeUR+oAzwk46gyOWIKztEnyyomu2e9gyUNpgidB4Y0NLolYrzzjdpM5EULPHj4KKPqMN7YAoeVowN/UWFepm4/5Z4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhHQ4CTsTsRyy1oZ0PfL6Sp5PESwl/7Ga9fqMoM6Kjg=;
 b=A+sKLo08w3XTw60/YulFRqMjFFj2E/BQIHA0Jrxk/op5SF0+I1e2Q8Fa2v4Sb2BkN2AOU/cpyK3pMXq9CrgkQLKHyy3S0F30pXQUuf070uEZCDLY/yhoKrNhzFmHYR4/+ik1SdCzTy0wEckUKRSS7kH4c3Tz2baIpL6FFb7aqNKYGAKwpxd27+JCsS6i83wqeDUNGcYW05ugfJs7X3fnv3ytCmNF8ouTO1CWgLXnCWHnzY/JoQkc/Uo54cQ+3GMAd+f6Nsw/Vw1YdIecdXvN/w0QkGkll1BO466S/K1lskLt5s9qD7iiAhxNRq6Wk4sb1+RAl75oPdIFsr7srmM3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=daktronics.com;dmarc=pass action=none
 header.from=daktronics.com;dkim=pass header.d=daktronics.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhHQ4CTsTsRyy1oZ0PfL6Sp5PESwl/7Ga9fqMoM6Kjg=;
 b=m51AatnoonPAaqF1b16ZxnNnhPvydbrDCKP5xTLFSgKLJbLzU96S4ANJuStAlIL5S7iBMY6bXqQnj4S2rvv1cWqEKxIyv7wvteNRMugqinEkl1JzAiJQtDhTq+yfhAdFiqrVXxSGglx3caX+TJPleR7mLoI64CkQCTHa87uy9jM=
Received: from SN6PR02MB4016.namprd02.prod.outlook.com (52.135.69.145) by
 SN6PR02MB4191.namprd02.prod.outlook.com (52.135.70.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 20:59:02 +0000
Received: from SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::3dba:454:9025:c1d0]) by SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::3dba:454:9025:c1d0%7]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 20:59:02 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH v3] staging: kpc2000: Convert put_page to put_user_page*()
Thread-Topic: [PATCH v3] staging: kpc2000: Convert put_page to
 put_user_page*()
Thread-Index: AQHVPmzwE09u8sDYuEmu2VoulZlSaKbSax/w
Date:   Fri, 19 Jul 2019 20:59:02 +0000
Message-ID: <SN6PR02MB4016754FE1BB6200746281A2EECB0@SN6PR02MB4016.namprd02.prod.outlook.com>
References: <20190719200235.GA16122@bharath12345-Inspiron-5559>
In-Reply-To: <20190719200235.GA16122@bharath12345-Inspiron-5559>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [2620:9b:8000:6046:2d0d:49c4:33aa:6af4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b09fe611-239c-4c46-f80e-08d70c8bed98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR02MB4191;
x-ms-traffictypediagnostic: SN6PR02MB4191:
x-microsoft-antispam-prvs: <SN6PR02MB4191BFF69A81601D2A153FF9EECB0@SN6PR02MB4191.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(478600001)(110136005)(99286004)(54906003)(6506007)(2906002)(46003)(102836004)(476003)(11346002)(256004)(8676002)(446003)(7736002)(316002)(229853002)(74316002)(305945005)(76176011)(6116002)(7696005)(486006)(53936002)(14454004)(86362001)(6246003)(55016002)(8936002)(2201001)(68736007)(81156014)(81166006)(25786009)(33656002)(4326008)(2501003)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(76116006)(71190400001)(9686003)(6436002)(5660300002)(52536014)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4191;H:SN6PR02MB4016.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CEkRMd4RGN2q2Q9I2GACh75eW9sk/l7ej0w33Jq45Ld8A2OafT10oD4/QL93yZ+XLyyEQ/6/wCqsp+7KKgWR/OesWbI5ewItzLDdTTtGqJBCm6t1Fpm9zmjMh0Hc1VPDKl/YOQIQfBW96z2BAaxruhK4Tyu1TW/uJh92zE9dt2x69J67+GndbUj/BVfljXQ50e22TVUT06sZoAiP9Cjmdh8Zkd1VIUSBZF4ZrqSzME1ZS7JHvLqlVqmiiHxfRWC+5vkNPmmqri1UYj1+TOtvVCIJiTdcoM4Qzek9YsASbe2z00Xbud528lwj44aHMe82w+bYr7kz3wQojG4PsXNcpFldlG/BWPqv3eV03KxSeLai7ploZfMWuHxenCcMjReEhteWtOtxIuwonpL1qGAQ621EiMprHXzzydP/HKR2oH0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09fe611-239c-4c46-f80e-08d70c8bed98
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 20:59:02.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: matt.sickler@daktronics.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bharath Vedartham <linux.bhar@gmail.com>
>Changes since v2
>        - Added back PageResevered check as suggested by John Hubbard.
>
>The PageReserved check needs a closer look and is not worth messing
>around with for now.
>
>Matt, Could you give any suggestions for testing this patch?

Myself or someone else from Daktronics would have to do the testing since t=
he
hardware isn't really commercially available.  I've been toying with the id=
ea
of asking for a volunteer from the mailing list to help me out with this - =
I'd
send them some hardware and they'd do all the development and testing. :)
I still have to run that idea by Management though.

>If in-case, you are willing to pick this up to test. Could you
>apply this patch to this tree and test it with your devices?

I've been meaning to get to testing the changes to the drivers since upstre=
aming
them, but I've been swamped with other development.  I'm keeping an eye on =
the
mailing lists, so I'm at least aware of what is coming down the pipe.
I'm not too worried about this specific change, even though I don't really =
know
if the reserved check and the dirtying are even necessary.
It sounded like John's suggestion was to not do the PageReserved() check an=
d just
use put_user_pges_dirty() all the time.  John, is that incorrect?
