Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3736DCCF50
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfJFIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 04:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:05:18 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9139E2084D;
        Sun,  6 Oct 2019 08:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570349117;
        bh=D/wd/mWjmPW54gsl+QbV0f4qahPhKTVJuxLON5hP40Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH/RzuIGYc/dOl4IhP5y4h85I95r/bQ5J8zN0qKVhvuw7vDiQ6SDlIuWnFY8pvyDj
         6BPXid09AqnfgTnrScg6vt3UZrK1DLPUjn9POE22o09cLjLqadWcW+lG8EYTqsK45w
         BwrEomQXQBzWyS7VxqucwOTBQsbzUkuSsV9R6a7c=
Date:   Sun, 6 Oct 2019 16:04:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: etnaviv: Add #cooling-cells
Message-ID: <20191006080442.GW7150@dragon>
References: <cover.1568255903.git.agx@sigxcpu.org>
 <6e9d761598b2361532146f43161fd05f3eee6545.1568255903.git.agx@sigxcpu.org>
 <caf166f465465c61b70ad69d88f0634f1ca2ae64.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caf166f465465c61b70ad69d88f0634f1ca2ae64.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 04:32:55PM +0200, Lucas Stach wrote:
> On Mi, 2019-09-11 at 19:40 -0700, Guido G�nther wrote:
> > Add #cooling-cells for when the gpu acts as a cooling device.
> > 
> > Signed-off-by: Guido G�nther <agx@sigxcpu.org>
> 
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Lucas,

I assume you will pick it up.

Shawn

> 
> > ---
> >  .../devicetree/bindings/display/etnaviv/etnaviv-drm.txt          | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> > index 8def11b16a24..640592e8ab2e 100644
> > --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> > @@ -21,6 +21,7 @@ Required properties:
> >  Optional properties:
> >  - power-domains: a power domain consumer specifier according to
> >    Documentation/devicetree/bindings/power/power_domain.txt
> > +- #cooling-cells: : If used as a cooling device, must be <2>
> >  
> >  example:
> >  
> 
