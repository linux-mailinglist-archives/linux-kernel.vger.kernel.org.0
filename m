Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913CF6E521
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfGSLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 07:40:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfGSLkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:40:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE6F337;
        Fri, 19 Jul 2019 04:40:11 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 349363F71A;
        Fri, 19 Jul 2019 04:40:11 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id E0E3668065E; Fri, 19 Jul 2019 12:40:09 +0100 (BST)
Date:   Fri, 19 Jul 2019 12:40:09 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
Message-ID: <20190719114009.GA16673@e110455-lin.cambridge.arm.com>
References: <1561604994-26925-1-git-send-email-lowry.li@arm.com>
 <20190718131737.GD5942@e110455-lin.cambridge.arm.com>
 <20190719090816.GA4133@lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719090816.GA4133@lowry.li@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:09:30AM +0000, Lowry Li (Arm Technology China) wrote:
> Hi Liviu,
> 
> On Thu, Jul 18, 2019 at 01:17:37PM +0000, Liviu Dudau wrote:
> > On Thu, Jun 27, 2019 at 04:10:36AM +0100, Lowry Li (Arm Technology China) wrote:
> > > Adds to print the event message when error happens and the same event
> > > will not be printed until next vsync.
> > > 
> > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > ---
> > >  drivers/gpu/drm/arm/display/komeda/Makefile       |   1 +
> > >  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  13 ++
> > >  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 144 ++++++++++++++++++++++
> > >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |   2 +
> > >  4 files changed, 160 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > > 
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> > > index 38aa584..3f53d2d 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> > > +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> > > @@ -7,6 +7,7 @@ ccflags-y := \
> > >  komeda-y := \
> > >  	komeda_drv.o \
> > >  	komeda_dev.o \
> > > +	komeda_event.o \
> > >  	komeda_format_caps.o \
> > >  	komeda_coeffs.o \
> > >  	komeda_color_mgmt.o \
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > index 096f9f7..e863ec3 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > @@ -40,6 +40,17 @@
> > >  #define KOMEDA_ERR_TTNG			BIT_ULL(30)
> > >  #define KOMEDA_ERR_TTF			BIT_ULL(31)
> > >  
> > > +#define KOMEDA_ERR_EVENTS	\
> > > +	(KOMEDA_EVENT_URUN	| KOMEDA_EVENT_IBSY	| KOMEDA_EVENT_OVR |\
> > > +	KOMEDA_ERR_TETO		| KOMEDA_ERR_TEMR	| KOMEDA_ERR_TITR |\
> > > +	KOMEDA_ERR_CPE		| KOMEDA_ERR_CFGE	| KOMEDA_ERR_AXIE |\
> > > +	KOMEDA_ERR_ACE0		| KOMEDA_ERR_ACE1	| KOMEDA_ERR_ACE2 |\
> > > +	KOMEDA_ERR_ACE3		| KOMEDA_ERR_DRIFTTO	| KOMEDA_ERR_FRAMETO |\
> > > +	KOMEDA_ERR_ZME		| KOMEDA_ERR_MERR	| KOMEDA_ERR_TCF |\
> > > +	KOMEDA_ERR_TTNG		| KOMEDA_ERR_TTF)
> > > +
> > > +#define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
> > > +
> > >  /* malidp device id */
> > >  enum {
> > >  	MALI_D71 = 0,
> > > @@ -207,6 +218,8 @@ struct komeda_dev {
> > >  
> > >  struct komeda_dev *dev_to_mdev(struct device *dev);
> > >  
> > > +void komeda_print_events(struct komeda_events *evts);
> > > +
> > >  int komeda_dev_resume(struct komeda_dev *mdev);
> > >  int komeda_dev_suspend(struct komeda_dev *mdev);
> > >  #endif /*_KOMEDA_DEV_H_*/
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > > new file mode 100644
> > > index 0000000..309dbe2
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > > @@ -0,0 +1,144 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
> > > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > > + *
> > > + */
> > > +#include <drm/drm_print.h>
> > > +
> > > +#include "komeda_dev.h"
> > > +
> > > +struct komeda_str {
> > > +	char *str;
> > > +	u32 sz;
> > > +	u32 len;
> > > +};
> > > +
> > > +/* return 0 on success,  < 0 on no space.
> > > + */
> > > +static int komeda_sprintf(struct komeda_str *str, const char *fmt, ...)
> > > +{
> > > +	va_list args;
> > > +	int num, free_sz;
> > > +	int err;
> > > +
> > > +	free_sz = str->sz - str->len;
> > > +	if (free_sz <= 0)
> > > +		return -ENOSPC;
> > > +
> > > +	va_start(args, fmt);
> > > +
> > > +	num = vsnprintf(str->str + str->len, free_sz, fmt, args);
> > > +
> > > +	va_end(args);
> > > +
> > > +	if (num <= free_sz) {
> > > +		str->len += num;
> > > +		err = 0;
> > > +	} else {
> > > +		str->len = str->sz;
> > > +		err = -ENOSPC;
> > > +	}
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static void evt_sprintf(struct komeda_str *str, u64 evt, const char *msg)
> > > +{
> > > +	if (evt)
> > > +		komeda_sprintf(str, msg);
> > > +}
> > 
> > Why do we need this wrapper?
> The komeda_sprintf is a generic function and will be used by other
> places, while evt_sprintf is working for the detail event msg.

Yeah, I'm not buying this argument any more. We should not create new functions
just because we want to save typing one if () condition. evt_sprintf does
nothing with the extra evt argument other than checking that it is not zero.

> 
> > > +
> > > +static void evt_str(struct komeda_str *str, u64 events)
> > > +{
> > > +	if (events == 0ULL) {
> > > +		evt_sprintf(str, 1, "None");
> > > +		return;
> > > +	}
> > > +
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_VSYNC, "VSYNC|");
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_FLIP, "FLIP|");
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_EOW, "EOW|");
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_MODE, "OP-MODE|");
> > > +
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_URUN, "UNDERRUN|");
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_OVR, "OVERRUN|");
> > > +
> > > +	/* GLB error */
> > > +	evt_sprintf(str, events & KOMEDA_ERR_MERR, "MERR|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> > > +
> > > +	/* DOU error */
> > > +	evt_sprintf(str, events & KOMEDA_ERR_DRIFTTO, "DRIFTTO|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TETO, "TETO|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_CSCE, "CSCE|");
> > > +
> > > +	/* LPU errors or events */
> > > +	evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_ACE2, "ACE2|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_ACE3, "ACE3|");
> > > +
> > > +	/* LPU TBU errors*/
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TCF, "TCF|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TTNG, "TTNG|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TITR, "TITR|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TTF, "TTF|");
> > > +
> > > +	/* CU errors*/
> > > +	evt_sprintf(str, events & KOMEDA_ERR_CPE, "COPROC|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_ZME, "ZME|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_CFGE, "CFGE|");
> > > +	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> > > +
> > > +	if (str->len > 0 && (str->str[str->len - 1] == '|')) {
> > > +		str->str[str->len - 1] = 0;
> > > +		str->len--;
> > > +	}
> > > +}
> > > +
> > > +static bool is_new_frame(struct komeda_events *a)
> > > +{
> > > +	return (a->pipes[0] | a->pipes[1]) & KOMEDA_EVENT_FLIP;
> > > +}
> > > +
> > > +void komeda_print_events(struct komeda_events *evts)
> > > +{
> > > +	u64 print_evts = KOMEDA_ERR_EVENTS;
> > > +	static bool en_print = true;
> > > +
> > > +	/* reduce the same msg print, only print the first evt for one frame */
> > > +	if (evts->global || is_new_frame(evts))
> > > +		en_print = true;
> > > +	if (!en_print)
> > > +		return;
> > 
> > When does en_print ever get false?
> Once the events printed, it will be set false (pls find at the last
> line of this function).

What is the point of making en_print a static variable? We print all the time
when we have a global event anyway.


> > > +
> > > +#ifdef DEBUG
> > > +	print_evts |= KOMEDA_WARN_EVENTS;
> > > +#endif
> > > +
> > > +	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
> > > +		#define STR_SZ		128
> > > +		char msg[STR_SZ];
> > 
> > I've counted about 27 evt_sprintf() calls in evt_str() function, with an
> > average of 5 characters each, so thats 135 characters printed into a buffer
> > that is only 128 bytes. Please don't do this!
> komeda_sprintf() will check the size and also I thought those evt
> will not populat together. But yes, I'd better change this to 256.
> Will change this.
> 
> > > +		struct komeda_str str;
> > > +
> > > +		str.str = msg;
> > > +		str.sz  = STR_SZ;
> > > +		str.len = 0;
> > > +
> > > +		komeda_sprintf(&str, "gcu: ");
> > > +		evt_str(&str, evts->global);
> > > +		komeda_sprintf(&str, ", pipes[0]: ");
> > > +		evt_str(&str, evts->pipes[0]);
> > > +		komeda_sprintf(&str, ", pipes[1]: ");
> > > +		evt_str(&str, evts->pipes[1]);
> > > +
> > > +		DRM_ERROR("err detect: %s\n", msg);
> > > +
> > > +		en_print = false;
> > > +	}
> > > +}
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > index 647bce5..1462bac 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > @@ -47,6 +47,8 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
> > >  	memset(&evts, 0, sizeof(evts));
> > >  	status = mdev->funcs->irq_handler(mdev, &evts);
> > >  
> > > +	komeda_print_events(&evts);
> > 
> > Calling this function from the IRQ handler is a bad idea. We should use debugfs
> > if you really want to have a trace of the events, but I personally don't see
> > value in having this functionality in the kernel at all. You can expose the
> > value of the evts->global and evts->pipes[] as integers and decode that in
> > userspace or as a debugfs entry.
> > 
> > Best regards,
> > Liviu
> 
> The name of this function is misleading, but this is printing out the
> hardware detected errors, from which we can know directly once the
> errors happened on the hardware. Like if the driver code was at
> bring-up stage, the logs from this layer is helpful. So can we keep
> this?

We should probably just collect the global and pipes values and expose
them to userspace so that the printing and decoding of the messages happens
there.

Best regards,
Liviu


> 
> Best regards,
> Lowry
> 
> > > +
> > >  	/* Notify the crtc to handle the events */
> > >  	for (i = 0; i < kms->n_crtcs; i++)
> > >  		komeda_crtc_handle_event(&kms->crtcs[i], &evts);
> > > -- 
> > > 1.9.1
> > > 
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯
> 
> -- 
> Regards,
> Lowry

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
