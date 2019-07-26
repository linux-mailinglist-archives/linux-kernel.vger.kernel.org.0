Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8C76BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfGZOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:46:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44263 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfGZOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:46:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so51714431ljc.11;
        Fri, 26 Jul 2019 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ngavBtIxx1ZHHLm1jYRPvkhoDxTlTbQTiXBro1aKL/s=;
        b=PxfsFPU8+IUqWCWe+i72ZKO9kQh18DVzKU2MLFKKOUpu5zex1eZBUZVZ+AhQ61nVY4
         SK/9FEv8qOzyrSKLURXLa4fZn5XC84S4KSZn59mfqvGCTaTfzEc0knttSfT8VuoL4pT1
         nklzDsJ0jGn+ZdIn3FLHFxswbaaWyxaM3LgrREUYhhHUhqyRBuolf6eNYIGKYOGbIyO0
         EnxIoiToxgUEjTG7UkwOXT7MKntPT4NLWiXfxzsxBDxLLICGnwKApbyvYBCXZV93F6KT
         WSy7yWZBIML9Y9AhYqW7VG19j8Hvv7uIg1uNS/Mjnvx60aZcdxY+cM9RbUTD8bMH+d5g
         HoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngavBtIxx1ZHHLm1jYRPvkhoDxTlTbQTiXBro1aKL/s=;
        b=T2TROr8krykIGUTBifE5AYuzCMxdNboZmAia2Nn31vxX+fRh1mvClxC18TQ1LzkitP
         I3KR+tFnxmRdCmiQM1CR3SckKF6wpmvuo3yYKY4Z8EUEX+uxg6p+tzGds/23x3unwykh
         zWQYd2yBlAs/ZCBNQkAO7xXrRn9gK5etJGnxB6l2zsoaWbeX3vdlP8WAmeiTXYsPpuHd
         wQTnTrSt2y43ywWQfu39gZ/QXfwGLw/UiC9bBkI08j+1zlvE2NfVU/tyJOZ+OcCkYLrs
         1Q9YmMNESCQDAD5a54RYwlJCmfCcZa0Qnqf7KwFHDGabQ0wA1CHqPob6tzR53PBCv7gF
         ZLaA==
X-Gm-Message-State: APjAAAVgzd9AFBbiE78kdLq3HJ+bUdtCLT0zqctGL1+d3Brwe6uV67MN
        BIywteuVHl2pHr/kNIZDmzmlub0W
X-Google-Smtp-Source: APXvYqxEAMHAtYXYoiYX0iqT9+JIeGKN9tzZGsYw27N7E++ru7XERerKKxfyYKK/DkJSuJojP+2vCQ==
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr50209286ljq.128.1564152377358;
        Fri, 26 Jul 2019 07:46:17 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id h10sm8515352lfp.33.2019.07.26.07.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 07:46:16 -0700 (PDT)
Subject: Re: [PATCH] drm/tegra: return with probe defer if GPIO subsystem is
 not ready
To:     Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com
Cc:     airlied@linux.ie, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180726133606.14587-1-stefan@agner.ch>
 <de84d04c902d1f7f22b6f024b853a1c7@agner.ch>
 <cd14bca0a1f1e097265602a1d5f0c0f5@agner.ch>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f035a8ba-ffa7-b98b-a444-db8b4bbd34ec@gmail.com>
Date:   Fri, 26 Jul 2019 17:46:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cd14bca0a1f1e097265602a1d5f0c0f5@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.07.2019 17:23, Stefan Agner пишет:
> Hi Thierry, Hi Dave,
> 
> On 2018-09-07 01:31, Stefan Agner wrote:
>> On 26.07.2018 06:36, Stefan Agner wrote:
>>> If the GPIO subsystem is not ready make sure to return -EPROBE_DEFER
>>> instead of silently continuing without HPD.
>>>
>>> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> I think this did not get merged yet, any chance to get it in?
> 
> Any chance to get this in in the next merge window?

The patch isn't relevant anymore (since v5.3) because the code was
changed and now propagates the proper error code in a case of error,
please see [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.3-rc1&id=bbad640709fd43ff77b8838c409c977c0b28430c
