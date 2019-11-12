Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA9F8F18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 07:00:46 -0500
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:41347
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfKLMAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:00:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldW5sKamKKQRFNl1w4Qz7FHuHCWhmR9OBLvh3DzpUlascgS3UBUbw4o6cc7FJx/WV2aCzf6qCPvt5zE1g/mtLTVLyUiLsUCISnhcRk0zh5uT/zVuIH9/FB38YaU1rRUG2dF0Lmp3FnSOoIOPYTZ7BbnXKKzlHiXE+ZTFxjLr51xDzvKPR8fV+3tMM+rBHYjcGeWXstD/c6+N9MWW4Q9+4ctYCbX4jW89l1M+WdqzrAORE3TYkFdq80oQzPyMHyPTW1k36yGnlhtDoQkliA5/fX3p1cxnYh9ldpu7OnPETjF7tmnrT1XfsxaeUNyvv8RRYgYB5mVzix7JoL5SNS1bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1+7gyRxhEnE4qxsHprLpzlPlByhhAXEDCN0jjjjZNU=;
 b=YurbK4LZbo1vsKlSnp2c6t7xHyd086RByPGFhkJwKzOe4jvZPXiJZkGSGLldDoT5y0TUP161zFSLIQ7Hv8UJKXE5RKGnzj8rBF9nucw819NUNThFjDw0HGO5wQB8Fc/Ha59yKAotXQ5Eo29+0p94KipDaxk4r775Tpbt8a1v7ZM3m/zTzABmS2QupxJUXjAPs73KubOGwNaMfWdoPXt613v4oM8YjGib8qMgKSLITFQk9Xxzsm35zvSGClSVnJHn/o0JlMXcgTlJoTbWZvw46TVV0XhFHAvK9yXqR56jH8TfNH6jUA6qFcNhXcuBv51klKrCez56oXvNAhMsSfoIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1+7gyRxhEnE4qxsHprLpzlPlByhhAXEDCN0jjjjZNU=;
 b=KDSXGZKG9tMOT15G4LdUxsjRetI6ZuZQwBO/u++BBGTzpL3Vi7nKFnJuO9Cqf0qh2Q3v9JPtEcaO0LtZOgsuMg2pP+d3x2pHvvrJFY93KXUTmndrh7FwZvObIgTv0WfQYcRPcM3hL0sjv3CKCF82vLtMutZSHRpyiiot8WLarCU=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4144.namprd11.prod.outlook.com (20.179.150.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Tue, 12 Nov 2019 12:00:41 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::90bc:abcd:689a:944]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::90bc:abcd:689a:944%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 12:00:41 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Jules Irenge <jbi.octave@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Boqun.Feng@microsoft.com" <Boqun.Feng@microsoft.com>
Subject: Re: [PATCH] staging: wfx: add gcc extension __force cast
Thread-Topic: [PATCH] staging: wfx: add gcc extension __force cast
Thread-Index: AQHVlo2vxeA9owBuRU69L3+4vyY0cqeCkGWAgANwwICAAG8CAIAALvmAgADVXwA=
Date:   Tue, 12 Nov 2019 12:00:41 +0000
Message-ID: <1714567.V28SpQSAGH@pc-42>
References: <20191108233837.33378-1-jbi.octave@gmail.com>
 <20191111202852.GX26530@ZenIV.linux.org.uk>
 <20191111231659.GA22837@ZenIV.linux.org.uk>
