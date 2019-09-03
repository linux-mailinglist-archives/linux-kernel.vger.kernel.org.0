Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81898A6E03
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfICQYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:24:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43776 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfICQYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:24:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id d5so5686784lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZveg6mK+E2YHe55A6a0W+my7BBYnxsHTvRqGKfbHHU=;
        b=N8zWABOn9S+3i7NCdVRFka+PsNBaHlwe6NsbV/3gcuW2ESNEl8uh2oqvumWFPXbEDr
         iBEFwEPZjx9RRFw8g7fhIy0mOrWL3g6kOkSPnp4dKT4RTMG007mkeRGB1skoCqMaPrzC
         G+cvlMy/mviUKpyz2n8C346C4h1M3FKOxUums=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZveg6mK+E2YHe55A6a0W+my7BBYnxsHTvRqGKfbHHU=;
        b=RhW8ycm31TxaCgHT+iHK0tVJ0AsDqJoZREjQeLSv/3FXXiXFqsy7HXmPJJv0qIUZJX
         o/pDFrpR5nXT8Stp5gNWDREy+afKc5zCidzEx2ihM95yLdKi9xFxjSCjdPF2kiVdG9ja
         j6H5NoJ2Sx+n1IAkCF/xKBm+ZLBjP70fZDs+fxmcGm3xPoTlHn+muoRfx0Eph1OhwIKi
         7PAlY6RZCjw5ttFZlO7iYsjqx5kgp+zFZL6iajZIjb7pYS2jkbQjbOa5STkhzc8OwyS/
         ijKOAU57p3UM/3zZdiVT0bqSfe3tVbMNYmOyvcoIhd8mMkJ8PU+5Kj+KR29+C0RuQN0t
         1Nzw==
X-Gm-Message-State: APjAAAUYdoRpB87rbdEWNAghBdAcEdjTc+J2sncbBcmSVg1yfgKgp7kw
        yrjdfD10uJ0RMVBJSrQzkGbxTs8ojGM=
X-Google-Smtp-Source: APXvYqx4dEnCkmdGVl0jCWjVBW9P1sRYsV1ytrnX1cger/wrSfWhamm6O20NVyrKY9kdcCC0+t/YHA==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr702131ljh.47.1567527845472;
        Tue, 03 Sep 2019 09:24:05 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f26sm1004976ljc.10.2019.09.03.09.24.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 09:24:04 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id y23so5576701lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:24:03 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr8334804ljg.72.1567527843691;
 Tue, 03 Sep 2019 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160036.2400-1-mathieu.desnoyers@efficios.com> <20190903160036.2400-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190903160036.2400-3-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 09:23:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY-Lh1SvzpG2OPh_DUNJMeTTSyfNmx=ALz1UuZ4EiC=g@mail.gmail.com>
Message-ID: <CAHk-=wiY-Lh1SvzpG2OPh_DUNJMeTTSyfNmx=ALz1UuZ4EiC=g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Fix: sched/membarrier: READ_ONCE p->mm in membarrier_global_expedited
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:00 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Due to the lack of READ_ONCE() on p->mm, this code can in fact turn into
> a NULL deref when we hit do_exit() around exit_mm(). The first p->mm
> read is before and sees !NULL, the second is after and does observe
> NULL, which triggers a null pointer dereference.

This is horribly ugly, and I don't think it is necessary.

The way to fix the problem you are addressing in patches 2-3 is to
move the MEMBARRIER_STATE_GLOBAL_EXPEDITED flag from the mm struct to
the task struct, and avoiding the whole issue with "mm may be released
at any point" that way.

Now, your reaction will be "but lots of threads can share an 'mm', so
we can't do that", but that doesn't seem to be true. Looking at the
place that _sets_ this, you already handle the single-thread cases
specially, and the multiple threads has to do a "synchronize_rcu()".
You might as well either walk the current CPU's and set it in all
threads where the thread->mm matches the mm. And then you make the
scheduler set the bit on newly scheduled entities.

NOTE! When you walk all current cpu's in
membarrier_register_global_expedited(), you only look at the
'task->mm' _value_, you don't dereference it. And that's ok, because
'task' itself is stable, it's just mm that can go away.

Wouldn't that solve the issue much more cleanly?

             Linus
