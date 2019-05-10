Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5BE1A075
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEJPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 11:49:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38435 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfEJPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:49:08 -0400
X-Originating-IP: 90.88.28.253
Received: from aptenodytes (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 882431BF207;
        Fri, 10 May 2019 15:49:03 +0000 (UTC)
Message-ID: <2fe2b72a28a7892797fed6d3db86b7c7912fe8c9.camel@bootlin.com>
Subject: Re: [PATCH v8 4/4] drm/vc4: Allocate binner bo when starting to use
 the V3D
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 10 May 2019 17:48:39 +0200
In-Reply-To: <87r2973222.fsf@anholt.net>
References: <20190503081242.29039-1-paul.kocialkowski@bootlin.com>
         <20190503081242.29039-5-paul.kocialkowski@bootlin.com>
         <87r2973222.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-05-09 at 11:39 -0700, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The binner BO is not required until the V3D is in use, so avoid
> > allocating it at probe and do it on the first non-dumb BO allocation.
> > 
> > Keep track of which clients are using the V3D and liberate the buffer
> > when there is none left, using a kref. Protect the logic with a
> > mutex to avoid race conditions.
> > 
> > The binner BO is created at the time of the first render ioctl and is
> > destroyed when there is no client and no exec job using it left.
> > 
> > The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
> > enabling it before having allocated a binner bo.
> > 
> > We also want to keep the BO alive during runtime suspend/resume to avoid
> > failing to allocate it at resume. This happens when the CMA pool is
> > full at that point and results in a hard crash.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > @@ -313,6 +321,49 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
> >  	return ret;
> >  }
> >  
> > +int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vc4->bin_bo_lock);
> > +
> > +	if (used && *used)
> > +		goto complete;
> 
> 
> > +
> > +	if (used)
> > +		*used = true;
> > +
> > +	if (vc4->bin_bo) {
> > +		kref_get(&vc4->bin_bo_kref);
> > +		goto complete;
> > +	}
> > +
> > +	ret = bin_bo_alloc(vc4);
> 
> I think this block wants to be:
> 
> if (vc4->bin_bo)
> 	kref_get(&vc4->bin_bo_kref);
> else
> 	ret = bin_bo_alloc(vc4);
> 
> if (ret == 0 && used)
> 	*used = true;
> 
> (so we don't flag used if bin_bo_alloc fails)
> 
> If you agree, then the series is:

I totally agree, and had definitely lost sight of the return value.

Thanks for the thorough code review once more!

Cheers,

Paul

> Reviewed-by: Eric Anholt <eric@anholt.net>
> 
> > +
> > +complete:
> > +	mutex_unlock(&vc4->bin_bo_lock);
> > +
> > +	return ret;
> > +}
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