In-Reply-To: <20191111231659.GA22837@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed489764-9f02-4e90-362a-08d76767f0a6
x-ms-traffictypediagnostic: MN2PR11MB4144:
x-microsoft-antispam-prvs: <MN2PR11MB41442313873E27D0D5DFEA9693770@MN2PR11MB4144.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39850400004)(366004)(346002)(376002)(396003)(189003)(199004)(14444005)(71190400001)(5660300002)(6246003)(71200400001)(478600001)(9686003)(486006)(446003)(91956017)(11346002)(6512007)(76176011)(476003)(81156014)(81166006)(4326008)(256004)(8936002)(305945005)(7736002)(229853002)(14454004)(6486002)(8676002)(6916009)(66556008)(66574012)(6436002)(316002)(6116002)(66446008)(3846002)(64756008)(5024004)(33716001)(76116006)(66476007)(2906002)(86362001)(54906003)(99286004)(66066001)(6506007)(66946007)(102836004)(26005)(186003)(25786009)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4144;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YP3Dwj8jzPUmmg34ys7f5wIxL5oAoSHDDIzW7ZAGfEZ1+NRtDC48R5n5VNTBf1GRJr5VXPpc/08WkdbE+a4sTgtuqoLM/gJoni68u4uop6bZocJLwo5svh9ti6PgLYjPGbEqRpG62WDx5SpFJktQJb7m0aLhmM+zOwWtph4HwT7SIvGDMAZVdHq2Mrhrq2BdcgpVcDXvDbYYbvuVnjeMykz0eVm41eoRR5E1350qXD9DIMFTX/qQag1aGVc6EzsKZM8JqY6DsrSCJoKYlHOXBYIojSmSwDxq24Qr780OG2rcnwVBbjApWIv5fWeYvxZBD1j51wd8Y1CKV6hWwkmoWf1a+vgjUglwHuue/wfb8ZX7r+eId8v1aNeTRouDhN8YkyX9Ilu0jcjcFjeQoVQ36bpOgejM7oNsORPllBUuqGZilH4096bnvCTzAAQBSZuR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CE57DFF83C429145BD4595E5B90CA18B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed489764-9f02-4e90-362a-08d76767f0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 12:00:41.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68ruFczmvw7MYr46eyIkCYLPdEqJSb6rcwwRjKYkpkfrMW1DL1UtuldTteSDTHP2TqyALFu+BnTAJsK3jzutMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 November 2019 00:16:59 CET Al Viro wrote:
[...]
> More fun:
> int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val,=
 size_t val_len)
> {
>         int ret;
>         struct hif_msg *hif;
>         int buf_len =3D sizeof(struct hif_cnf_read_mib) + val_len;
>         struct hif_req_read_mib *body =3D wfx_alloc_hif(sizeof(*body), &h=
if);
>         struct hif_cnf_read_mib *reply =3D kmalloc(buf_len, GFP_KERNEL);
>=20
> OK, allocated request and reply buffers, by the look of it; request one
> being struct hif_msg with struct hif_req_read_mib for payload
> and reply - struct hif_cnf_read_mib {
>         uint32_t   status;
>         uint16_t   mib_id;
>         uint16_t   length;
>         uint8_t    mib_data[];
> } with val_len bytes in mib_data.
>=20
>         body->mib_id =3D cpu_to_le16(mib_id);
>         wfx_fill_header(hif, vif_id, HIF_REQ_ID_READ_MIB, sizeof(*body));
>=20
> Filled request, {.len =3D cpu_to_le16(4 + 4),
>                  .id =3D HIF_REQ_ID_READ_MIB,
>                  .interface =3D vif_id,
>                  .body =3D {
>                         .mib_id =3D cpu_to_le16(mib_id)
>                 }
>         }
> Note that mib_id is host-endian here; what we send is little-endian.
>=20
>         ret =3D wfx_cmd_send(wdev, hif, reply, buf_len, false);
> send it, get reply
>=20
>         if (!ret && mib_id !=3D reply->mib_id) {
> Wha...?  Now we are comparing two bytes at offset 4 into reply with a hos=
t-endian
> value?  Oh, well...

Agree.

>=20
>                 dev_warn(wdev->dev, "%s: confirmation mismatch request\n"=
, __func__);
>                 ret =3D -EIO;
>         }
>         if (ret =3D=3D -ENOMEM)
>                 dev_err(wdev->dev, "buffer is too small to receive %s (%z=
u < %d)\n",
>                         get_mib_name(mib_id), val_len, reply->length);
>         if (!ret)
>                 memcpy(val, &reply->mib_data, reply->length);
> What.  The.  Hell?
>=20
> We are copying data from the reply.  Into caller-supplied object.
> With length taken from the same reply and no validation even
> attempted?  Not even "um, maybe we shouldn't copy more than the caller
> told us to copy, especially since that's as much as there is in the
> source of that memcpy"?

In fact, hif_generic_confirm() check that data from hardware is smaller
than "buf_len". If it is not the case, ret will contains -ENOMEM. But
indeed, if size of data is correct but reply->length is corrupted, we
will have big trouble.

(In add, I am not sure that -ENOMEM is well chosen for this case)

> And that's besides the endianness questions.  Note that getting the
> endianness wrong here is just about certain to blow up - small value
> will be misinterpreted by factor of 256.
>=20
> In any case, even if this is talking to firmware on a card, that's
> an unhealthy degree of trust, especially since the same function
> does consider the possibility of bogus replies.

It is obvious that the errors paths have not been sufficiently checked.
If you continue to search, I think you will find many similar problems.

I will update the TODO list attached to the driver.

--=20
J=E9r=F4me Pouiller

