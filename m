Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2FB3F82
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfIPRQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 13:16:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37212 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbfIPRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:16:29 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so873758iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUJero5UkE6Fljf/Pm1mxTzFIA/90cizF+WESKd6Mss=;
        b=s1+pQC3ihcD+84Cl+sriqk1pZOtccOPGfZAJyxTif7fCYa0kuMj1w/zZcHe4yTI8Jj
         MgWiKcZL5WulHOpW0A22XsOPx9WzZ4wJa6nHwdHAG1i/bFKvwZFa1bwP3QmS1CZ1VwA4
         8V9q7vRDMIu6/xUac9u15AOTO4fJ4kwS6RwGkc5hHCY/FqRLnSG6yqRFdE0EtauOHTMS
         xjUv2hrjZ0OkPyU3B0wtGbRrucKEdBQmaEcTCPegbv8C7VSL2YrgpQb4IymGxE/gmZD0
         g/kbE6AL80zoFUJa/XxGssyfy4aJ19WwdWt+ayyZpWkJ8lDx5YHgSkIhg41MBUy4AK+B
         URPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUJero5UkE6Fljf/Pm1mxTzFIA/90cizF+WESKd6Mss=;
        b=gFfyQmriGgJgnQUbXXSP2cnIKHu1jx23qXLWXA/jQNsKxfFlZMi8DI8y5BHqzTIuoq
         2w+6YlKPSEgevZk+U6jXzE8vaHuMMUVBvsofQ6UrNRiG++7iYr+3xp/ffXA0Anq6UTkF
         wig59Fu9wAeXvvivFQkhSuN9DjKqdlvuZjOBy7yIJRrYPzB8OplCs3flKOcSL+KTRWw6
         LTK1FLZzth1EcpIiy9e4AspM+dsYo5ly+A4MSAoUveLB9h9KmDZ9Hpb0JG/1T00mCARG
         Zyv7sBXy67lBBNOidZrZ0apVitp6g6Lz2UTAYgu0SNNMhXG5ioyn1XtOgl76qzDPKixl
         I4pg==
X-Gm-Message-State: APjAAAU1ikUH41aMysvBn8nvk2W6DMpmLfYfrpCvC5lOODA7+5K5CxXh
        8DewkR+zGQK7OYmPXUHPNZzZ3aHUUJKSu/EHYIG8Y6TxpERI9w==
X-Google-Smtp-Source: APXvYqx3LYUfAKHGcDtvfqlYxzFFBjLjFGswJF8z3f9bdd3KJ9QJmUib4Dxrf4qVVJx1Zk8Pm6uGG3nf2LxfFtkTcaE=
X-Received: by 2002:a02:b782:: with SMTP id f2mr1135007jam.48.1568654188556;
 Mon, 16 Sep 2019 10:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190916162258.6528-1-vkuznets@redhat.com> <20190916162258.6528-2-vkuznets@redhat.com>
In-Reply-To: <20190916162258.6528-2-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 16 Sep 2019 10:16:17 -0700
Message-ID: <CALMp9eQP7Dup+mMuAiShNtH754R_Wwuvf63hezygh3TGR=a9rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpu/SMT: create and export cpu_smt_possible()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 9:23 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> KVM needs to know if SMT is theoretically possible, this means it is
> supported and not forcefully disabled ('nosmt=force'). Create and
> export cpu_smt_possible() answering this question.

It seems to me that KVM really just wants to know if the scheduler can
be trusted to avoid violating the invariant expressed by the Hyper-V
enlightenment, NoNonArchitecturalCoreSharing. It is possible to do
that even when SMT is enabled, if the scheduler is core-aware.
Wouldn't it be better to implement a scheduler API that told you
exactly what you wanted to know, rather than trying to infer the
answer from various breadcrumbs?
