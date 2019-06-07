Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5339858
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfFGWNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 18:13:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41321 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbfFGWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:13:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so2700855lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jg1F7lO7uVdQ9tdkXQLyc2uUklR2L0U9AiiLwg+uvg=;
        b=aoO38c3t9rsjPFOteILVcuGQgCSWmQvFmxqe1O+LyeoYe2aN68r4/UJ6/k8U6kDF+9
         k5nu15rfkguUHB69Ug3k1zaCjiMfZbLwrN5OOkDfDyFaGoeL8MWvfl6J09wlT65fi1IT
         7aToDUMiC1CDBV3U4Q7S4ZrpIP6miijco5Te8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jg1F7lO7uVdQ9tdkXQLyc2uUklR2L0U9AiiLwg+uvg=;
        b=sSBU4+YAyBL4YAjsPnnYB9RqBGQRmku1U8C0PhWISmj5SnODlWXyjYFrc7PPy5sD/d
         JwRNtEHNrA7Sqbe6mLeVbMtEvnwq9jvU98kWIhQP0kxZDLBljEdEF5O9YtYg6RK9WVY8
         T7R0jLB1XShY4MIbMpzhTRb6dSJK0iiewtiUmPIUy4Vtp+p0JOzohTmMdcKrSclVdsUk
         2wy9e8nghnApgrPRcBxrp7mPKTPQNjnLigxBGSp+2HnptTEp9R2GlO0tK/RWW6VV9x4J
         3q+8384J5lYDxcoZn9C6biAe14teCkwSeTogBFsbsP8dGGYcjolnxD/Ac0SdW78at/Eu
         kVsA==
X-Gm-Message-State: APjAAAW3CWE3WTZaeRFXDLQP+WwZbSzFn54B14uBCFNXT0Ti0TIp1PB5
        iKUdRYMhjSUTWM3ewAk0BCGpH29Z3MmyGA==
X-Google-Smtp-Source: APXvYqyNQ1FCYcaQgzM/uDJXbFZG3DKe7/L7xXmDk9ya9Z03S4/8GS17KVj/VPoK40VU7nEPfc68Ng==
X-Received: by 2002:ac2:44d3:: with SMTP id d19mr24383327lfm.30.1559945600221;
        Fri, 07 Jun 2019 15:13:20 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id o8sm574079ljh.42.2019.06.07.15.13.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:13:19 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k18so2995376ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:13:19 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr29323271lja.44.1559945263826;
 Fri, 07 Jun 2019 15:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com> <87ef45axa4.fsf_-_@xmission.com>
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 15:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, Eric Wong <e@80x24.org>,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Laight <David.Laight@aculab.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 2:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The sigsuspend system call overrides the signal mask just
> like all of the other users of set_user_sigmask, so convert
> it to use the same helpers.

Me likey.

Whole series looks good to me, but that's just from looking at the
patches. Maybe testing shows problems..

              Linus
