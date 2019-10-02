Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54098C894F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfJBNJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 09:09:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33935 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfJBNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:09:32 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so56742331ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LGBRuLqUYrX9GGEZI9KKoyUAhJq9ZXxDsRWTIcZfJKs=;
        b=rivVgCttX729kcL32gPJi94oiGeS/ifekn7WfKH0+689qAHuwZ9GMA8DoZ3c1HyAR/
         hLXUYrXvu/gAXPTX4iddYvXTTqa4Clmf9rHuwEC5ng0E4lqdeTmrusQ/3rMg9Hl8tJ66
         T/m4Lsd230UKL4EoovEAS51KnE/io9py1nKfWosvvFoE9iykZLeRcp4WbIiPCEXcoAaM
         BSq09rThM9NHC2ODOBVwG3W/Dl7wBBGv/xnvIoC4NIAcf4Ld3PmW3sXbRdGHT3rKj+CD
         3QwI4qifLJc1emxI5N20ihafo6GqeuuARQ7FOLsRk9ryt9v0nRr/G404yZpHtpR9ECkF
         XYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LGBRuLqUYrX9GGEZI9KKoyUAhJq9ZXxDsRWTIcZfJKs=;
        b=eFkztHYAv8iHAMW/mUReywyhNGnZPA7iOhGj3nLYcJncTh5imK5NwUSZq5X6WJBi9j
         8JAdel38wqggO7bZCh9z070QszulbW8UHdZNsVLWX4EYvO8E0Oe2Yz6EVoLSF3c9Cphc
         ctewXctGvdvJGHV5s5dHpa1HyjoItxAyWa5tnxOUOz3e+Obq5LsC9hlYNDRKW2gJe3ao
         i/j5uGr/Q7quNGEByD58wlWQ7Dr7ONnJk/VCpgT1QNUuWmkGX0HFrzvo06R9HBKemY+n
         PzdEGmcNg40gWNPuoce22d1EWhF5LcPMrxMee4xCWScK+c+57FlTsDLq96yD/fAHdILt
         B+gA==
X-Gm-Message-State: APjAAAVJhN9EM9K+MrGZ9rQlQSfZuDKpCXmiKbY1tG1R3p5VCbNApktS
        nGZXpNV9Fc1Dm8cvB2Pd4zf/xA==
X-Google-Smtp-Source: APXvYqxoOv3gPtGv+2gVmJxtYhhJTGAOSpJ5159QObAXDK3v9RjA9LkKGLL73o5+qLKCvndxIogJsA==
X-Received: by 2002:a5e:8341:: with SMTP id y1mr2926558iom.284.1570021769994;
        Wed, 02 Oct 2019 06:09:29 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c4sm7265663ilh.32.2019.10.02.06.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 06:09:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] blk-mq: Inline request status checkers
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
 <e6fc239412811140c83de906b75689530661f65d.1569872122.git.asml.silence@gmail.com>
 <e4d452ad-da24-a1a9-7e2d-f9cd5d0733da@acm.org>
 <6da099e2-7e29-3c7b-7682-df86835e9e8c@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4fb245a-5587-866b-8bfa-927d0fb0801b@kernel.dk>
Date:   Wed, 2 Oct 2019 07:09:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6da099e2-7e29-3c7b-7682-df86835e9e8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 2:12 PM, Pavel Begunkov wrote:
> On 30/09/2019 22:53, Bart Van Assche wrote:
>> On 9/30/19 12:43 PM, Pavel Begunkov (Silence) wrote:
>>> @@ -282,7 +282,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>>   	 * test and set the bit before assining ->rqs[].
>>>   	 */
>>>   	rq = tags->rqs[bitnr];
>>> -	if (rq && blk_mq_request_started(rq))
>>> +	if (rq && blk_mq_rq_state(rq) != MQ_RQ_IDLE)
>>>   		return iter_data->fn(rq, iter_data->data, reserved);
>>>   
>>>   	return true>
>>> @@ -360,7 +360,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>>   {
>>>   	unsigned *count = data;
>>>   
>>> -	if (blk_mq_request_completed(rq))
>>> +	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
>>>   		(*count)++;
>>>   	return true;
>>>   }
>>
>> Changes like the above significantly reduce readability of the code in
>> the block layer core. I don't like this. I think this patch is a step
>> backwards instead of a step forwards.
> 
> Yep, looks too bulky.
> 
> Jens, could you consider the first version?

Yes, first one is fine, I have applied it. Thanks.

-- 
Jens Axboe

