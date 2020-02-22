Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED3D169141
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBVS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 13:27:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45239 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:27:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so5057692qko.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iSt0msnF0ZhwKCGb8Okdz1fIg/M5YVTNd1XK2V2MV/g=;
        b=tYJ2ESlu1tFD+UfI/001XgMEBByJPJaVyN0sZwLIzlBz29lV+eTRKZk54oYApL6K31
         Qixv4ggI/IgoRQTHkUVE7Af6XhUiKa3LhQD93T9r6MKA5gyuLeZim5azELfof3wCRJEM
         FqzPX/PFo337GgqW0K1nS1xTjI5w+uc205lX+Jh5R1lXXKr5CNkvjJDrwf50Uu4wYUDW
         LoDt0S5am2cxTJTyHTq0+sVfQ3bljIW2ddVEPrRCydQ7mrvgA5ffQ8nZjW1WLdd15/c5
         JG0qsDH+y6A7/8iWhgK/BvrlIxqGkJ8VCuvos1h8aYH1/JztPMbNyPvnL+Gs9oju1+2Z
         8hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSt0msnF0ZhwKCGb8Okdz1fIg/M5YVTNd1XK2V2MV/g=;
        b=VocfAm+Ze3mXi9yjIEry1XnAEvVYN3VFaaxnDnX+3jsL5/jnLPOQUYTHeOsxi3CH7I
         87RK3mkiQeIWcARWYLOhBS4P7NcS2dnFzhwDObGqPnD2gY0k4m0Nf4W9ueicKWVLyQm4
         XOXeoQ8qbH9ZrKs3dRtefdT3yFx9auABtmwVKZbPSgPFAmD4RAYw6kxxGR8F64UltuBC
         yO+CKFMl6ZV5/zWYtjnrPD8vEXMSg5la12R6xsD0cGF39C8STOL2Vbrx3C2+NGPhFrLA
         3xiNHVz1aXGCgBDzyJrNsMaOgm9YhtlmF9FxVIx0FUQA4wgeotXzQOOt0QtZaFH/e95V
         hY9g==
X-Gm-Message-State: APjAAAWwdojxwvgUThkJmdiy6eMI/YybPI/3EmJQHDHoYp79EI8BbsNL
        AZXvcpOWwMt3pQ+9nUbo7V4BWg==
X-Google-Smtp-Source: APXvYqxOxxyrz/iCNkESC/H6dFVvOvVrgrQdHhV6KIzj37uxQCea0Op4Ll5OAkWVLXlpek0RvVEElA==
X-Received: by 2002:a05:620a:14b8:: with SMTP id x24mr15752725qkj.210.1582396034342;
        Sat, 22 Feb 2020 10:27:14 -0800 (PST)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id f128sm1024267qke.54.2020.02.22.10.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 10:27:13 -0800 (PST)
Subject: Re: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
To:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <20200222005213.3873-2-thara.gopinath@linaro.org>
 <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <d7890dc4-f5d8-9bad-8473-062c0206da09@linaro.org>
Date:   Sat, 22 Feb 2020 13:27:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/20 7:59 PM, Randy Dunlap wrote:
> On 2/21/20 4:52 PM, Thara Gopinath wrote:
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 2a25c769eaaa..8d56902efa70 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -464,6 +464,10 @@ config HAVE_SCHED_AVG_IRQ
>>   	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>>   	depends on SMP
>>   
>> +config HAVE_SCHED_THERMAL_PRESSURE
>> +	bool "Enable periodic averaging of thermal pressure"
> 
> This prompt string makes this symbol user-configurable, but
> I don't think that's what you want here.

Hi Randy,
Thank you for the review.
Actually I thought being user-configurable is a good idea as it will 
allow users to easily enable it and see if the benefits their systems. 
(I used menuconfig while developing, to enable it).
Do you see a reason why this should not be so?

> 
>> +	depends on SMP
>> +
>>   config BSD_PROCESS_ACCT
>>   	bool "BSD Process Accounting"
>>   	depends on MULTIUSER
> 
> 

-- 
Warm Regards
Thara
