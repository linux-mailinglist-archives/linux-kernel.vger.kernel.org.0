Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FAE53AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfJYSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 14:18:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42328 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbfJYSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:17:40 -0400
Received: by mail-io1-f67.google.com with SMTP id i26so3449294iog.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cEp2IwZKQPQmmm2FW1iKbpwmFQ8Xs6tcg4OA6zfr4/M=;
        b=icig6KsD2TpQ66Xr/S/wECboULwzQnRngVtCPdD1hQPltOc0nDqrUFCOWfzH/IJHq5
         V8kUHDFd+o4xtXCPRL8oILKPDf0mFUYyV8n2m2g33KkkD5hxkP+TTvkv51hbep+S8yUC
         kAxUR3dtNowOfrl/A1hBY4e0t0GlU+Jtfz+QHIzc3XsKZ+sUjME4J7xWsopxa139lln0
         iyvVjNwQeZ25EUMxEJwbNvXX18nKPoFIpn4a1RxowHzurplABQ4AP9zMzQJ/3pi729I3
         SCLgOH8O84N9NS+rBeK5wlvQ+VN55mblWwOlsaw4vTE4ovnQ2yJQymttUBdqwpySeiwR
         Kpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cEp2IwZKQPQmmm2FW1iKbpwmFQ8Xs6tcg4OA6zfr4/M=;
        b=jiRV7YAjMp6dWeZMdDGJ7JvmBFZLUxjalMvhQ4OB26XYGVUT3E3vlSvcI0uS16IvhS
         e2QaFBpxWzGDAxCUFu9oVj+Z8/+3jU6G+kBfd/8nDXofEOTsVBBGW4eD0NwWLbT45lpT
         mAchDK5iQtmwnkinxlco1KU/QAPHRnHaaQAjVHLQtNz7nAOfe/8wdJ4ZGKa16atWIIf7
         b+Ede6aJtqZUONYhSymJLLUVne7WDXuXy7xFLF3Acphfrlm6I/S9p2SURGXw54wqTBIW
         KzphTRiJKHktM/+rLRD/hKcV5V/L9QBtUIV3E0jb2psFvGlmST/puUt32+B6lDuU1Dap
         PM6Q==
X-Gm-Message-State: APjAAAWDzjRJ0YBqoospiUGuVmGGTcHHM7mkjrKrvdaImhY1VqUu2bX9
        BwwnN+8Jope2ppAclLnSPJ9sk3fvgjDkVA==
X-Google-Smtp-Source: APXvYqysoFK5c7/3wdwPSUl84Q1Nx5uXQAZ2VHCAU284/KLJkgalKBQBScryp9skgcrtBxD+r2CHaQ==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr5317901ioq.208.1572027457864;
        Fri, 25 Oct 2019 11:17:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y26sm341850ion.1.2019.10.25.11.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 11:17:36 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
 <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
 <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
 <a0d8a8e1-18dc-8090-037c-e5baf9bd45c3@kernel.dk>
 <436eb658-582d-c752-f20a-2f2c43d741a3@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3b7a9fb-1a95-5419-3408-669d8b466d48@kernel.dk>
Date:   Fri, 25 Oct 2019 12:17:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <436eb658-582d-c752-f20a-2f2c43d741a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 12:13 PM, Pavel Begunkov wrote:
> On 25/10/2019 19:57, Jens Axboe wrote:
>> On 10/25/19 10:55 AM, Pavel Begunkov wrote:
>>> On 25/10/2019 19:44, Jens Axboe wrote:
>>>> On 10/25/19 10:40 AM, Pavel Begunkov wrote:
>>>>> On 25/10/2019 19:32, Jens Axboe wrote:
>>>>>> On 10/25/19 10:27 AM, Jens Axboe wrote:
>>>>>>> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>>>>>>>> On 25/10/2019 19:03, Jens Axboe wrote:
>>>>>>>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>>>>>>>> I found 2 problems with __io_sequence_defer().
>>>>>>>>>>
>>>>>>>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>>>>>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>>>>>>>>>> it can be maliciously changed.
>>>>>>>>>>
>>>>>>>>>> see sent liburing test (test/defer *_hung()), which left an unkillable
>>>>>>>>>> process for me
>>>>>>>>>
>>>>>>>>> OK, how about the below. I'll split this in two, as it's really two
>>>>>>>>> separate fixes.
>>>>>>>> cached_sq_dropped is good, but I was concerned about cached_cq_overflow.
>>>>>>>> io_cqring_fill_event() can be called in async, so shouldn't we do some
>>>>>>>> synchronisation then?
>>>>>>>
>>>>>>> We should probably make it an atomic just to be on the safe side, I'll
>>>>>>> update the series.
>>>>>>
>>>>>> Here we go, patch 1:
>>>>>>
>>>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=f2a241f596ed9e12b7c8f960e79ccda8053ea294
>>>>>>
>>>>>> patch 2:
>>>>>>
>>>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=b7d0297d2df5bfa0d1ecf9d6c66d23676751ef6a
>>>>>>
>>>>> 1. submit rqs (not yet completed)
>>>>> 2. poll_list is empty, inflight = 0
>>>>> 3. async completed and placed into poll_list
>>>>>
>>>>> So, poll_list is not empty, but we won't get to polling again.
>>>>> At least until someone submitted something.
>>>>
>>>> But if they are issued, the will sit in ->poll_list as well. That list
>>>> holds both "submitted, but pending" and completed entries.
>>>>
>>> Missed it, then should work. Thanks!
>>
>> Glad we agree :-)
>>
>>>> + ret = iters = 0;
>>> A small suggestion, could we just initialise it in declaration
>>> to be a bit more concise?
>>> e.g. int ret = 0, iters = 0;
>>>
>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>> And let me test it as both patches are ready.
>>
>> Sure, I'll make that change and add your reviewed-by. Thanks!
>>
> Stress tested, works well!
> 
> Tested-by: Pavel Begunkov <asml.silence@gmail.com>

Great, thanks for finding these, sending patches, and testing the ones
that I fixed!

-- 
Jens Axboe

