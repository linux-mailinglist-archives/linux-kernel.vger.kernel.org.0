Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41FEFD142
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 00:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKNXBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 18:01:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33352 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:01:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so8679753wmb.0;
        Thu, 14 Nov 2019 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMb2gGIGBy8Y4g8q0F79Vcw8ulQafQxvuTBGmskEwT4=;
        b=LUduz5XwBCTgXwIJcqEpUyULFEbUkb09m8AbYH3mkbDPVrzwoKdMpvOdUNuz7WaZMF
         +9Sy81knRip4DfNWRgr69NQFfLp5QKT2CygIZxiNGxotIeTwFuu57ewKKBsTXMX6ecW9
         67+FjXnq52EpJ9q4ZPVjKzhb+LgMqSf2s7BTOt+pXDmDnSjvTlKPCVGTwVcPdqC6OmxJ
         1o8eybenY59mq680Chd9OTHQ849LTUo4LG3fN22lWwd1WDiy58HeFFJZ/vfm1TYEmNtU
         tXFUtAbTMbnGKKNqBtYhDjx8moTrnCs0sUl8dwwACxUTxETw++0DA8N0ULOoCJUD5zi0
         AEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vMb2gGIGBy8Y4g8q0F79Vcw8ulQafQxvuTBGmskEwT4=;
        b=sw+eAQ0Xpy8w0ToR+1bHywkkBg+ANXa+syOou3Vzy/MgRKrEp4vhQCjTNlkhZrN8h5
         wKsGmXRFpg1aPCdJvx0dghvhmgE6ZL0+wGlYLOqPnW7u9TH3ZcfNBBUE4czEcHacJfeb
         raAsNzLszrJ4f38VrEALg2FzlS6qxKKnf8QUMFwC6dcriysXzsPmTt3vxy6+xdp/SyjA
         vJlBMQvP5fB7nv9j2Sqzt6NrlKqCnm3VxEgArMh7Apey8WtrAdMwFrH/QpH9NycRlm4o
         QTOGvGksozwr+lRtwOV3qqMQDFtKasTiag29pINaVcAIVUzn9xc/5dy64G1EG1s/87My
         AfeQ==
X-Gm-Message-State: APjAAAVh3vRzZgTEY0et1uEute/Lp+l4gcG1ORx1LZP5gp6U2mbBMUWI
        hj85UPp9Hypdajl+b/21VbA=
X-Google-Smtp-Source: APXvYqzYGk2vVTEJA3tyq75TRhbLDS2DTOUhB1B1jO7jEhzSdleHCwuCR4jxR4AT2/VcPRx9S7fMGg==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr10745475wml.21.1573772489081;
        Thu, 14 Nov 2019 15:01:29 -0800 (PST)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s8sm467507edj.6.2019.11.14.15.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 15:01:28 -0800 (PST)
Subject: Re: [PATCH v6 0/6] KASan for arm
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, mhocko@suse.com,
        julien.thierry@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        yamada.masahiro@socionext.com, ryabinin.a.a@gmail.com,
        glider@google.com, kvmarm@lists.cs.columbia.edu, corbet@lwn.net,
        liuwenliang@huawei.com, daniel.lezcano@linaro.org,
        linux@armlinux.org.uk, kasan-dev@googlegroups.com,
        bcm-kernel-feedback-list@broadcom.com, geert@linux-m68k.org,
        drjones@redhat.com, vladimir.murzin@arm.com, keescook@chromium.org,
        arnd@arndb.de, marc.zyngier@arm.com, andre.przywara@arm.com,
        philip@cog.systems, jinb.park7@gmail.com, tglx@linutronix.de,
        dvyukov@google.com, nico@fluxnic.net, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, linux-doc@vger.kernel.org,
        christoffer.dall@arm.com, rob@landley.net, pombredanne@nexb.com,
        akpm@linux-foundation.org, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, kernel@pengutronix.de
References: <20190617221134.9930-1-f.fainelli@gmail.com>
 <20191114181243.q37rxoo3seds6oxy@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <7322163f-e08e-a6b7-b143-e9d59917ee5b@gmail.com>
Date:   Thu, 14 Nov 2019 15:01:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114181243.q37rxoo3seds6oxy@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marco,

On 11/14/19 10:12 AM, Marco Felsch wrote:
> Hi Florian,
> 
> first of all, many thanks for your work on this series =) I picked your
> and Arnd patches to make it compilable. Now it's compiling but my imx6q
> board didn't boot anymore. I debugged the code and found that the branch
> to 'start_kernel' won't be reached
> 
> 8<------- arch/arm/kernel/head-common.S -------
> ....
> 
> #ifdef CONFIG_KASAN
>         bl      kasan_early_init
> #endif
> 	mov     lr, #0
> 	b       start_kernel
> ENDPROC(__mmap_switched)
> 
> ....
> 8<----------------------------------------------
> 
> Now, I found also that 'KASAN_SHADOW_OFFSET' isn't set due to missing
> 'CONFIG_KASAN_SHADOW_OFFSET' and so no '-fasan-shadow-offset=xxxxx' is
> added. Can that be the reason why my board isn't booted anymore?

The latest that I have is here, though not yet submitted since I needed
to solve one issue on a specific platform with a lot of memory:

https://github.com/ffainelli/linux/pull/new/kasan-v7

Can you share your branch as well? I did not pick all of Arnd's patches
since some appeared to be seemingly independent from KASan on ARM. This
is the KASAN related options that are set in my configuration:

grep KASAN build/linux-custom/.config
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=1
CONFIG_TEST_KASAN=m

are you using something different by any chance?
-- 
Florian
