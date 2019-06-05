Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB235807
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFEHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 03:49:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35517 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:49:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so4579026qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crok5Ev15ISYgnnJaOj6tV1yV3D0d5LwKbKEuJqsl3Y=;
        b=H07f7vvX6zOe65o4mwg5wNjghQ4H1S8GWtb2mCwvZet5mfzCwBvghBQyqMil/v+NmS
         jxS+E2q9nnh5topQIncq2m7o1j5FYS1W0ziPR8ITZyRGqwlTwRt8Qz8Ic56s3Sq+EgCE
         S8i2e3xGLmWq21o9gSFcUlFSRfvJIHIDjbdk3SaQ1eA8EGv6gYq/sSpnSgmH9cs1+V8v
         38i1gfaR34TipZmzJqCfiCeh1h0aFFJQXMWrasj2cQhfZoV2Pr+MLK6etWXAl93gN0vA
         usA7BpEmam95PLwwJW/4uxrk0kDAaZYoaeqGoM/U8E+FJJ0sQitL6a2faBQTGYqB1x3f
         XMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crok5Ev15ISYgnnJaOj6tV1yV3D0d5LwKbKEuJqsl3Y=;
        b=OlECk8DCJ1Q6DC+aJt2ofRBJIOBllOa4zlVVOf1pr4+avl3OLgHLuwzps+O5FvLMB8
         1n1Wf4F2ZmmpDrcfSHdB6YpLfYb2IO29xojLKnEq2/4j6AyuCSk62smxSBux7O9lm1GQ
         ksto9aEdaSfsa4khp+tWvBcyo6++OYtIxaT/k7ECmoL4aZWdhdTupbBHNC5NkLu0SQwH
         0WZq9Akg68wA4bx6eXe0PU8hOB7hRY6YxNGgzHTX8OVtkiGBpAJUk9ZpQ+2Fod4uX9g9
         6KvRlrQYq2uCY6pj3qNXWf4owMZiHR79yKiOVT4SzONQqGecbc1aKBJXzz4ZwqAoSpyu
         +nUA==
X-Gm-Message-State: APjAAAVVyMT6Ro6bFi/19hy15VH3GawjFND7sU4iUfe233p0wEDaw0yK
        ZsNLW6EqyM/In6UJjvOf9yktlszwN2E8wCJxq3g=
X-Google-Smtp-Source: APXvYqxh/68hD50ZIEWtIjkHpaISLrUVF4zaV3BX8nCSwzVGaamXKHojDp93Oh/YWT/lIvDnc/AGbSu323RBdL7LHfw=
X-Received: by 2002:a37:aa4d:: with SMTP id t74mr32146842qke.144.1559720941438;
 Wed, 05 Jun 2019 00:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205918.22251-1-longman@redhat.com> <20190520205918.22251-8-longman@redhat.com>
 <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
 <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
 <20190604091220.GA29633@tardis> <d1a2894e-144e-d30b-966d-c2fd7b6f3f7e@redhat.com>
In-Reply-To: <d1a2894e-144e-d30b-966d-c2fd7b6f3f7e@redhat.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Wed, 5 Jun 2019 15:48:49 +0800
Message-ID: <CAHttsrYVHXZTtC7fTRn-osH-yYzC-GUhpQJVapWp0UhPsGfZxA@mail.gmail.com>
Subject: Re: [PATCH v8 07/19] locking/rwsem: Implement lock handoff to prevent
 lock starvation
To:     Waiman Long <longman@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Wed, 5 Jun 2019 at 00:00, Waiman Long <longman@redhat.com> wrote:
> With my patchset applied, the reader-writer ordering is still supposed
> to be preserved. Of course, there can be exceptions depending on the
> exact timing, but we can't rely on that to prevent deadlock.

This is exactly what I want to know. Thanks for the reply.

Thanks,
Yuyang
