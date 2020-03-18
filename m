Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455E3189927
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgCRKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:19:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35085 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgCRKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:19:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id u12so26355181ljo.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gzym+ypZqpjWmWKa4VJKBMKo9LIO59BdQoueTVn41OM=;
        b=zOTIH/VOJopsLS0rZHxSVfiTGkCoEaq9QcfoXQf9O9MFBO+oNrnrouGTC2y6Pv4zll
         RNva8BANBr2Y5cEndoEbedTZQEQmM25pJbjU7o/gLWKCVD5AdD+e0vNteSlI3aBq2/gN
         U6QoRwbpoJ3H8KhzKfKBimcoprdAhvhgWfFfSJwwAzDzDSnruLL9JeocTicsbraAJ9Aj
         QC4rLBrsMX63siPSOunTGHKZPVg89mPn/1DW2BCtUvOQhFtYSzR9/dOCdGDDtitd3r0S
         wFwgzhcInX3rXZWgjf6Up6rSjvxQ8XlMKVMCPk/1boTeRDRGHDkVIaaZeN0/5F0TbcmM
         F+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gzym+ypZqpjWmWKa4VJKBMKo9LIO59BdQoueTVn41OM=;
        b=AzNaFfJ8eZWjdqUA1w9yZHi++zgKOgKivMGpqpDbiLPvq4+kGQOP//hxptJ6ek5+iA
         A4ho5JBhNQbKdojrr967C/DQzN3f2/2HhwqELZUDa1O2htaHL8en/RaCBrIWUxhh6lOD
         9xkQItvRKFUSgtL43WIElakROuXrYN7dfNS1ltPsODtP3/82Bi7+WmR4N3UJm13hsLQ/
         Nbdncn/uCaTFHGFn39aHyAAB9oqwuYoop7rvvjy6tDKynXRZ8WRrMWcgEzQQ+9XwDCib
         siQJsSA+QGbHsaCvn3GVG8NfhIb2YKtHOtoSO+FPObnR1kjlb9NSh5RoJ0Zf65n3Vtx8
         4rNg==
X-Gm-Message-State: ANhLgQ3P4EcfytfrwLY5MoTU3lXpu/qnOrh/x7TmKMT01FvIKcirSybG
        jGvbPXY9ZqSusK53LmRUuvhDULFyW3Q=
X-Google-Smtp-Source: ADFU+vvzt0BbIXxDJbV9xAGI8ELBnSE73Mm5oRWePbKFm4alzRuwENpzZQgxE+sl7zMNsxenhANutw==
X-Received: by 2002:a2e:9b93:: with SMTP id z19mr1922902lji.64.1584526777495;
        Wed, 18 Mar 2020 03:19:37 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id t6sm3537154ljc.50.2020.03.18.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:19:36 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:19:36 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Suresh Udipi <sudipi@jp.adit-jv.com>
Cc:     akiyama@nds-osk.co.jp, efriedrich@de.adit-jv.com,
        erosca@de.adit-jv.com, hverkuil-cisco@xs4all.nl,
        jacopo+renesas@jmondi.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, mrodin@de.adit-jv.com,
        securitycheck@denso.co.jp
Subject: Re: [PATCH v2] [RFC] rcar-vin: rcar-csi2: Correct the selection of
 hsfreqrange
Message-ID: <20200318101936.GA2667161@oden.dyn.berto.se>
References: <20200316130247.GA2258968@oden.dyn.berto.se>
 <1584428905-21560-1-git-send-email-sudipi@jp.adit-jv.com>
 <20200317103756.GC2496015@oden.dyn.berto.se>
 <20200318090029.GA22842@jp-u0004>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318090029.GA22842@jp-u0004>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suresh,

Thanks for your feedback.

