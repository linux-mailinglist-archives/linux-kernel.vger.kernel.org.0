Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2582D19E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 00:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfE1Wel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 18:34:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55994 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbfE1Wek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:34:40 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SMV36u008536;
        Tue, 28 May 2019 15:33:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yzUsiThfxqJ3m3PsdlBwZo0B8EabbnUUFizV8GMZm78=;
 b=PbhcRH0axQgvLXaIlNlHfYE6E6iol0Z8OSN0/CNlZA4TZ5ihfvTZKqCQpOLCv+ChNJXg
 PE4ZFjst23cuThskp9F+tUXfO1DsERgOxUQeyN79AoNUF1QI1lLx06SZxrq2Dg42YUA3
 v86cyBx+zzhJRjhXi1eJ6o1n51RNIZYjgHE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sscnx882j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 15:33:17 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 15:33:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 28 May 2019 15:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzUsiThfxqJ3m3PsdlBwZo0B8EabbnUUFizV8GMZm78=;
 b=B/QuI3XzwdnjpQT8JmZXBvsObxpBn1Kp9cts0s56RFEepS/YTeSvqV2HNyGi73ubhRhbPfSiLTUkctb0Pd0lQMP96keHYA9YSsIQ+BohR1E07j9pdd2TabG8GXSiDvV6HN8dKL7Jj+oK26R1ppJvIZEVA3jqohB2SY3ZX6iyJD8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2997.namprd15.prod.outlook.com (20.178.238.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 22:33:14 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 22:33:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/4] mm/vmap: remove "node" argument
Thread-Topic: [PATCH v3 1/4] mm/vmap: remove "node" argument
Thread-Index: AQHVFHAI0OUzCD+oxU2OHlfrQOKzsqaBIccA
Date:   Tue, 28 May 2019 22:33:14 +0000
Message-ID: <20190528223309.GF27847@tower.DHCP.thefacebook.com>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-2-urezki@gmail.com>
In-Reply-To: <20190527093842.10701-2-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:102:2::39) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:3dca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3261554b-0350-452b-114b-08d6e3bc78b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2997;
x-ms-traffictypediagnostic: BYAPR15MB2997:
x-microsoft-antispam-prvs: <BYAPR15MB299788E38ECFAC6F2B14CF39BE1E0@BYAPR15MB2997.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(7416002)(64756008)(66446008)(6916009)(73956011)(66946007)(478600001)(66556008)(66476007)(86362001)(8936002)(6486002)(6436002)(6512007)(305945005)(14454004)(6116002)(81156014)(1076003)(9686003)(102836004)(68736007)(33656002)(229853002)(2906002)(7736002)(5660300002)(52116002)(99286004)(6506007)(316002)(4326008)(476003)(256004)(76176011)(71190400001)(186003)(8676002)(54906003)(6246003)(71200400001)(81166006)(46003)(486006)(25786009)(446003)(53936002)(11346002)(1411001)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2997;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gdyUSNClqgtYiEP7R+0VOxqTa4yRfU4POhSgQAA/JsAGb0fpNDTYNABidPdW87HfrztjCJXWr7EFCfjVY4NtCRddwnujWRctAhaQgFgmN2x5d4vvNqfJauYxD7ulevuNYqnJtfo8ABP4xqGGXiS1J4gYElKic/dabPVRQYcss2xV419L2ohOKqDN1vdWMmh7xeQ9BqAO3fbmEZbUB2jzBU2+p+ohqRHPFb5f8FkORJ49PpRVtrmZ6+Sgx1n2xbKFioxP4AFivjkJL3iraG6Jxa4iEz+ogPy+LBzaTY+Z6uxKXGAO29VKdUpA6PPccDNJ/meo4XVxyVHVIedqtlyi/sdmerv8ew5f79yjJ27FfUvvW+22rcmb5HalmdGIPxYVx2QUrEjrw4niwlhNrRZpHgk93lrcDMj2bd9WHio3d7g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2E3A4D65090D84890DC2538E418F9C6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3261554b-0350-452b-114b-08d6e3bc78b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 22:33:14.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2997
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 11:38:39AM +0200, Uladzislau Rezki (Sony) wrote:
> Remove unused argument from the __alloc_vmap_area() function.
>=20
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c42872ed82ac..ea1b65fac599 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -985,7 +985,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
>   */
>  static __always_inline unsigned long
>  __alloc_vmap_area(unsigned long size, unsigned long align,
> -	unsigned long vstart, unsigned long vend, int node)
> +	unsigned long vstart, unsigned long vend)
>  {
>  	unsigned long nva_start_addr;
>  	struct vmap_area *va;
> @@ -1062,7 +1062,7 @@ static struct vmap_area *alloc_vmap_area(unsigned l=
ong size,
>  	 * If an allocation fails, the "vend" address is
>  	 * returned. Therefore trigger the overflow path.
>  	 */
> -	addr =3D __alloc_vmap_area(size, align, vstart, vend, node);
> +	addr =3D __alloc_vmap_area(size, align, vstart, vend);
>  	if (unlikely(addr =3D=3D vend))
>  		goto overflow;
> =20
> --=20
> 2.11.0
>=20

Reviewed-by: Roman Gushchin <guro@fb.com>
