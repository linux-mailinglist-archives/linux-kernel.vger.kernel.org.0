Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06735104091
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 17:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfKTQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 11:19:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34506 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728972AbfKTQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:19:03 -0500
Received: (qmail 2086 invoked by uid 2102); 20 Nov 2019 11:19:03 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2019 11:19:03 -0500
Date:   Wed, 20 Nov 2019 11:19:03 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ikjoon Jang <ikjn@chromium.org>
cc:     linux-usb@vger.kernel.org, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>
Subject: Re: [PATCH 0/2] usb: override hub device bInterval with device node
In-Reply-To: <CAATdQgB9_qd+u1mr7ExNbeg0NP6AWO150WfXUabvL9AvKZC0dA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911201116590.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, Ikjoon Jang wrote:

> On Tue, Nov 19, 2019 at 11:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 19 Nov 2019, Ikjoon Jang wrote:
> >
> > > On Sun, Nov 17, 2019 at 11:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Sun, 17 Nov 2019, Ikjoon Jang wrote:
> > > >
> > > > > This patchset enables hard wired hub device to use different bInterval
> > > > > from its descriptor when the hub has a combined device node.
> > > > >
> > > > > When we know the specific hard wired hub supports changing its polling
> > > > > interval, we can adjust hub's interval to reduce the time of waking up
> > > > > from autosuspend or connect detection of HIDs.
> > > >
> > > > In fact, _all_ hubs support changing the polling interval.  The value
> > > > given in the USB spec is just an upper limit; any smaller value is
> > > > equally acceptable.
> > > >
> > > > So why are you doing this only for hard-wired hubs?  Why not for all
> > > > hubs?
> > >
> > > Because we only want to apply it to a specific device instance under
> > > our control.
> >
> > Why?  What's so special about that device instance?
> >
> > For example, why not instead have a poll_interval sysfs attribute for
> > all hubs that can be written from userspace?  Then people could reduce
> > the autoresume latency for any device they want.
> 
> Changing its INT interval during runtime seems not so easy, there's no device
> drivers doing this to my knowledge. At least xhci needs to restart
> endpoint to change
> the interval. So I think patching ep descriptor at enumeration stage
> is more convincing.

That's a good point.  It would be necessary to send a Set-Interface 
request at the very least if you wanted to change the interval 
on-the-fly.

> > > We apply autosuspend to built-in touchpad device for power savings,
> > >
> > > Users can attach external hub devices with same VID:PID that we don't want to
> > > change the behavior.
> >
> > Why don't you want to change the behavior?  Or allow the user to change
> > the behavior?
> >
> 
> Yes, that's a difficult question here too, when the hub is external device,
> it can't be fully controlled by here. Even though it's the same
> VID:PID hub chip,
> that's not the 100% same device. We don't know how much this will
> impact to the other
> external hub devices regarding power consumption and compatibility.
> 
> > >  Maybe disabling autosuspend for external HIDs
> > > can be more reasonable for that case?
> >
> > If it makes sense to to save power for your built-in touchpad device,
> > why doesn't it also make sense to save power for other external HIDs?
> >
> > > > And is 250 ms really too long to wait for remote wakeup or connect
> > > > detection?  What's the real motivation behind this change?
> > >
> > > When a user starts to move the cursor while touchpad is in autosuspend state,
> > > It takes more than >250ms (worst case can be >500ms) to wake up and response.
> > > That makes the cursor stuck for a while and warp to another location suddenly.
> >
> > All right, that's a good reason.  But doesn't it apply just as well to
> > other devices, not only your built-in touchpad?
> 
> Actually the hub is the one to be applied, I don't care much about the
> rare case that
> a user connects an additional external hub with same PID and connect
> external HID
> under that hub.
> 
> We could reduce autosuspend delay for built-in touchpad when we know
> that's better
> for power savings only if response time of wake up is good enough. but
> we don't know
> the optimal values for external HIDs. So we could use the default long
> delay for external
> devices, or just disable autosuspend for all external HIDs,
> so user might experience much less cursor lags even with that rare case.

All right.  Can you resubmit the patch with this explanation added to
the Changelog?

Alan Stern

