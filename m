Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A231153C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 16:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 10:00:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45556 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726246AbfLFPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:00:18 -0500
Received: (qmail 1696 invoked by uid 2102); 6 Dec 2019 10:00:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Dec 2019 10:00:16 -0500
Date:   Fri, 6 Dec 2019 10:00:16 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ikjoon Jang <ikjn@chromium.org>
cc:     Johan Hovold <johan@kernel.org>, <linux-usb@vger.kernel.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
In-Reply-To: <CAATdQgBK4gWvR06YJ3Z_y5NeqLKYY7Ajc0KG78rG2deR3Ga11A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1912060958550.1618-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019, Ikjoon Jang wrote:

> On Thu, Dec 5, 2019 at 10:26 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Dec 05, 2019 at 03:32:38PM +0800, Ikjoon Jang wrote:
> > > On Wed, Dec 4, 2019 at 3:55 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > But related to my question above, why do you need to do this during
> > > > enumeration? Why not just set the lower interval value in the hub
> > > > driver?
> > >
> > > Because I want device tree's bInterval to be checked against the same rules
> > > defined in usb_parse_endpoint(). e.g. although hardware says its maximum
> > > is 255, but the practical limit is still 0 to 16, so the code can
> > > print warnings when bInterval from device node is too weird.
> >
> > But that could be handled refactoring the code in question or similar.
> >
> 
> Yes, that should be worked. I can't exactly figure out how to refactor
> the code for now, but maybe parsed endpoint descriptors are being
> checked with default hard wired bInterval value and after that
> an overridden value should be checked again.
> 
> Actually I don't care about the details of software policies. I just want
> all devices to be handled in the same manner without any further
> special treatments.
> 
> > The fundamental problem here is that you're using devicetree, which is
> > supposed to only describe the hardware, to encode policy which should be
> > deferred to user space.
> 
> The hub hardware has a default bInterval inside which is actually
> adjustable. So I can think setting bInterval is to describe the hardware
> rather than policy.

If the hardware is adjustable, why don't you adjust the hardware 
instead of changing the software?

> > So I think you need to figure out an interface that allows user space to
> > set the polling interval for any hub at runtime instead.
> 
> Changing the interval at runtime is an another way to solve the
> power consumption problem, but it's not so easy. At least xhci needs
> to restart an endpoint and no devices are changing the interval after
> enumeration stage.

Restarting endpoints is easy; just call usb_set_interface().

Alan Stern

