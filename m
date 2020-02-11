Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABE159A50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 21:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgBKUMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 15:12:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45288 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgBKUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:12:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6027016pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlqJl8lJ0d/NouuQRbqG8ZhYdISr8b6hpT80DhDEOT8=;
        b=jVeKyYKS8z8jH5uBoPw9hFUIW+3PRhcQ9FYhmiDn/VQWHcL4WYl+bDWjyVbQ9j/8PR
         D/iAKeaeZCsBvyYEGBlOi1zFHEuFT41ohyVx2LTvDGpSy6eTX4kCLZkXRNRpf0Qh0qAg
         jiTPSKeIRBcp5oSwbRW+YqlW8DvD/sNNESnHNuypEhkNMcfxTfqCyU5RXQOTIYBxJpCW
         3mWgF2M4+hphJefXU1oEWWHpZQsKxQrZ0tmv1YkWJl3BAozB23Y3OlpwEriTE9nULBXz
         SPymit1lnRbi/kmKF/fzYbdQCqbd9TSrcPy2L887Ii9iqKUZIxdLTejrl3jWZLqbgfdG
         sTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlqJl8lJ0d/NouuQRbqG8ZhYdISr8b6hpT80DhDEOT8=;
        b=LeB6LWN33awVKZVsV/P1cd8YoZHbBLoGOCIEr+6NqUlxrlvWuL8roKIX1Qau8D4ZWe
         JWqbYWcIOoZSEUGxyy/1f+IHuMWM96Nk5uG16y/yI7My7rc6Z5bfSPENfyqpaJG3vNXe
         EBl/rcGHQuNc34bA51mvL9SXu1qJ5/x+XUBnwDsM/1iSgObhzo5jb4T2rTGuLbpvmbwP
         CsMB7SKAWfeUBuUCFmdq6RcdXdvAqEIwdRTHcyleB8QRnykRje8DshGvNGM3usnXoBxX
         zne9wqGdQnu1QP1mNyi5Jq0//JCkYnZyrWvs856o59G332WU9wD4GVJ/7XRCPcAeUJWo
         dLOg==
X-Gm-Message-State: APjAAAUStA5YK2+0s58OXylT9QUgCma625Ja3e85uwvEQeEWAD4urF/6
        JsbevU0mtYw7MCr8o0QAGU41buRkIayAn+X/MMO6XA==
X-Google-Smtp-Source: APXvYqzKJDmBK4efnnfS6O9Kr7nvDRR2hvSR9jbboDWimwZgxO273OUqpOmZkWeQQwhUM/I503OkpzGM71fPNhEltc0=
X-Received: by 2002:aa7:8618:: with SMTP id p24mr4896709pfn.3.1581451966090;
 Tue, 11 Feb 2020 12:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20200208140858.47970-1-natechancellor@gmail.com>
 <your-ad-here.call-01581426728-ext-3459@work.hours> <CAKwvOd=CWKnrY_T8vP4a-KXkz-V57dFqk+6FC_krm=pVAVibyg@mail.gmail.com>
 <your-ad-here.call-01581450834-ext-0583@work.hours>
In-Reply-To: <your-ad-here.call-01581450834-ext-0583@work.hours>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Feb 2020 20:12:33 +0000
Message-ID: <CAKwvOdk_6kOVPMWOuZ1r2HyAQ9MhE1=n56GhrO49bzghw3724g@mail.gmail.com>
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:54 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Tue, Feb 11, 2020 at 05:30:24PM +0000, Nick Desaulniers wrote:
> > On Tue, Feb 11, 2020 at 5:12 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> > > Applied, thanks.
> >
> > Hi Vasily, is this the expected tree+branch that the patch will be
> > pushed to? (I'm trying to track when+where our patches land).
> > https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes
> >
> Hi Nick,
> yes, this is correct. There might be some delay due to ci runs. But
> this particular patch is now landed on that fixes branch.
>

Ah, yeah now I see it, thanks. The aggressive patch tracking helps us
figure out what landed where so that we can better backport patches to
LTS (hence the Fixes tags you've seen on other patches).
-- 
Thanks,
~Nick Desaulniers
