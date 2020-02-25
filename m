Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9226C16EBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgBYQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:43:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35174 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgBYQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:43:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id 145so6316367qkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9CAIwCQip3fV1TpTcgIeZ6b814msVVSyDgFTY8ZaFD0=;
        b=SOlXKegQwXz5irZGdU8MonGmVbU3rVtcMn20KUpqT33xVQX0nf06Y81KDCFDUnZoxA
         1MtEnIiYcjO9Q/ylNtbbMGAfJGt0fKIcByzwgE1umFYkOXmDhPC/1PsoiBfJm/KhbTQ5
         g+J4ZVlRkoRZOtcVPdoxsegeXSiooBpQEt87lUZADrDpMjE1ZAF13ZhEo/lrhUsde0AC
         0XwGExp7JsnWPlOar6JLhWprEjzdVHLVcHl9lWwsI4h+qn8MwKzoGxmTBsgxxRgZB6nf
         4uTWZo+xDxgA/VZVChMlPK8o5OCD2pHlo9v5i7nAnmlb6N7MAxX4Yzwf/LX3Fnbo0TWI
         5ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9CAIwCQip3fV1TpTcgIeZ6b814msVVSyDgFTY8ZaFD0=;
        b=LyY7/LXsqvftMF2Fhw9Avs1t99i3cmokWZARHEgwL+bke30+76AvhU13zZaB89A1jI
         kiaYnKAvf5fp55HRL1IKhQs/7+kqZpYf0WwiGWWhEDO1RI8/NRjremzCP5Q+eTTdTIQz
         ix7PGpsV8iKNacAtLLQPywVJP8LF5KihNihktxIa0+n0tsOCfEx6w0U2en9BLziV1q71
         jLWkHSvVtquV5fQ3Cxr98/glYujy0oG5AIR2t+GOWutvFrV9pQt9tuIig6PXgnq28bVX
         Qn1XzXBojmYUtML7A9LWOHoZ45fyYZgRYX2vTSMXJVA1gPmJoMzJYzh9EpoHd1IPuBOU
         Nl8g==
X-Gm-Message-State: APjAAAVt7VwlG/M3TeLNDGFUpqLbS66f6/tBwplg6Vt3STT6P+aDnFWM
        I6sBmer8QYq6TV7wX5LEGWUyUQ==
X-Google-Smtp-Source: APXvYqwxSHbDZ6tTTp1ylnUB1+6DlxTKGQv6GDB2QhTrkjq6fDFzXwbq8nlgDAc/u+nROK91HOaYzg==
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr57573869qki.478.1582649020191;
        Tue, 25 Feb 2020 08:43:40 -0800 (PST)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id p126sm7615699qkd.108.2020.02.25.08.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 08:43:39 -0800 (PST)
Subject: Re: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com, qperret@google.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rostedt@goodmis.org, will@kernel.org, catalin.marinas@arm.com,
        sudeep.holla@arm.com, juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <20200222005213.3873-2-thara.gopinath@linaro.org>
 <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
 <d7890dc4-f5d8-9bad-8473-062c0206da09@linaro.org>
 <a3102cf8-bb77-fed4-ffc7-8ef74e9feb23@infradead.org>
 <2c680a71-31ee-3a9a-4859-5c4cbc9dc0e1@linaro.org>
 <20200225154744.GN18400@hirez.programming.kicks-ass.net>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <d7a5916a-cae1-267c-a862-8659ccf8c4c5@linaro.org>
Date:   Tue, 25 Feb 2020 11:43:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225154744.GN18400@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 10:47 AM, Peter Zijlstra wrote:
> On Mon, Feb 24, 2020 at 09:33:22AM -0500, Thara Gopinath wrote:
>> I see what you mean. I will send an update to this patch with HAVE_ removed.
>> It is not selected by any other options. Best is for user to select it or
>> platform/SoC configs to enable it.
> 
> Done that for you ;-)

Thanks!

> 

-- 
Warm Regards
Thara
