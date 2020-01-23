Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE41471BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAWT3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 14:29:14 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50885 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:29:14 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1653849pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+x4HS3myrT3PecWjHz3mXPh94Cn4qZCSHWdGIz+/tM=;
        b=EhdlXD8m901R8DmbxPcX0bZX6RHF6nU7OaYwQGqXA5KQRU9S6OE8JLHbjyBrdJJ6nB
         Js8UtcT/bMPwVijvR2McPlKnUHH4EghiVcxLKqp5TDRfLY+OmdvqjjE/Lpo+4JtehBrd
         9y1CeWFQQ90iGyfLy2FlcIiKAIvRkQMhuMo3M/SjxmWxTKVKJsZ9TOkVS+tl/mZASEBr
         3auDDZunIASjl7zlGwbH6mmS1lV3jgrAlxxUChkLGo9d5/5Vh6OMKouq34NbPYOyCAZy
         VZwWJCWFiyOXufSYcz1f9zFHvnHICGJ6fQcLtlBNPA8fEKk90RijffMd/DHWrg78JXsk
         ssQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+x4HS3myrT3PecWjHz3mXPh94Cn4qZCSHWdGIz+/tM=;
        b=pqZc2IgI0o1dnaGQ/v95S0Aos+Lr/vpILlk3zDCdKhUHAF9JFDIAZRuNKoxN1U12cO
         WGDk8wrWUwEkOmxmaAfUu04o3aATYTOUn8RvQKw1e7v7FTTXeP/kOc3OMQNZqi8JdF83
         JNE+wR8+xWSzUO4iq1Za6g6Je1vsHnFnB0QTXbITXT/sr3TD4v1ti1rMQyO5P9T3eTbe
         FmEqhMVavCp+Re+H7VKXNqwYHT/N45e9EchmkSvh/CvmhGyn7fvys8fQ9zB2waaEUlpn
         6pKL7mX++ENtU0zLqRNWcdYEpUf3901bXJqBEbLvC/TSwIaJcv3IvuVRkijjNtCmC1z4
         TuCg==
X-Gm-Message-State: APjAAAX+uBUamMcee6d2jsAbzCWM7yZKt04mRqz+SZ7a5raNXaf6+10J
        k7ORZ3hnhNJgYbnxI1jLNFAFFXNnMrklZA==
X-Google-Smtp-Source: APXvYqzOsZbARvVkuXzGUtlFm3Tj3E6T+F5nxAVRNMXUXmWqpw7a2JkLLrYugJizC/LapU2ddEFitQ==
X-Received: by 2002:a17:90a:eb14:: with SMTP id j20mr6196753pjz.95.1579807753349;
        Thu, 23 Jan 2020 11:29:13 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id y14sm3550278pfe.147.2020.01.23.11.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:29:12 -0800 (PST)
Subject: Re: [PATCH] Adding multiple workers to the loop device.
To:     Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
 <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
 <CAByjrT9=pZGOwDFnJQ60aG-EznV2QK+DQT3a1NEDJr3RU0K_Gw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c2833ef-5d7f-32ae-bbb0-01d6f812a34b@kernel.dk>
Date:   Thu, 23 Jan 2020 12:29:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAByjrT9=pZGOwDFnJQ60aG-EznV2QK+DQT3a1NEDJr3RU0K_Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't top post, we just lost all context here unless I had fixed
it up for you.


On 1/23/20 12:25 PM, Muraliraja Muniraju wrote:
> 
> On Thu, Jan 23, 2020 at 10:59 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
>>> Current loop device implementation has a single kthread worker and
>>> drains one request at a time to completion. If the underneath device is
>>> slow then this reduces the concurrency significantly. To help in these
>>> cases, adding multiple loop workers increases the concurrency. Also to
>>> retain the old behaviour the default number of loop workers is 1 and can
>>> be tuned via the ioctl.
>>
>> Have you considered using blk-mq for this? Right now loop just does
>> some basic checks and then queues for a thread. If you bump nr_hw_queues
>> up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
>> tag flags, then that might be a more viable approach for handling this.
>
> I see that the kernel is already is using the multi queues with the
> number of hardware queues is 1. But the problem IMO is that the worker
> seems to be processing 1 request at a time, to parallelize requests
> and have more concurrency more workers needs to be added. I also tried
> increasing the nr_hw_queues without increasing the number of workers,
> I did not see any difference in performance and it stayed the same. It
> allows to queue more requests but it is processed one at a time. I
> have not tried with enabling BLK_MQ_F_BLOCKING though. I see that it
> can schedule requests early.

The experiment is useless without BLK_MQ_F_BLOCKING set, so you need
that at least. With that, you _will_ see work items processed in
parallel, depending on where they are queued from.

-- 
Jens Axboe

