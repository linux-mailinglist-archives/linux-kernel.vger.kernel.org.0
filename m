Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D763087DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436564AbfHIPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:05:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37750 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfHIPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:05:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so38169227ljn.4;
        Fri, 09 Aug 2019 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=acZurH2HTDYCaTPNUYlalmeHoQEO9y92gUKscv1e/o0=;
        b=ZsUKW75hMOBWc0tFTD41qUGRi3Y4bbl0VyCSwlzs9tWWi63nbAivX4UU4RWoW2ImvX
         3We8qazI3Geynpt9591+loZ2a+DurRjaZ+adOegz04i+O/rYY5az7tpK+foAkk/iLlcE
         YthtfW8jGndE0Y81/PmbNuWaWA9ojRtWx2Tff8Jie0n6Julb0+BbB5EUcAPFmD3ytXoN
         BEJ1DDrS50+whZghfKXsV41OgrkbHWd2Qc5A2iLT+ivjHQoYOsiq20Yf4i2oWISLddKt
         NUC1pSZTl8rvWm/pZBI9ts//os8KkEAl5FwJk2nm1yISYJgNrJgYNbBKWjOBWIUcswMc
         8HEw==
X-Gm-Message-State: APjAAAWTB/4vNuo9vZxKTaIdhx+zTgOl3r6IE7hcXcnErn0ZlcKFOoVk
        QtNoH0nGSVjnO7S1eoX6o0E=
X-Google-Smtp-Source: APXvYqw/8JKXd595yLew1u3FlnwtDQcs/cyjuJUM2DbnkpQQztctd2qcDEG8y0mcnBZdbhE8ducF3A==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr11193004ljy.86.1565363123091;
        Fri, 09 Aug 2019 08:05:23 -0700 (PDT)
Received: from [192.168.42.38] ([213.87.147.2])
        by smtp.gmail.com with ESMTPSA id z17sm19364949ljc.37.2019.08.09.08.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:05:20 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] floppy: fix usercopy direction
To:     Julia Lawall <julia.lawall@lip6.fr>, Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jikos@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
 <alpine.DEB.2.21.1908091555090.2946@hadrien>
From:   Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
Date:   Fri, 9 Aug 2019 18:05:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908091555090.2946@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2019 16:56, Julia Lawall wrote:
> On Fri, 9 Aug 2019, Alexander Popov wrote:
>> On 27.03.2019 1:03, Jann Horn wrote:
>>> As sparse points out, these two copy_from_user() should actually be
>>> copy_to_user().
>>
>> I also wrote a coccinelle rule for detecting similar bugs (adding coccinelle
>> experts to CC).
>>
>>
>> virtual report
>>
>> @cfu@
> 
> You can replace the above line with @cfu exists@.  You want to find the
> existence of such a call, not ensure that the call occurs on every
> control-flow path, which is the default.

Thanks Julia, I see `exists` allows to drop `<+ +>`, right?

> Do you want this rule to go into the kernel?

It turned out that sparse already can find these bugs.
Is this rule useful anyway? If so, I can prepare a patch.

>> identifier f;
>> type t;
>> identifier v;
>> position decl_p;
>> position copy_p;
>> @@
>>
>> f(..., t v@decl_p, ...)
>> {
>> <+...
>> copy_from_user@copy_p(v, ...)
>> ...+>
>> }
>>
>> @script:python@
>> f << cfu.f;
>> t << cfu.t;
>> v << cfu.v;
>> decl_p << cfu.decl_p;
>> copy_p << cfu.copy_p;
>> @@
>>
>> if '__user' in t:
>>   msg0 = "function \"" + f + "\" has arg \"" + v + "\" of type \"" + t + "\""
>>   coccilib.report.print_report(decl_p[0], msg0)
>>   msg1 = "copy_from_user uses \"" + v + "\" as the destination. What a shame!\n"
>>   coccilib.report.print_report(copy_p[0], msg1)
>>
>>
>> The rule output:
>>
>> ./drivers/block/floppy.c:3756:49-52: function "compat_getdrvprm" has arg "arg"
>> of type "struct compat_floppy_drive_params __user *"
>> ./drivers/block/floppy.c:3783:5-19: copy_from_user uses "arg" as the
>> destination. What a shame!
>>
>> ./drivers/block/floppy.c:3789:49-52: function "compat_getdrvstat" has arg "arg"
>> of type "struct compat_floppy_drive_struct __user *"
>> ./drivers/block/floppy.c:3819:5-19: copy_from_user uses "arg" as the
>> destination. What a shame!
