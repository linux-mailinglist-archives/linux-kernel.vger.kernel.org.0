Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93870909B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 22:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfHPUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 16:54:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32816 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfHPUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:54:13 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so8873195iog.0;
        Fri, 16 Aug 2019 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91jQ/1K7kYU4r+hqIk/0GetuOdEdQbgEXI/hU3nF7vU=;
        b=ABWr+53VyUXyNNEsg+h7VNrugvgp4aMgILG0XvZ4p4IcrL7LSAB7uAP/noWWzzJHtQ
         66TTBF1u9Ik/GRsRh2Vd+1jC5pcsT935T571KiY8dotCO3/GWlIpIfi0955DRcNsZpgd
         ecPrO8YBw5qHOc3Y/HBnT+BbxafUibdQX3XkAm8K+K3Zdhi4NmAmZg6vUcWnvxFgI7Vy
         q0UmWPXGp62/cCpBORf70sAEym+zxadzQ8BOwWO92MBEwEkPkXj9Xo3MYdvDup79PZ1c
         KJ1iKgL9Cgo+Q14uAyFB5iphFVNp7cILLY4sWOVlDHsMM3ZDkqEZcosKZF+69MuZ6L9a
         HvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91jQ/1K7kYU4r+hqIk/0GetuOdEdQbgEXI/hU3nF7vU=;
        b=CV+E2Em5NNqJKRzLdzmRsQ7WF5fjMRipHYUeryWlpn3wTECTdAMDoyQzj5R303ck1R
         62ROu1rLn+rfI3PFeT+wejJe5A9tHlqL05C/nVEYXG2m3b2i6LVMJ7At1ChOQWxYAYF4
         YJHtuGS0HqvQDKrFMeAdlzlDeSpW2mA+qsmxng2gZxif/Z2/kvN2Bw7xdZEwOcSP2bda
         B1S6f5tJ+e3YTC8qWoBEo4xqlkBgGg3EhF/Jxiikpp+dr1lJZiJjxoUUi308nC0pa9iW
         qbHFCfuyjg/d2J93IocIU2IKlXDBX/g2UfpZo3IQVM/U+DUA8tNakUoZrx9RJcPuu1q6
         RW5w==
X-Gm-Message-State: APjAAAWJGrkKEJ5Hw/CROPT73dwItUQEjqjiqkN8r41GMsEPSOE0dYbT
        3XNJGVJP7xcbbOtf/yGXFGI=
X-Google-Smtp-Source: APXvYqxvippJOsEiuV0kNa7WUcaLbinY0lyBhEUDUWtkjYDLhywmOx0qgxJcXi+GevMGGs5RL2BEEg==
X-Received: by 2002:a6b:bcc7:: with SMTP id m190mr13337620iof.107.1565988852592;
        Fri, 16 Aug 2019 13:54:12 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-177-58-16.mycingular.net. [166.177.58.16])
        by smtp.gmail.com with ESMTPSA id 6sm7459602iog.40.2019.08.16.13.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 13:54:12 -0700 (PDT)
Subject: Re: [PATCH v9 0/7] Solve postboot supplier cleanup and optimize probe
 ordering
From:   Frank Rowand <frowand.list@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190731221721.187713-1-saravanak@google.com>
 <919b66e9-9708-de34-41cd-e448838b130c@gmail.com>
 <CAGETcx8LqeOXD5zPsLuxoG5pR9VZ_v=PQfRf-aFwCSaW4kwoxA@mail.gmail.com>
 <7a0ee940-f81f-36b9-93e7-2b4c242360c9@gmail.com>
 <CAGETcx_UxNV_Qk79es0SJ3L0yAtFRpOjPcU7e5Cje6UPbp5adQ@mail.gmail.com>
 <183eab70-0eda-f30e-ae25-74355b8b84c9@gmail.com>
 <20190816091056.GA15703@kroah.com>
 <316be6cc-a138-3259-74a0-2cdf281a5646@gmail.com>
 <20190816152343.GA7918@kroah.com>
 <45ec28f3-cec1-bc4f-a281-81751eb99e68@gmail.com>
