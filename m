Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8965DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfGKQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 12:55:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfGKQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:55:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so7046531wrf.11;
        Thu, 11 Jul 2019 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cW9evuaNHUhu3xKoRblEDbGLej8PzYak53HB5pCVWjU=;
        b=oFX9gEXDAQ3+H/vT4H26l4Ol50OZG1qDmtkSHrTXHzx+qOSDK2mcRQyEeqpEms1luc
         x2NseAhAxqROgC5+GS1WF3rEVZsiNMXy08Dli2EK8K27ulNcLYG2riP7T5Jzd+vde0hP
         zIN7Lrge3OAkn/fwJmsI623UMVTf2l7xhGSijG+Jwofa1MH7yz/tvXF/m9mfhPUNhwd/
         +DIFuDo3ryRGyAmP26G4/B+x+VANns65dIwMXh6eXc1zojM8dY5rskKyYm7Ap/gOHyD4
         VIILEo9QuerSBwvNtsSaGEUsL+JEIpj31DYOiNVe/9JDVKZLqTL4F7UqQcOriKmJL2dk
         jqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cW9evuaNHUhu3xKoRblEDbGLej8PzYak53HB5pCVWjU=;
        b=TiEbeA3EmIgkBOVa3DKtx0LKWKG1tLfJVYc4fgUaj1rMXXtfqy3OIuhFRlJ/hYGOdz
         Fa/UM95izQRcxR6YKl9O8b3nT8G/jTM63egEcYnJHXurH1VQID+dJgWsLxvdqFzrfLQJ
         Uwc3NJJVx2lP5rdvkX5Gg6aTBRTVyQT9IXVYG/Pmrl4bXnX7jtLtuYiLNQbZF2jv99Wy
         BnHRZi2RRhjF4j53uahPx2U8OfkMOGAG0XcnbaMF4vFT0THkMGj46wHbiqjCpmq2/KGa
         qswIi11NtAzV6cNqoRUzIZnAcHBtS+T1kfJWqiINPGLdoFZgQDPdwdOIWGnfsQ8Lds12
         bNfA==
X-Gm-Message-State: APjAAAVRSyJKqJZqDRx9Qk0der+MOW5yeBZdMmJMkZ5GmidnVeGWDRz0
        xHMpujG3hFJNTriXPH1Wf/M=
X-Google-Smtp-Source: APXvYqyncqqeYoQxQNe4SwOZib3N1XzDI9ZUbBKHw4G85RoUNi5/s+EyoU18m/cNEEfjGlW4PRNmIg==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr6165469wrs.105.1562864114874;
        Thu, 11 Jul 2019 09:55:14 -0700 (PDT)
Received: from [10.67.49.31] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n5sm5189493wmi.21.2019.07.11.09.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 09:55:14 -0700 (PDT)
Subject: Re: [PATCH v6 1/6] ARM: Add TTBR operator for kasan_init
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>, christoffer.dall@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>, jinb.park7@gmail.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Landley <rob@landley.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, thgarnie@google.com,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andre Przywara <andre.przywara@arm.com>,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
 <20190617221134.9930-2-f.fainelli@gmail.com>
 <CACRpkdZGqiiax2m5L1y3=Enw0Q5cLc-idAQNae34uenf-drHDw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <0ad02a64-9470-936c-1db9-0079c0926cfb@gmail.com>
Date:   Thu, 11 Jul 2019 09:54:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdZGqiiax2m5L1y3=Enw0Q5cLc-idAQNae34uenf-drHDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 2:03 PM, Linus Walleij wrote:
> Hi Florian!
> 
> thanks for your patch!
> 
> On Tue, Jun 18, 2019 at 12:11 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> From: Abbott Liu <liuwenliang@huawei.com>
>>
>> The purpose of this patch is to provide set_ttbr0/get_ttbr0 to
>> kasan_init function. The definitions of cp15 registers should be in
>> arch/arm/include/asm/cp15.h rather than arch/arm/include/asm/kvm_hyp.h,
>> so move them.
>>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
>> +#include <linux/stringify.h>
> 
> What is this for? I think it can be dropped.

Indeed, that can be dropped came from an earlier version of the patch.

> 
> This stuff adding a whole bunch of accessors:
> 
>> +static inline void set_par(u64 val)
>> +{
>> +       if (IS_ENABLED(CONFIG_ARM_LPAE))
>> +               write_sysreg(val, PAR_64);
>> +       else
>> +               write_sysreg(val, PAR_32);
>> +}
> 
> Can we put that in a separate patch since it is not
> adding any users, so this is a pure refactoring patch for
> the current code?

Sure, that makes sense, first move all definitions, then add helper
functions, finally make use of them.
-- 
Florian
