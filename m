Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7851272EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 02:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLTBld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 20:41:33 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38126 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLTBlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:41:32 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so6570340ilq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kihFHk0I3eiSjPlsPOEWwLG5M5I3W9sqheb6sgl2P4k=;
        b=hiDu43S+ngvlMBE/4HJGTNYC1y1RavL4d+i+AbAdZAnmrfii3Ek2G5DaS1DHwSceO2
         hkYpdiXmsDhaduWGWG7ZuISR/pQrC7JlsMNpMQLaPA7Zvco28exuJNPYEMTjQa71P3p1
         nSmP3yaHXzQRXTKiyg9VPBxyCj7audWltZfb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kihFHk0I3eiSjPlsPOEWwLG5M5I3W9sqheb6sgl2P4k=;
        b=j2SYAIOaS+GmaimykFcq11KKbkP3UV1qAaK/MTzefbNmEKSMObOub3vzruI2+qOccG
         MORXcdC8F5ZT9r8O3k5RC2G8C0yn9Q3UbELU4CuXUnAFaa3O9U1El6QTx0bWUjZePQ1j
         8UYvjUm+1IXBtAGqvjut7+dDpl4IZoe7Xn+LY6xnPLbmOTG05l8SFA4afGwOznRWnYey
         j7s/SnqfxHm8Ot+1VYQWQKtOaHQqlm9wzXJQKy8Nr9MsvVP4MbeGhr0WRFcdMojSgYYF
         45vVDaAyODLGVsmtQxJ53u/FCoA42bQMuJQf24z+3GU25wOo4SRPOPC0kFhdd4aHI9CR
         paqg==
X-Gm-Message-State: APjAAAV+luJ5fA854LRyJ10zi1nAIkMOTpFLSQx82L5SXyohdrcz6epR
        uH7PSFa8atwf7hMsW5ZYdmlutw==
X-Google-Smtp-Source: APXvYqxJ1wlBxbfbo8n32neUIKY7qhlUNucAfrLjjhF9jQmtKljvxSLHrLQZTJntHeTRF1avB9VQhA==
X-Received: by 2002:a92:84dd:: with SMTP id y90mr9120333ilk.99.1576806092085;
        Thu, 19 Dec 2019 17:41:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i136sm1505454ild.23.2019.12.19.17.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 17:41:31 -0800 (PST)
Subject: Re: [PATCH for 5.4 0/3] Restartable Sequences Fixes
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190917182959.16333-1-mathieu.desnoyers@efficios.com>
 <211848436.2172.1576078102568.JavaMail.zimbra@efficios.com>
 <b67930c1-c8e0-124f-9a88-6ecace27317c@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7fd53b32-8d9e-5c24-56c5-86c1c7c700dc@linuxfoundation.org>
Date:   Thu, 19 Dec 2019 18:41:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b67930c1-c8e0-124f-9a88-6ecace27317c@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 8:47 AM, Shuah Khan wrote:
> On 12/11/19 8:28 AM, Mathieu Desnoyers wrote:
>> Hi Thomas,
>>
>> I thought those rseq fixes posted in September were in the -tip tree, 
>> but it
>> seems that they never made it to mainline.
>>
>> Now Shuah Khan noticed the issue with gettid() compatibility with glibc
>> 2.30+. This series contained that fix.
>>
>> Should I re-post it, or is this series on track to get into mainline
>> at some point ?
>>
> 
> It will be great this can make it into 5.5-rc2 or so.
> 
> thanks,
> -- Shuah
> 

I am pulling this patch in for Linux 5.5-rc4.

Let me know if you have any objections.

thanks,
-- Shuah
