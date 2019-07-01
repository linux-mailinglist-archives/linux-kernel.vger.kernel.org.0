Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58542C96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502208AbfFLQrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 12:47:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42543 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502196AbfFLQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:47:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so6846062plb.9;
        Wed, 12 Jun 2019 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xwdp4CeblY/7+jVjWFHkWlC+PPtPrMKGp8cPZ6kbYD0=;
        b=VhntI6C8kUQ0al4oseQ7+GcUtk1MtxMg8I/exWzUJqahPq6AF0r2RoLEvjLQzlxkGh
         oqnmYzwdh97FHAy++vqRD1A+3Yzzxhs7+dxB3OPxKsqa11zsXp41r0W9BSTh5cUiIM3e
         qmiVtITUwjmVs7xYyKk7k0PYy22gULGtu+zLaAM6GBhROKaYFtq50ACP1BcTLr5wMtgV
         V4ANabq7TCjHPvt23ynDWFovKhaj6e7/AUTk1U6GCXMlaPSLp6oPaJFExomb+MEUF2mU
         OlGl5MHfyRZJ6kN3gpJlWZ97gPt3f0DCzEHNh8NTnbE4KQTB/VJKBYzV5vuzEYqJia0O
         tosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xwdp4CeblY/7+jVjWFHkWlC+PPtPrMKGp8cPZ6kbYD0=;
        b=UzhYbFJhbd+7jou1kovYbXpwSWF55Gkr9FqyeHnF2GdZT73yw/nhykaPeaJthdbta2
         apMneP+A5sVVPbUz3xpqUQgY6VXIB+6ljS1mTg1cTyPGcV89ZiCa8KPPPeKTZcWDLPsl
         TH4Ix1JN03v5GBVO1qGf/JNN8JxKtpJ67+NihOb8aRem+YLPqJ2hBSeFhuWlbCIWr/Lv
         rV7H+hKcPA3JqpNNEtSdMVDFtvP53t1KJGvZjMqX79SwzTJMuLSpSn1PzmphNDolACfZ
         64oU1463wOW3gyKkqbD7zBkPx3JTAeQhUELLJfwk/B5kYhf+BeoYWtJSdVi2jB6ThTd8
         BMFw==
X-Gm-Message-State: APjAAAXhy27cagRqJCxxdfd0WWrxt0v+s8QsN2rqvtDr6oO1AnNNCjpy
        5U8IMe7lnTToO+eZgWTF/X0=
X-Google-Smtp-Source: APXvYqykK2cHgENyGBh8cJLps8+RGSjP2m0z+af3S/7bc3y2dTyGbPfl9aVElqxgYmpl+UoO2PdYxQ==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr3914692pls.8.1560358027101;
        Wed, 12 Jun 2019 09:47:07 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e22sm60573pgb.9.2019.06.12.09.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:47:06 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up
 of_find_device_by_node()
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sandeep Patil <sspatil@android.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20190604003218.241354-1-saravanak@google.com>
 <20190604003218.241354-2-saravanak@google.com>
 <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
 <570474f4-8749-50fd-5f72-36648ed44653@gmail.com>
 <CAGETcx8M3YkUBZ-e2LLfrbWgnMKMMNG5cv=p8MMmBe7ZyPJ7xw@mail.gmail.com>
 <20190611215242.GE212690@google.com>
 <CAL_Jsq+V9QUBpzmPyYjWe93-06-mpU=5JmUqvf-QsnuLxPnmUA@mail.gmail.com>
 <75be9e83-4d56-6080-7011-0c79b70c8cb9@gmail.com>
