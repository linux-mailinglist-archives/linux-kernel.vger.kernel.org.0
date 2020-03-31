Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFDD199D04
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCaRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 13:37:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:37:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id b1so2336097ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OxKMfb5gM7QgpqPWgcxadm93cwWvuJ3xwBX2b8h0Zk=;
        b=QxeKeYdvDxDB2KsGnX96MJFLBWN6r9Xl8+/nIiMmPIZWNQXbE0OBwYYyKmRM7E/fef
         BnDLeeW8GbZyT7kv0iN+fWr1quptod8J5R+QLtKCbWBkXLNlZVkBoPl0KHmiowGXRuDB
         myOVnk4frLAjbB4qFDYiVBTowniezeJv1tkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OxKMfb5gM7QgpqPWgcxadm93cwWvuJ3xwBX2b8h0Zk=;
        b=McXwSa8hAfADKqagve9oXhxbfenTKuv3LCmiJtSejQS//Ly6FLAu/SRX/8WwE7eiOL
         3hnXsUYOpg80WtPikk8HnJ6mrf9k4iCwiCA7rkc4Bn+DhhfIf/77cKw73Oe2DO7MaWor
         UxjLlZbG709wBc6L00xzf5AeDbwnkpoqPkY5kWGEww7WwhDQDcaDozZYu0T+qL4+hJum
         iU0E2N69qIrXKbRfv44lHnzBW2KYpqHT/FKsiTq4477pWIJlQwgUgYsk69F9sfq7+byZ
         uxev9/IMb+emSQoYNke3PJ0mS2jkMp73ztMwDy25KD9ocDao9cwyMqjoRgMwup3YwOhe
         bJqQ==
X-Gm-Message-State: AGi0PuakVG6iePf/7d07q83ajYKMJsb5yjOjBdcmEU+jyLttJFiBo8t/
        9YMLr3aBHIrECvdU8tQfucCcATVARUs=
X-Google-Smtp-Source: APiQypKd4AKyV3eLm2tTdlns4pU6EU8AJmOUoeudctM+4iijfuwhOj5AVKx7xY5aHTz+S8TLoilgUw==
X-Received: by 2002:a2e:b8c1:: with SMTP id s1mr11365565ljp.0.1585676228824;
        Tue, 31 Mar 2020 10:37:08 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q10sm10336349lfa.29.2020.03.31.10.37.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 10:37:08 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 19so22863194ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:37:07 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr10831245lji.150.1585676227614;
 Tue, 31 Mar 2020 10:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200331075305.GA57035@gmail.com>
In-Reply-To: <20200331075305.GA57035@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Mar 2020 10:36:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFiniKY80uDdSmZVXqXJdvLQS8xeKo9TnN1POqiU5Qxg@mail.gmail.com>
Message-ID: <CAHk-=wjFiniKY80uDdSmZVXqXJdvLQS8xeKo9TnN1POqiU5Qxg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/boot changes for v5.7
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:53 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>       x86/*/Makefile: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections

Ugh.

Looking at that commit, wouldn't it be better to try to move in a
direction where the special 32-bit code (or other stub code) simply
uses the actual KBUILD_CFLAGS as a base for what they do.

For example, in that EFI case, arm64 seems to do things the right way,
and this is literally the x86 code being inferior.

Both 32-bit and 64-bit arm seem to just filter out the flags that
don't work for it the stub code.

And honestly, that seems to be the *much* better approach.

The x86 approach is just rewriting the the cflags from scratch
inevitably has these kinds of odd special cases they it misses.

Wouldn't it be much better to try to standardize around that arm model instead?

I've pulled this, but it hurts to see these kinds of magical hackery.

              Linus
