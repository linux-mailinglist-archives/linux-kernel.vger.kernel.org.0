Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35C181DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgCKQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:34:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729809AbgCKQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583944450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0UQBcv3ClfkZ3GTWOkSjQXsHKOgPqPeFIPaUV59z/Q=;
        b=KeVuR3rTpuYOJl/b6STrfy9OheahvUbm6uiuCzHpBAmi6nJOQ1ZfXiMScv7+GWcvkQfzH1
        PHNfEvhPu+6YZcZE/YtNtw5DcNSCJmkE5KhEmmhGcLo88VAcpTz1Sf2c1d3FQ7At4bSge1
        mAfpckwvzG5fSBYqaXzLmojP+vyWMK0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-TDU8xIAONriR0ZKt1nhKAg-1; Wed, 11 Mar 2020 12:34:06 -0400
X-MC-Unique: TDU8xIAONriR0ZKt1nhKAg-1
Received: by mail-wr1-f72.google.com with SMTP id v6so1173123wrg.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o0UQBcv3ClfkZ3GTWOkSjQXsHKOgPqPeFIPaUV59z/Q=;
        b=Y8Lzqojb8TsWe0tNI+DKjWdR8tYKrGrgRhj4VlpUI5bNboHnYuoshDcQGx7Ll0msOc
         qWFMX5r0wIuJVRhZ21F7PWMNbk+lpsVuWZGGf3rHMqaECjrktObLsR0tgafFyISAgudI
         b/ysFHY5aUcZYzJDZehdpmTG7+LP8EvL5a0JiRQwASLkJnx5ujRhlXC9ID+BVhfyGbaY
         lXZBEG89fqND0oY1aIj187yJS44fY4gZi3Vi4m9N5ihDpygikWbzUvDtTkS4zYU3Evws
         7GDwK7pW2XK6vvEeTCpKIR6a7TKfuiHrSpYpGOeMCREGmpg9KIqhxRJ5tSZ1LNXvzaF8
         tkGA==
X-Gm-Message-State: ANhLgQ06R5M6P1qZVcPT3PhsX6KlSej1E8zYGKNx3T49EAE8oA9/cogi
        hJaDOgozjozw1cWbQBgcZm1frWTVusilqeesi/MHDXIz9zW10JyXdAxq4PBNSUbu1BeMAxj4+aA
        FnYyVpmH6SmO7Ro9J9gVyia+d
X-Received: by 2002:a7b:c854:: with SMTP id c20mr4344406wml.99.1583944444069;
        Wed, 11 Mar 2020 09:34:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvtmn/4eDyZpJUKinhyyJiHE9nSuqnqU/lemHqk65BXNDC8q15OnTZCYjUR74KbeSE/DsoD3g==
X-Received: by 2002:a7b:c854:: with SMTP id c20mr4344393wml.99.1583944443866;
        Wed, 11 Mar 2020 09:34:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id c23sm9228728wme.39.2020.03.11.09.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:34:03 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
To:     chi-hsien.lin@cypress.com,
        Christopher Rumpf <Christopher.Rumpf@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>
Cc:     linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
 <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
 <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
Message-ID: <0a5933fc-ae5f-07fa-2e36-8924ea5c2b27@redhat.com>
Date:   Wed, 11 Mar 2020 17:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/5/20 4:50 AM, Chi-Hsien Lin wrote:
> (+Chris)
> 
> On 03/04/2020 7:45, Hans de Goede wrote:
>> Hi,
>>
>> On 2/26/20 11:16 PM, Hans de Goede wrote:
>>> Hello Cypress people,
>>>
>>> Can we please get updated firmware for
>>> brcm/brcmfmac4356-pcie.bin and brcm/brcmfmac4356-sdio.bin
>>> fixing CVE-2019-15126 as well as for any other affected
>>> models (the 4356 is explicitly named in the CVE description) ?
>>>
>>> The current Cypress firmware files in linux-firmware are
>>> quite old, e.g. for brcm/brcmfmac4356-pcie.bin linux-firmware has:
>>> version 7.35.180.176 dated 2017-10-23, way before the CVE
>>>
>>> Where as https://community.cypress.com/docs/DOC-19000 /
>>> cypress-fmac-v4.14.77-2020_0115.zip has:
>>> version 7.35.180.197 which presumably contains a fix (no changelog)
>>
>> Ping?
>>
>> The very old age of the firmware files in linux-firmware is really
>> UNACCEPTABLE and very irresponsible from a security POV. Please
>> fix this very soon.
>>
>> If you do not reply to this email I see no choice but to switch
>> the firmwares in linux-firmware over to the ones from the SDK which
>> you do regularly update, e.g. those from:
>> https://community.cypress.com/docs/DOC-19000
>>
>> Yes those are under an older, slightly different version of the Cypress
>> license, which is less then ideal, but that license is still acceptable
>> for linux-firmware (*) and since you are not providing any updates to
>> the special builds you have been doing for linux-firmware you are
>> really leaving us no option other then switching to the SDK version
>> of the firmwares.
> 
> Hans,

<snip>

> Chris owns the Cypress firmware upstream strategy and will explain our going-forward strategy to you.

Ping? It has been a week and we have not heard anything from Chris about this yet?

Regards,

Hans

