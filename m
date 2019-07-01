Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C289458982
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF0SKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:10:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54781 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF0SKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:10:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so6619182wme.4;
        Thu, 27 Jun 2019 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c+0ZQ9Od+086D/9fGWPHqSpaGVLYjvBvrTlk4zSHV/Q=;
        b=GzM9c5PeEFBSo8uapQ/yfFJMpfD3DoQYdIQryDht0CtNDQxWdcmt2ILkKRYTLMo25m
         YNNT6I0hysDhkC0jOkHLCSfhwEEwc/7lrXi1dyRkw6c7TcaZEDvQixRvnOVXoYCD1MR+
         Yjh+Wy9FLHU7IwOVnUlR2vPBpqVzN+4H4Eb8cd4BsiQrwRm4hRBCRFN3pS2awLHXFTsD
         ouO+kX0KsZ+Dtm79OekfZlEvYoUSnfrjKj8wmqOIlyMxNmemVSM2yQ2nMM6aqFzY8gBn
         RcASzY8DWfZ142+deLM8OQGE1sFEOBSRXTqWuSQwOiEA8qYtYVvdnhiP3gWlUcgum2vC
         yxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c+0ZQ9Od+086D/9fGWPHqSpaGVLYjvBvrTlk4zSHV/Q=;
        b=f0sQbhMeBoIHScwPQ/HTnYeBVt00o0+FmXMSST4JrLoosXXAN+pL7Gos6yJYxpusxf
         T8ke6N76NGp84/XXVta9/ts/dUDIiV9w47Xs9M6R9GTqiwo4Py2DvxI9LjVCbxodNoxS
         XwjF8BDC+6oJ+ZGHmKKrxRjedLObmLS89fE+zlM9NJ+WyQaH1Z+BqpBdSJUyILGVV0RP
         ToRpIELfFjcYRrpxRU+YmTNxT+zh6XQW7NalfWza45lJzzxpNpGAzGQ1+s98hOfRv3mA
         S29K74I1u52+VScu4Ws7ACyEMqEDXFzN6RvtJ4Z5iPxMFShvF3C/jKC5dye9YWeYQ+4a
         ZbWA==
X-Gm-Message-State: APjAAAWCdVXVjamXUDxwDH+c8pLu3J2A5Ig0skEE/v3duUIuObBOHArP
        lrl17W7zg/ntJfSG5mtHlWY=
X-Google-Smtp-Source: APXvYqwKje19Mf3kwwP4DXyn4gPXouc6Ky887LFnCqTQk2/9HnAefzFvuqUqRU6vycHsxmv59+cJQQ==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr4314069wml.90.1561659015084;
        Thu, 27 Jun 2019 11:10:15 -0700 (PDT)
