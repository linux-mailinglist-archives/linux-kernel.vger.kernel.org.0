Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D339A88AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfIDOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 10:21:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46720 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729993AbfIDOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:21:42 -0400
Received: (qmail 2340 invoked by uid 2102); 4 Sep 2019 10:21:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2019 10:21:40 -0400
Date:   Wed, 4 Sep 2019 10:21:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Felipe Balbi <balbi@kernel.org>
cc:     Jacky.Cao@sony.com, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kento.A.Kobayashi@sony.com>
Subject: Re: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
In-Reply-To: <87sgpcmr7v.fsf@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909041017180.1722-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Felipe Balbi wrote:

> 
> Hi,
> 
> <Jacky.Cao@sony.com> writes:
> 
> > The power budget for SuperSpeed mode should be 900 mA
> > according to USB3.0 specification, so set the power
> > budget to 900 mA for dummy_start_ss which is only used
> > for SuperSpeed mode.
> >
> > If the max power consumption of SuperSpeed device is
> > larger than 500 mA, insufficient available bus power
> > error happens in usb_choose_configuration function
> > when the device connects to dummy hcd.
> >
> > Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
> > ---
> > drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> > index 8414fac..52f2cf5 100644
> > --- a/drivers/usb/gadget/udc/dummy_hcd.c
> > +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> > @@ -48,6 +48,7 @@
> > #define DRIVER_VERSION "02 May 2005"
> >
> >  #define POWER_BUDGET  500  /* in mA; use 8 for low-power port testing */
> > +#define POWER_BUDGET_3_0  900  /* in mA */
> >
> >  static const char  driver_name[] = "dummy_hcd";
> > static const char  driver_desc[] = "USB Host+Gadget Emulator";
> > @@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
> >      dum_hcd->rh_state = DUMMY_RH_RUNNING;
> >      dum_hcd->stream_en_ep = 0;
> >      INIT_LIST_HEAD(&dum_hcd->urbp_list);
> > -     dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
> > +     dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3_0;
> >      dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
> >      dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
> > #ifdef CONFIG_USB_OTG
> 
> Alan, I suppose you're okay with this change?

Yes.  Except that I think the name POWER_BUDGET_3_0 is a little odd.  
It implies that this change is specific to USB 3.0 -- but it isn't.  
USB 3.1 and 3.2 also have a 900 mA limit, right?

So please consider changing the name to POWER_BUDGET_3.

Alan Stern

