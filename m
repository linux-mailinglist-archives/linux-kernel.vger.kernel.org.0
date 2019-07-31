Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE07B9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGaG0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 02:26:37 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:48876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfGaG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:26:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D38943811;
        Wed, 31 Jul 2019 06:26:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2902:2904:2911:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4425:4605:5007:6119:7514:7875:7903:9025:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30054:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: error57_395f5308c0426
X-Filterd-Recvd-Size: 2802
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 06:26:34 +0000 (UTC)
Message-ID: <29b3741ca8a9e94d64dba213059abb2296c30936.camel@perches.com>
Subject: Re: [PATCH v2] drm: use trace_printk rather than printk in drm_dbg.
From:   Joe Perches <joe@perches.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Jul 2019 23:26:32 -0700
In-Reply-To: <20190731062416.26238-1-huangfq.daxian@gmail.com>
References: <20190731062416.26238-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 14:24 +0800, Fuqian Huang wrote:
> In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
> amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
> finally calls printk.
> As amdgpu_ih_process is called from an interrupt handler,
> and interrupt handler should be short as possible.
> 
> As printk may lead to bogging down the system or can even
> create a live lock. printk should not be used in IRQ context.
> Instead, trace_printk is recommended in IRQ context.
> Link: https://lwn.net/Articles/365835
> 
> Reviewed-by: Joe Perches <joe@perches.com> 

I made a suggestion.  I did not review this.

Please do not add signatures like this if
not specifically given by someone.


> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Only make the interrupt uses the trace_printk to avoid
>     all 4000+ drm_dbg/DRM_DEBUG uses emitting a trace_printk.
> 
>  drivers/gpu/drm/drm_print.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index a17c8a14dba4..747835d16fa6 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -236,9 +236,13 @@ void drm_dbg(unsigned int category, const char *format, ...)
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> -	       __builtin_return_address(0), &vaf);
> -
> +	if (in_interrupt()) {
> +		trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +		       __builtin_return_address(0), &vaf);
> +	} else {
> +		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> +		       __builtin_return_address(0), &vaf);
> +	}
>  	va_end(args);
>  }
>  EXPORT_SYMBOL(drm_dbg);

