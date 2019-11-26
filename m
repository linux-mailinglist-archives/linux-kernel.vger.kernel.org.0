Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8080A10A4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:37:44 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:50594 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:37:44 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A99EE20053;
        Tue, 26 Nov 2019 20:37:41 +0100 (CET)
Date:   Tue, 26 Nov 2019 20:37:40 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
Message-ID: <20191126193740.GC2044@ravnborg.org>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-29-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126131541.47393-29-mihail.atanassov@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7CQSdrXTAAAA:8
        a=6lCv3_9TmdkNs-__4ugA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
        a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail.

On Tue, Nov 26, 2019 at 01:16:26PM +0000, Mihail Atanassov wrote:
> No functional change.
> 
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/sti/sti_dvo.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index 68289b0b063a..20a3956b33bc 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -462,9 +462,7 @@ static int sti_dvo_bind(struct device *dev, struct device *master, void *data)
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	bridge->driver_private = dvo;
> -	bridge->funcs = &sti_dvo_bridge_funcs;
> -	bridge->of_node = dvo->dev.of_node;
> +	drm_bridge_init(bridge, &dvo->dev, &sti_dvo_bridge_funcs, NULL, dvo);
>  	drm_bridge_add(bridge);
>  
>  	err = drm_bridge_attach(encoder, bridge, NULL);

I can see from grepping that bridge.driver_private is used
in a couple of other files in sti/

Like sti_hdmi.c:
        bridge->driver_private = hdmi;
        bridge->funcs = &sti_hdmi_bridge_funcs;
        drm_bridge_attach(encoder, bridge, NULL);


I wonder if a drm_bridge_init() should be added there.
I did not look closely - but it looked suspisiously.

	Sam
