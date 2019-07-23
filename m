Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891B37210E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391849AbfGWUtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 16:49:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33368 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfGWUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:49:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so45450484otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8f2Ta9iQpdbzDFNjSTEAOZef+ZrvFOzQiYTB6S5m3GA=;
        b=ts+Jr7Y8jDBQpkgB7PVhyjG8HMB5P1jNdQbQ5m14yln7eF4vSvx8qnghXBKqRXeUub
         40jxFaJZANUtyVGq0W7FRqbs4IOyCRXqSpjRnXXgdcCTiIl763G6/nDaWoomU1oCuqqZ
         4hyB1+zl+Kv4cLRdc9QP9xZi6dFmdZLAdkBwZ9kzki9TQFpyTJ/MwHdBkaMRtPUXaDfE
         XgJSWSgu6weEHhegxKjhrXjVsuuKZ5AFqr9PdUSOuvI18zdhaMkZfBz96YGdTaORTd/k
         /741lyO5a46cmB/PI2d6eAEd3muk+AhHG5JW9tZkb9L3KP2LAr+SipM8OwCVlqGHP7Qv
         ysuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8f2Ta9iQpdbzDFNjSTEAOZef+ZrvFOzQiYTB6S5m3GA=;
        b=a9Vhlj+7vBp8S+olccAOg0pZYO7HKB8LmKjsU6mYuARwu2uY++L4LZRasOoK4/h+ax
         GJSkTQuXtI59H7QRrRl0itRuqr2EZRgJ2ZAue/IfdxyK9JaGmasMFFFVP5zq24nikFTq
         nvbldYQOxQHhbF2ZnPNu8tY5qYmxl1xpmxbRt4IymTdUsRnxvYiNPwAN777SGKggwPlA
         Q/z2GUp+roSYaSKpHnL8lUnItpYyYIJLHHqRmnIf647KBTwHr58dwI27t+CrwM2bJ2Qa
         F85wRyceFF/GfdDx5hOIy7C5kaCRCOvj3fBCKRjZ7Ku06n7R5r648Lxo4ZI0lKEf+LDh
         T97Q==
X-Gm-Message-State: APjAAAUe9WfWvstLKFJknSMLbdS5TueMbPOK4YZV9NWY4jgllPYQy5vi
        ZFW8uFJoACiS7oNoOPNFfUGl0mMSa2vsbeUW3DzavA==
X-Google-Smtp-Source: APXvYqyPzdvDqTZ+cfvvR+VInQlk3TLGF3D5fbLh9/+vZ1vwHox96XSgIbOgZU/x0UBf23zOZaqAsnRTWlapePbUNHQ=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr7149188otp.225.1563914946426;
 Tue, 23 Jul 2019 13:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com> <20190720061647.234852-4-saravanak@google.com>
 <CAL_JsqK9GTxxxjhhWwqxOW9XERFziu2O71ETV2RhXb7B1WFY2g@mail.gmail.com>
In-Reply-To: <CAL_JsqK9GTxxxjhhWwqxOW9XERFziu2O71ETV2RhXb7B1WFY2g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 13:48:30 -0700
Message-ID: <CAGETcx-hCrUvY5whZBihueqqCxmF3oDjFybjmoo3JUu87iiiEw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:06 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sat, Jul 20, 2019 at 12:17 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add device-links after the devices are created (but before they are
> > probed) by looking at common DT bindings like clocks and
> > interconnects.
>
> The structure now looks a lot better to me. A few minor things below.

Thanks.

