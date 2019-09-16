Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9930CB3B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfIPNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:17:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33866 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfIPNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:17:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so7533pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MjQNGhXyoaNi7Ay7kNVBn/RrtRO16elkvB5c9bQH3Ng=;
        b=SYLsH1zdYx57s482sWVsKSF+XeD7VvoNkey5U1eVajFgPK8kmYPyn3f5gFcvLHHk6p
         Hlp/7O6ReChutEM4UnVYdCn2Bu0A6fkvud3HWeOnZ9GIcdDT7d74yANT1TS7HCDU5dUF
         gfCVY0klDO1nG8E+b9beCtvCPTI3ujkQIexdKXh3oPbxNCrBnxHQEO5x6yhwtuOpQ9Rw
         TyomXjmEkMLihQMJSpVktAcRmFbnMfd69cfA0PiBEiTFh7kRyDJ6u31swjN0DPTHmc6/
         2A5etCKnUhuNqeKQ2uDTXkibkWD2wpD1xm3XwsN2gqy6zjegAojKbuDihzqMIjnC1Ov5
         /yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MjQNGhXyoaNi7Ay7kNVBn/RrtRO16elkvB5c9bQH3Ng=;
        b=YObRY4NtYoEwsqaYl3usTsNcRWbO1lR1N+/IQc1lo3NBD6/S78TRp2Yn/qC1GFuV0o
         U+J1tkQbXoZOHrvoZpQ3HJytNOLcvEMeaHav9e3RtevPkO3FmcLLByruIwoC5QExXiM6
         B+Zw2nwkSe9L2AMsGc0DwZiggyZCyxRyCNLxXB2wlfYBo7CofWfkZjTPSNH+wqgAx0P6
         gZyFs4SpW5BucDh249jRukuAxyv8HTJe5YsS0650m9usRssHhG+hnHULvkbKs2i8/Cpe
         cLi+mxS0+xRwPWdbFCjFZg/AENiwYbiSPcyKt5k+gMIE5FYTerPzUZpyhf97dFkvozgx
         t7lA==
X-Gm-Message-State: APjAAAXJLpJWO+XUCG0ERJVNVlmRJ3WPHHbe4+ohBy3qBNsaQXiXQMfD
        jukX8L+WL4YUnT5UNvrRt80KlN8S
X-Google-Smtp-Source: APXvYqwckFq6sIHAg9OHkleNo4ZFt8VL66JtMi1tyaXaSMHw+Aii21E3b+iAqnfcYHfZEFGZXFdG2w==
X-Received: by 2002:a17:90a:9ab:: with SMTP id 40mr20663608pjo.38.1568639823740;
        Mon, 16 Sep 2019 06:17:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v43sm13446903pjb.1.2019.09.16.06.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 06:17:02 -0700 (PDT)
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net>
 <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
Date:   Mon, 16 Sep 2019 06:17:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 12:49 AM, Arnd Bergmann wrote:
> On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Hi everyone,
>>>
>>> This small series is preparatory work for a series that I'm working on
>>> which attempts to establish a formal framework for system restart and
>>> power off.
>>>
>>> Guenter has done a lot of good work in this area, but it never got
>>> merged. I think this set is a valuable addition to the kernel because
>>> it converts all odd providers to the established mechanism for restart.
>>>
>>> Since this is stretched across both 32-bit and 64-bit ARM, as well as
>>> PSCI, and given the SoC/board level of functionality, I think it might
>>> make sense to take this through the ARM SoC tree in order to simplify
>>> the interdependencies. But it should also be possible to take patches
>>> 1-4 via their respective trees this cycle and patches 5-6 through the
>>> ARM and arm64 trees for the next cycle, if that's preferred.
>>>
>>
>> We tried this twice now, and it seems to go nowhere. What does it take
>> to get it applied ?
> 
> Can you send a pull request to soc@kernel.org after the merge window,
> with everyone else on Cc? If nobody objects, I'll merge it through
> the soc tree.
> 

Sure, I'll rebase and do that.

Thanks,
Guenter
