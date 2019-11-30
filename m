Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F910DF50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfK3U4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 15:56:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41648 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3U4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 15:56:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so2394660pgk.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uEgawNzSWxhied7eJMcDGpDU5tVmGngFbZvCJqRYEVk=;
        b=VShXE6QTRMlOUcvcP6+DNxhrBZRfdfwTXITrM/WB3dDp4WZb+fBy7IEw7loJqZjq8R
         NKLa1rhn7Z6AxrC8NXq/VvDSm6L4LtzL1oZSKK7sF0NIVsssUowFXmg3Ggnakx029RnJ
         XjMuQsrNohr1IRNibViF0KLcvHkSDFJos8hPn4FBO99QA4wSnvB7jVMJ+d9pMovpmdMp
         P9PVZmt5m3oD75xZZEomYUd52LmhblQ4fr9jZzZ8F9D2Tpnx1wEOzehnSfaDjWxhSNH/
         2IofVeKVuQy+crnI7MHhZwqSmTd4R2+hjX1GSjrUfMNCPbBhv3TktwAS0XXy4S8TQBNM
         K6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uEgawNzSWxhied7eJMcDGpDU5tVmGngFbZvCJqRYEVk=;
        b=h8dl9yMotXjsAbYWMkgXG6Ue6rMKHfp2tYLmnhZ74gWOilDqL0ag59Stjdh5ddDZ0E
         sdrGs3jqk1OSZcUiUarcZgcgOFJvhHfYSYDXowSAHnuEfLREwhYVfoMr7RnQxbtWHaaZ
         OptBYoCINA/ltzHjxznLhBdtMRaja8UdZJngA1CyKWv4z1GR2AFQQyRLtyEvxB568OaC
         j9Y9z8AZjA8FRSra76qIcI7XIXAhizjXwoK3ial09ZDUXnzrWz3VjdnbeDFkhkr1sPmo
         P9duWTqZpagAhTCM5YiEDyg3o5+ynQzSwNbZ124nqOVXwEQLXXDtXWiX12tNAG2WbV/s
         qHcA==
X-Gm-Message-State: APjAAAWwEZVY+//BrNimEWPZK3iGkB8daQWlN7/od0xm0CdprnCkzeSb
        /79tSPC2uc1Y4zmehcCHBF/RDvuusVPd3g==
X-Google-Smtp-Source: APXvYqwJSEOA7gu9xgCRQoi8z5xuefmYj9hMCv9d5JZuDxfkQ4i944Dt0HJpgH02HZV2mISwXZSxYA==
X-Received: by 2002:a63:2063:: with SMTP id r35mr24421656pgm.120.1575147364330;
        Sat, 30 Nov 2019 12:56:04 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:4c44:14f1:fc4c:1a31? ([2605:e000:100e:8c61:4c44:14f1:fc4c:1a31])
        by smtp.gmail.com with ESMTPSA id x4sm7061779pff.143.2019.11.30.12.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 12:56:03 -0800 (PST)
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
 <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
 <20191130185634.GA1848835@rani.riverdale.lan>
 <42c183af-2fcf-7d72-70e1-a7a31ab541e5@kernel.dk>
 <84a065b0-956c-460a-3575-260df7117fb8@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4dd79f37-c874-59b2-c37e-193ff0696131@kernel.dk>
Date:   Sat, 30 Nov 2019 12:56:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <84a065b0-956c-460a-3575-260df7117fb8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/19 12:11 PM, Pavel Begunkov wrote:
> On 30/11/2019 21:57, Jens Axboe wrote:
>> On 11/30/19 10:56 AM, Arvind Sankar wrote:
>>> On Sat, Nov 30, 2019 at 12:22:27PM +0300, Pavel Begunkov wrote:
>>>> On 30/11/2019 02:24, Arvind Sankar wrote:
>>>>> On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
>>>>>> On 30/11/2019 01:17, Arvind Sankar wrote:
>>>>>>>
>>>>>>> The loop can be simplified a bit further, as done has to be 0 once we go
>>>>>>> beyond the current bio_vec. See below for the simplified version.
>>>>>>>
>>>>>>
>>>>>> Thanks for the suggestion! I thought about it, and decided to not
>>>>>> for several reasons. I prefer to not fine-tune and give compilers
>>>>>> more opportunity to do their job. And it's already fast enough with
>>>>>> modern architectures (MOVcc, complex addressing, etc).
>>>>>>
>>>>>> Also need to consider code clarity and the fact, that this is inline,
>>>>>> so should be brief and register-friendly.
>>>>>>
>>>>>
>>>>> It should be more register-friendly, as it uses fewer variables, and I
>>>>> think it's easier to see what the loop is doing, i.e. that we advance
>>>>> one bio_vec per iteration: in the existing code, it takes a bit of
>>>>> thinking to see that we won't spend more than one iteration within the
>>>>> same bio_vec.
>>>>
>>>> Yeah, may be. It's more the matter of preference then. I don't think
>>>> it's simpler, and performance is entirely depends on a compiler and
>>>> input. But, that's rather subjective and IMHO not worth of time.
>>>>
>>>> Anyway, thanks for thinking this through!
>>>>
>>>
>>> You don't find listing 1 simpler than listing 2? It does save one
>>> register, as it doesn't have to keep track of done independently from
>>> bytes. This is always going to be the case unless the compiler can
>>> eliminate done by transforming Listing 2 into Listing 1. Unfortunately,
>>> even if it gets much smarter, it's unlikely to be able to do that,
>>> because they're equivalent only if there is no overflow, so it would
>>> need to know that bytes + iter->bi_bvec_done cannot overflow, and that
>>> iter->bi_bvec_done must be smaller than cur->bv_len initially.
>>>
>>> Listing 1:
>>>
>>>      bytes += iter->bi_bvec_done;
>>>      while (bytes) {
>>>          const struct bio_vec *cur = bv + idx;
>>>
>>>          if (bytes < cur->bv_len)
>>>              break;
>>>          bytes -= cur->bv_len;
>>>          idx++;
>>>      }
>>>
>>>      iter->bi_idx = idx;
>>>      iter->bi_bvec_done = bytes;
>>>
>>> Listing 2:
>>>
>>>      while (bytes) {
>>>          const struct bio_vec *cur = bv + idx;
>>>          unsigned int len = min(bytes, cur->bv_len - done);
>>>
>>>          bytes -= len;
>>>          done += len;
>>>          if (done == cur->bv_len) {
>>>              idx++;
>>>              done = 0;
>>>          }
>>>      }
>>>
>>>      iter->bi_idx = idx;
>>>      iter->bi_bvec_done = done;
>>
>> Have yet to take a closer look (and benchmark) and the patches and
>> the generated code, but fwiw I do agree that case #1 is easier to
>> read.
>>
> Ok, ok, I'm not keen on bike-shedding. I'll resend a simplified version

Sweet thanks. Make sure it's green.

-- 
Jens Axboe

