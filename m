Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33BC140E33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 16:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgAQPqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 10:46:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40545 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:46:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so23065366qkg.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aXZ8dXipx6gFHTzlZBKcAhtcTbuZkHXOw3MBG8REHQA=;
        b=HegVRoAO4kMTIt90rQGA39HtXtJXVmvKVrpE6/u20wm+oJfhSz26yhmzo0vjFbO1DC
         Rhgvpkzw7S2fxTnxZmkdMSj6djbwmZ+WMUX+kp8iWMUPt101PoqkoH5WcPnpYP2t8aic
         eEc4SGR8+EWpsZOgLU5wo7y1DtqZewyZ4ruzO5wlU3oQr6NvcsIlzEjKM9qVCN4RE+G0
         kSuzamHF1qvTLpboq0ag5aPjWtx7Es95iqEiGVjsC24Atc/NiYyT8QRND4qFHM3tDC8c
         Clu3uX9zDEtE4HXZcrxypytsfrL9AzjZa4Y1W8NcmzP4EX6krDUunsUW+YdFwlsGaGVX
         W2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aXZ8dXipx6gFHTzlZBKcAhtcTbuZkHXOw3MBG8REHQA=;
        b=bwUF6K5TLdHtGaeXuEBnum5uyBFEjvD3wZX9V6x99kTHlfra9eKkpNqNgYbr385RoX
         lYXG3chsbHvBx5qvpChwZthaabEP4S92f/mv8F1U7kmlsNH6oM14GpA2aCzv9S2Ar5nZ
         r74/uIuu1zPPeVWvbjPQ9QVQZDlcDTvAgQD/kSNQM2uQ7R8oXabyQ4Pytz41FyXq7sSF
         Hg6lzpXg1fXeXj4I7780sOOAXIQMuoyaJpfjOe8TeNAuj76BtbKeshwR8Bu0koV4kOGr
         j4SFZZaHDpx5ZpDDTE/+NJRDbpKDJk/h8R8CnIDYUDMmVLC5jJSAsXLDB1jA+Jl7PeBx
         xsSw==
X-Gm-Message-State: APjAAAWmI3Sesq4FrAEgdHHanvZTRfkD1MXcNvKcJ0TW8xsMySQW6dPR
        Cis4TpkuE13mR4K+dbi20iIfFA==
X-Google-Smtp-Source: APXvYqyeqRu2+qekSE6k6kGn98J9HUKfWx+8D3SimXGYB9/BujWUhZzuatGY+8VzvFdSC6uNIHMCAQ==
X-Received: by 2002:a37:4f8d:: with SMTP id d135mr34699586qkb.455.1579275996948;
        Fri, 17 Jan 2020 07:46:36 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id i28sm13579413qtc.57.2020.01.17.07.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:46:36 -0800 (PST)
Subject: Re: [Patch v8 7/7] sched/fair: Enable tuning of decay period
To:     Quentin Perret <qperret@google.com>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-8-git-send-email-thara.gopinath@linaro.org>
 <20200117114758.GB219309@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        kernel-team@android.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E21D6AC.4020502@linaro.org>
Date:   Fri, 17 Jan 2020 10:45:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200117114758.GB219309@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17/2020 06:47 AM, Quentin Perret wrote:
> On Tuesday 14 Jan 2020 at 14:57:39 (-0500), Thara Gopinath wrote:
>> +static int __init setup_sched_thermal_decay_shift(char *str)
>> +{
>> +	int _shift;
>> +
>> +	if (kstrtoint(str, 0, &_shift))
>> +		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
> 
> Nit: looking at kstrtoint() it seems that _shift will be left unmodified
> upon failure. To avoid feeding a random value to clamp() below, perhaps
> initialize _shift to 0 ?

You are right. I will fix it. Thanks!
> 
>> +	sched_thermal_decay_shift = clamp(_shift, 0, 10);
>> +	return 1;
>> +}
> 
> Thanks,
> Quentin
> 


-- 
Warm Regards
Thara