> >
> > Automatically adding device-links for functional dependencies at the
> > framework level provides the following benefits:
> >
> > - Optimizes device probe order and avoids the useless work of
> >   attempting probes of devices that will not probe successfully
> >   (because their suppliers aren't present or haven't probed yet).
> >
> >   For example, in a commonly available mobile SoC, registering just
> >   one consumer device's driver at an initcall level earlier than the
> >   supplier device's driver causes 11 failed probe attempts before the
> >   consumer device probes successfully. This was with a kernel with all
> >   the drivers statically compiled in. This problem gets a lot worse if
> >   all the drivers are loaded as modules without direct symbol
> >   dependencies.
> >
> > - Supplier devices like clock providers, interconnect providers, etc
> >   need to keep the resources they provide active and at a particular
> >   state(s) during boot up even if their current set of consumers don't
> >   request the resource to be active. This is because the rest of the
> >   consumers might not have probed yet and turning off the resource
> >   before all the consumers have probed could lead to a hang or
> >   undesired user experience.
> >
> >   Some frameworks (Eg: regulator) handle this today by turning off
> >   "unused" resources at late_initcall_sync and hoping all the devices
> >   have probed by then. This is not a valid assumption for systems with
> >   loadable modules. Other frameworks (Eg: clock) just don't handle
> >   this due to the lack of a clear signal for when they can turn off
> >   resources. This leads to downstream hacks to handle cases like this
> >   that can easily be solved in the upstream kernel.
> >
> >   By linking devices before they are probed, we give suppliers a clear
> >   count of the number of dependent consumers. Once all of the
> >   consumers are active, the suppliers can turn off the unused
> >   resources without making assumptions about the number of consumers.
> >
> > By default we just add device-links to track "driver presence" (probe
> > succeeded) of the supplier device. If any other functionality provided
> > by device-links are needed, it is left to the consumer/supplier
> > devices to change the link when they probe.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   5 +
> >  drivers/of/platform.c                         | 158 ++++++++++++++++++
> >  2 files changed, 163 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 138f6664b2e2..109b4310844f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3141,6 +3141,11 @@
> >                         This can be set from sysctl after boot.
> >                         See Documentation/sysctl/vm.txt for details.
> >
> > +       of_devlink      [KNL] Make device links from common DT bindings. Useful
> > +                       for optimizing probe order and making sure resources
> > +                       aren't turned off before the consumer devices have
> > +                       probed.
> > +
> >         ohci1394_dma=early      [HW] enable debugging via the ohci1394 driver.
> >                         See Documentation/debugging-via-ohci1394.txt for more
> >                         info.
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 04ad312fd85b..88a2086e26fa 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -509,6 +509,163 @@ int of_platform_default_populate(struct device_node *root,
> >  }
> >  EXPORT_SYMBOL_GPL(of_platform_default_populate);
> >
> > +bool of_link_is_valid(struct device_node *con, struct device_node *sup)
> > +{
> > +       of_node_get(sup);
> > +       /*
> > +        * Don't allow linking a device node as a consumer of one of its
> > +        * descendant nodes. By definition, a child node can't be a functional
> > +        * dependency for the parent node.
> > +        */
> > +       while (sup) {
> > +               if (sup == con) {
> > +                       of_node_put(sup);
> > +                       return false;
> > +               }
> > +               sup = of_get_next_parent(sup);
> > +       }
> > +       return true;
> > +}
> > +
> > +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> > +{
> > +       struct platform_device *sup_dev;
> > +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> > +       int ret = 0;
> > +
> > +       /*
> > +        * Since we are trying to create device links, we need to find
> > +        * the actual device node that owns this supplier phandle.
> > +        * Often times it's the same node, but sometimes it can be one
> > +        * of the parents. So walk up the parent till you find a
> > +        * device.
> > +        */
> > +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> > +               sup_np = of_get_next_parent(sup_np);
> > +       if (!sup_np)
> > +               return 0;
> > +
> > +       if (!of_link_is_valid(dev->of_node, sup_np)) {
> > +               of_node_put(sup_np);
> > +               return 0;
> > +       }
> > +       sup_dev = of_find_device_by_node(sup_np);
> > +       of_node_put(sup_np);
> > +       if (!sup_dev)
> > +               return -ENODEV;
> > +       if (!device_link_add(dev, &sup_dev->dev, dl_flags))
> > +               ret = -ENODEV;
> > +       put_device(&sup_dev->dev);
> > +       return ret;
> > +}
> > +
> > +static struct device_node *parse_prop_cells(struct device_node *np,
> > +                                           const char *prop, int i,
>
> I like 'i' for for loops, but less so for function params. Perhaps
> 'index' instead like of_parse_phandle_with_args.

Sounds good.

>
> > +                                           const char *binding,
> > +                                           const char *cell)
> > +{
> > +       struct of_phandle_args sup_args;
> > +
> > +       if (!i && strcmp(prop, binding))
>
> Why the '!i' test?

To avoid a string comparison for every index. It's kinda wasteful once
the first index passes.

> > +               return NULL;
> > +
> > +       if (of_parse_phandle_with_args(np, binding, cell, i, &sup_args))
> > +               return NULL;
> > +
> > +       return sup_args.np;
> > +}
> > +
> > +static struct device_node *parse_clocks(struct device_node *np,
> > +                                       const char *prop, int i)
> > +{
> > +       return parse_prop_cells(np, prop, i, "clocks", "#clock-cells");
> > +}
> > +
> > +static struct device_node *parse_interconnects(struct device_node *np,
> > +                                              const char *prop, int i)
> > +{
> > +       return parse_prop_cells(np, prop, i, "interconnects",
> > +                               "#interconnect-cells");
> > +}
> > +
> > +static int strcmp_suffix(const char *str, const char *suffix)
> > +{
> > +       unsigned int len, suffix_len;
> > +
> > +       len = strlen(str);
> > +       suffix_len = strlen(suffix);
> > +       if (len <= suffix_len)
> > +               return -1;
> > +       return strcmp(str + len - suffix_len, suffix);
> > +}
> > +
> > +static struct device_node *parse_regulators(struct device_node *np,
> > +                                           const char *prop, int i)
> > +{
> > +       if (i || strcmp_suffix(prop, "-supply"))
> > +               return NULL;
> > +
> > +       return of_parse_phandle(np, prop, 0);
> > +}
> > +
> > +/**
> > + * struct supplier_bindings - Information for parsing supplier DT binding
> > + *
> > + * @parse_prop:                If the function cannot parse the property, return NULL.
> > + *                     Otherwise, return the phandle listed in the property
> > + *                     that corresponds to index i.
> > + */
> > +struct supplier_bindings {
> > +       struct device_node *(*parse_prop)(struct device_node *np,
> > +                                         const char *name, int i);
> > +};
> > +
> > +struct supplier_bindings bindings[] = {
>
> static const

Will do.

>
> > +       { .parse_prop = parse_clocks, },
> > +       { .parse_prop = parse_interconnects, },
> > +       { .parse_prop = parse_regulators, },
> > +       { },
> > +};
> > +
> > +static bool of_link_property(struct device *dev, struct device_node *con_np,
> > +                            const char *prop)
> > +{
> > +       struct device_node *phandle;
> > +       struct supplier_bindings *s = bindings;
> > +       unsigned int i = 0;
> > +       bool done = true;
> > +
> > +       while (!i && s->parse_prop) {
>
> Using 'i' is a little odd. Perhaps a 'matched' bool would be easier to read.

That's how I wrote it first (locally) and then redid it this way
because the bool felt very superfluous. I don't think this is that
hard to understand.

> > +               while ((phandle = s->parse_prop(con_np, prop, i))) {
> > +                       i++;
> > +                       if (of_link_to_phandle(dev, phandle))
> > +                               done = false;
>
> Just return here. No point in continuing as 'done' is never set back to true.

Actually, there is a point for this. Say Device-C depends on suppliers
Device-S1 and Device-S2 and they are listed in DT in that order.

Say, S1 gets populated after late_initcall_sync but S2 is probes way
before that. If I don't continue past a "failed linking" to S1 and
also link up to S2, then S2 will get a sync_state() callback before C
is probed. So I have to go through all possible suppliers and as many
as possible.

Let me add a comment about this somewhere in the code (probably the
header that defines the add_links() ops).

-Saravana

> > +               }
> > +               s++;
> > +       }
> > +       return done ? 0 : -ENODEV;
> > +}
> > +
> > +static bool of_devlink;
> > +core_param(of_devlink, of_devlink, bool, 0);
> > +
> > +static int of_link_to_suppliers(struct device *dev)
> > +{
> > +       struct property *p;
> > +       bool done = true;
> > +
> > +       if (!of_devlink)
> > +               return 0;
> > +       if (unlikely(!dev->of_node))
> > +               return 0;
> > +
> > +       for_each_property_of_node(dev->of_node, p)
> > +               if (of_link_property(dev, dev->of_node, p->name))
> > +                       done = false;
> > +
> > +       return done ? 0 : -ENODEV;
> > +}
> > +
> >  #ifndef CONFIG_PPC
> >  static const struct of_device_id reserved_mem_matches[] = {
> >         { .compatible = "qcom,rmtfs-mem" },
> > @@ -524,6 +681,7 @@ static int __init of_platform_default_populate_init(void)
> >         if (!of_have_populated_dt())
> >                 return -ENODEV;
> >
> > +       platform_bus_type.add_links = of_link_to_suppliers;
> >         /*
> >          * Handle certain compatibles explicitly, since we don't want to create
> >          * platform_devices for every node in /reserved-memory with a
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