Message-ID: <da287ff3-5c20-3797-0d05-34bd84fe25ce@gmail.com>
Date:   Wed, 12 Jun 2019 09:47:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <75be9e83-4d56-6080-7011-0c79b70c8cb9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 9:07 AM, Frank Rowand wrote:
> On 6/12/19 6:53 AM, Rob Herring wrote:
>> On Tue, Jun 11, 2019 at 3:52 PM Sandeep Patil <sspatil@android.com> wrote:
>>>
>>> On Tue, Jun 11, 2019 at 01:56:25PM -0700, 'Saravana Kannan' via kernel-team wrote:
>>>> On Tue, Jun 11, 2019 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>
>>>>> Hi Saravana,
>>>>>
>>>>> On 6/10/19 10:36 AM, Rob Herring wrote:
>>>>>> Why are you resending this rather than replying to Frank's last
>>>>>> comments on the original?
>>>>>
>>>>> Adding on a different aspect...  The independent replies from three different
>>>>> maintainers (Rob, Mark, myself) pointed out architectural issues with the
>>>>> patch series.  There were also some implementation issues brought out.
>>>>> (Although I refrained from bringing up most of my implementation issues
>>>>> as they are not relevant until architecture issues are resolved.)
>>>>
>>>> Right, I'm not too worried about the implementation issues before we
>>>> settle on the architectural issues. Those are easy to fix.
>>>>
>>>> Honestly, the main points that the maintainers raised are:
>>>> 1) This is a configuration property and not describing the device.
>>>> Just use the implicit dependencies coming from existing bindings.
>>>>
>>>> I gave a bunch of reasons for why I think it isn't an OS configuration
>>>> property. But even if that's not something the maintainers can agree
>>>> to, I gave a concrete example (cyclic dependencies between clock
>>>> provider hardware) where the implicit dependencies would prevent one
>>>> of the devices from probing till the end of time. So even if the
>>>> maintainers don't agree we should always look at "depends-on" to
>>>> decide the dependencies, we still need some means to override the
>>>> implicit dependencies where they don't match the real dependency. Can
>>>> we use depends-on as an override when the implicit dependencies aren't
>>>> correct?
>>>>
>>>> 2) This doesn't need to be solved because this is just optimizing
>>>> probing or saving power ("we should get rid of this auto disabling"):
>>>>
>>>> I explained why this patch series is not just about optimizing probe
>>>> ordering or saving power. And why we can't ignore auto disabling
>>>> (because it's more than just auto disabling). The kernel is currently
>>>> broken when trying to use modules in ARM SoCs (probably in other
>>>> systems/archs too, but I can't speak for those).
>>>>
>>>> 3) Concerns about backwards compatibility
>>>>
>>>> I pointed out why the current scheme (depends-on being the only source
>>>> of dependency) doesn't break compatibility. And if we go with
>>>> "depends-on" as an override what we could do to keep backwards
>>>> compatibility. Happy to hear more thoughts or discuss options.
>>>>
>>>> 4) How the "sync_state" would work for a device that supplies multiple
>>>> functionalities but a limited driver.
>>>
>>> <snip>
>>> To be clear, all of above are _real_ problems that stops us from efficiently
>>> load device drivers as modules for Android.
>>>
>>> So, if 'depends-on' doesn't seem like the right approach and "going back to
>>> the drawing board" is the ask, could you please point us in the right
>>> direction?
>>
>> Use the dependencies which are already there in DT. That's clocks,
>> pinctrl, regulators, interrupts, gpio at a minimum. I'm simply not
>> going to accept duplicating all those dependencies in DT. The downside
>> for the kernel is you have to address these one by one and can't have
>> a generic property the driver core code can parse. After that's in
>> place, then maybe we can consider handling any additional dependencies
>> not already captured in DT. Once all that is in place, we can probably
>> sort device and/or driver lists to optimize the probe order (maybe the
>> driver core already does that now?).
>>
>> Get rid of the auto disabling of clocks and regulators in
>> late_initcall. It's simply not a valid marker that boot is done when
>> modules are involved. We probably can't get rid of it as lot's of
>> platforms rely on that, so it will have to be opt out. Make it the
>> platform's responsibility for ensuring a consistent state.
> 
> Setting aside modules for one moment, why is there any auto disabling
> of clocks and regulators in late initcall????  Deferred probe processing
> does not begin until deferred_probe_initcall() sets

I failed to mention that deferred_probe_initcall() is a late_initcall.

-Frank

> driver_deferred_probe_enable to true.  No late_initcall function
> should ever depend on ordering with respect to any other late_initcall.
> (And yes, I know that among various initcall levels, there have been
> games played to get a certain amount of ordering, but that is at
> best fragile.)
> 
> In addition to modules, devicetree overlays need to be considered.
> 
> Just as modules can result in a driver appearing after boot finishes,
> overlays can result in new devicetree nodes (and thus dependencies)
> appearing after boot finishes.
> 
> -Frank
> 
>>
>> Perhaps we need a 'boot done' or 'stop deferring probe' trigger from
>> userspace in order to make progress if dependencies are missing. Or
>> maybe just some timeout would be sufficient. I think this is probably
>> more useful for development than in a shipping product. Even if you
>> could fallback to polling mode instead of interrupts for example, I
>> doubt you would want to in a product.
>>
>> You should also keep in mind that everything needed for a console has
>> to be built in. Maybe Android can say the console isn't needed, but in
>> general we can't.
>>
>> Rob
>> .
>>
> 
> 

