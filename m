Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD61969D1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 23:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgC1Wa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 18:30:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbgC1Wa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 18:30:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id d5so16406921wrn.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXJuf2d61/8VVRTPBrmoNd9kHkfvBJR4eW3rH5y+FIU=;
        b=DFo7Iydl8YwLfZxc2DLYtdcLmKa0XDIFKr95+X2iKt8uf+XyU60KPDk8AaAr9fOWP6
         16L/XsZ1lN7J4YqSsAZCHcGs8P3OdQtLqKHaYOTN0ZLZUHikJvcjESR1TIa+idWQudiY
         pR4TUEEW51zfyzcbcyulaG8fqY/4+gJMO2x/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXJuf2d61/8VVRTPBrmoNd9kHkfvBJR4eW3rH5y+FIU=;
        b=DrHTjml2FgpolsZsfgFD1zVDKDMOvV/J0M7nPXcYBeaoyhuMoG9C0P08EVb62stmPy
         st3mNwIbFXAdMmi1D7qSnfYP/5W2wYCnS0g9/mLB+zazEmplaIIYeKSxZvUjhP60+TfS
         lXmTykdDkA78V2jdp0/Kg5Qp1XZzqzYSz1i5xvP/Td4oz8wNFKERkywlwOz4vYyGpOeU
         ilururhAbyVJ9blvNd3SiY/QoxJHQHLOnp4p7U9ICK1/yW+oEjJNbiL3XMcNTSFDnNDW
         epqyCbqv/9N6LwgVIV/9JvY3WLF5aMLY3XH+VmfwZNYKX+sSYiURn18BLP9/84+uZGil
         hm/A==
X-Gm-Message-State: ANhLgQ18doylBFACzPSDXiJZW8BODvIWw5LNNI6ZuIUQQlbAf5H8k/OO
        R3fuox5OkEZCcSMuLdY/w5Ul4EP0PdNeKcST/WMl/Q==
X-Google-Smtp-Source: ADFU+vulCziRFDJbIJ694ouqZtPpGPxGPDaurIMchBqU6/L0KIgWi8FFPyh3yqIaaooUdMm1rEUFxDNgE/x8ObAMY5k=
X-Received: by 2002:adf:e48c:: with SMTP id i12mr6643082wrm.173.1585434623969;
 Sat, 28 Mar 2020 15:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200327192854.31150-1-kpsingh@chromium.org> <4e5a09bb-04c4-39b8-10d4-59496ffb5eee@iogearbox.net>
 <20200328195636.GA95544@google.com> <202003281449.333BDAF6@keescook>
In-Reply-To: <202003281449.333BDAF6@keescook>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 28 Mar 2020 23:30:13 +0100
Message-ID: <CACYkzJ4v_X87-+GCE++g0_BkcJWFhbNePAMQmH8Ccgq7id-akA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 0/8] MAC and Audit policy using eBPF (KRSI)
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 10:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Mar 28, 2020 at 08:56:36PM +0100, KP Singh wrote:
> > Since the attachment succeeds and the hook does not get called, it
> > seems like "bpf" LSM is not being initialized and the hook, although
> > present, does not get called.
> >
> > This indicates that "bpf" is not in CONFIG_LSM. It should, however, be
> > there by default as we added it to default value of CONFIG_LSM and
> > also for other DEFAULT_SECURITY_* options.
> >
> > Let me know if that's the case and it fixes it.
>
> Is the selftest expected to at least fail cleanly (i.e. not segfault)

I am not sure where the crash comes from, it does not look like it's test_lsm,
it seems to happen in test_overhead. Both seem to run fine for me.

- KP

> when the BPF LSF is not built into the kernel?
>
> --
> Kees Cook
