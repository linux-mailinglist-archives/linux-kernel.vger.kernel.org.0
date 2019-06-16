Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8547520
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfFPOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 10:09:06 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42616 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:09:06 -0400
Received: by mail-lf1-f51.google.com with SMTP id y13so4660434lfh.9;
        Sun, 16 Jun 2019 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E8vAHm5fNfx3JHjHoDH8HJSu0t2QoGEaq+gO0J45Wtw=;
        b=WHbVd2Yr5Ti5gw6IcDQ88mow2xLWDitabLbYcq1tCD0vD34gGi0QJMn2GikEsdEYDj
         xgxo0aMplw4Wg9tjY/MKyhiuw6blF+av0THGXw6wyMw5l7RXynFaSr8pVysucdxx7iK4
         +abNxGzJiMv+25WIeLCxeHGkICsUHfj1Akqw+mrhySBPhDi4f1BewS2p8ADlYy9ic5uu
         7vNWFN6JydEMZNDbwuIzgoOr99MtBgf7rjMduoLnL8tNNlXVrq2kz1NqPckzG/wOu9X5
         PzqIhCCflpBhHPqh1vYShjvlJPRp5CZu+awAqs4YqG20k+JeV1236cbWio2TOo4EVx79
         aVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8vAHm5fNfx3JHjHoDH8HJSu0t2QoGEaq+gO0J45Wtw=;
        b=s8gsFtW4+K6e1YjU61/RP7Xzy1Ssu3IQwsIdo2/3244+kEU/rWg9fnub/ME+dAMjDm
         NstOFoaAO0KgV6hZfANWCXNIorFj09GniOSgl+w+e2KY+M3YwMn0rIMIKY3cR+/SbNI+
         WXD6RdarjXTeuovqmkqokN9gbzGWk3MS7CawOrlql9U6VRHgjw7yY40Q7nIvBLwRob1z
         QLdUSvauewyZLAIYoJOrR+CWW6lCpwfzzeDx6VjTUE5bug8tEGuNeeUaP8bbqXJDK4fv
         Sm8xgkNJTSfWCrW+o1Y/eaCTvpbDwAVqRbrJGJKYCwMqt+mSnitn31rIC5EF14mvdYyL
         cFGw==
X-Gm-Message-State: APjAAAXangxzD5jhQlGcAQXoLonvTUHScvtBwsXx6ruLF0BQeIbM4df+
        3itd0iWY4Jiqy3xwm+QDAGRKHomi
X-Google-Smtp-Source: APXvYqweZ2vVw8giy/ZF//DAlrMwVaB6CT4sj8/JOyiATtZz0y3OFG8dRiDnMofecSrwLu9s4h91Cg==
X-Received: by 2002:a19:f506:: with SMTP id j6mr28280288lfb.168.1560694144339;
        Sun, 16 Jun 2019 07:09:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id j23sm587163lfb.93.2019.06.16.07.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 07:09:03 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the clockevents tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190613090700.04badfc3@canb.auug.org.au>
 <1b6c715b-5aa9-b0c1-d228-c99d2adc57b4@linaro.org>
 <20190616232408.7ca0ec1c@canb.auug.org.au>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <daa92c0a-9c29-39cb-8612-1103bf09cf13@gmail.com>
Date:   Sun, 16 Jun 2019 17:08:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190616232408.7ca0ec1c@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2019 16:24, Stephen Rothwell пишет:
> Hi Daniel,
> 
> [Sorry for the slow response.]
> 
> On Thu, 13 Jun 2019 08:52:21 +0200 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> actually it returns:
>>
>> git log -1 --format='Fixes: %h ("%s")' 3be2a85a0b61
>>
>> Fixes: 3be2a85a0b61 ("clocksource/drivers/tegra: Support per-CPU timers on all Tegra's")
> 
> Indeed.
> 
>> Is it ok to shorten the subject?
> 
> I figure it is easier to just use the "git log" result and to give
> anyone (or any script) the wants to use the Fixes tag as much
> information as possible.
> 

Daniel, I'd also recommend to shorten the common subsys prefix in general to something
like "clocksource: tegra:".
