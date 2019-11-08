Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804B2F5B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 23:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKHWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 17:41:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42823 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:41:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id q17so4904863pgt.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbbMQa5jhDWCcUiWhuu4CV4k2cUR0OHJdYDG5Mtjc6g=;
        b=fDmjcY1L6EJ49eNMPi7gFqw3lzyg1CqYTqvm5W2+1MOhpqjbWeWzdt2arSiWhUgJZn
         JjaWYe+wRMB7xw9o+Vb0QPBioOaruoqAwQvThU7BA5ZoiW1hsdbudU5luQCNBLm8IiJa
         QaKlLCZNIAwCS6s6ZfCT03E2UchiDBmoZKSFRzIBk8GQdY5pNLqc3hmuBb9u1Mb7d2OL
         +IcQiTU8Ps9osackcDetuYNqzS19GKLOv+LEvCHYTvdZegwobT5aio21B2NwGHcjzA3g
         wPw5aQ0+7k2zgOSUWEE7WApFuFVdy2xBN63PcnkeOUcDrOS3rmZv8u9urv8QbSOPlfsL
         0ybA==
X-Gm-Message-State: APjAAAWw75BqvinHYFmGs5PaQnjdRC8zwgPEe6dcwKy0UeNvBHYJvis+
        UyayqNI0ZcpaRrwOxVlCwwn8HQ==
X-Google-Smtp-Source: APXvYqzOdObkAd8fDFB39c5FefPnKS3nEyrR4LXkq5wMuqe8ewjiYa9bhSHRWl/ldG5gdwlj6d87aQ==
X-Received: by 2002:a17:90a:348c:: with SMTP id p12mr16843824pjb.105.1573252899059;
        Fri, 08 Nov 2019 14:41:39 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id 82sm8093029pfa.115.2019.11.08.14.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 14:41:38 -0800 (PST)
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.133597409@linutronix.de>
 <20191107091231.GA4131@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1911071502350.4256@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911071508020.4256@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <c753068f-adae-92a1-a6a9-bcb1e74829c2@kernel.org>
Date:   Fri, 8 Nov 2019 14:41:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911071508020.4256@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 6:08 AM, Thomas Gleixner wrote:
> On Thu, 7 Nov 2019, Thomas Gleixner wrote:
>> On Thu, 7 Nov 2019, Peter Zijlstra wrote:
>>> On Wed, Nov 06, 2019 at 08:35:03PM +0100, Thomas Gleixner wrote:
>>>> There is no requirement to update the TSS I/O bitmap when a thread using it is
>>>> scheduled out and the incoming thread does not use it.
>>>>
>>>> For the permission check based on the TSS I/O bitmap the CPU calculates the memory
>>>> location of the I/O bitmap by the address of the TSS and the io_bitmap_base member
>>>> of the tss_struct. The easiest way to invalidate the I/O bitmap is to switch the
>>>> offset to an address outside of the TSS limit.
>>>>
>>>> If an I/O instruction is issued from user space the TSS limit causes #GP to be
>>>> raised in the same was as valid I/O bitmap with all bits set to 1 would do.
>>>>
>>>> This removes the extra work when an I/O bitmap using task is scheduled out
>>>> and puts the burden on the rare I/O bitmap users when they are scheduled
>>>> in.
>>>
>>> This also nicely aligns with that the context switch time is accounted
>>> to the next task. So by doing the expensive part on switch-in gets it
>>> all accounted to the task that caused it.
>>
>> Just that I can't add the storage to tss_struct due to the VMX insanity of
>> setting TSS limit hard to 0x67 on vmexit instead of restoring the host
>> value.
> 
> Well, I can. The build bugon in vmx.c is just bogus.

SDM vol 3 27.5.2 says the BUILD_BUG_ON is right.  Or am I
misunderstanding you?

I'm reasonably confident that the TSS limit is indeed 0x67 after VM
exit, and I wrote the existing code that tries to optimize this to avoid
LTR when not needed.
