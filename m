Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADF818D2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCTPXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:23:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35633 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgCTPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:23:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so6857602ljo.2;
        Fri, 20 Mar 2020 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VhKccgOguj0tmSH6fBMBTNwniprhbO/QTAsIU+tUQJ4=;
        b=Wq387MNCHhecuMuRsEWLiVv1BFl0CsqAEduLhMhl2ao5mjEB0BPhwZXRFsQqL5DSqx
         fpQn3J2stJZoXVwPh+i4XleGz3uIjFcpWHpfCFVVQ4+G/nTKcn5iDfaLl+y3YfsUX2wM
         gKYWp1XD7O697uH5sNFx+XdrTMiqUdU5oVQENXRIpV8+g9lDCbEKv/3BMwVDJhtPS43w
         ffm3jXcuypBDD0/M2bHlyvyyUamhr/tOOiv/uR+Q1dp4Nrco1mtgVL6kwtUGpzxSX9Ph
         TkA6R8Gt4dQg9dX6GvvUDfpACywAxIdkYk+iEIxkAtz7p0p61uQlWZA5W+z3FJ45llRl
         nMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhKccgOguj0tmSH6fBMBTNwniprhbO/QTAsIU+tUQJ4=;
        b=kQK93Km8swt8P2iVl5KKvcOrqlO08sC8mJ5a5uZrhGKO54iGDuBdVfQ/MqkPD6t4kc
         vKpp1yOKhx/eVPUWyDOBY9PAgAABGLz4VNDh7AvaW0rxX8gZJuqAYJH1RillA2bC9CTY
         BeC910+dP7mCibmgNTtiwljPFi42Hcn5Wj4eQt9jdKOjEkCo+ONfcJQs4phGYjfvXKTh
         O8lgvakI5Sm5NhbJADSGdN9rNGbTynm0DqgFRziuKCZehWkjJfpRbzlZvHXeIZvHULpo
         cu/KcarHAMPcVeqAORePubAgZxt585twPpRxx8ZQlPFdpVN8g1I0InhOxihLHJ3JLAUt
         0j7A==
X-Gm-Message-State: ANhLgQ2DuCJ7HRibFHQuI29w4Lxq0b7UJzFJjIWR/xAeBXF0Ytq3GXMS
        qW9DnujKpIyOSD+QRhRmQasq014X
X-Google-Smtp-Source: ADFU+vuPOnEfIEwilICbKe1X3ON8BwLNa+UsQHd8CUyjAbQDFymDc/KT62U+ae8v9qg+tuhpsQYskQ==
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr5631999ljc.42.1584717816993;
        Fri, 20 Mar 2020 08:23:36 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id k63sm3721513lfk.43.2020.03.20.08.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 08:23:36 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <df532fef-1533-9da7-d676-f4671746fde3@gmail.com>
 <20200320150406.GA3706404@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a559950-0497-b24f-6484-c2513375fe62@gmail.com>
Date:   Fri, 20 Mar 2020 18:23:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320150406.GA3706404@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.03.2020 18:04, Thierry Reding пишет:
> On Fri, Mar 20, 2020 at 05:39:01PM +0300, Dmitry Osipenko wrote:
>> 20.03.2020 16:34, Thierry Reding пишет:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Currently this only supports a single watchdog, which uses a timer in
>>> the background for countdown. Eventually the timers could be used for
>>> various time-keeping tasks, but by default the architected timer will
>>> already provide that functionality.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  drivers/clocksource/Kconfig          |   8 +
>>>  drivers/clocksource/Makefile         |   1 +
>>>  drivers/clocksource/timer-tegra186.c | 377 +++++++++++++++++++++++++++
>>>  3 files changed, 386 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-tegra186.c
>> Hello Thierry,
>>
>> Shouldn't this driver reside in drivers/watchdog/? Like it's done in a
>> case of the T30+ driver.
> 
> The hardware block that this binds to is primarily a time-keeping block
> that just so happens to also implement a watchdog. Moving this to
> drivers/watchdog would put us into an odd situation if we ever added
> code to also implement the time-keeping bits for this hardware.
> 
> I also think that the way this is done on Tegra30 was a bad choice. The
> problem is that we now have two drivers (tegra_wdt.c and tegra-timer.c)
> that both access the same region of memory. This seems to be relatively
> safe to do on those chips because there's no overlap between the timer
> and the watchdog interfaces, but on Tegra186 and later the watchdog is
> actually using one of the timers, so we'd have to be extra careful how
> to coordinate between the two. It seems much easier to do that by having
> everything in the same driver and have that register multiple devices in
> the system.

Sounds like a watchdog on Tegra20, where one of the timer is shared with
a watchdog function and there are no other free timers. Well, yes, it's
not nice.

But, will you really ever need an additional clocksource on T186?