Received: from [10.67.50.91] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c1sm5012340wrh.1.2019.06.27.11.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:10:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
 <AM0PR04MB44814D3BD59033ECDDE3094C88E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com>
 <20190626170919.GC13572@e107155-lin>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz7QnRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+iGYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSC5BA0ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU4hPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJ7kCDQRXG8fwARAA6q/pqBi5PjHcOAUgk2/2LR5LjjesK50bCaD4JuNc
 YDhFR7Vs108diBtsho3w8WRd9viOqDrhLJTroVckkk74OY8r+3t1E0Dd4wHWHQZsAeUvOwDM
 PQMqTUBFuMi6ydzTZpFA2wBR9x6ofl8Ax+zaGBcFrRlQnhsuXLnM1uuvS39+pmzIjasZBP2H
 UPk5ifigXcpelKmj6iskP3c8QN6x6GjUSmYx+xUfs/GNVSU1XOZn61wgPDbgINJd/THGdqiO
 iJxCLuTMqlSsmh1+E1dSdfYkCb93R/0ZHvMKWlAx7MnaFgBfsG8FqNtZu3PCLfizyVYYjXbV
 WO1A23riZKqwrSJAATo5iTS65BuYxrFsFNPrf7TitM8E76BEBZk0OZBvZxMuOs6Z1qI8YKVK
 UrHVGFq3NbuPWCdRul9SX3VfOunr9Gv0GABnJ0ET+K7nspax0xqq7zgnM71QEaiaH17IFYGS
 sG34V7Wo3vyQzsk7qLf9Ajno0DhJ+VX43g8+AjxOMNVrGCt9RNXSBVpyv2AMTlWCdJ5KI6V4
 KEzWM4HJm7QlNKE6RPoBxJVbSQLPd9St3h7mxLcne4l7NK9eNgNnneT7QZL8fL//s9K8Ns1W
 t60uQNYvbhKDG7+/yLcmJgjF74XkGvxCmTA1rW2bsUriM533nG9gAOUFQjURkwI8jvMAEQEA
 AYkCaAQYEQIACQUCVxvH8AIbAgIpCRBhV5kVtWN2DsFdIAQZAQIABgUCVxvH8AAKCRCH0Jac
 RAcHBIkHD/9nmfog7X2ZXMzL9ktT++7x+W/QBrSTCTmq8PK+69+INN1ZDOrY8uz6htfTLV9+
 e2W6G8/7zIvODuHk7r+yQ585XbplgP0V5Xc8iBHdBgXbqnY5zBrcH+Q/oQ2STalEvaGHqNoD
 UGyLQ/fiKoLZTPMur57Fy1c9rTuKiSdMgnT0FPfWVDfpR2Ds0gpqWePlRuRGOoCln5GnREA/
 2MW2rWf+CO9kbIR+66j8b4RUJqIK3dWn9xbENh/aqxfonGTCZQ2zC4sLd25DQA4w1itPo+f5
 V/SQxuhnlQkTOCdJ7b/mby/pNRz1lsLkjnXueLILj7gNjwTabZXYtL16z24qkDTI1x3g98R/
 xunb3/fQwR8FY5/zRvXJq5us/nLvIvOmVwZFkwXc+AF+LSIajqQz9XbXeIP/BDjlBNXRZNdo
 dVuSU51ENcMcilPr2EUnqEAqeczsCGpnvRCLfVQeSZr2L9N4svNhhfPOEscYhhpHTh0VPyxI
 pPBNKq+byuYPMyk3nj814NKhImK0O4gTyCK9b+gZAVvQcYAXvSouCnTZeJRrNHJFTgTgu6E0
 caxTGgc5zzQHeX67eMzrGomG3ZnIxmd1sAbgvJUDaD2GrYlulfwGWwWyTNbWRvMighVdPkSF
 6XFgQaosWxkV0OELLy2N485YrTr2Uq64VKyxpncLh50e2RnyAJ9Za0Dx0yyp44iD1OvHtkEI
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <02f505e2-132c-477a-1e6b-6a060ef3f404@gmail.com>
Date:   Thu, 27 Jun 2019 11:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626170919.GC13572@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 10:09 AM, Sudeep Holla wrote:
> On Wed, Jun 26, 2019 at 09:44:06AM -0700, Florian Fainelli wrote:
>> On 6/26/19 6:31 AM, Peng Fan wrote:
>>>>> The firmware driver might not have func-id, such as SCMI/SCPI.
>>>>> So add an optional func-id to let smc mailbox driver could
>>>>> use smc SiP func id.
>>>>>
>>>> There is no end to conforming to protocols. Controller drivers should
>>>> be written having no particular client in mind.
>>>
>>> If the func-id needs be passed from user, then the chan_id suggested
>>> by Sudeep should also be passed from user, not in mailbox driver.
>>>
>>> Jassi, so from your point, arm_smc_send_data just send a0 - a6
>>> to firmware, right?
>>>
>>> Sudeep, Andre, Florian,
>>>
>>> What's your suggestion? SCMI not support, do you have
>>> plan to add smc transport in SCMI?
>>
>> On the platforms that I work with, we have taken the liberty of
>> implementing SCMI in our monitor firmware because the other MCU we use
>> for dynamic voltage and frequency scaling did not have enough memory to
>> support that and we still had the ability to make that firmware be
>> trusted enough we could give it power management responsibilities. I
>> would certainly feel more comfortable if the SCMI specification was
>> amended to indicate that the Agent could be such a software entity,
>> still residing on the same host CPU as the Platform(s), but if not,
>> that's fine.
>>
> 
> That's completely legal and there's nothing in the specification that
> prohibits. I understand it's not explicitly not mentioned and I have
> been trying to get such things clarified. But since it's main focus
> is on the message protocol, the clarity on transport mechanism is very
> thin and there's hesitation to add more details under the impression
> that it may restrict the usage.
> 
> But as I mentioned, I understand what you need there :)
> 
>> This has lead us to implement a mailbox driver that uses a proprietary
>> SMC call for the P2A path ("tx" channel) and the return being done via
>> either that same SMC or through SGI. You can take a look at it in our
>> downstream tree here actually:
>>
>> https://github.com/Broadcom/stblinux-4.9/blob/master/linux/drivers/mailbox/brcmstb-mailbox.c
>>
> 
> Just curious, I see it's fast call and why do you still depend on
> interrupt to indicate completion of the message. Will the return from
> SMC not suffice ? Sorry if I am missing something obvious.

It is currently used for synchronous delayed responses where the SMC
call returns early, but the operation is carried out asynchronously by
e.g: the MCU that does voltage scaling a few milliseconds later. We'd
rather not block the caller for too long and that's where it stems from.
-- 
Florian


