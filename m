Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6B8F895
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 03:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfHPBvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 21:51:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41295 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHPBvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:51:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so8227165ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 18:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9NU7HcknVz/HqwVtJuvmbgSez9Bt2QNTH8TWaCx5Rc=;
        b=qniNgwpy2X5OOw8pdbzL8Rp+hPpWipGI2uvT8v+EoBZ4u91C0W0vvlasn/zh/6A45b
         3nj16JfS7cM7dUcWYM3ffLSplsAPgaiblkBxtv8VqlNUEX6/YSRHf+JD1Pf2MUvMS7H3
         3k23XQjBfdLU6Ve8w4fTj6z03VTomQm69FDQUyvFDoCJyln/gWm9esu9pyMe+qq6Auq9
         kVnZk1RVtvZNPCbznkgsolQVSXbW+fRdek0JJWeRXRuSTI5jpI/TrT024U19XxjVP5Qb
         kDY9XAcqwzam/h8GmX9HPiELdiC3V0TbSeQ2xIvw1vVW+BbApCpC7TzRNPdKo/fkbkae
         4vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9NU7HcknVz/HqwVtJuvmbgSez9Bt2QNTH8TWaCx5Rc=;
        b=NvdVKJLaNs1RYdm5nJWBcGV91BuxsOH1u2yWuOVjm89KUugZKIbfKeBOJjfZ5eUGv6
         UEsjPjqopJVs2Un1UHLVI22XlJXgPY0wwRtsZrFKlRxMsuYsNlwtpDGq4R4wkyzG3AOz
         8T3NcJiun/J0dBImD2vHkWdPrYCfmdwCmAEYxmeHscqG5zJ5RIi4MA+KCgZdJCbJriGi
         adg3LGfS9picAmtAHDTfxQB6X7V/kfLpWyWcQsfIkzLDYjz4rkmrdUlf1vdYjf9iPy4t
         w3/GdjFH9el74ovxSI5jiY0yoCOdMnfJC2R414vL7pjt/RaB319EDmWcF+dcvaX7FfVa
         /rgg==
X-Gm-Message-State: APjAAAVkPuktG9VSAiwZzultQzORfkq/Tcrin2M/XoRNJDXfNkMn5mxC
        RWHhaGHB7tkWfMspshOtWNlgvmyDdFUVlaVH7cLHXw==
X-Google-Smtp-Source: APXvYqwlCWT51OaDRl2VOd03bODXapHcsplc+iKh3g38gAw7/ZYVqYbsptx+6hGMlj9Et22XBQW5rr9bHLivNZKjn6U=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr5425168otp.236.1565920261211;
 Thu, 15 Aug 2019 18:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190731221721.187713-1-saravanak@google.com> <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
 <CAGETcx8LqeOXD5zPsLuxoG5pR9VZ_v=PQfRf-aFwCSaW4kwoxA@mail.gmail.com> <7a0ee940-f81f-36b9-93e7-2b4c242360c9@gmail.com>
In-Reply-To: <7a0ee940-f81f-36b9-93e7-2b4c242360c9@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Aug 2019 18:50:25 -0700
Message-ID: <CAGETcx_UxNV_Qk79es0SJ3L0yAtFRpOjPcU7e5Cje6UPbp5adQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe ordering
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

