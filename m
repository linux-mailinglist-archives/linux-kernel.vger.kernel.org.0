Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA519BB8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgDBGP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 02:15:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55420 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgDBGP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:15:28 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so1119190pjb.5;
        Wed, 01 Apr 2020 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+qX3LMX0MIUlumP4lRbC3RShy9BjP+VQIG7iWcCQmM=;
        b=lSVMb7oZIvihisTi34Q+A+o3HTODhuRCf7yJKx7MjFqfUXiEn+9MC7yr+8UbiFsXua
         OG4w/G+idptAHe8Xy2IVLQ4Zqx7b6K+a+a4nlh2dAez+4VVlRng1L7UVNSFjqaqDXM7D
         f7kF1RoEUJSo0fihaaWKwxAozdH0Z0oPjTqp1UzZJXq2hrFr3vE7g+XtBmgbjwcA1Y1U
         E6kkMqSAbXUAKz6vTq88pVSWUvATaLPv4pBvN9VM+2kuzvC3y2bMGxnZ1qJ25gL/Eg8X
         fA78UmrODqL1wFMfx618/gmPnSoaHUcNJftTYCNvZCIJlB4gikQgLugsdsB0/79KHc7e
         NbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b+qX3LMX0MIUlumP4lRbC3RShy9BjP+VQIG7iWcCQmM=;
        b=QehjxmKh0LH6nloNghMM5k0MjOg627EUmNNGjyjuG/7O4e8WgtONCORJ2OXmFop6jg
         2hTSCmBGMscZfeGv9Lw+Rqe2jOYSN/nmbIRIuJUmjPA5G1v1QVWM6/O7XMxZ2Pb2Wfgu
         FeH/L4s2tlZcrihD5p4Y8+m+zzniQsmz5aK6DBodvuLqsA/pejkv+RQL9g5tacr1gEXS
         brfXe8VzqWbXOsDB/UFsj5XxQNrtEkc/0CVEbmFDxhQ5lKOPMGfJxr2PArNzgB4ydULT
         ikNtgs4fDwTTJpLBbL/EGla2p9+3G/r1Qk47Nvy5aSG8PkvTvq2MFjOueHT0NLnYdmiw
         zOHA==
X-Gm-Message-State: AGi0PuY7GivIoWzJrNOgKVyBuG3haGNt/8l/dc7Vi3VttPFm+Bcu91QC
        KcHEQlCJKY94OP8KT2rxMxDWgpEj
X-Google-Smtp-Source: APiQypLotK/ET+MlesGDWy2F8ZyXrdZMiNvHSAmQyVK2TQW/uh0tDzV+J/wasPsqH5Y2vosywQzvRw==
X-Received: by 2002:a17:90a:1acd:: with SMTP id p71mr2124116pjp.112.1585808126022;
        Wed, 01 Apr 2020 23:15:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nl7sm3099497pjb.36.2020.04.01.23.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 23:15:25 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (dell-smm) Use one DMI match for all XPS models
To:     Thomas Hebb <tommyhebb@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org
References: <be17c0a111983e886d871db8dc2fc8fbfe8e2da0.1585800134.git.tommyhebb@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a7ee8173-bbb8-a68c-8b46-da2174cd08ad@roeck-us.net>
Date:   Wed, 1 Apr 2020 23:15:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <be17c0a111983e886d871db8dc2fc8fbfe8e2da0.1585800134.git.tommyhebb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 9:02 PM, Thomas Hebb wrote:
> Currently, each new XPS has to be added manually for module autoloading
> to work. Since fan multiplier autodetection should work fine on all XPS
> models, just match them all with one block like is done for Precision
> and Studio.
> 
> The only match we replace that doesn't already use autodetection is
> "XPS13" which, according to Google, only matches the XPS 13 9333. (All
> other XPS 13 models have "XPS" as its own word, surrounded by spaces.)
> According to the thread at [1], autodetection works for the XPS 13 9333,
> meaning this shouldn't regress it. I do not own one to confirm with,
> though.
> 
> Tested on an XPS 13 9350 and confirmed the module now autoloads and
> reports reasonable-looking data. I am using BIOS 1.12.2 and do not see
> any freezes when querying fan speed.
> 
> [1] https://lore.kernel.org/patchwork/patch/525367/
> 
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
> 
>  drivers/hwmon/dell-smm-hwmon.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index d4c83009d625..c1af4c801dd8 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1087,14 +1087,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_config_data[DELL_STUDIO],
>  	},
> -	{
> -		.ident = "Dell XPS 13",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS13"),
> -		},
> -		.driver_data = (void *)&i8k_config_data[DELL_XPS],

So .driver_data is no longer needed for xps 13 models ? Really ?

Guenter

> -	},
>  	{
>  		.ident = "Dell XPS M140",
>  		.matches = {
> @@ -1104,17 +1096,10 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>  		.driver_data = (void *)&i8k_config_data[DELL_XPS],
>  	},
>  	{
> -		.ident = "Dell XPS 15 9560",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9560"),
> -		},
> -	},
> -	{
> -		.ident = "Dell XPS 15 9570",
> +		.ident = "Dell XPS",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS"),

Quite frankly, I'd want to have this tested on many more models.
I don't really want to deal with the fallout if it doesn't work
on all xps a3 and xps 15 systems, especially since Dell doesn't
support the BIOS interface used by this driver.

Guenter

>  		},
>  	},
>  	{ }
> 