Message-ID: <fb56bab5-f33a-1bfb-4d18-2f08008a28d9@gmail.com>
Date:   Fri, 16 Aug 2019 13:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <45ec28f3-cec1-bc4f-a281-81751eb99e68@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/19 1:52 PM, Frank Rowand wrote:
> On 8/16/19 8:23 AM, Greg Kroah-Hartman wrote:
>> On Fri, Aug 16, 2019 at 07:05:06AM -0700, Frank Rowand wrote:
>>> i Greg,
>>>
>>> On 8/16/19 2:10 AM, Greg Kroah-Hartman wrote:
>>>> On Thu, Aug 15, 2019 at 08:09:19PM -0700, Frank Rowand wrote:
>>>>> Hi Saravana,
>>>>>
>>>>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
>>>>>> On Fri, Aug 9, 2019 at 10:20 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>>
>>>>>>> On 8/9/19 10:00 PM, Saravana Kannan wrote:
>>>>>>>> On Fri, Aug 9, 2019 at 7:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Saravana,
>>>>>>>>>
>>>>>>>>> On 7/31/19 3:17 PM, Saravana Kannan wrote:
>>>>>>>>>> Add device-links to track functional dependencies between devices
>>>>>>>>>> after they are created (but before they are probed) by looking at
>>>>>>>>>> their common DT bindings like clocks, interconnects, etc.
>>>>>>>>>>
>>>>>>>>>> Having functional dependencies automatically added before the devices
>>>>>>>>>> are probed, provides the following benefits:
>>>>>>>>>>
>>>>>>>>>> - Optimizes device probe order and avoids the useless work of
>>>>>>>>>>   attempting probes of devices that will not probe successfully
>>>>>>>>>>   (because their suppliers aren't present or haven't probed yet).
>>>>>>>>>>
>>>>>>>>>>   For example, in a commonly available mobile SoC, registering just
>>>>>>>>>>   one consumer device's driver at an initcall level earlier than the
>>>>>>>>>>   supplier device's driver causes 11 failed probe attempts before the
>>>>>>>>>>   consumer device probes successfully. This was with a kernel with all
>>>>>>>>>>   the drivers statically compiled in. This problem gets a lot worse if
>>>>>>>>>>   all the drivers are loaded as modules without direct symbol
>>>>>>>>>>   dependencies.
>>>>>>>>>>
>>>>>>>>>> - Supplier devices like clock providers, interconnect providers, etc
>>>>>>>>>>   need to keep the resources they provide active and at a particular
>>>>>>>>>>   state(s) during boot up even if their current set of consumers don't
>>>>>>>>>>   request the resource to be active. This is because the rest of the
>>>>>>>>>>   consumers might not have probed yet and turning off the resource
>>>>>>>>>>   before all the consumers have probed could lead to a hang or
>>>>>>>>>>   undesired user experience.
>>>>>>>>>>
>>>>>>>>>>   Some frameworks (Eg: regulator) handle this today by turning off
>>>>>>>>>>   "unused" resources at late_initcall_sync and hoping all the devices
>>>>>>>>>>   have probed by then. This is not a valid assumption for systems with
>>>>>>>>>>   loadable modules. Other frameworks (Eg: clock) just don't handle
>>>>>>>>>>   this due to the lack of a clear signal for when they can turn off
>>>>>>>>>>   resources. This leads to downstream hacks to handle cases like this
>>>>>>>>>>   that can easily be solved in the upstream kernel.
>>>>>>>>>>
>>>>>>>>>>   By linking devices before they are probed, we give suppliers a clear
>>>>>>>>>>   count of the number of dependent consumers. Once all of the
>>>>>>>>>>   consumers are active, the suppliers can turn off the unused
>>>>>>>>>>   resources without making assumptions about the number of consumers.
>>>>>>>>>>
>>>>>>>>>> By default we just add device-links to track "driver presence" (probe
>>>>>>>>>> succeeded) of the supplier device. If any other functionality provided
>>>>>>>>>> by device-links are needed, it is left to the consumer/supplier
>>>>>>>>>> devices to change the link when they probe.
>>>>>>>>>>
>>>>>>>>>> v1 -> v2:
>>>>>>>>>> - Drop patch to speed up of_find_device_by_node()
>>>>>>>>>> - Drop depends-on property and use existing bindings
>>>>>>>>>>
>>>>>>>>>> v2 -> v3:
>>>>>>>>>> - Refactor the code to have driver core initiate the linking of devs
>>>>>>>>>> - Have driver core link consumers to supplier before it's probed
>>>>>>>>>> - Add support for drivers to edit the device links before probing
>>>>>>>>>>
>>>>>>>>>> v3 -> v4:
>>>>>>>>>> - Tested edit_links() on system with cyclic dependency. Works.
>>>>>>>>>> - Added some checks to make sure device link isn't attempted from
>>>>>>>>>>   parent device node to child device node.
>>>>>>>>>> - Added way to pause/resume sync_state callbacks across
>>>>>>>>>>   of_platform_populate().
>>>>>>>>>> - Recursively parse DT node to create device links from parent to
>>>>>>>>>>   suppliers of parent and all child nodes.
>>>>>>>>>>
>>>>>>>>>> v4 -> v5:
>>>>>>>>>> - Fixed copy-pasta bugs with linked list handling
>>>>>>>>>> - Walk up the phandle reference till I find an actual device (needed
>>>>>>>>>>   for regulators to work)
>>>>>>>>>> - Added support for linking devices from regulator DT bindings
>>>>>>>>>> - Tested the whole series again to make sure cyclic dependencies are
>>>>>>>>>>   broken with edit_links() and regulator links are created properly.
>>>>>>>>>>
>>>>>>>>>> v5 -> v6:
>>>>>>>>>> - Split, squashed and reordered some of the patches.
>>>>>>>>>> - Refactored the device linking code to follow the same code pattern for
>>>>>>>>>>   any property.
>>>>>>>>>>
>>>>>>>>>> v6 -> v7:
>>>>>>>>>> - No functional changes.
>>>>>>>>>> - Renamed i to index
>>>>>>>>>> - Added comment to clarify not having to check property name for every
>>>>>>>>>>   index
>>>>>>>>>> - Added "matched" variable to clarify code. No functional change.
>>>>>>>>>> - Added comments to include/linux/device.h for add_links()
>>>>>>>>>>
>>>>>>>>>> v7 -> v8:
>>>>>>>>>> - Rebased on top of linux-next to handle device link changes in [1]
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> v8 -> v9:
>>>>>>>>>> - Fixed kbuild test bot reported errors (docs and const)
>>>>>>>>>
>>>>>>>>> Some maintainers have strong opinions about whether change logs should be:
>>>>>>>>>
>>>>>>>>>   (1) only in patch 0
>>>>>>>>>   (2) only in the specific patches that are changed
>>>>>>>>>   (3) both in patch 0 and in the specific patches that are changed.
>>>>>>>>>
>>>>>>>>> I can adapt to any of the three styles.  But for style "(1)" please
>>>>>>>>> list which specific patch has changed for each item in the change list.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks for the context Frank. I'm okay with (1) or (2) but I'll stick
>>>>>>>> with (1) for this series. Didn't realize there were options (2) and
>>>>>>>> (3). Since you started reviewing from v7, I'll do that in the future
>>>>>>>> updates? Also, I haven't forgotten your emails. Just tied up with
>>>>>>>> something else for a few days. I'll get to your emails next week.
>>>>>>>
>>>>>>> Yes, starting with future updates is fine, no need to redo the v9
>>>>>>> change logs.
>>>>>>>
>>>>>>> No problem on the timing.  I figured you were busy or away from the
>>>>>>> internet.
>>>>>>
>>>>>> I'm replying to your comments on the other 3 patches. Okay with a
>>>>>> majority of them. I'll wait for your reply to see where we settle for
>>>>>> some of the points before I send out any patches though.
>>>>>>
>>>>>> For now I'm thinking of sending them as separate clean up patches so
>>>>>> that Greg doesn't have to deal with reverts in his "next" branch. We
>>>>>> can squash them later if we really need to rip out what's in there and
>>>>>> push it again.
>>>>>>
>>>>>> -Saravana
>>>>>>
>>>>>
>>>>> Please do not do separate clean up patches.  The series that Greg has is
>>>>> not ready for acceptance and I am going to ask him to revert it as we
>>>>> work through the needed changes.
>>>>>
>>>>> I suspect there will be at least two more versions of the series.  The
>>>>> first is to get the patches I commented in good shape.  Then I will
>>>>> look at the patches later in the series to see how they fit into the
>>>>> big picture.
>>>>>
>>>>> In the end, there should be one coherent patch series that implements
>>>>> the feature.
>>>>
>>>> Incremental patches to fix up the comments and documentation is fine, no
>>>> need to respin the whole mess.
>>>
>>> The problem is that the whole thing is a "mess" at this point.  I expect
>>> the series to go through at least two or three more versions.
>>
>> I'm confused.  All I see so far is objections about some documentation
>> in comments that can be cleaned up, and a disagreement about the name of
>> some things (naming is hard, tie goes to the submitter).
> 
> Yes naming is hard. No,tie does not go to the submitter is the naming

                                                          ^^ if

-Frank

> makes the code difficult to understand.
> 
> Naming is one of the reasons why I have found this series so difficult
> to understand.
> 
> 
>> But no logic issues, right?  Documentation and names can be fixed
>> anytime, the logic is all working properly, right?
> 
> Yes, there are logic issues.  I do not agree will all of the explanations
> in the replies.
> 
> Without going into detail about all the issues, one key is that I
> need to see an example of the edit_links() function, which Saravana
> says he will provide.  I don't want a bunch of ad hoc edit_links()
> functions that each deal with cyclic dependencies in different ways.
> 
> There is also disagreement over whether the complexity of the
> dev->has_edit_links field and driver_edit_links() are needed.
> 
> My biggest meta-issue is that this patch series is papering over the
> real problem that prompted the patches.  The real problem is that the
> boot loader has enabled a power supply, but the power subsystem is
> not aware that there is an active consumer.  I have been hopeful that
> this series can be implemented in a way that makes me comfortable
> that it is _not_ just papering over the true problem.  I still
> retain that hope.
> 
> 
>>
>> What am I missing here?
>>
>> thanks,
>>
>> greg k-h
>>
> 
> -Frank
> 

