Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE889186DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgCPO6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 10:58:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35407 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbgCPO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:57:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so1006413wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jkAPmdhBH4C1pIBo+TmHcs70WrsTSZzrkmYMJt1bVQ0=;
        b=anyY1tSE2Z3652pfffnB95q903tdjOtG0zfB5NimD+NkUj5CC4p08vwqvnk7kHyza+
         O3KVGClb64tZKvP7ARD0vfZa1fEON28bnoCf6vpLEakQmseTzsbsYBWmpPW90FrZMGAb
         hlXG8BCKquTrWYf6dZhndQGHhtvNbnYPJOQk2jR1ZNkKuvN/3AbkNh9jbOyCY/2lr9qS
         GqsW3+OxLuM8hbHGB5kHQk8eD+TkAYo8qqJZrw/zhDYlg0VSEo4RSnLTvobMKqJWXr3j
         wScYQO2o1SFLfNC03GSKj9zH+oEXg0abIY+J+494C5AkjsEdOztHdb9VKcN4CldbxmEn
         P0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jkAPmdhBH4C1pIBo+TmHcs70WrsTSZzrkmYMJt1bVQ0=;
        b=I2DbufXztee8N6NrE6koWUewIhdChpn/zUdgDJtttEE4cdkuNDtr5xozmWYnqMY6If
         tHHPRGcxXhS3vPQPBy/A23p9iAYRkrL47lMRIBz4w+i+d95v/IDBAWEIQC0YgDdg8eIF
         JEIFFdhfGd0KJBpHO/Vi1BsInijUHSJ0PcNmMcdDs9dpuYzv09nYGAP+CTJzUkIZ3vNh
         C5FWTQMw4n6t1XPhfR1gg8pRNTCXuX0eqx454FjJEycp+Lg4mMe6XddAITK85U6a8p2k
         lWVBrg4Om0jQcgU9piH/h0peBkKZVGHfBpUZYz2bTTESic1cug0o3gnT+rD4lNkQdWa1
         v9yQ==
X-Gm-Message-State: ANhLgQ1SHmtzc4nWYDNsFPPOUFCAQmNDXK7oxVB+FfjTdDEk4HJR7Y4z
        gQgHKAi45fdvREKfvLN2FCRBatni1kg=
X-Google-Smtp-Source: ADFU+vuw5nCxmsrb8sYqyFBYI6UDLjTNuoRDrR9R8oS1W5f+pmF+2GyJVYzuZBSBC6MCQJ87aEuLwg==
X-Received: by 2002:adf:80af:: with SMTP id 44mr36891885wrl.241.1584370676279;
        Mon, 16 Mar 2020 07:57:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f835:499f:9553:971a? ([2a01:e34:ed2f:f020:f835:499f:9553:971a])
        by smtp.googlemail.com with ESMTPSA id d21sm235290wrb.51.2020.03.16.07.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 07:57:55 -0700 (PDT)
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Saravana Kannan <saravanak@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200111052125.238212-1-saravanak@google.com>
 <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
 <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com>
 <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org>
 <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <897866cb-f059-d15f-62f5-9ee2688dded0@linaro.org>
Date:   Mon, 16 Mar 2020 15:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2020 06:53, Saravana Kannan wrote:
> On Wed, Mar 4, 2020 at 11:56 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/03/2020 20:30, Saravana Kannan wrote:
>>> On Thu, Feb 27, 2020 at 1:22 PM Saravana Kannan <saravanak@google.com> wrote:
>>>>
>>>> On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> On 11/01/2020 06:21, Saravana Kannan wrote:
>>>>>> Timer initialization is done during early boot way before the driver
>>>>>> core starts processing devices and drivers. Timers initialized during
>>>>>> this early boot period don't really need or use a struct device.
>>>>>>
>>>>>> However, for timers represented as device tree nodes, the struct devices
>>>>>> are still created and sit around unused and wasting memory. This change
>>>>>> avoid this by marking the device tree nodes as "populated" if the
>>>>>> corresponding timer is successfully initialized.
>>
>> TBH, I'm missing the rational with the explanation and the code. Can you
>> elaborate or rephrase it?
> 
> Ok, let me start from the top.
> 
> When the kernel boots, timer_probe() is called (via time_init()) way
> before any of the initcalls are called in do_initcalls().
> 
> In systems with CONFIG_OF, of_platform_default_populate_init() gets
> called at arch_initcall_sync() level.
> of_platform_default_populate_init() is what kicks off creating
> platform devices from device nodes in DT. However, if the struct
> device_node that corresponds to a device node in DT has OF_POPULATED
> flag set, a platform device is NOT created for it (because it's
> considered already "populated"/taken care of).
> 
> When a timer driver registers using TIMER_OF_DECLARE(), the driver's
> init code is called from timer_probe() on the struct device_node that
> corresponds to the timer device node. At this point the timer is
> already "probed". If you don't mark this device node with
> OF_POPULATED, at arch_initcall_sync() it's going to have a pointless
> struct platform_device created that's just using up memory and
> pointless.
> 
> So my patch sets the OF_POPULATED flag for all timer device_node's
> that are successfully probed from timer_probe().
> 
> If a timer driver doesn't use TIMER_OF_DECLARE() and just registers as
> a platform device, the driver init function won't be called from
> timer_probe() and it's corresponding devices won't have OF_POPULATED
> set in their device_node. So platform_devices will be created for them
> and they'll probe as normal platform devices. This is why my change
> doesn't break drivers/clocksource/ingenic-timer.c.
> 
> Btw, this is no different from what irqchip does with IRQCHIP_DECLARE.
> 
> Hope that clears it up.

Yes, thanks for the explanation.

Why not just set the OF_POPULATED if the probe succeeds?

Like:

diff --git a/drivers/clocksource/timer-probe.c
b/drivers/clocksource/timer-probe.c
index ee9574da53c0..f290639ff824 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -35,6 +35,7 @@ void __init timer_probe(void)
                        continue;
                }

+               of_node_set_flag(np, OF_POPULATED);
                timers++;
        }

instead of setting the flag and clearing it in case of failure?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

