Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E772F2183
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 23:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfKFWS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 17:18:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfKFWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:18:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so152809pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JE31y7/1PohMIq8p9sxPVVsnkr1/mtmR3vBS1hVh4bY=;
        b=kyz4X4mEVwaJN8snCR0ZaABOjRGPLx/KHhhQUM6LGvXmWwNaUMnv7I6Ecjt8dZi3yP
         0e+EJzexRFNFLHgLPMNjlWlQHjQ58SD1MhFUCsk2KOsPFqAEvjV8CmGgOadkfLHV+K4I
         qwrJO/kAEsEmsOk/geFK1c4SYtF/B8Mvv6ubTX72xTSbBaLJbEIG/ws3sU+xaJ+EnY5s
         zVnG/nw29g6ugm1KKbBQk/El44jEPnA6U5n3ZsXJYrZ4tku7Kngw3eaiT3IOQaMVtn93
         zRv0hySm+Th3ZYtUMEEX2Vnld5vV12XalSpgUDWKOzwA6kblsD7GC93GLtQlx7Vu6JPT
         ziTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JE31y7/1PohMIq8p9sxPVVsnkr1/mtmR3vBS1hVh4bY=;
        b=cKw17W9LU3b3rYw6ORpx6VUSgLH/f97LQReaBVgDko8cOftxZMeJXC2FmVhtTM6AcW
         U8KERe+1hJxeiHrviO+5Jregqg2caW52p5uL2KpAjmeT1eq94EHJPJjeQqfygUxRSYvt
         /aXzAOzcidLP73AmR2BykDWiEcDqVGOMl1u4QUBuyq9C1JL3zzEDbeKXF3wRrahgWoP+
         Pq/W9a7SxjxqpMZL+d+m1AU6z6AA48GrJKUlHiXwn9le1nFLnIKEy3m+ZI9/RpeK1AYa
         3e3pB0j4KvYgWdRMwEjtIFHprezZ7VerWJTEyT/sspt87N0Qq4SQ0O1BIIZhkaUP+lBR
         Z7IQ==
X-Gm-Message-State: APjAAAWjLx8Xu37h8uTdwN9EsM0HONwpf4L97FE5Yh5ZVRxSuJBhfAyO
        kwUxn6zyL6lDwrU/G2IYUCqeHg==
X-Google-Smtp-Source: APXvYqwZmPrtfXIzsImzq1U0tM+DVSZhcV6QxOWtVet0UaSmIgup9fxnheqMJBUwkP/hADWg82x37Q==
X-Received: by 2002:a65:480d:: with SMTP id h13mr253210pgs.46.1573078736741;
        Wed, 06 Nov 2019 14:18:56 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h13sm28791361pfr.98.2019.11.06.14.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:18:55 -0800 (PST)
Subject: Re: [PATCH] xtensa: improve stack dumping
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
 <27720768-9fb7-0382-e1ef-ac9760cdf5cc@arista.com>
 <CAMo8BfLDk_ztsG0eSFgd2+hW9-MqrOKmPn0kSvCeq3uBGXapHg@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <78ff494e-2fe2-b881-29ca-84992e26d415@arista.com>
Date:   Wed, 6 Nov 2019 22:18:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLDk_ztsG0eSFgd2+hW9-MqrOKmPn0kSvCeq3uBGXapHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 10:00 PM, Max Filippov wrote:
> On Wed, Nov 6, 2019 at 12:51 PM Dmitry Safonov <dima@arista.com> wrote:
>> On 11/6/19 6:16 PM, Max Filippov wrote:
>>> @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>>>       for (i = 0; i < kstack_depth_to_print; i++) {
>>>               if (kstack_end(sp))
>>>                       break;
>>> -             pr_cont(" %08lx", *sp++);
>>> +             sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
>>
>> buf is on the stack, does sprintf() put null-terminator for hex?
> 
> It should put null-terminator regardless of the format string.

Always unsure what to expect from printf() :)

> 
>>>               if (i % 8 == 7)
>>> -                     pr_cont("\n");
>>> +                     pr_info("%s\n", buf);
>>>       }
>>> +     if (i % 8)
>>> +             pr_info("%s\n", buf);
>>
>> If the stack trace ends with (i % 8 == 7), you'll double-print the last
>> line?
> 
> No, I don't think so. 'For' loop condition is checked after i++, so if
> loop ends with i % 8 == 7 then its last iteration was done with
> i % 8 == 6 and thus the buf haven't been printed.

Ah, right - me being stupid.

Thanks,
          Dmitry
