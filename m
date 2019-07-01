Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B6A5AC91
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF2Qfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 12:35:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41484 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfF2Qfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 12:35:33 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so19199742ioc.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bLcPXD293myVNKmMw/+HXfUyYNiVcqiviMrBWHy3K0=;
        b=nJ6hEyg3jX+4MXvvPdz75vPCWZ2LYuqhZlzSd2zW1dmPKZqnhrUgLqvgF/PsHutTn1
         FcygzfAPw9KHygKpqg4jYfhQLrZXU98FkC8Vdc1iz30YuoCBql104JBsQPdRWOuDAhjg
         IPaxQAFpuJgK+qNSYBvTQPh4rt8wZAdh/7AR/3PWzoJXQhrlkByBcivaW7AAfA8XIwOQ
         vnO4SQaeJ16m3ncYWHqkK4mOqvDBwBVQfcERw+KuEThU972nXv02cPJur8AebwXmLhMQ
         tGdJc5vwfxoV/88tzdDVu7b1hUdZ2iz5PSCoBNrzeDWr/f4yx4oa1Y13bKmuXaFFHK6O
         C/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bLcPXD293myVNKmMw/+HXfUyYNiVcqiviMrBWHy3K0=;
        b=hE7sJHdsNzosJC9a+JIPbwMveQB4lKApSypTg2uH0l5sBRTcm99H97r29N5GT30+II
         T3cd5DkDl9gTQqUMADi6Qb2PtaWsckmnrl1OZoGQkoW5SrCdbif0fZfWWQOIJLltmPwi
         o+QPzTZ1cATraMmiWmp/0UAvRvkLuxYRrB/kQuh8B+JaCYVWOySbWLTpPFTDJXTVco7P
         x9FgB5xgArhyBNROvuAB0kSUz7vpv9iGtVoATNqdNCcP8XKKfpQXllMmfWzWBl7wTW3v
         FO+xo3SYpwiX13Jh2W+FKt9zYaMrGE9EVi6K6TrSYB3xVFaTcStsSbTLrluj62jumO1u
         V5xw==
X-Gm-Message-State: APjAAAUUJfQ7eujCZHxg7qm/g0ncPsYNoXoZO4Qwm5opI2giRB8U9foX
        1F8fcTELPU/C7VdKkRXncHC0XA==
X-Google-Smtp-Source: APXvYqy2wRKtN2cvMlA/F9Z2nWcwqtokFG7YSVfK/YCihAPLXVBzuTMTb6+TFylxQ7+N2cD40p3C3Q==
X-Received: by 2002:a02:a48f:: with SMTP id d15mr18068186jam.12.1561826132648;
        Sat, 29 Jun 2019 09:35:32 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r24sm4260675ioc.76.2019.06.29.09.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 09:35:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
To:     Scott Bauer <sbauer@plzdonthack.me>
Cc:     jonathan.derrick@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
References: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <7ee5d705c12d770bf7566bce7d664bf733b25206.camel@intel.com>
 <20190629161947.GA20127@hacktheplanet>
 <d3074ee1-0506-511d-c29c-44effb4eda97@kernel.dk>
 <20190629162835.GA21042@hacktheplanet>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb37028f-bff9-92a6-4ecd-efe938274d24@kernel.dk>
Date:   Sat, 29 Jun 2019 10:35:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190629162835.GA21042@hacktheplanet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/19 10:28 AM, Scott Bauer wrote:
> On Sat, Jun 29, 2019 at 10:26:52AM -0600, Jens Axboe wrote:
>> On 6/29/19 10:19 AM, Scott Bauer wrote:
>>>
>>> Hey Jens,
>>>
>>> Can you please stage these for 5.3 aswell?
>>
>> Yes, looks fine to me. But it conflicts with the psid revert in terms
>> of ioctl numbering. You fine with me renumbering IOC_OPAL_MBR_DONE to:
>>
>> #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
> 
> Sorry for the conflict. That's fine. I'll fix up userland tooling.

Renamed 232 -> 233, and 233 -> 234, for the two conflicts. So now we have:

#define IOC_OPAL_PSID_REVERT_TPR    _IOW('p', 232, struct opal_key)
#define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
#define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)

-- 
Jens Axboe

