Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0651124AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEUIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:46:07 -0400
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:8973
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfEUIqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl8YQQM1knmycl/X2Ux61n2z8liHcFcwcrwB5Hr1G/M=;
 b=11sXCmFsa0ZNGYcKGXKsLAY6UH6W967/keZtWuZVOthYCwHyi9jNsF0mK9yvRv5Gx5BSEg+qjzcD95DCRRUzdDgj1KyOGkisi9Js8xiJimsyz9gLK5gts84iZWrN6mwYajJRjYhkBmVcBpBXefgtNJz6X4/d+rzBu5I6KW+KNgI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5023.eurprd08.prod.outlook.com (10.255.159.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 08:45:58 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 08:45:58 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Topic: [PATCH] drm/komeda: Added AFBC support for komeda driver
Thread-Index: AQHU6tZrSfGY2oLen0KpP248EWVF9Q==
Date:   Tue, 21 May 2019 08:45:58 +0000
Message-ID: <20190521084552.GA20625@james-ThinkStation-P300>
References: <20190404110552.15778-1-james.qian.wang@arm.com>
 <20190516135748.GC1372@arm.com>
In-Reply-To: <20190516135748.GC1372@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0042.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::30) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a65dbd0-c278-4d6e-89ad-08d6ddc8be8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5023;
x-ms-traffictypediagnostic: VE1PR08MB5023:
x-ms-exchange-purlcount: 6
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5023FFF0BDC98E42CC38FFB5B3070@VE1PR08MB5023.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(58126008)(55236004)(53936002)(33716001)(6636002)(6246003)(33656002)(6506007)(6862004)(8676002)(68736007)(52116002)(76176011)(386003)(1076003)(9686003)(6512007)(6306002)(102836004)(99286004)(4326008)(11346002)(3846002)(6116002)(446003)(476003)(86362001)(5660300002)(30864003)(53946003)(305945005)(7736002)(478600001)(2906002)(14454004)(71200400001)(71190400001)(8936002)(966005)(486006)(81166006)(6486002)(316002)(256004)(81156014)(229853002)(66066001)(66446008)(26005)(186003)(73956011)(14444005)(64756008)(66556008)(6436002)(66476007)(25786009)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5023;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x3qmWC9nWJq4tomr0Aaa2hoWMmo+VAwbEa4GQQ1FrnGeO8Hk0csMiYHZeliKIvnTM02rrWmCUpsxw4Tkvq+MLkhBplVCvftkZJyaF4gTdl48+rnR352Q0WCrbuiIHiADMXXXEcdkGxlLOUVe3R0O4jx91BXKCXlUeWDDm2qR9UPcZcTreaEB7spFhXx6uTFyMgwgJPR7aM4UjXEpFivstySj9erWYU9kW8PvMD238+n6H2crfM1zgQdNVKOquHfpLHMJ08XFMdOnt0Kyc9JfLxKrE/3d1bEXnVIRNtrU/OdA7Bk7rdbGXfMN3Rry1oKGWeqMul6n9HCMvmHC0BpOhWo24kd8wSbf5eKpO8zA2vMo0iNR3S+PIucdYor6DqlIfm6c6AjkELCuwwB4iiuPl+ts4KVn5QlewB1SAUb6DTM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD8765B7CDB62D468B986AF16F4EED99@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a65dbd0-c278-4d6e-89ad-08d6ddc8be8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:45:58.5075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 09:57:49PM +0800, Ayan Halder wrote:
> On Thu, Apr 04, 2019 at 12:06:14PM +0100, james qian wang (Arm Technology=
 China) wrote:
> > For supporting AFBC:
> > 1. Check if the user requested modifier can be supported by display HW.
> > 2. Check the obj->size with AFBC's requirement.
> > 3. Configure HW according to the modifier (afbc features)
> Can we have a bit more detailed commit message listing the various
> constraints (about which combination of modifiers, format and block
> sizes are valid) ?

- First for the acceptable combination of modifiers for the specific format
  which is desribed by komeda format handling patch=20
  https://patchwork.freedesktop.org/patch/274057/?series=3D54681&rev=3D1

  and the struct komeda_format_caps has a detailed doc information. =20