On 2020-03-18 18:00:29 +0900, Suresh Udipi wrote:
> On Tue, Mar 17, 2020 at 11:37:56AM +0100, Niklas S�derlund wrote:
> > Hi Suresh,
> > 
> > Thanks for your work.
> > 
> > On 2020-03-17 16:08:25 +0900, Suresh Udipi wrote:
> > > hsfreqrange should be chosen based on the calculated mbps which
> > > is closer to the default bit rate  and within the range as per
> > > table[1]. But current calculation always selects first value which
> > > is greater than or equal to the calculated mbps which may lead
> > > to chosing a wrong range in some cases.
> > > 
> > > For example for 360 mbps for H3/M3N
> > > Existing logic selects
> > > Calculated value 360Mbps : Default 400Mbps Range [368.125 -433.125 mbps]
> > > 
> > > This hsfreqrange is out of range.
> > > 
> > > The logic is changed to get the default value which is closest to the
> > > calculated value [1]
> > > 
> > > Calculated value 360Mbps : Default 350Mbps  Range [320.625 -380.625 mpbs]
> > > 
> > > [1] specs r19uh0105ej0200-r-car-3rd-generation.pdf [Table 25.9]
> > > 
> > > There is one exectpion value 227Mbps, which may cause out of
> > > range.
> > 
> > Then something else is needed I think :-)
> > 
> > I liked v1 of this RFC more, where you added a u16 min and max to struct 
> > rcsi2_mbps_reg. I think that is the right solution.
> > 
> > What I tried to express in my review of v1 was
> > 
> > - You should remove the mbps member from struct rcsi2_mbps_reg.
> > - Update the walk of the array in rcsi2_set_phypll() so that it finds 
> >   the first entry where the calculated target value is between min and 
> >   max and use the reg setting for that entry.
> > 
> > Would that solution make sens too you? Sorry if I expressed myself a but 
> > muddy in v1 about this.
>  
> Thank you for your feedback. Checking the range make more sense.
> 
> We can further optimize it, by checking only the Max range value.
> 
> - Remove mbps and min member from struct rcsi2_mbps_reg.
> - Update the walk of the array in rcsi2_set_phypll() so that it finds
>   the first entry where the calculated bit rate is less than the max.
> 
> Lower bit rates less than 80Mbps 
> like 48Mbps(Raspberry pi camera 640x480 connected to Kingfisher)
> can also be supported by selecting the lowest default bit rate 80Mbps
> as done before this fix.

I think this approach sounds nice.

> 
> Please let me know your opinion on the same.
> Meanwhile iam working on creating the patch, test it and update the same.

Looking forward to it!

> > > 
> > > Fixes: 769afd212b16 ("media: rcar-csi2: add Renesas R-Car MIPI CSI-2 receiver driver")
> > > 
> > > Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
> > > Signed-off-by: Kazuyoshi Akiyama <akiyama@nds-osk.co.jp>
> > > ---
> > > Changes in v2:
> > >   - Added the boundary check for the maximum bit rate.
> > >   
> > >   - Simplified the logic by remmoving range check 
> > >     as only the closest default value covers most 
> > >     of the use cases.
> > > 
> > >   - Aligning the commit message based on the above change
> > > 
> > >  drivers/media/platform/rcar-vin/rcar-csi2.c | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > index faa9fb2..6573625 100644
> > > --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> > > @@ -199,6 +199,7 @@ static const struct rcsi2_mbps_reg phtw_mbps_v3m_e3[] = {
> > >  /* PHY Frequency Control */
> > >  #define PHYPLL_REG			0x68
> > >  #define PHYPLL_HSFREQRANGE(n)		((n) << 16)
> > > +#define PHYPLL_HSFREQRANGE_MAX		1500
> > >  
> > >  static const struct rcsi2_mbps_reg hsfreqrange_h3_v3h_m3n[] = {
> > >  	{ .mbps =   80, .reg = 0x00 },
> > > @@ -431,16 +432,23 @@ static int rcsi2_wait_phy_start(struct rcar_csi2 *priv)
> > >  static int rcsi2_set_phypll(struct rcar_csi2 *priv, unsigned int mbps)
> > >  {
> > >  	const struct rcsi2_mbps_reg *hsfreq;
> > > +	const struct rcsi2_mbps_reg *hsfreq_prev = NULL;
> > >  
> > > -	for (hsfreq = priv->info->hsfreqrange; hsfreq->mbps != 0; hsfreq++)
> > > -		if (hsfreq->mbps >= mbps)
> > > -			break;
> > > -
> > > -	if (!hsfreq->mbps) {
> > > +	if (mbps > PHYPLL_HSFREQRANGE_MAX) {
> > >  		dev_err(priv->dev, "Unsupported PHY speed (%u Mbps)", mbps);
> > >  		return -ERANGE;
> > >  	}
> > >  
> > > +	for (hsfreq = priv->info->hsfreqrange; hsfreq->mbps != 0; hsfreq++) {
> > > +		if (hsfreq->mbps >= mbps)
> > > +			break;
> > > +		hsfreq_prev = hsfreq;
> > > +	}
> > > +
> > > +	if (hsfreq_prev &&
> > > +	    ((mbps - hsfreq_prev->mbps) <= (hsfreq->mbps - mbps)))
> > > +		hsfreq = hsfreq_prev;
> > > +
> > >  	rcsi2_write(priv, PHYPLL_REG, PHYPLL_HSFREQRANGE(hsfreq->reg));
> > >  
> > >  	return 0;
> > > -- 
> > > 2.7.4
> > > 
> > 
> > -- 
> > Regards,
> > Niklas S�derlund
> 
> -- 
> Best Regards,
> Suresh Udipi.

-- 
Regards,
Niklas S�derlund
