Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA618FC28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 18:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCWR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 13:57:24 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:21003 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCWR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:57:24 -0400
IronPort-SDR: XSmrdQYMRxakr+UvHi122eqauWoMR4pXbbndVHt6vB3kYU/9UItnUUmUCipqFTeQDZJX+gkbpl
 Cm8J7EZk28qxIPjf1L9q7fbbOAppZUduCBl+kSZ6iJ3TWHokn/iQYLHx5Wr8KZI03HcMhxINpM
 23gCZdb5jfZKrB+TdcdIUGBTfqP0GnLeNPYvDYHlsI32cKRiHUeAPvOm+MiSSXC5hMz6y46git
 wK6OnCPwSayBsjUliSP8mbPlvX/aSwXCFfyAViNLVfIykCEvinruwrpPKFEUIgzISdoVMtGGBA
 rt4=
X-IronPort-AV: E=Sophos;i="5.72,297,1580799600"; 
   d="scan'208";a="70964770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2020 10:57:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Mar 2020 10:57:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Mar 2020 10:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzQskDdqYA5sr7bZEOSVlrMOcPEZa8d1g/yHgUxVOoFz/5d8DbhwHzPDU6TC+Epvj8lIrYDiXUaYEAo3mwo01Atb0XbtsOXlhx+3VBS3ZYS8yATawpDYnwTiTPxSU0RYuVSUA7Mio1jAHUT58flF+bVbmSLn7q4nRi+j7AFdK5EsTZiVgEydejczoJeSMkuCw8yX+GSaIkgwuV7XO4S2YXIVkU8dhIaj/FWzmZAqtxXPGynlXgS4v9hW7q4hSnrVFi2x2bRwa43LWVpxP4E6pv+RZy75HRh6/cJGrkqNnRrJIPsqalgutrpJhFYHKljArxbrKdeHC/3MsCjdk3jGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLknpR8qIUH/NTM48rvSJn8ntHIYvx69fE0ZrHkOEiA=;
 b=RunMgiJik9Oy3LMYiLiYEjiIz1anBe9ace2dHcIPdQdSHdEbciuvII1/gxncAskAcxkH09FB+4Lnt9iO8TK0wjsYaSXza9rdJrWzYiUvfhtrm8svBGrhXIDfVcll3s/QzfLwzf6RnbsqlUk0d2f8NG5N3Vhe2bwSC6siVZY2Yuk5f8i++yxY3idGfVON/sdtuKXWCGyQi66K3T36LpamVuStbEGUgeNHwfA4CQC39OfHrXefLRUzkUe/ByMR/EdmosgXbdgFjXazVhZjT43zRDgnIOs7jFhqpxbUm5yR6p0OK+slF59+DrjQC+ZUTqueVlaV+ghBZMSXBNua6RPu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLknpR8qIUH/NTM48rvSJn8ntHIYvx69fE0ZrHkOEiA=;
 b=kGEr2PRuVPcMSIIiyG3vVn3rlL2QObipJynvmsc0FNFdeVuO/ZHDXYCraDi/vlAZisCLKYotkXFvzuSr3Tha5qqwh0ewDA4ZTAh71GFtks5dVQT0EQQ2K4sFdtiJCg+ARu7wUJq9Fs74bTCL8Xas6nkcat6cH2G6CnmYKw7JkJk=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB3925.namprd11.prod.outlook.com (2603:10b6:a03:182::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 17:57:00 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::e918:9196:b47e:9692]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::e918:9196:b47e:9692%3]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 17:57:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <lukas.bulwahn@gmail.com>
CC:     <bbrezillon@kernel.org>, <vigneshr@ti.com>, <vz@mleia.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <joe@perches.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update entry after SPI NOR controller move
Thread-Topic: [PATCH] MAINTAINERS: update entry after SPI NOR controller move
Thread-Index: AQHWATxzB3pzaldLS0q/vR8lNGgubg==
Date:   Mon, 23 Mar 2020 17:57:00 +0000
Message-ID: <22897927.UjJTgWM9OM@192.168.0.120>
References: <20200321064217.6179-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200321064217.6179-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b028224b-4a9d-4421-0995-08d7cf53966a
x-ms-traffictypediagnostic: BY5PR11MB3925:
x-microsoft-antispam-prvs: <BY5PR11MB3925F42478085D27C38119BFF0F00@BY5PR11MB3925.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(6512007)(53546011)(9686003)(81166006)(8936002)(86362001)(316002)(478600001)(2906002)(54906003)(186003)(26005)(66946007)(66476007)(66556008)(66446008)(76116006)(64756008)(91956017)(6916009)(6506007)(71200400001)(14286002)(6486002)(8676002)(81156014)(15650500001)(4326008)(5660300002)(4744005)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB3925;H:BY5PR11MB4419.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xg08fyhdEMqHemeyiNoWogOeosi6S1sxlipGFR/XemRX2asRWB1OlvTiM440G+wrCideQnUE00k2Vj4MobwQLHFfpMHT79A8lmzg4j2B3IxpR0F2f5JuDCvNsLMSPvZo8laZVguNFk3pst701V47YvJL+jKlr+lcl/ey+lNlwyE+FGGCxOuFqKbFaCWobJBTpdYSQXj1xLe5jyd8GI/xqQDQid1R3SyTxp8vJF7GODkW63jga7aaG/JRRH9vG73KBa008CIzehecqNc9FCn4NVv8uehv7487yGREgeMPINdsKMyT/wqM0jCwXmP0MgmrUrRZj12SJDojfb9hAHkYf5azF0iF1mu+mECsLij3ucPV0la+hFuMlu2ARg3fGEzCTgqU7T4/rrtzJX+CdFVRDrHySGelm7MqlFtzAsM1Ww1tFosVmBJiS6ibXRdSqr31nL+1lNEI+LY3VC6GQIouJaSb3L/j/AtpQoOAbvg0pV9HlFpSwFBPL2sSMBSGMEFN
x-ms-exchange-antispam-messagedata: qywx5mUZD0KrZXMejv1SPDaQS/mFltBrWgbbT8O9zDin/DyCPl17PBLUjW81De60sA/tmVP4C2zZ9k7LG6BpvLXJ+zc6o4+6mvIlGi2R5HqTT9LwndqbhZWQsdC+M/Q1RKw7Fc5lIfNpCfNmSj46JQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <253F337988CC1D479FB10CD757D5D7BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b028224b-4a9d-4421-0995-08d7cf53966a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 17:57:00.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6a2Yi0lm1uUc/GOoEe0dxatx2ZXFuCXcrLoEDOcAl+I/rBVnghnxrkfWE+Q+upiNSFq0iVYt+YAlBsUfUma1G5wcUgFepXfftsKqLXutcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 21, 2020 8:42:17 AM EET Lukas Bulwahn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Commit a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code
> split") moved all SPI NOR controller drivers to a controllers/
> sub-directory. However, the moved nxp-spifi.c file was referenced in the
> ARM/LPC18XX ARCHITECTURE entry in MAINTAINERS.
>=20
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
>=20
>   warning: no file matches F: drivers/mtd/spi-nor/nxp-spifi.c
>=20
> Update the file entry in MAINTAINERS to its new location.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20200320
> Boris, Tudor, please pick this trivial patch. Not urgent.
>=20
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to spi-nor/next, thanks.
ta

