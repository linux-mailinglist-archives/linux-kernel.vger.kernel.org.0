Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005D9FE0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfKOO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 09:57:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfKOO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:57:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so11302033wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LhVSGfEhFzAltpE8aRiy3vpD2H1oU8Mhp/p8hqjjUJk=;
        b=eFp7WM7WqUS0dAkxY6zmVayqvN0U6ecqQ2z9n4gKEkYjfdgWqfOUJ6SRplWsNH267a
         GeHWvBzZMtMYR52ly7SOrP4Mfw16hJYy4r1l6lMJwNdXO2jJ95OFpcZRKt1MU5GXXycX
         08wu9HCqA0m9nv2zsmbePJCDfeQwBhrp6wPFYkN9j9BeIxZmWyWEcgmOj8Vwz1LB03dH
         3SbG7jA3F3X7uzg54TzU6pLSRmYdE6ts1OOsD4MoEEqbEI8kt+gNma+lKr0ux6RKbtX8
         gC8cvNt6g7mSf1kvegxJlC2Judje44+s4PXXRWwYNr8c9cxAg1YNBwJth92O7is8ZrPP
         YIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LhVSGfEhFzAltpE8aRiy3vpD2H1oU8Mhp/p8hqjjUJk=;
        b=V/S+K1xLzxmpuaIwcjBPouoOSsh5NruF4+RzeKk5MrA+UaPH2nmReCMNHZW6OGP5fy
         tbSF53UAhgNVcEGh7vfu6v7mLUTz1gzReALMpVSbOIvKbqOvwwYRHY8PTRtC4V7DBrte
         YqsFn/TlCuAHMtt7J9RuP0mO1QwJKadh7BOngJY0R/DGlZkzSgCEc1R+fwGvNjpTNaEV
         Qz4qB9Xade2KLi1TeKP1eR+PMyYpMP9r8LByBNYooro2OdZdVQVfK/CrEx9YuFSHiZDI
         WX6ziWjPvrhO1UoIn5EXz0XH1gg1DzFg53CpR13qNUc+0MtpA6/C8c66d2hPC4tn8obL
         2ipA==
X-Gm-Message-State: APjAAAXrMMeyBsNBh2uhDdB+jzjiBd3eVv1ixbOSCVqzChiR/sey4UFH
        3VjMrPCRSQA1EKOwF6wzXn+a0RBglKsbgw==
X-Google-Smtp-Source: APXvYqwqOQ7MLMABPEV4GiRIClcn1AxUx+OW8p5Iv5Mb6AIt0bAoEipWbmZXhyVfMmLkxa6wYMd/bA==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr16585766wrc.150.1573829855230;
        Fri, 15 Nov 2019 06:57:35 -0800 (PST)
Received: from [10.32.51.158] ([185.149.63.251])
        by smtp.gmail.com with ESMTPSA id q15sm11782035wrs.91.2019.11.15.06.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:57:34 -0800 (PST)
Subject: Re: [PATCH v17 00/19] Multicolor Framework
To:     Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191114133023.32185-1-dmurphy@ti.com>
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Message-ID: <55c6a873-9ed7-0c00-b85b-7a0f7ae7046e@flowbird.group>
Date:   Fri, 15 Nov 2019 15:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191114133023.32185-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 14:30, Dan Murphy wrote:
> Hello
>
> Simple fix in the multicolor code where the extended registration call was not
> called in the devm_* function
>
> Thanks Martin F. for finding this issue.
>
> Hopefully this will be pulled in for the 5.5 merge window.

For patches 2, 3, 4

     Tested-by: Martin Fuzzey <martin.fuzzey@flowbird.group>

I have applied patch 1 to my tree too but, being just documentation, 
it's not testable.

I don't have a lp50xx but have written my own multicolor driver on top 
of this patchset (for a custom LED controller implemented in a MCU).


Martin


