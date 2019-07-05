Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7765FE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 23:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfGDVK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 17:10:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35062 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGDVK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:10:27 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4F3C24B;
        Thu,  4 Jul 2019 23:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1562274624;
        bh=rH5bR+9lFkKtZCDqwCe8OuU9RTZKTQrIQJBkM0CbF3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCDjPpeCNkj1EFXAIg9h/NzwKcGsKZmLD7agdaR1+cVt7JK7zHSn1M4g4HlG/aOvH
         1qGga4AH5et1WH+DOXF7QSWYGsZibj8vneYOfJZVMVbNpsKkcj4Fumwl4JfHAl8Ude
         A2HXM0xBa6cY8K0LRFVuMfpl4D0sbHRWItMo/Wqo=
Date:   Fri, 5 Jul 2019 00:10:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi86: add debugfs
Message-ID: <20190704211004.GH5024@pendragon.ideasonboard.com>
References: <20190702154419.20812-1-robdclark@gmail.com>
 <CGME20190702154441epcas2p2cba89e3a84216d9a8da43438a9648e03@epcas2p2.samsung.com>
 <20190702154419.20812-3-robdclark@gmail.com>
 <1b56a11c-194d-0eca-4dd1-48e91820eafb@samsung.com>
 <20190704123511.GG6569@pendragon.ideasonboard.com>
 <CAF6AEGvYJ6iA5B+thJuBC=pFStuhsn87xrrcWAZyroWj5xKMZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6AEGvYJ6iA5B+thJuBC=pFStuhsn87xrrcWAZyroWj5xKMZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Jul 04, 2019 at 06:56:56AM -0700, Rob Clark wrote:
> On Thu, Jul 4, 2019 at 5:35 AM Laurent Pinchartwrote:
> > On Thu, Jul 04, 2019 at 02:31:20PM +0200, Andrzej Hajda wrote:
> > > On 02.07.2019 17:44, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Add a debugfs file to show status registers.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 42 +++++++++++++++++++++++++++
> > > >  1 file changed, 42 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > index f1a2493b86d9..a6f27648c015 100644
> > > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > @@ -5,6 +5,7 @@
> > > >   */
> > > >
> > > >  #include <linux/clk.h>
> > > > +#include <linux/debugfs.h>
> > > >  #include <linux/gpio/consumer.h>
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/iopoll.h>
> > > > @@ -109,6 +110,7 @@ struct ti_sn_bridge {
> > > >     struct drm_dp_aux               aux;
> > > >     struct drm_bridge               bridge;
> > > >     struct drm_connector            connector;
> > > > +   struct dentry                   *debugfs;
> > > >     struct device_node              *host_node;
> > > >     struct mipi_dsi_device          *dsi;
> > > >     struct clk                      *refclk;
> > > > @@ -178,6 +180,42 @@ static const struct dev_pm_ops ti_sn_bridge_pm_ops = {
> > > >     SET_RUNTIME_PM_OPS(ti_sn_bridge_suspend, ti_sn_bridge_resume, NULL)
> > > >  };
> > > >
> > > > +static int status_show(struct seq_file *s, void *data)
> > > > +{
> > > > +   struct ti_sn_bridge *pdata = s->private;
> > > > +   unsigned int reg, val;
> > > > +
> > > > +   seq_puts(s, "STATUS REGISTERS:\n");
> >
> > NO NEED TO SHOUT :-)
> >
> > > > +
> > > > +   pm_runtime_get_sync(pdata->dev);
> > > > +
> > > > +   /* IRQ Status Registers, see Table 31 in datasheet */
> > > > +   for (reg = 0xf0; reg <= 0xf8; reg++) {
> > > > +           regmap_read(pdata->regmap, reg, &val);
> > > > +           seq_printf(s, "[0x%02x] = 0x%08x\n", reg, val);
> > > > +   }
> > > > +
> > > > +   pm_runtime_put(pdata->dev);
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +DEFINE_SHOW_ATTRIBUTE(status);
> > > > +
> > > > +static void ti_sn_debugfs_init(struct ti_sn_bridge *pdata)
> > > > +{
> > > > +   pdata->debugfs = debugfs_create_dir("ti_sn65dsi86", NULL);
> > >
> > > If some day we will have board with two such bridges there will be a
> > > problem.
> >
> > Could we use the platform device name for this ?
> 
> hmm, yeah, that would solve the 2x bridges issue
> 
> > > Anyway:
> > >
> > > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > >
> > > > +
> > > > +   debugfs_create_file("status", 0600, pdata->debugfs, pdata,
> > > > +                   &status_fops);
> > > > +}
> > > > +
> > > > +static void ti_sn_debugfs_remove(struct ti_sn_bridge *pdata)
> > > > +{
> > > > +   debugfs_remove_recursive(pdata->debugfs);
> > > > +   pdata->debugfs = NULL;
> > > > +}
> > > > +
> >
> > You need to conditionally-compile this based on CONFIG_DEBUG_FS.
> 
> Hmm, is that really true?  Debugfs appears to be sufficently stub'd w/
> inline no-ops in the !CONFIG_DEBUG_FS case

You're right, my bad. I wonder if the compiler will optimise the above
two functions out. It might warrant a CONFIG_DEBUG_FS check here for
that reason, but that's really bikeshedding. So with the 2x bridges
issue addressed, I think the patch will be good.

-- 
Regards,

Laurent Pinchart
