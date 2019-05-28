Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4A2BCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfE1BY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 21:24:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38737 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfE1BY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 21:24:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so9908639pgl.5;
        Mon, 27 May 2019 18:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHQw3lav/PBIHSEk7xB4IRyMHMKQnV3Yd1OKzaDUdNw=;
        b=TjEyV+y2Y0Fl1Vj/eJZJERcicDndhnZZT+aoUQOBJkgcpdo7s/p79ZM+xG7as7WOuO
         BTO6HQGTSpTZk2Gsm/NjAa6T/6i51DGofyV4kn9dIyqRfeaLBRXaGc+K+fZYWvJD10vV
         Id4gCD0aPSxJu+SRnBXbOxeVqbGa9DV1iReRpJFzU73PdExuzhHR5IcponblJ7s28gDE
         BSOS8hQoTRKT5XHB4iNCBXXqHSQ6CJAkAK6/4RonYE+eoPH4vRzir+2ylJcqQs9roa5E
         cFQkJbm/4oJTfjCiLSlAAg3P5qPtNbAhhEH2zSLmRuPjYw4UN2pyvOtwLaxbe0xffvsV
         DZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHQw3lav/PBIHSEk7xB4IRyMHMKQnV3Yd1OKzaDUdNw=;
        b=cTPCzhrxKzlDS6vAKqjCBZTanBVJVrZTOeEqhM21zBT2aV+nexxCVE6bDk+5JWBAgZ
         pWA8JXkVV9XdvU7ql90k6Q+CqOkH5NJ8Qs+bHg4nxgndRcmC1K3Qfs88kd6M3NdyLtf4
         jxdbLukPvJyN67gkQ8o6Kc6jhyGZrGIwCWuY/gv8G6619WgCzXS0UDa4eHvsDWi/taJF
         7MtrD+4p/y2SAlhe1GY5d9IeNt+zgnfSzXHipLVJCwkTIg3fxYHmYItBHzIP9j4/ylCl
         U64O0WUt9LQw0Kmfj4jcgr6q8+5Ft7Tob/TsmEtqTTOYNKUhx/M+pofuIQklJYvteYGr
         koLA==
X-Gm-Message-State: APjAAAWlaXkKGp0XO9Xi0R5tQP5lcZ2IlUdzW2Hh/GqeBbPM5VWcAkoW
        0pjMoyUjWV9YUtYd4+qnN9B6Tqs9
X-Google-Smtp-Source: APXvYqy176OmHchT2D5BqWNdzPy9F8pGN2V36nTv/+7X1hl8oMmQpSunDo+JID9e8IS5U/tY3JZlRg==
X-Received: by 2002:a17:90a:3569:: with SMTP id q96mr2117324pjb.14.1559006665631;
        Mon, 27 May 2019 18:24:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm13094111pfj.93.2019.05.27.18.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 18:24:24 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (smsc47m1) fix outside array bounds warnings
To:     Jean Delvare <jdelvare@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190521044456.26431-1-yamada.masahiro@socionext.com>
 <20190522170848.198ccea6@endymion>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d5b1d8f4-af0a-03e7-8480-3caf593214ee@roeck-us.net>
Date:   Mon, 27 May 2019 18:24:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522170848.198ccea6@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 8:08 AM, Jean Delvare wrote:
> Hi Masahiro,
> 
> On Tue, 21 May 2019 13:44:56 +0900, Masahiro Yamada wrote:
>> Kbuild test robot reports outside array bounds warnings:
>>
>>    CC [M]  drivers/hwmon/smsc47m1.o
>> drivers/hwmon/smsc47m1.c: In function 'fan_div_store':
>> drivers/hwmon/smsc47m1.c:370:49: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>>    tmp = 192 - (old_div * (192 - data->fan_preload[nr])
>>                                  ~~~~~~~~~~~~~~~~~^~~~
>> drivers/hwmon/smsc47m1.c:372:19: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>>    data->fan_preload[nr] = clamp_val(tmp, 0, 191);
>>    ~~~~~~~~~~~~~~~~~^~~~
>> drivers/hwmon/smsc47m1.c:373:53: warning: array subscript [0, 2] is outside array bounds of 'const u8[3]' {aka 'const unsigned char[3]'} [-Warray-bounds]
>>    smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
>>                               ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> 
> These messages are pretty confusing. Subscript [0, 2] would refer to a
> bi-dimensional array, while these are 1-dimension arrays. If [0, 2]
> means something else, I still don't get it, because both indexes 0 and
> 2 are perfectly within bounds of a 3-element array. So what do these
> messages mean exactly? Looks like a bogus checker to me.
> 
>> The index field in the SENSOR_DEVICE_ATTR_R* defines is 0, 1, or 2.
>> However, the compiler never knows the fact that the default in the
>> switch statement is unreachable.
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>   drivers/hwmon/smsc47m1.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
>> index 5f92eab24c62..e00102e05666 100644
>> --- a/drivers/hwmon/smsc47m1.c
>> +++ b/drivers/hwmon/smsc47m1.c
>> @@ -364,6 +364,10 @@ static ssize_t fan_div_store(struct device *dev,
>>   		tmp |= data->fan_div[2] << 4;
>>   		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>>   		break;
>> +	default:
>> +		WARN_ON(1);
>> +		mutex_unlock(&data->update_lock);
>> +		return -EINVAL;
>>   	}
> 
> So basically the code is fine, the checker (which checker, BTW?)
> incorrectly thinks it isn't, and you propose to add dead code to make
> the checker happy?
> 
> I disagree with this approach. Ideally the checker must be improved to

Me too. I understand and accept that we sometimes initialize variables
to make he compiler happy, but this goes a bit too far. We really should
not add dead code - it creates the impression that it can be reached,
and would live forever for no good reason.

> understand that the code is correct. If that's not possible, we should
> be allowed to annotate the code to skip that specific check on these
> specific lines, because it has been inspected by a knowledgeable human
> and confirmed to be correct.
> 
Agreed.

> And if that it still not "possible", then the least intrusive fix would > be to make one of the valid cases the default. But adding new code
> which will never be executed, but must still be compiled and stored,
> no, thank you. Another code checker could legitimately complain about
> that actually.
> 
> IMHO if code checkers return false positives then they are not helping
> us and should not be used in the first place.
> 
Checkers are always only providing guidelines and should never be taken
at face value.

In summary - NACK.

Guenter

