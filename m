Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4244FA77
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFWGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 02:10:23 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59882 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbfFWGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 02:10:23 -0400
X-IronPort-AV: E=Sophos;i="5.63,407,1557180000"; 
   d="scan'208";a="388655915"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 08:10:21 +0200
Date:   Sun, 23 Jun 2019 08:10:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Mao Wenan <maowenan@huawei.com>, airlied@linux.ie, daniel@ffwll.ch,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, kernel-janitors@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables
 'ret'
In-Reply-To: <20190623060027.GU28859@kadam>
Message-ID: <alpine.DEB.2.21.1906230809400.4961@hadrien>
References: <20190622030314.169640-1-maowenan@huawei.com> <20190622104318.GT28859@kadam> <20190623060027.GU28859@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jun 2019, Dan Carpenter wrote:

> On Sat, Jun 22, 2019 at 01:43:19PM +0300, Dan Carpenter wrote:
> > On Sat, Jun 22, 2019 at 11:03:14AM +0800, Mao Wenan wrote:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > > index 0e6dba9..0bf4dd9 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > > @@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
> > >  /* init amdgpu_pmu */
> > >  int amdgpu_pmu_init(struct amdgpu_device *adev)
> > >  {
> > > -	int ret = 0;
> > > -
> > >  	switch (adev->asic_type) {
> > >  	case CHIP_VEGA20:
> > >  		/* init df */
> > > -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> > > +		init_pmu_by_type(adev, df_v3_6_attr_groups,
> > >  				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > >  				       DF_V3_6_MAX_COUNTERS);
> >
> >
> > You're resending this for other reasons, but don't forget to update the
> > indenting on the arguments so they still line up with the '('.
> >
>
> Sorry, I was unclear.  If you pull the init_pmu_by_type( back 6
> characters then you also need to pull the "DF" back 6 characters.
>
> 		init_pmu_by_type(adev, df_v3_6_attr_groups, "DF", "amdgpu_df",
> 				 PERF_TYPE_AMDGPU_DF, DF_V3_6_MAX_COUNTERS);
>
> You can actually fit it into two lines afterwards.

My suggestion was to keep the ret = instead of discarding the indication
of failure, so I think that this is not relevant.

julia
