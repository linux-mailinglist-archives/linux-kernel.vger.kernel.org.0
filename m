Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29ACB762F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfGZKBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 06:01:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43262 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:01:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so26339439ljk.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulNW18rlea00T4v4mX0XiyIJoM8J8QRrrh1waQS7iQg=;
        b=T48SKlXoPZS+Jtcvyo43u8l9a3NdUpuXfKaLqrLvaU6MVPQUIPnHk8ifvkq/L613Ck
         kVbpp3vSLdgMZ/HiSlrZyh7SyvGd4Vrk1m7od62jEEkSvLC4kOkrtIwCZsXOwv9PmyEV
         vtud/HmBRJPqQ2QLODuaaxzbD4pbixtF7g1JCBFLtwbi8+vV/D8jh1E7QVqrh9iF0g7Z
         mMUj/nRel538JHLA/il+Xpz9JyJzQ34Ky+W8EZoXWi4vmu6HKpeEuLfsy1UHEqHN0Es/
         CPYo9AaQA/X4gff59JLKqVugvmOhCFtKAGJydV9rdhViWR1sOWIFuljQtrKVln9LPHSs
         38wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulNW18rlea00T4v4mX0XiyIJoM8J8QRrrh1waQS7iQg=;
        b=K/xMNhWrQyzgqzzhU+vhyNrzfbvKOMKp7vz1B3VL1547Wjwr3cI8ZByJ8vuhldfcCn
         57DXvYzYxYW/Kc+UGbWlKlo3bLjDlzAsFSfj7coCGzTD0kTBIGw5crYf9YJ8PjlvtZX9
         5q4ZMx0vBnWq0CL/Zr2j08ubP1DvXm5E8+wGnzjDbIGzcFyZGzj6THP4w1oeY/266mFD
         hkZAdXeTlT79a6MYTJK5Caypv0AcX+Rs4baz1fXioD4pt7/J1xucMUtn4u0DatBHIeWn
         sXab4EByaPmd+e8jahS+FdOSM2VowOku/J2KaOQbyOSh1zen7oIcO13OYG1QZsHBdqok
         ECPw==
X-Gm-Message-State: APjAAAWq3m8MO1k0B+YI/wvclBOwecyWEwJ9AsCw3vDUa8oN5aHJOabr
        vZ+LLQ67RzQ1Usp6SuyWfFjMHaAbItagqcQ+ld+8yg==
X-Google-Smtp-Source: APXvYqwTEkWNPqspU/F1fvkItB0YhjSFLk/j8xBD0+1KJrE/DmTd3ZHthiHV+l00jf0MevZgfEmycRbcnEBgfeYUNPc=
X-Received: by 2002:a05:651c:92:: with SMTP id 18mr40612881ljq.35.1564135276954;
 Fri, 26 Jul 2019 03:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190611154751.10923-1-anders.roxell@linaro.org> <alpine.DEB.2.21.1906231314030.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906231314030.32342@nanos.tec.linutronix.de>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 26 Jul 2019 12:01:05 +0200
Message-ID: <CADYN=9JyjfQv6nh=kj5uOPXEWGxTycUPsuE=Vjyct-8=pYmVqA@mail.gmail.com>
Subject: Re: [PATCH v2] seqlock: mark raw_read_seqcount and
 read_seqcount_retry as __always_inline
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019 at 13:16, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 11 Jun 2019, Anders Roxell wrote:
>
> > With the function graph tracer, each traced function calls sched_clock()
> > to take a timestamp. As sched_clock() uses
> > raw_read_seqcount()/read_seqcount_retry(), we must ensure that these
> > do not in turn trigger the graph tracer.
> > Both functions is marked as inline. However, if CONFIG_OPTIMIZE_INLINING
> > is set that may make the two functions tracable which they shouldn't.
> >
> > Rework so that functions raw_read_seqcount and read_seqcount_retry are
> > marked with __always_inline so they will be inlined even if
> > CONFIG_OPTIMIZE_INLINING is turned on.
>
> Why just those two? The same issue can happen in other places with other
> clocks which can be utilized by the tracer.
>
> Aside of your particular issue, there is no reason why any of those
> functions should ever trigger a graph.


Yes you are correct. I'll update the patch with __always_inline to all functions
in that file.

Cheers,
Anders
