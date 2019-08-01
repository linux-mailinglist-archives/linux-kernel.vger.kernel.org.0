Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABE7D234
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 02:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfHAASh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 20:18:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39165 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfHAASh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:18:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so32898659pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HguRxYDESCL5JmD3/mYii286Ot+gL1zw7cuRbKsoMmY=;
        b=fpE60V0Oz7+mBNKiTOcj4EUkxAetGX/wmNJhgK4ernSenYAJPgh+Ij9N3u2nOr/yav
         NH48nKJBwoWl3+blv163A+p196VP5Hu+cUjnQF57+psVoBGxe2ppL9fUSyRc3iqFZTqo
         2TdQNowkt631FKm0f0i4Lz2ILGPWArk8W4iCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HguRxYDESCL5JmD3/mYii286Ot+gL1zw7cuRbKsoMmY=;
        b=qkJKtU52oqWcF8q5S689a0Z/cWcbUkzOJl7ERMbDxOs+YWnmrlk/iXo0DmBvNfpWUN
         HK6w+ktPeLsc01FR3cI7T+14dAjV5ASg68m6s/kFRordvmvvZxyvUY3ap/Bc984ikhF9
         s2K3XDEvyFd57JlZq1cBOSB66qfoOx0jo/jkkQunoJlVjoLQj/4VXaoJD4X4xe4nXHpf
         MRZfx/cKPjuagtBkk3ml+ILGB+mmQIOcFtagnXJUUAhdSCOwgQV3udGpUQHsYe0Advy0
         jpqdn/y8cqQc9n2+MxNW2IeRpwvdq4uQJcn00pn291UxTmJgRdz3hlAKIdMh3KQbE8aO
         QCfA==
X-Gm-Message-State: APjAAAVhfgix2B0P5igVkUU/JbZwPPq4oLdKkeui+sU3quKODF4RO3mM
        PzyU6SYFKRtIsuIPK7rgZK/4Ww==
X-Google-Smtp-Source: APXvYqxNJ8MduqZ6+7rAkIRQV7GUlEBbBgSe1TDlqW2OygUA1oI+kELge96nIbD9kxuGgjuJeTil1w==
X-Received: by 2002:a63:784c:: with SMTP id t73mr119574658pgc.268.1564618716666;
        Wed, 31 Jul 2019 17:18:36 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u23sm72272436pfn.140.2019.07.31.17.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 17:18:36 -0700 (PDT)
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-3-scott.branden@broadcom.com>
 <20190523055233.GB22946@kroah.com>
 <15c47e4d-e70d-26bb-9747-0ad0aa81597b@broadcom.com>
 <20190523165424.GA21048@kroah.com>
 <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
 <20190524052258.GB28229@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <2f67db0a-27c3-d13c-bbe0-0af5edd4f0da@broadcom.com>
Date:   Wed, 31 Jul 2019 17:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190524052258.GB28229@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I am now back from leave to continue this patch.  Comment below.

On 2019-05-23 10:22 p.m., Greg Kroah-Hartman wrote:
> On Thu, May 23, 2019 at 10:01:38PM -0700, Scott Branden wrote:
>> On 2019-05-23 9:54 a.m., Greg Kroah-Hartman wrote:
>>> On Thu, May 23, 2019 at 09:36:02AM -0700, Scott Branden wrote:
>>>> Hi Greg,
>>>>
>>>> On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
>>>>> On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
>>>>>> Add offset to request_firmware_into_buf to allow for portions
>>>>>> of firmware file to be read into a buffer.  Necessary where firmware
>>>>>> needs to be loaded in portions from file in memory constrained systems.
>>>>>>
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>> ---
>>>>>>     drivers/base/firmware_loader/firmware.h |  5 +++
>>>>>>     drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
>>>>>>     include/linux/firmware.h                |  8 +++-
>>>>>>     3 files changed, 45 insertions(+), 17 deletions(-)
>>>>> No new firmware test for this new option?  How do we know it even works?
>>>> I was unaware there are existing firmware tests.  Please let me know where
>>>> these tests exists and I can add a test for this new option.
>>> tools/testing/selftests/firmware/
>> Unfortunately, there doesn't seem to be a test for the existing
>> request_firmware_into_buf api.
> Are you sure?  The test is for userspace functionality, there isn't
> kernel unit tests here.  You need to verify that you didn't break
> existing functionality as well as verify that your new functionality
> works.

I managed to figure out how to build and run 
tools/testing/selftest/firmware/fw_run_tests.sh

and my changes don't break existing functionality.

But, I find no use of request_firmware_into_buf in lib/test_firmware.c 
(triggered by fw_run_tests.sh).

Is there another test for request_firmware_into_buf?

>>>> We have tested this with a new driver in development which requires the
>>>> firmware file to be read in portions into memory.  I can add my tested-by
>>>> and others to the commit message if desired.
>>> I can't take new apis without an in-kernel user, you all know this...
>> OK, It will have to wait then as I was hoping to get this in before my
>> leave.
> Throwing new code over the wall and running away is a sure way to ensure
> that your code will be ignored :)
>
> thanks,
>
> greg k-h
