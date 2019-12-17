Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2312345A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 19:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfLQSGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 13:06:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46555 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfLQSGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:06:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so7606799lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FmdBG00eyF0mCLPHUhnZPiYsr9gMuTHxWDo5KEuXIA=;
        b=RfiBPyWeZAzQgIBtq60kIzhloZUPXwDzUfA7/StNCE0CG0dtDUhp2Ewy/xVxfm6KGP
         Df5Tk+VbkeJUcH9BCjIfG5UOSKgGvWdi5Az1/Qo1yD1OhxmYNXkDchH0t3cs5GTsnGGc
         mY0wPUPFyCbvMDhlKo0Sh/qqCC9ol32klGEME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FmdBG00eyF0mCLPHUhnZPiYsr9gMuTHxWDo5KEuXIA=;
        b=qVmc+VKGk3x/hUAEiewoP9rRedVu9oNf+d77Mm6GvvYl/YQIsoCCBG7a/LmarYJQak
         PD/oKVBlsyIKZvEXE8n3e/IkAGYmdD3OJDfR1viaBh4CSXrItCEijJQc1UHHPLvPlhhq
         B0SPxJ0Ck565U7YL4pZQxuNSZdLZvVmxSY+P1gFnhrB1qOhgX4R2+2lWzl+WfQx78CcU
         NIsC9pGdmerP3s3fj6/ek/QVrdSlhG5GOk9tFQj7oS5jrNH5mXymIntyWxAUZ+oCMTWW
         ejk1oY9UniEUAUKJ6RsyR9uUelkKL5x/bsTN3JE0opJ1BlabIQuT+BkBBjFyJM8nE94f
         I12w==
X-Gm-Message-State: APjAAAVtAZjAh9BAwKdHl+SFidaYqQiB1zdUyCrW5EHY+BL5BDCxuoQA
        S2iCKFTi1Uk4xaGU6uuVAmIKmxOFqgk=
X-Google-Smtp-Source: APXvYqwZ+LnPTdZF/U/hYgQ5seSSvWLRWv5v8CUXrYnEClW5VX+8nKc0Y+m7qEhBJq6IbnjwYLFTUQ==
X-Received: by 2002:ac2:4834:: with SMTP id 20mr3298806lft.166.1576605971719;
        Tue, 17 Dec 2019 10:06:11 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n11sm13400260ljg.15.2019.12.17.10.06.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:06:11 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id j26so2868979ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:06:10 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4238381ljj.148.1576605970602;
 Tue, 17 Dec 2019 10:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck> <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 10:05:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Message-ID: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me think about it.

.. and in the short term, maybe for code generation, the right thing
is to just do the cast in the bitops, where we can just cast to
"unsigned long *" and remove the volatile that way.

I'm still hoping there's a trick, but..

           Linus
