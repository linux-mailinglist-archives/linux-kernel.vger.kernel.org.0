Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC21019AE44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbgDAOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 10:50:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42363 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgDAOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:50:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id 22so19951pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+DYwUjefJWuI4jXWkQv6iB///w8GSFT7G5tHSKXqxZ8=;
        b=LfuoYRzeLErVh6W9uIqvJmwNN9GKNoSTVWjCCUtzx8hhvgsTKGbKrQJ1NDkxwfBY0B
         pbb8lpr+Q6r3mwKxHfucU999QfnU5cfAcQqlAXYUaQnMpoVKoIv7gJwz7StqEybnG37q
         +Rkn6M42h/SiVsZ36VmFlatECFjedBhn2J5R6zR1l4qxYgromRrzd5/FkebLp6bDRGH0
         +dYh/oAjjhK73FL/zJFxcGWaxz0MkNg6932Kf6hZ9fazka9NqcqvpsSGRceYGoXQ2w2z
         VWgC3KKerfpe8KBZBRK9G7d4qqnja/ih/Ee+i5u9Z35L3A029iqJJEAwoWwr2uVUWjYE
         NXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+DYwUjefJWuI4jXWkQv6iB///w8GSFT7G5tHSKXqxZ8=;
        b=DKR0XYwX29RUeFl7QrK3NMXpMXSNCdXlCUZFFdySIdOjpNFj5AW+7WmuFQXojwkyOt
         gHpHwswR2Bg2ujvrVD+wWJ56hjhXN2k2qyYtOgaRe9USyaEwEuQt/5uKn70xi2vUOp8F
         jY58NCPJETfDaMjYGp9EKZ7ncGGxo/+xFzbZbcKk077/JSuXRlaoFwF3F2BeD7pAFIW9
         uEyYS7ASDakpl2dhJQi1poBZ9q6LCtKHMDpt/ARwwTRysJiDqZO9clK92CTj9Kn9RshI
         6V0oSgkQVMG3OFU5ej6VbyJQHirHrsXawQSOjA+vSDO5ndoNuvz/mTcTsWd58oLq7M2V
         FJ3A==
X-Gm-Message-State: ANhLgQ2nis9HThN2FvAcPJGvadjUL9cL76Exn5yHgUVcydEV9MW6/v50
        o0mBEclLLOhBi1IExIdDLpx1dA==
X-Google-Smtp-Source: ADFU+vvjRpL2aaydcveXDe5l3anPPfX7/cbn2ZfE+JPRB092hnufVl5AhjwM3vBZ1Z11PSdTx11ZSg==
X-Received: by 2002:a63:b905:: with SMTP id z5mr20648627pge.402.1585752601380;
        Wed, 01 Apr 2020 07:50:01 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 132sm1745983pfc.183.2020.04.01.07.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 07:50:00 -0700 (PDT)
Subject: Re: [PATCH] tty/sysrq: Export sysrq_mask()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Slaby <jslaby@suse.com>
References: <20200401143904.423450-1-dima@arista.com>
 <20200401144610.GA2433317@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <b0099c8c-5bab-960a-8d0d-4691e11a462f@arista.com>
Date:   Wed, 1 Apr 2020 15:49:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401144610.GA2433317@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 3:46 PM, Greg Kroah-Hartman wrote:
> On Wed, Apr 01, 2020 at 03:39:04PM +0100, Dmitry Safonov wrote:
>> Build fix for serial_core being module:
>>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.com>
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  drivers/tty/sysrq.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Is this a new problem?  What commit does this fix?

Right, sorry I've managed to forget adding the tag:

Fixes: eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")

Maybe also:

Link:
https://lore.kernel.org/linux-fsdevel/87tv23tmy1.fsf@mpe.ellerman.id.au/

Thanks,
          Dmitry
