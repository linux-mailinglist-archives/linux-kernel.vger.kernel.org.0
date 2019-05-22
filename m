Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88C7266C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfEVPRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:17:37 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:38954 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbfEVPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:17:37 -0400
Received: by mail-vs1-f45.google.com with SMTP id m1so1628719vsr.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85/xp1LLQ/Gq2RJYWYYuF9b0tPNRLe+Qag7yBp7mWAc=;
        b=iBWci38mGhcli5wl56IPjiVCAofYwzUm4VCJt87rQIGMSzAXm/QAy94eFgEFu8rUce
         2NBGu1/wkdaHaRcgpPfNmplL8dhDXjTVblDzenDcR0W+w6pUL9obwUeRHAVKQLcZoXYF
         GuCdoBXre8W4MP86eIDrkksZYa1fEFrxAcO9jXA7sAl9bJllqYSc5wJa1iAdguUqvdlf
         OuBrz86GYBbuxVW87BTcDE3HQS59eTVvXENFhOHWENHDbM0HUJ39W2JzfNV16r7l/wgO
         oj0farWsUo773EVjgFU5QmbjsDTQlf1c11zA1tw7d8iG5F7UYd4mxj4QI+EKJufJaBpc
         YTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85/xp1LLQ/Gq2RJYWYYuF9b0tPNRLe+Qag7yBp7mWAc=;
        b=GOPHCpZNWaIYVdyuEKOn+TrxUF9B1kOuJVyZmHdUiMaZXmoB7S1w6nAYg4wcqNpZKa
         E/O8WF/q1D49+Q2PUaLwp7bmfkJ93tpUrG7OT0M8vmMc31u2vZihwKllk1cYQ9IOmWzu
         VApETPEjLuXGM8gRKRzicIbFaACDvtFx+MQ3Mue3Rku3AdyAVorKTisx2eKcrDJIvMie
         wz5XiRqjh7zKvAE4PIRxrWmYMAeSlbVXSp2r/rc/xnbnXuTSzfWNSaV8UDfQCNTBue8u
         4sR10EYt/6B1vLDNHmp0pW2Htj2yEjvZ8/1tVlyOP61S4I181WdULawuCY0PQG7cY4MC
         s4HQ==
X-Gm-Message-State: APjAAAW11dWPX/GVRi31egLe4EPUz2b75bYvtUQ6q+u1tbmZ4fJIusZR
        M+wT7bd41TkYk97hbNXRCbljAsVzcdwoW6OHtaS9RxbHzzc=
X-Google-Smtp-Source: APXvYqwY3fllxdUsIb9pMNHzQvevbLB7gTfbyxHIV/lLfYAFC6DFS71u+U2Zbq2qGndivpbq5Z7rOI0NonYCw87UG3I=
X-Received: by 2002:a67:e1d3:: with SMTP id p19mr31572261vsl.183.1558538255715;
 Wed, 22 May 2019 08:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com> <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io> <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com> <20190522145216.jkimuudoxi6pder2@brauner.io>
In-Reply-To: <20190522145216.jkimuudoxi6pder2@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 22 May 2019 08:17:23 -0700
Message-ID: <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Christian Brauner <christian@brauner.io>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> I'm not going to go into yet another long argument. I prefer pidfd_*.

Ok. We're each allowed our opinion.

> It's tied to the api, transparent for userspace, and disambiguates it
> from process_vm_{read,write}v that both take a pid_t.

Speaking of process_vm_readv and process_vm_writev: both have a
currently-unused flags argument. Both should grow a flag that tells
them to interpret the pid argument as a pidfd. Or do you support
adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
should process_madvise be called pidfd_madvise while process_vm_readv
isn't called pidfd_vm_readv?
