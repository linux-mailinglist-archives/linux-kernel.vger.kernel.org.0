Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5030F158C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 11:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgBKKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 05:08:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:8829 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgBKKIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:08:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 02:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347251201"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 02:08:17 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 02:08:17 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX156.amr.corp.intel.com (10.22.240.22) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 02:08:17 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Feb 2020 02:08:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1PuXVbi1teswE6xgS6xnwm458F4cxRaHhcDDF6W7E0MbZF5gD8Rm5oQkNFPc3/rNkdgWDcj5Cly8P1E0vd+3HMCrTYyMIPGqwysZTeOpvBBE6nTJcF/HIW5QeGwCsAtA0pOrsLdolx/OfgRmRsUDCr6E4E0V9jeOWJkbzKWVuhYSiQGcUbhc0E5E3Gw+YD96hLf/kTHy57EpYnXl/x0AR9F/IYVbTV/wcRToPfSrr6J4XeGjknqHL0txNbxiTKLe7jYfKj14yDx8pVFsWGgJAU4aJ/TRVudCMGjKJDL1Sz87AzNts/St3HmO6zDaCQVyNF8+QCW4Uyp09sQRH3YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpcmSIVywS6TGD3yd0QknKobI3PH6rA5TxvAwleHvWU=;
 b=H+m+OcfLW/yi4tuUPJsC4PkXXBTbja5mDrb0hBVEvO6ND8lP2t5w1AKRl2kgvwU1Le9RGMu3QfI8UqdpAXO7BFiBLEZipeY0kf1wjbLk0Ko8oLpY3W2WQKJOver8CRvA7HHRCThoxrTPGV7yP67HBTPOQUfOwodtHBkliL6wpSbpv9Y1ObJ10Yr9PyZN7wZJJT7LwQm6dJthKHAs2yfd+xBYSvp2DzBFhilbN66hY4gCZYY8aY0uf0VXLSmpr9UD/qhvGpHV8CyXevOOavZ+pXgtG5fwZ11cjzWPlazbC1XIegOGKHYOyczpeNDKbyKUbeAksqxP3BMmUet5w8yXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpcmSIVywS6TGD3yd0QknKobI3PH6rA5TxvAwleHvWU=;
 b=DdKvXIXL0VM+wbC045vdU/zs/Jna01VOvei3gnJYz/N3OloYKgA6UT0U61C0xUo0vyX9NLNIHW6Dv6jBjqKNj70nMdEXzf9vgrbU7ARHQ+kKdZjTuLphmhME1ET7StxENc8o3EQfL6DZVPZUjQJVAGxyYdyU/3V0PdQclVCeIqA=
Received: from SN6PR11MB2670.namprd11.prod.outlook.com (52.135.96.25) by
 SN6PR11MB2573.namprd11.prod.outlook.com (52.135.89.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 10:08:15 +0000
Received: from SN6PR11MB2670.namprd11.prod.outlook.com
 ([fe80::d9a3:52a2:97d7:89ec]) by SN6PR11MB2670.namprd11.prod.outlook.com
 ([fe80::d9a3:52a2:97d7:89ec%4]) with mapi id 15.20.2707.028; Tue, 11 Feb 2020
 10:08:15 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cychiang@google.com" <cychiang@google.com>,
        "Chiang, Mac" <mac.chiang@intel.com>
Subject: RE: [PATCH] ASoC: da7219: check SRM lock in trigger callback
Thread-Topic: [PATCH] ASoC: da7219: check SRM lock in trigger callback
Thread-Index: AQHV3+tuqX6FpQoz5UK6Rt5tUMk2f6gUfeSAgAE8rrA=
Date:   Tue, 11 Feb 2020 10:08:15 +0000
Message-ID: <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brent.lu@intel.com; 
x-originating-ip: [192.55.52.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f04bdcf-fc5d-4839-a702-08d7aeda4f57
x-ms-traffictypediagnostic: SN6PR11MB2573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB25731C3AED984BA1ECA3B08197180@SN6PR11MB2573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(66476007)(66556008)(64756008)(66446008)(66946007)(55016002)(76116006)(478600001)(2906002)(6506007)(107886003)(71200400001)(4326008)(9686003)(33656002)(8936002)(5660300002)(81156014)(81166006)(8676002)(52536014)(186003)(86362001)(54906003)(110136005)(316002)(7696005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2573;H:SN6PR11MB2670.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsmTVP1RayZekXXCsezHTX7nKqn61HiA1rCLLTYShN0lD9puCNOLbrXSnNqhACL5GXoFAcNyh4kOFIjL9DTg6aBlFCki6E9++8GeexryU29Uf9lBxcrxglRqfNyyEFrM+ZvnDib4h+BkSufQFOreLE5bnNlcOUH7V/FH8fZViFCVJGuVuSqvqGYSuCqXJilKmGISYxAozAQoZTnLHn3Fe2VDA/BJOOyFhtW08mU2x93FZfsbUj8H1HMpBF0urbmEbRDG6U6tj4RGcatQHRdTB6iTeJjediZS6/q2f+oMYLK6mUCd+7ipvvhfKTdobowbKQOniYmopkWNtE1HoCY3JfWu/CcPfamXIpPL0NGc4iqDMnDEu2N3fj6TQ9eO1Vo/rvWPkyCrlgPts6ngqGr9fR1sLi6zQZw/NfRyYmVi8wlj305mpS1KBr/W2DAO3ctD
x-ms-exchange-antispam-messagedata: znHEXOJwdhOt30dnMFDyKLr+tbVLj5F38Ciz8XFIa+YUNX502uRGQ5WkzSQW26U2VtrR0fcAH6xjc7YODDFHHQiU3yJdxratDr4Izy41RX45ltpo4cfR/wMaIF/e1V/XKUHKpB7qk+SsX2FT6vgmEA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f04bdcf-fc5d-4839-a702-08d7aeda4f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 10:08:15.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLkUdEdmfJUolACqmCVB1uhWBQUMHZsOSNw3RRXQYQFhDoYtzFmo2nDvKRBwzVg9+0rTJh445tlFTXRXi8zhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2573
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Could ensure? This change seems specific to Intel DSP based systems, at
> least from the description. Having looked through the core, the trigger c=
ode
> for a codec is seemingly always called before the trigger for the CPU. Ho=
w will
> this work for other platforms, assuming their clocks are enabled in the C=
PU
> DAI trigger function by default?
>=20
> Can we always guarantee the CPU side isn't going to send anything other
> than 0s until after SRM has locked?
>=20

I think the patch is for those systems which enable I2S clocks in pcm_start=
 instead
of pcm_prepare. It has no effect on systems already be able to turn on cloc=
ks in
supply widgets or set_bias_level() function.

If the trigger type in the DAI link is TRIGGER_PRE, then the trigger functi=
on of FE port
(component or CPU DAI) will be called before codec driver's trigger functio=
n. In this
case we will be able to turn on the clock in time. However, if the trigger =
type is
TRIGGER_POST, then the patch does not help because just like what you said,=
 codec
driver's trigger function is called first.

In my experiment with the patch, the SRM is locked in the second read and c=
ost
50ms to wait.

>=20
> I was under the impression that 'trigger()' was atomic? We'd have to have
> some kind of workqueue to do all of this, which means we'd almost certain=
ly
> lose some PCM data at the start of a stream.
>=20


