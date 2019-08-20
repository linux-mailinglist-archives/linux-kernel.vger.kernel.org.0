Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642CE95212
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfHTAAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:00:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43290 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfHTAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:00:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id e12so3368563otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzA2HODJ3urRt2X8rONRdz7gI3c1lYKAb1hXmonKPmc=;
        b=bqtGSKVmqNo1DG0D4ec/POPSBeweJbhFPkvSx7Xo90/sbt3MByWjVYpWwaFd24XwrI
         74X6RViLMM2hZUvkLqMsW/byFbupzfjkcV4QWQHLu5l2R6NpslcSz9dN8s05lUZvomUk
         RTkR9zYAN/Ns0OGq613Z3J7RhvKysiddNBfBLCeYR7S7kDRJVWyuRyH804RZ4a9o/lmG
         v5TVjosEmdomjMPlieqnfxWMNjkoptfVPafxegPeRFphgoTHal+0472CRaF7qaK+i141
         FGmXCD8XNyg0VwdYyFsIzDtRZj7Rk/xXhpWQdxN0llYkPr8EBr56mpUsyCCpzeh6GLPG
         cefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzA2HODJ3urRt2X8rONRdz7gI3c1lYKAb1hXmonKPmc=;
        b=RHrJkae9DHnu7NdIFxu+5+aSYZWEnHpJ8o/0RqqD7u0qP/iPOMFYAaAvDIRW/q8y7P
         ghMA+FhEK+bEpwAEWh1qaswNzbkZfyhUi6McYOpyzYY45qSb+GqnQy8d1ia3tEc1jNvE
         NBGOUVdTHOmJ7AI0ImNQaG8TNmE1yVRJXNIQHmOLRXifNnhchhJU9aws1Z788RSrXlgN
         3JH2N+Vf1qGP4OVi7Z24oygPszmClXZTQd0VHrldF6dx5pOq7uI0RUszPE/kUPxa7K8I
         hwRephPTNVGHgBOebrGWQkp3oWHie60lJLge4RjauWcku4xq+IV3wNIQy1xNsjrxVg7d
         bVtA==
X-Gm-Message-State: APjAAAW3dzWCLpHKHPJQVmwSo5hvHmtaKevAaqsQDEZyp9qlBKeyW7PN
        eWBWwijImDHixRG+MWEXNgiVX/fKMM8Zk6dKKujeRw==
X-Google-Smtp-Source: APXvYqzhReT8uMMUw+UOSkW3TsVG1ZyMF35bjl/WDLEw9BjPcWDYBFT6RN4OpXo3JnKhdWlv2Bm7aWwi2rZCpFPKteg=
X-Received: by 2002:a9d:6256:: with SMTP id i22mr1951240otk.139.1566259242824;
 Mon, 19 Aug 2019 17:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com> <20190724001100.133423-2-saravanak@google.com>
 <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com> <CAGETcx8Q27+Jnz+rHtt33muMV6U+S3cmKh02Ok_Ds_ZzfBqhrg@mail.gmail.com>
 <522e8375-5070-f579-6509-3e44fe66768e@gmail.com>