> >=20
> > This patch depends on:
> > - https://patchwork.freedesktop.org/series/54448/
> > - https://patchwork.freedesktop.org/series/54449/
> > - https://patchwork.freedesktop.org/series/54450/
> > - https://patchwork.freedesktop.org/series/58976/
> > - https://patchwork.freedesktop.org/series/59000/
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../arm/display/komeda/d71/d71_component.c    | 39 ++++++++++
> >  .../arm/display/komeda/komeda_format_caps.c   | 53 +++++++++++++
> >  .../arm/display/komeda/komeda_format_caps.h   |  5 ++
> >  .../arm/display/komeda/komeda_framebuffer.c   | 74 ++++++++++++++++++-
> >  .../arm/display/komeda/komeda_framebuffer.h   |  4 +
> >  .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  4 +
> >  .../display/komeda/komeda_pipeline_state.c    | 18 ++++-
> >  .../gpu/drm/arm/display/komeda/komeda_plane.c | 15 +++-
> >  9 files changed, 209 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index b582afcf9210..33ca1718b5cd 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -134,6 +134,27 @@ static u32 to_rot_ctrl(u32 rot)
> >  	return lr_ctrl;
> >  }
> > =20
> > +static u32 to_ad_ctrl(u64 modifier)
> > +{
> > +	u32 afbc_ctrl =3D AD_AEN;
> > +
> > +	if (!modifier)
> > +		return 0;
> > +
> > +	if ((modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) =3D=3D
> > +	    AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
> > +		afbc_ctrl |=3D AD_WB;
> > +
> > +	if (modifier & AFBC_FORMAT_MOD_YTR)
> > +		afbc_ctrl |=3D AD_YT;
> > +	if (modifier & AFBC_FORMAT_MOD_SPLIT)
> > +		afbc_ctrl |=3D AD_BS;
> > +	if (modifier & AFBC_FORMAT_MOD_TILED)
> > +		afbc_ctrl |=3D AD_TH;
> > +
> > +	return afbc_ctrl;
> > +}
> > +
> >  static inline u32 to_d71_input_id(struct komeda_component_output *outp=
ut)
> >  {
> >  	struct komeda_component *comp =3D output->component;
> > @@ -173,6 +194,24 @@ static void d71_layer_update(struct komeda_compone=
nt *c,
> >  			       fb->pitches[i] & 0xFFFF);
> >  	}
> > =20
> > +	malidp_write32(reg, AD_CONTROL, to_ad_ctrl(fb->modifier));
> > +	if (fb->modifier) {
> > +		u64 addr;
> > +
> > +		malidp_write32(reg, LAYER_AD_H_CROP, HV_CROP(st->afbc_crop_l,
> > +							     st->afbc_crop_r));
> > +		malidp_write32(reg, LAYER_AD_V_CROP, HV_CROP(st->afbc_crop_t,
> > +							     st->afbc_crop_b));
> > +		/* afbc 1.2 wants payload, afbc 1.0/1.1 wants end_addr */
> > +		if (fb->modifier & AFBC_FORMAT_MOD_TILED)
> > +			addr =3D st->addr[0] + kfb->offset_payload;
> > +		else
> > +			addr =3D st->addr[0] + kfb->afbc_size - 1;
> > +
> > +		malidp_write32(reg, BLK_P1_PTR_LOW, lower_32_bits(addr));
> > +		malidp_write32(reg, BLK_P1_PTR_HIGH, upper_32_bits(addr));
> > +	}
> > +
> >  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
> >  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/=
drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> > index 1e17bd6107a4..b2195142e3f3 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> > @@ -35,6 +35,59 @@ komeda_get_format_caps(struct komeda_format_caps_tab=
le *table,
> >  	return NULL;
> >  }
> > =20
> > +/* Two assumptions
> > + * 1. RGB always has YTR
> > + * 2. Tiled RGB always has SC
> > + */
> > +u64 komeda_supported_modifiers[] =3D {
> > +	/* AFBC_16x16 + features: YUV+RGB both */
> > +	AFBC_16x16(0),
> > +	/* SPARSE */
> > +	AFBC_16x16(_SPARSE),
> > +	/* YTR + (SPARSE) */
> > +	AFBC_16x16(_YTR | _SPARSE),
> > +	AFBC_16x16(_YTR),
> > +	/* SPLIT + SPARSE + YTR RGB only */
> > +	/* split mode is only allowed for sparse mode */
> > +	AFBC_16x16(_SPLIT | _SPARSE | _YTR),
> > +	/* TILED + (SPARSE) */
> > +	/* TILED YUV format only */
> > +	AFBC_16x16(_TILED | _SPARSE),
> > +	AFBC_16x16(_TILED),
> > +	/* TILED + SC + (SPLIT+SPARSE | SPARSE) + (YTR) */
> > +	AFBC_16x16(_TILED | _SC | _SPLIT | _SPARSE | _YTR),
> > +	AFBC_16x16(_TILED | _SC | _SPARSE | _YTR),
> > +	AFBC_16x16(_TILED | _SC | _YTR),
> > +	/* AFBC_32x8 + features: which are RGB formats only */
> > +	/* YTR + (SPARSE) */
> > +	AFBC_32x8(_YTR | _SPARSE),
> > +	AFBC_32x8(_YTR),
> > +	/* SPLIT + SPARSE + (YTR) */
> > +	/* split mode is only allowed for sparse mode */
> > +	AFBC_32x8(_SPLIT | _SPARSE | _YTR),
> > +	/* TILED + SC + (SPLIT+SPARSE | SPARSE) + YTR */
> > +	AFBC_32x8(_TILED | _SC | _SPLIT | _SPARSE | _YTR),
> > +	AFBC_32x8(_TILED | _SC | _SPARSE | _YTR),
> > +	AFBC_32x8(_TILED | _SC | _YTR),
> > +	DRM_FORMAT_MOD_LINEAR,
> > +	DRM_FORMAT_MOD_INVALID
> > +};
> > +
> > +bool komeda_format_mod_supported(struct komeda_format_caps_table *tabl=
e,
> > +				 u32 layer_type, u32 fourcc, u64 modifier)
> > +{
> > +	const struct komeda_format_caps *caps;
> > +
> Do we have a NULL check on 'table' anywhere? I see it gets
> dereferenced in the function call below.

No need check, since table is embebbed in komeda_dev, which is=20
komeda_dev is referenced by &mdev->table.

Any dereferenced should be a bug, can you point me the place.

> > +	caps =3D komeda_get_format_caps(table, fourcc, modifier);
> > +	if (!caps)
> > +		return false;
> > +
> > +	if (!(caps->supported_layer_types & layer_type))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *tab=
le,
> >  				  u32 layer_type, u32 *n_fmts)
> >  {
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/=
drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> > index 60f39e77b098..bc3b2df361b9 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> > @@ -77,6 +77,8 @@ struct komeda_format_caps_table {
> >  	const struct komeda_format_caps *format_caps;
> >  };
> > =20
> > +extern u64 komeda_supported_modifiers[];
> > +
> >  const struct komeda_format_caps *
> >  komeda_get_format_caps(struct komeda_format_caps_table *table,
> >  		       u32 fourcc, u64 modifier);
> > @@ -86,4 +88,7 @@ u32 *komeda_get_layer_fourcc_list(struct komeda_forma=
t_caps_table *table,
> > =20
> >  void komeda_put_fourcc_list(u32 *fourcc_list);
> > =20
> > +bool komeda_format_mod_supported(struct komeda_format_caps_table *tabl=
e,
> > +				 u32 layer_type, u32 fourcc, u64 modifier);
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/=
drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> > index 4d8160cf09c3..f842c886c73c 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> > @@ -36,6 +36,75 @@ static const struct drm_framebuffer_funcs komeda_fb_=
funcs =3D {
> >  	.create_handle	=3D komeda_fb_create_handle,
> >  };
> > =20
> > +static int
> > +komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file=
,
> > +			  const struct drm_mode_fb_cmd2 *mode_cmd)
> > +{
> > +	struct drm_framebuffer *fb =3D &kfb->base;
> > +	const struct drm_format_info *info =3D fb->format;
> > +	struct drm_gem_object *obj;
> > +	u32 alignment_w =3D 0, alignment_h =3D 0, alignment_header;
> > +	u32 n_blocks =3D 0, min_size =3D 0;
> > +
> > +	obj =3D drm_gem_object_lookup(file, mode_cmd->handles[0]);
> > +	if (!obj) {
> > +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	switch (fb->modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_32x8:
> > +		alignment_w =3D 32;
> > +		alignment_h =3D 8;
> > +		break;
> > +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> > +		alignment_w =3D 16;
> > +		alignment_h =3D 16;
> > +		break;
> > +	default:
> Can we have something like a warn here ?

will add a WARN here.

> > +		break;
> > +	}
> > +
> > +	/* tiled header afbc */
> > +	if (fb->modifier & AFBC_FORMAT_MOD_TILED) {
> > +		alignment_w *=3D AFBC_TH_LAYOUT_ALIGNMENT;
> > +		alignment_h *=3D AFBC_TH_LAYOUT_ALIGNMENT;
> > +		alignment_header =3D AFBC_TH_BODY_START_ALIGNMENT;
> > +	} else {
> > +		alignment_header =3D AFBC_BODY_START_ALIGNMENT;
> > +	}
> > +
> > +	kfb->aligned_w =3D ALIGN(fb->width, alignment_w);
> > +	kfb->aligned_h =3D ALIGN(fb->height, alignment_h);
> > +
> > +	if (fb->offsets[0] % alignment_header) {
> > +		DRM_DEBUG_KMS("afbc offset alignment check failed.\n");
> > +		goto afbc_unreference;
> > +	}
> > +
> > +	n_blocks =3D (kfb->aligned_w * kfb->aligned_h) / AFBC_SUPERBLK_PIXELS=
;
> > +	kfb->offset_payload =3D ALIGN(n_blocks * AFBC_HEADER_SIZE,
> > +				    alignment_header);
> > +
> > +	kfb->afbc_size =3D kfb->offset_payload + n_blocks *
> > +			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
> > +			       AFBC_SUPERBLK_ALIGNMENT);
> > +	min_size =3D kfb->afbc_size + fb->offsets[0];
> > +	if (min_size > obj->size) {
> > +		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%=
x.\n",
> > +			      obj->size, min_size);
> > +		goto afbc_unreference;
> > +	}
> > +
> > +	fb->obj[0] =3D obj;
> > +	return 0;
> > +
> > +afbc_unreference:
> Why not call it afbc_fail ?

no problem :)

> > +	drm_gem_object_put_unlocked(obj);
> > +	fb->obj[0] =3D NULL;
> > +	return -EINVAL;
> > +}
> > +
> >  static int
> >  komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_=
fb *kfb,
> >  			       struct drm_file *file,
> > @@ -118,7 +187,10 @@ komeda_fb_create(struct drm_device *dev, struct dr=
m_file *file,
> > =20
> >  	drm_helper_mode_fill_fb_struct(dev, &kfb->base, mode_cmd);
> > =20
> > -	ret =3D komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
> > +	if (kfb->base.modifier)
> > +		ret =3D komeda_fb_afbc_size_check(kfb, file, mode_cmd);
> > +	else
> > +		ret =3D komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
> >  	if (ret < 0)
> >  		goto err_cleanup;
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/=
drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> > index ea2fe190c1e3..e3bab0defd72 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> > @@ -25,6 +25,10 @@ struct komeda_fb {
> >  	u32 aligned_w;
> >  	/** @aligned_h: aligned frame buffer height */
> >  	u32 aligned_h;
> > +	/** @afbc_size: minimum size of afbc */
> > +	u32 afbc_size;
> > +	/** @offset_payload: start of afbc body buffer */
> > +	u32 offset_payload;
> >  };
> > =20
> >  #define to_kfb(dfb)	container_of(dfb, struct komeda_fb, base)
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 3e58901fb776..306ea069a1b4 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -148,7 +148,7 @@ static void komeda_kms_mode_config_init(struct kome=
da_kms_dev *kms,
> >  	config->min_height	=3D 0;
> >  	config->max_width	=3D 4096;
> >  	config->max_height	=3D 4096;
> > -	config->allow_fb_modifiers =3D false;
> > +	config->allow_fb_modifiers =3D true;
> > =20
> >  	config->funcs =3D &komeda_mode_config_funcs;
> >  	config->helper_private =3D &komeda_mode_config_helpers;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index 7998a1e456b7..ba5bc0810c81 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -235,6 +235,10 @@ struct komeda_layer_state {
> >  	/* layer specific configuration state */
> >  	u16 hsize, vsize;
> >  	u32 rot;
> > +	u16 afbc_crop_l;
> > +	u16 afbc_crop_r;
> > +	u16 afbc_crop_t;
> > +	u16 afbc_crop_b;
> >  	dma_addr_t addr[3];
> >  };
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 944dca2e3379..9b29e9a9f49c 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -289,8 +289,22 @@ komeda_layer_validate(struct komeda_layer *layer,
> >  	st =3D to_layer_st(c_st);
> > =20
> >  	st->rot =3D dflow->rot;
> > -	st->hsize =3D kfb->aligned_w;
> > -	st->vsize =3D kfb->aligned_h;
> > +
> Can you put some comments here explaining the snippet below?
> > +	if (fb->modifier) {
> > +		st->hsize =3D kfb->aligned_w;
> > +		st->vsize =3D kfb->aligned_h;
> > +		st->afbc_crop_l =3D dflow->in_x;
> > +		st->afbc_crop_r =3D kfb->aligned_w - dflow->in_x - dflow->in_w;
> > +		st->afbc_crop_t =3D dflow->in_y;
> > +		st->afbc_crop_b =3D kfb->aligned_h - dflow->in_y - dflow->in_h;
> > +	} else {
> > +		st->hsize =3D dflow->in_w;
> > +		st->vsize =3D dflow->in_h;
> > +		st->afbc_crop_l =3D 0;
> > +		st->afbc_crop_r =3D 0;
> > +		st->afbc_crop_t =3D 0;
> > +		st->afbc_crop_b =3D 0;
> > +	}
> > =20
> >  	for (i =3D 0; i < fb->format->num_planes; i++)
> >  		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->in_x,
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_plane.c
> > index aae5e800bed4..14d68612052f 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -150,6 +150,18 @@ komeda_plane_atomic_destroy_state(struct drm_plane=
 *plane,
> >  	kfree(to_kplane_st(state));
> >  }
> > =20
> > +static bool
> > +komeda_plane_format_mod_supported(struct drm_plane *plane,
> > +				  u32 format, u64 modifier)
> > +{
> > +	struct komeda_dev *mdev =3D plane->dev->dev_private;
> > +	struct komeda_plane *kplane =3D to_kplane(plane);
> > +	u32 layer_type =3D kplane->layer->layer_type;
> > +
> > +	return komeda_format_mod_supported(&mdev->fmt_tbl, layer_type,
> > +					   format, modifier);
> > +}
> > +
> >  static const struct drm_plane_funcs komeda_plane_funcs =3D {
> >  	.update_plane		=3D drm_atomic_helper_update_plane,
> >  	.disable_plane		=3D drm_atomic_helper_disable_plane,
> > @@ -157,6 +169,7 @@ static const struct drm_plane_funcs komeda_plane_fu=
ncs =3D {
> >  	.reset			=3D komeda_plane_reset,
> >  	.atomic_duplicate_state	=3D komeda_plane_atomic_duplicate_state,
> >  	.atomic_destroy_state	=3D komeda_plane_atomic_destroy_state,
> > +	.format_mod_supported	=3D komeda_plane_format_mod_supported,
> >  };
> > =20
> >  /* for komeda, which is pipeline can be share between crtcs */
> > @@ -209,7 +222,7 @@ static int komeda_plane_add(struct komeda_kms_dev *=
kms,
> >  	err =3D drm_universal_plane_init(&kms->base, plane,
> >  			get_possible_crtcs(kms, c->pipeline),
> >  			&komeda_plane_funcs,
> > -			formats, n_formats, NULL,
> > +			formats, n_formats, komeda_supported_modifiers,
> >  			get_plane_type(kms, c),
> >  			"%s", c->name);
> > =20
> > --=20
> > 2.17.1