On Fri, Aug 9, 2019 at 10:20 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 8/9/19 10:00 PM, Saravana Kannan wrote:
> > On Fri, Aug 9, 2019 at 7:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> Hi Saravana,
> >>
> >> On 7/31/19 3:17 PM, Saravana Kannan wrote:
> >>> Add device-links to track functional dependencies between devices
> >>> after they are created (but before they are probed) by looking at
> >>> their common DT bindings like clocks, interconnects, etc.
> >>>
> >>> Having functional dependencies automatically added before the devices
> >>> are probed, provides the following benefits:
> >>>
> >>> - Optimizes device probe order and avoids the useless work of
> >>>   attempting probes of devices that will not probe successfully
> >>>   (because their suppliers aren't present or haven't probed yet).
> >>>
> >>>   For example, in a commonly available mobile SoC, registering just
> >>>   one consumer device's driver at an initcall level earlier than the
> >>>   supplier device's driver causes 11 failed probe attempts before the
> >>>   consumer device probes successfully. This was with a kernel with all
> >>>   the drivers statically compiled in. This problem gets a lot worse if
> >>>   all the drivers are loaded as modules without direct symbol
> >>>   dependencies.
> >>>
> >>> - Supplier devices like clock providers, interconnect providers, etc
> >>>   need to keep the resources they provide active and at a particular
> >>>   state(s) during boot up even if their current set of consumers don't
> >>>   request the resource to be active. This is because the rest of the
> >>>   consumers might not have probed yet and turning off the resource
> >>>   before all the consumers have probed could lead to a hang or
> >>>   undesired user experience.
> >>>
> >>>   Some frameworks (Eg: regulator) handle this today by turning off
> >>>   "unused" resources at late_initcall_sync and hoping all the devices
> >>>   have probed by then. This is not a valid assumption for systems with
> >>>   loadable modules. Other frameworks (Eg: clock) just don't handle
> >>>   this due to the lack of a clear signal for when they can turn off
> >>>   resources. This leads to downstream hacks to handle cases like this
> >>>   that can easily be solved in the upstream kernel.
> >>>
> >>>   By linking devices before they are probed, we give suppliers a clear
> >>>   count of the number of dependent consumers. Once all of the
> >>>   consumers are active, the suppliers can turn off the unused
> >>>   resources without making assumptions about the number of consumers.
> >>>
> >>> By default we just add device-links to track "driver presence" (probe
> >>> succeeded) of the supplier device. If any other functionality provided
> >>> by device-links are needed, it is left to the consumer/supplier
> >>> devices to change the link when they probe.
> >>>
> >>> v1 -> v2:
> >>> - Drop patch to speed up of_find_device_by_node()
> >>> - Drop depends-on property and use existing bindings
> >>>
> >>> v2 -> v3:
> >>> - Refactor the code to have driver core initiate the linking of devs
> >>> - Have driver core link consumers to supplier before it's probed
> >>> - Add support for drivers to edit the device links before probing
> >>>
> >>> v3 -> v4:
> >>> - Tested edit_links() on system with cyclic dependency. Works.
> >>> - Added some checks to make sure device link isn't attempted from
> >>>   parent device node to child device node.
> >>> - Added way to pause/resume sync_state callbacks across
> >>>   of_platform_populate().
> >>> - Recursively parse DT node to create device links from parent to
> >>>   suppliers of parent and all child nodes.
> >>>
> >>> v4 -> v5:
> >>> - Fixed copy-pasta bugs with linked list handling
> >>> - Walk up the phandle reference till I find an actual device (needed
> >>>   for regulators to work)
> >>> - Added support for linking devices from regulator DT bindings
> >>> - Tested the whole series again to make sure cyclic dependencies are
> >>>   broken with edit_links() and regulator links are created properly.
> >>>
> >>> v5 -> v6:
> >>> - Split, squashed and reordered some of the patches.
> >>> - Refactored the device linking code to follow the same code pattern for
> >>>   any property.
> >>>
> >>> v6 -> v7:
> >>> - No functional changes.
> >>> - Renamed i to index
> >>> - Added comment to clarify not having to check property name for every
> >>>   index
> >>> - Added "matched" variable to clarify code. No functional change.
> >>> - Added comments to include/linux/device.h for add_links()
> >>>
> >>> v7 -> v8:
> >>> - Rebased on top of linux-next to handle device link changes in [1]
> >>>
> >>
> >>
> >>> v8 -> v9:
> >>> - Fixed kbuild test bot reported errors (docs and const)
> >>
> >> Some maintainers have strong opinions about whether change logs should be:
> >>
> >>   (1) only in patch 0
> >>   (2) only in the specific patches that are changed
> >>   (3) both in patch 0 and in the specific patches that are changed.
> >>
> >> I can adapt to any of the three styles.  But for style "(1)" please
> >> list which specific patch has changed for each item in the change list.
> >>
> >
> > Thanks for the context Frank. I'm okay with (1) or (2) but I'll stick
> > with (1) for this series. Didn't realize there were options (2) and
> > (3). Since you started reviewing from v7, I'll do that in the future
> > updates? Also, I haven't forgotten your emails. Just tied up with
> > something else for a few days. I'll get to your emails next week.
>
> Yes, starting with future updates is fine, no need to redo the v9
> change logs.
>
> No problem on the timing.  I figured you were busy or away from the
> internet.

I'm replying to your comments on the other 3 patches. Okay with a
majority of them. I'll wait for your reply to see where we settle for
some of the points before I send out any patches though.

For now I'm thinking of sending them as separate clean up patches so
that Greg doesn't have to deal with reverts in his "next" branch. We
can squash them later if we really need to rip out what's in there and
push it again.

-Saravana