In-Reply-To: <522e8375-5070-f579-6509-3e44fe66768e@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 19 Aug 2019 17:00:06 -0700
Message-ID: <CAGETcx-9Bera+nU-3=ZNpHqdqKxO0TmNuVUsCMQ-yDm1VXn5zA@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 8:38 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 8/15/19 6:50 PM, Saravana Kannan wrote:
> > On Wed, Aug 7, 2019 at 7:04 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >>> Date: Tue, 23 Jul 2019 17:10:54 -0700
> >>> Subject: [PATCH v7 1/7] driver core: Add support for linking devices during
> >>>  device addition
> >>> From: Saravana Kannan <saravanak@google.com>
> >>>
> >>> When devices are added, the bus might want to create device links to track
> >>> functional dependencies between supplier and consumer devices. This
> >>> tracking of supplier-consumer relationship allows optimizing device probe
> >>> order and tracking whether all consumers of a supplier are active. The
> >>> add_links bus callback is added to support this.
> >>
> >> Change above to:
> >>
> >> When devices are added, the bus may create device links to track which
> >> suppliers a consumer device depends upon.  This
> >> tracking of supplier-consumer relationship may be used to defer probing
> >> the driver of a consumer device before the driver(s) for its supplier device(s)
> >> are probed.  It may also be used by a supplier driver to determine if
> >> all of its consumers have been successfully probed.
> >> The add_links bus callback is added to create the supplier device links
> >>
> >>>
> >>> However, when consumer devices are added, they might not have a supplier
> >>> device to link to despite needing mandatory resources/functionality from
> >>> one or more suppliers. A waiting_for_suppliers list is created to track
> >>> such consumers and retry linking them when new devices get added.
> >>
> >> Change above to:
> >>
> >> If a supplier device has not yet been created when the consumer device attempts
> >> to link it, the consumer device is added to the wait_for_suppliers list.
> >> When supplier devices are created, the supplier device link will be added to
> >> the relevant consumer devices on the wait_for_suppliers list.
> >>
> >
> > I'll take these commit text suggestions if we decide to revert the
> > entire series at the end of this review.
> >
> >>>
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>> ---
> >>>  drivers/base/core.c    | 83 ++++++++++++++++++++++++++++++++++++++++++
> >>>  include/linux/device.h | 14 +++++++
> >>>  2 files changed, 97 insertions(+)
> >>>
> >>> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >>> index da84a73f2ba6..1b4eb221968f 100644
> >>> --- a/drivers/base/core.c
> >>> +++ b/drivers/base/core.c
> >>> @@ -44,6 +44,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
> >>>  #endif
> >>>
> >>>  /* Device links support. */
> >>> +static LIST_HEAD(wait_for_suppliers);
> >>> +static DEFINE_MUTEX(wfs_lock);
> >>>
> >>>  #ifdef CONFIG_SRCU
> >>>  static DEFINE_MUTEX(device_links_lock);
> >>> @@ -401,6 +403,51 @@ struct device_link *device_link_add(struct device *consumer,
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(device_link_add);
> >>>
> >>> +/**
> >>
> >>> + * device_link_wait_for_supplier - Mark device as waiting for supplier
> >>
> >>     * device_link_wait_for_supplier - Add device to wait_for_suppliers list
> >
>
> As a meta-comment, I found this series very hard to understand in the context
> of reading the new code for the first time.  When I read the code again in
> six months or a year or two years it will not be in near term memory and it
> will be as if I am reading it for the first time.  A lot of my suggestions
> for changes of names are in that context -- the current names may be fine
> when one has recently read the code, but not so much when trying to read
> the whole thing again with a blank mind.

Thanks for the context.

> The code also inherits a good deal of complexity because it does not stand
> alone in a nice discrete chunk, but instead delicately weaves into a more
> complex body of code.

I'll take this as a compliment :)

> When I was trying to understand the code, I wrote a lot of additional
> comments within my reply email to provide myself context, information
> about various things, and questions that I needed to answer (or if I
> could not answer to then ask you).  Then I ended up being able to remove
> many of those notes before sending the reply.
>
>
> > I intentionally chose "Mark device..." because that's a better
> > description of the semantics of the function instead of trying to
> > describe the implementation. Whether I'm using a linked list or some
> > other data structure should not be the one line documentation of a
> > function. Unless the function is explicitly about operating on that
> > specific data structure.
>
> I agree with the intent of trying to describe the semantics of a function,
> especially at the API level where other systems (or drivers) would be using
> the function.  But for this case the function is at the implementation level
> and describing explicitly what it is doing makes this much more readable for
> me.

Are you distinguishing between API level vs implementation level based
on the function being "static"/not exported? I believe the earlier
version of this series had this function as an exported API. So maybe
that's why I had it as "Mark device".

> I also find "Mark device" to be vague and not descriptive of what the
> intent is.
>
> >
> >>
> >>
> >>> + * @consumer: Consumer device
> >>> + *
> >>> + * Marks the consumer device as waiting for suppliers to become available. The
> >>> + * consumer device will never be probed until it's unmarked as waiting for
> >>> + * suppliers. The caller is responsible for adding the link to the supplier
> >>> + * once the supplier device is present.
> >>> + *
> >>> + * This function is NOT meant to be called from the probe function of the
> >>> + * consumer but rather from code that creates/adds the consumer device.
> >>> + */
> >>> +static void device_link_wait_for_supplier(struct device *consumer)
> >>> +{
> >>> +     mutex_lock(&wfs_lock);
> >>> +     list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
> >>> +     mutex_unlock(&wfs_lock);
> >>> +}
> >>> +
> >>> +/**
> >>
> >>
> >>> + * device_link_check_waiting_consumers - Try to remove from supplier wait list
> >>> + *
> >>> + * Loops through all consumers waiting on suppliers and tries to add all their
> >>> + * supplier links. If that succeeds, the consumer device is unmarked as waiting
> >>> + * for suppliers. Otherwise, they are left marked as waiting on suppliers,
> >>> + *
> >>> + * The add_links bus callback is expected to return 0 if it has found and added
> >>> + * all the supplier links for the consumer device. It should return an error if
> >>> + * it isn't able to do so.
> >>> + *
> >>> + * The caller of device_link_wait_for_supplier() is expected to call this once
> >>> + * it's aware of potential suppliers becoming available.
> >>
> >> Change above comment to:
> >>
> >>     * device_link_add_supplier_links - add links from consumer devices to
> >>     *                                  supplier devices, leaving any consumer
> >>     *                                  with inactive suppliers on the
> >>     *                                  wait_for_suppliers list
> >
> > I didn't know that the first one line comment could span multiple
> > lines. Good to know.
> >
> >
> >>     * Scan all consumer devices in the devicetree.
> >
> > This function doesn't have anything to do with devicetree. I've
> > intentionally kept all OF related parts out of the driver/core because
> > I hope that other busses can start using this feature too. So I can't
> > take this bit.
>
> My comment is left over from when I was taking notes, trying to understand the
> code.
>
> At the moment, only devicetree is used as a source of the dependency information.
> The comment would better be re-phrased as:
>
>         * Scan all consumer devices in the firmware description of the hardware topology
>

Ok

> I did not ask why this feature is tied to _only_ the platform bus, but will now.

Because devicetree and platform bus the only ones I'm familiar with.
If other busses want to add this, I'd be happy to help with code
and/or direction/review. But I won't pretend to know anything about
ACPI.

> I do not know of any reason that a consumer / supplier relationship can not be
> between devices on different bus types.  Do you know of such a reason?

Yes, it's hypothetically possible. But I haven't seen such a
relationship being defined in DT. Nor somewhere else where this might
be captured. So, how common/realistic is it?

> >
> >>  For any supplier device that
> >>     * is not already linked to the consumer device, add the supplier to the
> >>     * consumer device's device links.
> >>     *
> >>     * If all of a consumer device's suppliers are available then the consumer
> >>     * is removed from the wait_for_suppliers list (if previously on the list).
> >>     * Otherwise the consumer is added to the wait_for_suppliers list (if not
> >>     * already on the list).
> >
> > Honestly, I don't think this is any better than what I already have.
>
> Note that my version of these comments was written while I was reading the code,
> and did not have any big picture understanding yet.  This will likely also be
> the mind set of most everyone who reads this code in the future, once it is
> woven into the kernel.
>
> If you don't like the change, I can revisit it in a later version of the
> patch set.

I'll take in all the ones I feel are reasonable or don't feel strongly
about. We can revisit the rest later.

> >
> >>     * The add_links bus callback must return 0 if it has found and added all
> >>     * the supplier links for the consumer device. It must return an error if
> >>     * it is not able to do so.
> >>     *
> >>     * The caller of device_link_wait_for_supplier() is expected to call this once
> >>     * it is aware of potential suppliers becoming available.
> >>
> >>
> >>
> >>> + */
> >>> +static void device_link_check_waiting_consumers(void)
> >>
> >> Function name is misleading and hides side effects.
> >>
> >> I have not come up with a name that does not hide side effects, but a better
> >> name would be:
> >>
> >>    device_link_add_supplier_links()
> >
> > I kinda agree that it could afford a better name. The current name is
> > too similar to device_links_check_suppliers() and I never liked that.
>
> Naming new fields or variables related to device links looks pretty
> challenging to me, because of the desire to be part of device links
> and not a wart pasted on the side.  So I share the pain in trying
> to find good names.
>
> >
> > Maybe device_link_add_missing_suppliers()?
>
> My first reaction was "yes, that sounds good".  But then I stopped and
> tried to read the name out of context.  The name is not adding the
> missing suppliers, it is saving the information that a supplier is
> not yet available (eg, is "missing").  I struggled in coming up with
> the name that I suggested.  We can keep thinking.

No, this function _IS_ about adding links to suppliers. These
consumers were "saved" as "not yet having the supplier" earlier by
device_link_wait_for_supplier(). This function doesn't do that. This
function is just trying to see if those missing suppliers are present
now and if so adding a link to them from the "saved" consumers. I
think device_link_add_missing_suppliers() is actually a pretty good
name. Let me know what you think now.

>
>
> >
> > I don't think we need "links" repeated twice in the function name.
>
> Yeah, I didn't like that either.
>
>
> > With this suggestion, what side effect is hidden in your opinion? That
> > the fully linked consumer is removed from the "waiting for suppliers"
> > list?
>
> The side effect is that the function does not merely do a check.  It also
> adds missing suppliers to a list.

No, it doesn't do that. I can't keep a list of things that aren't
allocated yet :). In the whole patch series, we only keep a list of things
(consumers) that are waiting on other things (missing suppliers).

