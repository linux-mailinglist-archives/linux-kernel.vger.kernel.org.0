Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847315750C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 01:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFZXwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 19:52:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40694 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfFZXwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:52:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so5279389eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pyfPe8PH921mLZVXHodAopSDyO6itVZA0CZKdRsYCfE=;
        b=WzE9/2DBB6KUn71JEl6S2kI3BnjRUdY94bl+EEZvwVtFYNEunhX+oZBuRf+P3HJNWH
         8RDn6I/QrvMXSgNnmAbpROAtsJ+HwQ7QRZjWGNYZCDnC8vqRniqryr4QwSxFJz1zaxVz
         FtuFK1R+yIcfBJVF0B6V8H1RjIG0irvomjobE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyfPe8PH921mLZVXHodAopSDyO6itVZA0CZKdRsYCfE=;
        b=UYp3t7SACZtyvnAbsy1G38pIox/Oi8Ykhwlk9SPPmUv2WbqWQOEEix9PxEp2wg7Ps0
         zDPt/klZ+klt2liA3Ry0F4VQwTTcYmqV8q4vp97scJ6GOu2fGoSZ9zPV65I1IHhHdVuu
         L70wXwU+a0vNp0YwGZEBn/SuiBZT1eWJXCTmBtP56ukyOJeMEFIrkfNr+uDtkUbmDUwc
         anqti8r8qsT/ECUjw+KfdNgmOzEYJvFOKvroyEBQkr2nZHK2eugbmRlUI6kW/qHmFC4y
         3R/Bmsqn3c3voiXZhZw0sH40ABG9uh5vzCEpzPIbL1mXiLKspRTHHT9fAyu+VF5hC1rD
         HalA==
X-Gm-Message-State: APjAAAXVGziXOzG8cFXIFvpvVBFFbKeJT5sgNFqtG2O5sYSvXJG/wwnB
        hi2Wf7WuQIAvXW2O5oiVDLc6kPUg4uiFHEjp
X-Google-Smtp-Source: APXvYqxt/yaYCJYdbrwsqUZ0NoyEDwh5e4jbKFskE6cwPlUCwQEil1BanQAhZngznElo1riWGimV3g==
X-Received: by 2002:a17:906:6051:: with SMTP id p17mr403042ejj.142.1561593143014;
        Wed, 26 Jun 2019 16:52:23 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-112-26.cgn.fibianet.dk. [5.186.112.26])
        by smtp.gmail.com with ESMTPSA id j25sm129543edq.68.2019.06.26.16.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 16:52:22 -0700 (PDT)
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for
 DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk>
 <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
 <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk>
 <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
 <70aa7b96-e19d-5f8b-1ff6-af15715623e5@rasmusvillemoes.dk>
 <CAKwvOdkWo5yG7LrtGL_ht-XHFgNqx_t6rP+hHhcPyb+Ud1N+HA@mail.gmail.com>
 <CAKwvOdnFt18ffO0BV-AZ9+mYuOBMroPObxrakXdV1v4iL3CS3Q@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4e9d2103-2186-308b-c560-830c57ee3a6d@rasmusvillemoes.dk>
Date:   Thu, 27 Jun 2019 01:52:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnFt18ffO0BV-AZ9+mYuOBMroPObxrakXdV1v4iL3CS3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2019 01.16, Nick Desaulniers wrote:
> On Tue, Jun 25, 2019 at 3:18 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> 
> The prints should show up in dmesg right, assuming you do something to
> trigger them?  Can you provide more details for a test case that's
> easy to trip? What's an easy case to reproduce from a limited
> buildroot env (basic shell/toybox)?
> 

Hm, I seemed to remember that those kobject events triggered all the
time. Oh well, try this one:

echo 'file ping.c +p' > control
ping localhost
dmesg | grep ping

Rasmus
