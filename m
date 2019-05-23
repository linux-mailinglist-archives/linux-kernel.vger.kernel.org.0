Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC1283D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfEWQgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 12:36:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41039 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfEWQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:36:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id f12so2961581plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZHrK+VEAX/VhtgbnGngaaCqD5utZFEMM219guRaxE+E=;
        b=GorN/Qui+MVXqMMHGzBJqclGX9G6qBILF4AZy7hy0J2Jkz9bJv5a/lgqT77AO7krgL
         t5pCAjjuJBDRMa2gSHydXKIZze53hCW2b2ix5/3EWQv556/nTMUaIHDAr2/emt1R90rs
         dXn0pYf1PUHGFpkIoQWqHfXwJwBLb1vxtNl4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZHrK+VEAX/VhtgbnGngaaCqD5utZFEMM219guRaxE+E=;
        b=j1k44vSwz2qIy386oY5Oo9uJKMFKDLpNiMxSYbbqVsXxSIerLBI/Ec2ePkq9Jg2JZV
         UwBI63iigf8PHdJzxwbBaoUwcKc2t5O/bZ9AVoVwyXmeAiiRLrDb1P8hpIgbke04IRoL
         k+HprgtZDWb3nZ/vs1HC2YWTb19KY/i3ZSF1cfIpBh2hReUnVu2abqjh8GF0D0zkPtfq
         hO1pcEubrBFx7zPYbVSsEsTDKUpg7OK8WHWpdeKxpCGYdmwBPhQ97WDQiO0ScJFa/cL5
         60/MLKn6yCSzfsURoTzwtdSbrBZrCYC3VRgQ7gq9wTtjhQeAjm7PmfIw51p9oKZCooGM
         GLHA==
X-Gm-Message-State: APjAAAXqaR+HtgWl0i4+EXCrAoe5ZwsHdzujS2Ghv6kXpfE5pOPDlBeP
        h1gqCEgBzmOhkIU860QQDRPZew==
X-Google-Smtp-Source: APXvYqxzC+ORWnTrrOuRAOV5GhS5hVztdWBZSW4dRBg2tKPt3YliHLug2gmkP3GPmyVy614jfIqcmg==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr77186915pls.146.1558629365385;
        Thu, 23 May 2019 09:36:05 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q75sm41467250pfa.175.2019.05.23.09.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:36:04 -0700 (PDT)
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <15c47e4d-e70d-26bb-9747-0ad0aa81597b@broadcom.com>
Date:   Thu, 23 May 2019 09:36:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523055233.GB22946@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
>> Add offset to request_firmware_into_buf to allow for portions
>> of firmware file to be read into a buffer.  Necessary where firmware
>> needs to be loaded in portions from file in memory constrained systems.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/base/firmware_loader/firmware.h |  5 +++
>>   drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
>>   include/linux/firmware.h                |  8 +++-
>>   3 files changed, 45 insertions(+), 17 deletions(-)
> No new firmware test for this new option?  How do we know it even works?

I was unaware there are existing firmware tests.  Please let me know 
where these tests exists and I can add a test for this new option.

We have tested this with a new driver in development which requires the 
firmware file to be read in portions into memory.  I can add my 
tested-by and others to the commit message if desired.

> :)
>
> thanks,
>
> greg k-h

Regards,

Scott