> >
> > Maybe device_link_try_removing_from_wfs()?
>
> I like that, other than the fact that it still does not provide a clue
> that the function is potentially adding suppliers to a list.

It doesn't. How would you add a supplier device to a list if the
device itself isn't there? :)

>  I think
> part of the challenge is that the function does two things: (1) a check,
> and (2) potentially adding missing suppliers to a list.  Maybe a simple
> one line comment at the call site, something like:
>
>    /* adds missing suppliers to wfs */
>
>
> >
> > I'll wait for us to agree on a better name here before I change this.
> >
> >>> +{
> >>> +     struct device *dev, *tmp;
> >>> +
> >>> +     mutex_lock(&wfs_lock);
> >>> +     list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
> >>> +                              links.needs_suppliers)
> >>> +             if (!dev->bus->add_links(dev))
> >>> +                     list_del_init(&dev->links.needs_suppliers);
> >>
> >> Empties dev->links.needs_suppliers, but does not remove dev from
> >> wait_for_suppliers list.  Where does that happen?
> >
> > I'll chalk this up to you having a long day or forgetting your coffee
> > :) list_del_init() does both of those things because needs_suppliers
> > is the node and wait_for_suppliers is the list.
>
> Yes, brain mis-fire on my part.  I'll have to go back and look at the
> list related code again.
>
>
> >
> >>
> >>> +     mutex_unlock(&wfs_lock);
> >>> +}
> >>> +
> >>>  static void device_link_free(struct device_link *link)
> >>>  {
> >>>       while (refcount_dec_not_one(&link->rpm_active))
> >>> @@ -535,6 +582,19 @@ int device_links_check_suppliers(struct device *dev)
> >>>       struct device_link *link;
> >>>       int ret = 0;
> >>>
> >>> +     /*
> >>> +      * If a device is waiting for one or more suppliers (in
> >>> +      * wait_for_suppliers list), it is not ready to probe yet. So just
> >>> +      * return -EPROBE_DEFER without having to check the links with existing
> >>> +      * suppliers.
> >>> +      */
> >>
> >> Change comment to:
> >>
> >>         /*
> >>          * Device waiting for supplier to become available is not allowed
> >>          * to probe
> >>          */
> >
> > Po-tay-to. Po-tah-to? I think my comment is just as good.
>
> If just as good and shorter, then better.
>
> Also the original says "it is not ready to probe".  That is not correct.  It
> is ready to probe, it is just that the probe attempt will return -EPROBE_DEFER.
> Nit picky on my part, but tiny things like that mean I have to think harder.
> I have to think "why is it not ready to probe?".  Maybe my version should have
> instead been something like:
>
>         * Device waiting for supplier to become available will return
>         * -EPROBE_DEFER if probed.  Avoid the unneeded processing.
>
> >
> >>> +     mutex_lock(&wfs_lock);
> >>> +     if (!list_empty(&dev->links.needs_suppliers)) {
> >>> +             mutex_unlock(&wfs_lock);
> >>> +             return -EPROBE_DEFER;
> >>> +     }
> >>> +     mutex_unlock(&wfs_lock);
> >>> +
> >>>       device_links_write_lock();
> >>
> >> Update Documentation/driver-api/device_link.rst to reflect the
> >> check of &dev->links.needs_suppliers in device_links_check_suppliers().
> >
> > Thanks! Will do.
> >
> >>
> >>>
> >>>       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> >>> @@ -812,6 +872,10 @@ static void device_links_purge(struct device *dev)
> >>>  {
> >>>       struct device_link *link, *ln;
> >>>
> >>> +     mutex_lock(&wfs_lock);
> >>> +     list_del(&dev->links.needs_suppliers);
> >>> +     mutex_unlock(&wfs_lock);
> >>> +
> >>>       /*
> >>>        * Delete all of the remaining links from this device to any other
> >>>        * devices (either consumers or suppliers).
> >>> @@ -1673,6 +1737,7 @@ void device_initialize(struct device *dev)
> >>>  #endif
> >>>       INIT_LIST_HEAD(&dev->links.consumers);
> >>>       INIT_LIST_HEAD(&dev->links.suppliers);
> >>> +     INIT_LIST_HEAD(&dev->links.needs_suppliers);
> >>>       dev->links.status = DL_DEV_NO_DRIVER;
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(device_initialize);
> >>> @@ -2108,6 +2173,24 @@ int device_add(struct device *dev)
> >>>                                            BUS_NOTIFY_ADD_DEVICE, dev);
> >>>
> >>>       kobject_uevent(&dev->kobj, KOBJ_ADD);
> >>
> >>> +
> >>> +     /*
> >>> +      * Check if any of the other devices (consumers) have been waiting for
> >>> +      * this device (supplier) to be added so that they can create a device
> >>> +      * link to it.
> >>> +      *
> >>> +      * This needs to happen after device_pm_add() because device_link_add()
> >>> +      * requires the supplier be registered before it's called.
> >>> +      *
> >>> +      * But this also needs to happe before bus_probe_device() to make sure
> >>> +      * waiting consumers can link to it before the driver is bound to the
> >>> +      * device and the driver sync_state callback is called for this device.
> >>> +      */
> >>
> >>         /*
> >>          * Add links to dev from any dependent consumer that has dev on it's
> >>          * list of needed suppliers
> >
> > There is no list of needed suppliers.
>
> "the other devices (consumers) have been waiting for this device (supplier)".
> Isn't that a list of needed suppliers?

No, that's a list of consumers that needs_suppliers.

> >
> >> (links.needs_suppliers).  Device_pm_add()
> >>          * must have previously registered dev to allow the links to be added.
> >>          *
> >>          * The consumer links must be created before dev is probed because the
> >>          * sync_state callback for dev will use the consumer links.
> >>          */
> >
> > I think what I wrote is just as clear.
>
> The original comment is vague.  It does not explain why consumer links must be
> created before the probe.  I had to go off and read other code to determine
> why that is true.
>
> And again, brevity is better if otherwise just as clear.
>
>
> >
> >>
> >>> +     device_link_check_waiting_consumers();
> >>> +
> >>> +     if (dev->bus && dev->bus->add_links && dev->bus->add_links(dev))
> >>> +             device_link_wait_for_supplier(dev);
> >>> +
> >>>       bus_probe_device(dev);
> >>>       if (parent)
> >>>               klist_add_tail(&dev->p->knode_parent,
> >>> diff --git a/include/linux/device.h b/include/linux/device.h
> >>> index c330b75c6c57..5d70babb7462 100644
> >>> --- a/include/linux/device.h
> >>> +++ b/include/linux/device.h
> >>> @@ -78,6 +78,17 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
> >>>   *           -EPROBE_DEFER it will queue the device for deferred probing.
> >>>   * @uevent:  Called when a device is added, removed, or a few other things
> >>>   *           that generate uevents to add the environment variables.
> >>
> >>> + * @add_links:       Called, perhaps multiple times per device, after a device is
> >>> + *           added to this bus.  The function is expected to create device
> >>> + *           links to all the suppliers of the input device that are
> >>> + *           available at the time this function is called.  As in, the
> >>> + *           function should NOT stop at the first failed device link if
> >>> + *           other unlinked supplier devices are present in the system.
> >>
> >> * @add_links:   Called after a device is added to this bus.
> >
> > Why are you removing the "perhaps multiple times" part? that's true
> > and that's how some of the other ops are documented.
>
> I didn't remove it.  I rephrased it with a little bit more explanation as
> "If some suppliers are not yet available, this function will be
> called again when the suppliers become available." (below).
>
>
> >
> >>  The function is
> >> *               expected to create device links to all the suppliers of the
> >> *               device that are available at the time this function is called.
> >> *               The function must NOT stop at the first failed device link if
> >> *               other unlinked supplier devices are present in the system.
> >> *               If some suppliers are not yet available, this function will be
> >> *               called again when the suppliers become available.
> >>
> >> but add_links() not needed, so moving this comment to of_link_to_suppliers()
> >
> > Sorry, I'm not sure I understand. Can you please explain what you are
> > trying to say? of_link_to_suppliers() is just one implementation of
> > add_links(). The comment above is try for any bus trying to implement
> > add_links().
>
> This is conflating bus with the source of the firmware description of the
> hardware topology.  For drivers that use various APIs to access firmware
> description of topology that may be either devicetree or ACPI the access
> is done via fwnode_operations, based on struct device.fwnode (if I recall
> properly).
>
> I failed to completely address why add_links() is not needed.  The answer
> is that there should be a single function called for all buses.  Then
> the proper firmware data source would be accessed via a struct fwnode_operations.
>
> I think I left this out because I had not yet asked why this feature is
> tied only to the platform bus.  Which I asked earlier in this reply.

Thanks for the pointer about fwnode and fwnode_operations. I wasn't
aware of those. I see where you are going with this. I see a couple of
problems with this approach though:

1. How you interpret the properties of a fwnode is specific to the fw
type. The clocks DT property isn't going to have the same definition
in ACPI or some other firmware. Heck, I don't know if ACPI even has a
clocks like property. So have one function to parse all the FW types
doesn't make a lot of sense.

2. If this common code is implemented as part of driver/base/, then at
a minimum, I'll have to check if a fwnode is a DT node before I start
interpreting the properties of a device's fwnode. But that means I'll
have to include linux/of.h to use is_of_node(). I don't like having
driver/base code depend on OF or platform or ACPI headers.

3. The supplier info doesn't always need to come from a firmware. So I
don't want to limit it to that?

Also, I don't necessarily see this as conflating firmware (DT, ACPI,
etc) with the bus (platform bus, ACPI bus, PCI bus). Whoever creates
the device seems like the entity best suited to figure out the
suppliers of the device (apart from the driver, obviously). So the bus
deciding the suppliers doesn't seem wrong to me.

In this specific case, I'm trying to address DT for now and leaving
ACPI to whoever else wants to add device links based on ACPI data.
Most OF/DT based devices end up in platform bus. So I'm just handling
this in platform bus. If some other person wants this to work for ACPI
bus or PCI bus, they are welcome to implement add_links() for those
busses? I'm nowhere close to an expert on those.

> >
> >>
> >>
> >>> + *
> >>> + *           Return 0 if device links have been successfully created to all
> >>> + *           the suppliers of this device.  Return an error if some of the
> >>> + *           suppliers are not yet available and this function needs to be
> >>> + *           reattempted in the future.
> >>
> >> *
> >> *               Return 0 if device links have been successfully created to all
> >> *               the suppliers of this device.  Return an error if some of the
> >> *               suppliers are not yet available.
> >>
> >>
> >>>   * @probe:   Called when a new device or driver add to this bus, and callback
> >>>   *           the specific driver's probe to initial the matched device.
> >>>   * @remove:  Called when a device removed from this bus.
> >>> @@ -122,6 +133,7 @@ struct bus_type {
> >>>
> >>>       int (*match)(struct device *dev, struct device_driver *drv);
> >>>       int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
> >>
> >>
> >>> +     int (*add_links)(struct device *dev);
> >>
> >>               ^^^^^^^^^  add_supplier              ???
> >>               ^^^^^^^^^  add_suppliers             ???
> >>
> >>               ^^^^^^^^^  link_suppliers            ???
> >>
> >>               ^^^^^^^^^  add_supplier_dependency   ???
> >>               ^^^^^^^^^  add_supplier_dependencies ???
> >> add_links() not needed
> >
> > add_links() was an intentional decision. There's no requirement that
> > the bus should only create links from this device to its suppliers. If
> > the bus also knows the consumers of this device (dev), then it
> > can/should add those too.
>
> Is creating links to consumers of this device implemented in this patch
> series?  If so, I overlooked it and will have to consider how that
> fits in to the design.
>
>
> > So, it shouldn't have "suppliers" in the
> > name.
> >
> >>>       int (*probe)(struct device *dev);
> >>>       int (*remove)(struct device *dev);
> >>>       void (*shutdown)(struct device *dev);
> >>
> >>
> >>
> >>
> >>> @@ -893,11 +905,13 @@ enum dl_dev_state {
> >>>   * struct dev_links_info - Device data related to device links.
> >>>   * @suppliers: List of links to supplier devices.
> >>>   * @consumers: List of links to consumer devices.
> >>
> >>> + * @needs_suppliers: Hook to global list of devices waiting for suppliers.
> >>
> >>     * @needs_suppliers: List of devices deferring probe until supplier drivers
> >>     *                   are successfully probed.
> >
> > It's "need suppliers". As in, this is a device that "needs suppliers".
> > So, no, this is not a list. This is a node in a list. And all "nodes
> > in a list" are documented as "Hook" in rest of places in this file. So
> > I think the documentation is correct as is.
>
> Aha, I got confused about that while trying to keep everything straight.
>
> Somehow I managed to conflate needs_suppliers with the links between
> consumers and suppliers that are create via device_link_add().
>
> So original comment is fine.
>
> It is getting late, so I'll continue with patches 2 and 3 tomorrow.
>

Thanks for the review.

-Saravana
