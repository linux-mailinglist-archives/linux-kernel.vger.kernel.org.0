Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E08E17B890
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFIq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 03:46:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCFIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:46:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 42BBE296E60
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver
 support
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
 <20200213145416.890080-2-enric.balletbo@collabora.com>
 <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
 <CAFqH_53crnC6hLExNgQRjMgtO+TLJjT6uzA4g8WXvy7NkwHcJg@mail.gmail.com>
 <CA+E=qVfGiQseZZVBvmmK6u2Mu=-91ViwLuhNegu96KRZNAHr_w@mail.gmail.com>
 <CAFqH_505eWt9UU7Wj6tCQpQCMZFMfy9e1ETSkiqi7i5Zx6KULQ@mail.gmail.com>
 <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com>
 <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com>
 <CA+E=qVcyRW4LNC5db27d-8x-T_Nk9QAhkBPwu5rwthTc6ewbYA@mail.gmail.com>
 <20200305193505.4km5j7n25ph4b6hn@core.my.home>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2a5a4a62-3189-e053-21db-983a4c766d44@collabora.com>
Date:   Fri, 6 Mar 2020 09:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305193505.4km5j7n25ph4b6hn@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

On 5/3/20 20:35, Ondřej Jirman wrote:
> Hi,
> 
> On Thu, Mar 05, 2020 at 10:29:33AM -0800, Vasily Khoruzhick wrote:
>> On Thu, Mar 5, 2020 at 7:28 AM Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>>
>>> Hi Vasily,
>>
>> CC: Icenowy and Ondrej
>>>
>>> Would you mind to check which firmware version is running the anx7688 in
>>> PinePhone, I think should be easy to check with i2c-tools.
>>
>> Icenowy, Ondrej, can you guys please check anx7688 firmware version?
> 
> i2cget 0 0x28 0x00 w
> 0xaaaa
> 
> i2cget 0 0x28 0x02 w
> 0x7688
> 
> i2cget 0 0x28 0x80 w
> 0x0000
> 

Can you check the value for 0x81 too?

Thanks,
 Enric


> regards,
> 	o.
> 
>>> Thanks in advance,
>>>  Enric
>>>
>>> [snip]
