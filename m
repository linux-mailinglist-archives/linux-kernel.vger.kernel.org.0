Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8D2E244
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfE2Q2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 12:28:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58236 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfE2Q2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:28:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TGIlwS004991;
        Wed, 29 May 2019 09:26:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=X4eoqNRmc3LMmVaz3RomiWqkEf9IsoofKVkNtQpF48A=;
 b=ekW1+hYrEPN/8s5feZ6V82PdbWryQuWR6mL0syPRfnelA/rxBaaUty24NM69xkutC59x
 jpN1PIlWi6aJuKmjtkPKHg8fnNBqDLuI+0l3QV+otXQH/dOxxr5M6ZbJZla1kqSebiPS
 /kLWExZ75CtJG6lQkxUqocSoqVwtrbUFdKM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssvdura4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 09:26:47 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 29 May 2019 09:26:46 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 29 May 2019 09:26:46 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 29 May 2019 09:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4eoqNRmc3LMmVaz3RomiWqkEf9IsoofKVkNtQpF48A=;
 b=l1h9Ya5FsbFDb5dlRSJRnty1ezE57/Kf7+RtWDiWe35mLJUihhRuYA72iX1XIc2TkCjmPWQdlnLoy8q1rqwSrUMdR3Zem+IzYVYo0asyPL2PQ1rUA3TCm2vhB/ZtXdtl2ZK8z7DQrRWCgIbKq+E+WROPislmRn6xAF5Q9zXyiRo=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Wed, 29 May 2019 16:26:43 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 16:26:43 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Thread-Topic: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Thread-Index: AQHVFHAFBgyZ0nJ640yaup+zuj/dD6aAsSSAgAFzHYCAACl0gA==
Date:   Wed, 29 May 2019 16:26:43 +0000
Message-ID: <20190529162638.GB3228@tower.DHCP.thefacebook.com>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-5-urezki@gmail.com>
 <20190528225001.GI27847@tower.DHCP.thefacebook.com>
 <20190529135817.tr7usoi2xwx5zl2s@pc636>
In-Reply-To: <20190529135817.tr7usoi2xwx5zl2s@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:102:2::19) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:d07b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee927282-3083-4aab-f95c-08d6e4526f70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3029;
x-ms-traffictypediagnostic: BYAPR15MB3029:
x-microsoft-antispam-prvs: <BYAPR15MB302984381AAAD3AA5C4C66F9BE1F0@BYAPR15MB3029.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6916009)(186003)(476003)(14454004)(478600001)(2906002)(11346002)(46003)(7416002)(6436002)(33656002)(66476007)(66556008)(64756008)(66446008)(256004)(53936002)(66946007)(316002)(446003)(6116002)(5660300002)(14444005)(73956011)(76176011)(1076003)(6512007)(305945005)(9686003)(54906003)(102836004)(7736002)(68736007)(4326008)(6486002)(86362001)(8936002)(6506007)(52116002)(486006)(386003)(229853002)(8676002)(81166006)(81156014)(99286004)(25786009)(71190400001)(6246003)(1411001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3029;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LcC68bM6F9+mEA32eqgXfaPu7PWFGl6jGge7jt4ZFeWMD37mlo3B10xFVnumYwjtlAPv0ABp5r5Mqv+UZPyHqSCH1wNNES+qXBYT8Esw60N4TmlWvponjD1oJxCLhit/6PTxTjVjt48mMw8kzqzAQvGRxJcHWzZmF/Liw9unDNBQ2jCrnHQ6JxoZ1SxR+IX0Qv/qpk0rncSawFLFXq0AmVUWn43E5A1jMq8IbVZT90DdJozVIY4pxjnQ81/LOTfpon/XjlZ1uF//0xmUm6Wm6ncPiDz5v6I6G3WtEz67SXmecoB24V7IRtFhHVELOMfdWZW5DPK3rGWfcBXYXRJnrH0yi32RgZiEv0FdnGq1L/vZABQII8ou7nbzxIQDXimY9naMx2QGkpF7zBQ9f+zAJbh6lwLGEfirnYyu4xLAUlE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DE781A594B98E4EB961CFA26CC32854@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee927282-3083-4aab-f95c-08d6e4526f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 16:26:43.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290107
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:58:17PM +0200, Uladzislau Rezki wrote:
> Hello, Roman!
>=20
> > > Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> > > function, it means if an empty node gets freed it is a BUG
> > > thus is considered as faulty behaviour.
> >=20
> > It's not exactly clear from the description, why it's better.
> >=20
> It is rather about if "unlink" happens on unhandled node it is
> faulty behavior. Something that clearly written in stone. We used
> to call "unlink" on detached node during merge, but after:
>=20
> [PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when merge
>=20
> it is not supposed to be ever happened across the logic.
>=20
> >
> > Also, do we really need a BUG_ON() in either place?
> >=20
> Historically we used to have the BUG_ON there. We can get rid of it
> for sure. But in this case, it would be harder to find a head or tail
> of it when the crash occurs, soon or later.
>=20
> > Isn't something like this better?
> >=20
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index c42872ed82ac..2df0e86d6aff 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1118,7 +1118,8 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier)=
;
> > =20
> >  static void __free_vmap_area(struct vmap_area *va)
> >  {
> > -       BUG_ON(RB_EMPTY_NODE(&va->rb_node));
> > +       if (WARN_ON_ONCE(RB_EMPTY_NODE(&va->rb_node)))
> > +               return;
> >
> I was thinking about WARN_ON_ONCE. The concern was about if the
> message gets lost due to kernel ring buffer. Therefore i used that.
> I am not sure if we have something like WARN_ONE_RATELIMIT that
> would be the best i think. At least it would indicate if a warning
> happens periodically or not.
>=20
> Any thoughts?

Hello, Uladzislau!

I don't have a strong opinion here. If you're worried about losing the mess=
age,
WARN_ON() should be fine here. I don't think that this event will happen of=
ten,
if at all.

Thanks!
