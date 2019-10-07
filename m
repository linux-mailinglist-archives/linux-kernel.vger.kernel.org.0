Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD4CE539
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfJGO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 10:29:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGO3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:29:41 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E91A3B58C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 14:29:40 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k4so7494407wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DH2lGZItnyCxpT638su7JIBUbhf9Wf2K40MEjQfXGs=;
        b=rTE3jPTeoJKjhVwY7YIpw0AlKFxwTYj5Y4CvwRIpRrZtTK1QuIbSg9cmKnrr8xZx0r
         r1H2i6Lz3GDM1GycdjeGwTEM0UYZrzO3B33KNskfgP8cnS4OGKqVFVrJDwq+6tIs3tPu
         Zx4WKxw1w8zL+EwVOwa8tFrLoNL7jbqFXrUvSiJ+hHln0+TlFw8UvkDrZHsaBy9yrNm3
         TTHJ/ukvf6SmoxmEEfHcJmkk+SXM57bM8v9JHkzZByNdgV6RfwEJI6Dt7M94IGa94HYl
         msPMtnzdtj80ifHt5If6ulPIXRwrUeqzoRAZa7S+UN3jo4YBxMrVvTyoPCwCP49zcGtK
         W2Og==
X-Gm-Message-State: APjAAAUwp1Ap/v7/PICYt87ISMOSMnMQxxPOleRZdwsIzv5vUsKjcTib
        fYj5tS0JHFfbW3R3PS3/4RbXVECE5otHVh9PxTZavHsxH2M5V1+GBP4+PtwgStSsL+LEMloJkE1
        DyaNfBO/zKZlmL2SYsM/1eaXQ
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr20208484wme.77.1570458578900;
        Mon, 07 Oct 2019 07:29:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0iUna5xpCm/klRwotM0QLEzqWJ6+o/3qIKqAoj8z/BjCYdHBrV6duKeSKdnnUjVlquYJsWA==
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr20208466wme.77.1570458578691;
        Mon, 07 Oct 2019 07:29:38 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id m18sm31573558wrg.97.2019.10.07.07.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:29:38 -0700 (PDT)
Subject: Re: [PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Stephan Mueller <smueller@chronox.de>
References: <20191007134724.4019-1-hdegoede@redhat.com>
 <20191007140022.GA29008@gmail.com>
 <1dc3c53d-785e-f9a4-1b4c-3374c94ae0a7@redhat.com>
 <20191007142230.GA117630@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2982b666-e310-afb7-40eb-e536ce95e23d@redhat.com>
Date:   Mon, 7 Oct 2019 16:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007142230.GA117630@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-10-2019 16:22, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 07-10-2019 16:00, Ingo Molnar wrote:
>>>
>>> * Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>>> The purgatory code now uses the shared lib/crypto/sha256.c sha256
>>>> implementation. This needs memzero_explicit, implement this.
>>>>
>>>> Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
>>>> Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Changes in v2:
>>>> - Add barrier_data() call after the memset, making the function really
>>>>     explicit. Using barrier_data() works fine in the purgatory (build)
>>>>     environment.
>>>> ---
>>>>    arch/x86/boot/compressed/string.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
>>>> index 81fc1eaa3229..654a7164a702 100644
>>>> --- a/arch/x86/boot/compressed/string.c
>>>> +++ b/arch/x86/boot/compressed/string.c
>>>> @@ -50,6 +50,12 @@ void *memset(void *s, int c, size_t n)
>>>>    	return s;
>>>>    }
>>>> +void memzero_explicit(void *s, size_t count)
>>>> +{
>>>> +	memset(s, 0, count);
>>>> +	barrier_data(s);
>>>> +}
>>>
>>> So the barrier_data() is only there to keep LTO from optimizing out the
>>> seemingly unused function?
>>
>> I believe that Stephan Mueller (who suggested adding the barrier)
>> was also worried about people using this as an example for other
>> "explicit" functions which actually might get inlined.
>>
>> This is not so much about protecting against LTO as it is against
>> protecting against inlining, which in this case boils down to the
>> same thing. Also this change makes the arch/x86/boot/compressed/string.c
>> and lib/string.c versions identical which seems like a good thing to me
>> (except for the code duplication part of it).
>>
>> But I agree a comment would be good, how about:
>>
>> void memzero_explicit(void *s, size_t count)
>> {
>> 	memset(s, 0, count);
>> 	/* Avoid the memset getting optimized away if we ever get inlined */
>> 	barrier_data(s);
>> }
> 
> Well, the standard construct for preventing inlining would be 'noinline',
> right? Any reason that wouldn't work?

Good question. I guess the worry is that modern compilers are getting
more aggressive with optimizing and then even if not inlined if the
function gets compiled in the same scope, then the compiler might
still notice it is only every writing to the memory passed in; and
then optimize it away of the write happens to memory which lifetime
ends immediately afterwards. I mean removing the call is not inlining,
so compiler developers might decide that that is still fine to do.

IMHO with trickycode like this is is best to just use the proven
version from lib/string.c

I guess I made the comment to specific though, so how about:

void memzero_explicit(void *s, size_t count)
{
	memset(s, 0, count);
	/* Tell the compiler to never remove / optimize away the memset */
	barrier_data(s);
}

Regards,

Hans
