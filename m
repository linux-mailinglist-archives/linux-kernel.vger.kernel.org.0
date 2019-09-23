Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECE0BBD45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 22:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbfIWUsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 16:48:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43572 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389052AbfIWUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:48:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so2566639pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nUgRSkoDI5HIlvd1QcYFDyolqVga7j1qtEHfJ+8gxnQ=;
        b=GivnRW5mV4+6/svlNvgJuoze4kT8deBE3EL4DtQlUdbdSlSdqH3zrkcK585VAc2DkX
         N8Q+YY94IdMGkrs79yTc7ghVyfPdUTB3jrxnyOC9kTm32sOYByPVQRXxbTXSaAaZo+S7
         M4JFDJhRDy8ml1pJ7p0xevCWFJTSy1z6QclkBvh43GzVu/cnAqS4VU7nTwZ1iEE2j1JN
         +rfWJ0BdV/+BVDF+XEuNLAJCp3+QdHj+OsiamWsnBPYHCv7/bCvL5wYAPqbJXSCETC8i
         X9YY2Rmyv+SuYcjj1/g4cy4ooggS0ro/5+6/1U09TfqFTjAvTwM/8ZEi2b01yMSnpE8e
         OMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUgRSkoDI5HIlvd1QcYFDyolqVga7j1qtEHfJ+8gxnQ=;
        b=V+Q0fJyWZWiPcAGsy24yRzM8uoR2Nx9mFtHpcnvMNwcQjYkk5cj7JvAgbcD9gtVLJX
         i0co2s1NhYSRUItvrtezamieUMTJl+xlp0WLXn8b2Y4mCrxSsIEMlTQoX21ZrMYI8EfN
         jrtEp6fxEpKgCDGnKBgHy6W+xi3pjmueGLZHva+KdMGzDPOmRLXiDtA/aHf37hxfS2px
         xZZOQbA6ydq5QLXzeduyrO6ymWcVMti0AFvNdRLtX7gANwdm21lYvRyA6P2yoc6rPkTy
         Gs59fAC1DqSxf7O2/AkEkElVRWUkav5D7xTd7poEsuKTwvmIr3PdNqVR32yTPSz29ZvO
         6Qgg==
X-Gm-Message-State: APjAAAXcLizu1f1SwmzR6+6cugkh80W81drj8grBw107MZ8560+sBUx/
        xQx9n4g0qupddg9Nm0IjsYc6MpifpaXAGw==
X-Google-Smtp-Source: APXvYqw48cSQQjn+PidujI2PTC9qv93Tm8GIvX9VsJPAws6pbfuG9DkxwCiWL7PrBYLzRzUWJbrHHQ==
X-Received: by 2002:a62:5847:: with SMTP id m68mr1649730pfb.23.1569271723341;
        Mon, 23 Sep 2019 13:48:43 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id a13sm13504968pfg.10.2019.09.23.13.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:48:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
Date:   Mon, 23 Sep 2019 14:48:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 10:32 AM, Pavel Begunkov wrote:
> Sorry, mixed the threads.
> 
>>>
>>> I'm not sure an extension is needed for such a special interface, why not
>>> just put a ->threshold value next to the ctx->wait field and use either
>>> the regular wait_event() APIs with the proper condition, or
>>> wait_event_cmd() style APIs if you absolutely need something more complex
>>> to happen inside?
> Ingo,
> io_uring works well without this patch just using wait_event_*() with
> proper condition, but there are performance issues with spurious
> wakeups. Detailed description in the previous mail.
> Am I missing something?

I think we can do the same thing, just wrapping the waitqueue in a
structure with a count in it, on the stack. Got some flight time
coming up later today, let me try and cook up a patch.

-- 
Jens Axboe

