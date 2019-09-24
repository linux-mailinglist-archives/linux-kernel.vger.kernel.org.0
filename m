Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03EBC418
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394970AbfIXI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:28:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394923AbfIXI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:28:06 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so2353823iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rN+CCFgjkVKfpkBu9it69/0SwXM97JRpAOcW4kIpzI4=;
        b=BoVWD9Ei+4upFvzInWl+wWNqH3L3WMLBfNPHPRYnQWHtbHJmNphgq8YocFrVqAHtRf
         R6iasukQHA7sVYsd14LhpbF1bLPMqNSx4PjGlM6+BdHreaTsrQbO4POGb59vvQSqHyp7
         PkYbG0WOwey19zr/4wbS3P12SXf795gVfhBRBt8ybvn2/A55bMAsl2TUE3ek1dfEL1tK
         oLDqmJQ85s6iD0XldWvWOITuom9MWG2wKWk0WcS5PmB3pbHyQIbFi6hFk4XhWU/bpCct
         89HbWNrY+euZgQlCzL+Y0/yua1XW/pXosymxcCEKH7psIboyrN7rfZtHw9xpT7vggfQw
         yGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rN+CCFgjkVKfpkBu9it69/0SwXM97JRpAOcW4kIpzI4=;
        b=dgZcq1vp1oh1tocvn+KVMAg6Aj7L+8IATm+S14DWYL9aCbwtastuLSi0vrKJ4LIXjc
         654jeDRXj41qZsBkzuerTACqwuJeRse1r+LLiwFv2Dans8Pru0abY1j6A5hzD8ivp+V4
         o3y7YxjqIBmxvAPq8aOUYSgWAIFaIjBFsSMVMWZ/hvkSeC8PFOKQiFo6I/B5v/eY8Xtv
         SggAt9dYSJ1/fCbW6i3D1uDetmIYsIlpQ1DbrcjjNISUOegdn1a3jP2a8uo+lpcvt07H
         Z9nYTvz4BAjHe8SIGvTMGTj3bGL/kUE1F/SqUj5CKa79g2AopdUnbFEEp8LYAu3UwK+l
         +2pQ==
X-Gm-Message-State: APjAAAWhphYF5V8SKuLi352RirwQRqj/gAKjsEuMa1jVwsD3P4kcbPht
        YnggGSZzjqb/7d8yAvcObLXv8Eed6ctn9g==
X-Google-Smtp-Source: APXvYqxi662Z4Bn70WGfxOYR9BgahyryS+CkPCnD//1DLNnyE5xB+ZdcX0sUI4SNFIDJbJgCaRINWA==
X-Received: by 2002:a02:b60f:: with SMTP id h15mr2481697jam.73.1569313683084;
        Tue, 24 Sep 2019 01:28:03 -0700 (PDT)
Received: from [172.19.131.113] ([8.46.75.9])
        by smtp.gmail.com with ESMTPSA id g8sm914450ioc.0.2019.09.24.01.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 01:28:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
Message-ID: <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
Date:   Tue, 24 Sep 2019 10:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 2:02 AM, Jens Axboe wrote:
> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>> structure with a count in it, on the stack. Got some flight time
>>>> coming up later today, let me try and cook up a patch.
>>>
>>> Totally untested, and sent out 5 min before departure... But something
>>> like this.
>> Hmm, reminds me my first version. Basically that's the same thing but
>> with macroses inlined. I wanted to make it reusable and self-contained,
>> though.
>>
>> If you don't think it could be useful in other places, sure, we could do
>> something like that. Is that so?
> 
> I totally agree it could be useful in other places. Maybe formalized and
> used with wake_up_nr() instead of adding a new primitive? Haven't looked
> into that, I may be talking nonsense.
> 
> In any case, I did get a chance to test it and it works for me. Here's
> the "finished" version, slightly cleaned up and with a comment added
> for good measure.

Notes:

This version gets the ordering right, you need exclusive waits to get
fifo ordering on the waitqueue.

Both versions (yours and mine) suffer from the problem of potentially
waking too many. I don't think this is a real issue, as generally we
don't do threaded access to the io_urings. But if you had the following
tasks wait on the cqring:

[min_events = 32], [min_events = 8], [min_events = 8]

and we reach the io_cqring_events() == threshold, we'll wake all three.
I don't see a good solution to this, so I suspect we just live with
until proven an issue. Both versions are much better than what we have
now.

-- 
Jens Axboe

