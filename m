Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3544A116506
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 03:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLICXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 21:23:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40190 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfLICXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 21:23:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id s22so13780968ljs.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 18:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtNlyNh+mGdA2q4AO/JzXYXFrnuZqMnTZ+qQdX6qkbw=;
        b=dZTJ7Zvl+X4Orlt5MxUX7caFe5OE31NxlNViH1WqR1xDkCBQ5UDeD13DvceCigkefe
         NkUu8l4gfBUHZtIbZVYr5+fPLPBcJzA6yphObSdWg1lXpEgnqyLssA5GvFfNgnMwdzMh
         tAhKKkBhHK2297EJrC4yT/2mx9cAPYvsAmndE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtNlyNh+mGdA2q4AO/JzXYXFrnuZqMnTZ+qQdX6qkbw=;
        b=ByLPVOUatMSZaXpQbV61f53HdwQHrzEWtuD5AC0KtmfCoGYI7mhh5D1gKwWHHX/YE/
         8lnzLEQMbk/P1fYxlCr3hhSPphLpkt8/NocE+Uu7c5EXq0TEUJXN9qBJQmLkgBxeMavo
         kvokC6L0ajndhTc0PoUTteWS59bPVorEM4aw19RK+tf7qRLlkwv4x57vfAppOR/lvfx1
         4x0THeSa1DyG5kwlWAbOe38ZQMZc0oUR6efVz/KfIhWtTQjwaRRrShro1Q0BCss4w8rx
         Z++myLvX5eO/2EbxoR1+UAt60iHw8UwUbETl64Po7d57v6ES6/45bGecYfreiOCeNvZV
         sdTw==
X-Gm-Message-State: APjAAAVJB94+TrJi0y04c74UanndDGK0MGzOkmk/FGlqXT6aSpsFC9Fw
        Yq3EpkFl16fxdVYpubrLy/3XbejbQmc=
X-Google-Smtp-Source: APXvYqzNVSf5Tiq6B5DYukD6RqIZSYJXtfwwhPGm/5sCBySXKWsDzBa7hBku4XI/afGj/HvT1Z3UAA==
X-Received: by 2002:a2e:8646:: with SMTP id i6mr15350900ljj.122.1575858200302;
        Sun, 08 Dec 2019 18:23:20 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f26sm5118148ljn.104.2019.12.08.18.23.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 18:23:19 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a13so13762375ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 18:23:19 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr15164274ljk.26.1575858198831;
 Sun, 08 Dec 2019 18:23:18 -0800 (PST)
MIME-Version: 1.0
References: <30808b0b-367a-266a-7ef4-de69c08e1319@internode.on.net> <09396dca-3643-9a4b-070a-e7db2a07235e@internode.on.net>
In-Reply-To: <09396dca-3643-9a4b-070a-e7db2a07235e@internode.on.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 18:23:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjj8SQx4YzS8yw7ZJJKiVLBY0g=d8rCSyPCM=8Pzmz+Zg@mail.gmail.com>
Message-ID: <CAHk-=wjj8SQx4YzS8yw7ZJJKiVLBY0g=d8rCSyPCM=8Pzmz+Zg@mail.gmail.com>
Subject: Re: refcount_t: underflow; use-after-free with CIFS umount after
 scsi-misc commit ef2cc88e2a205b8a11a19e78db63a70d3728cdf5
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     SCSI development list <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 5:49 PM Arthur Marsh
<arthur.marsh@internode.on.net> wrote:
>
> This still happens with 5.5.0-rc1:

Does it happen 100% of the time?

Your bisection result looks pretty nonsensical - not that it's
impossible (anything is possible), but it really doesn't look very
likely. Which makes me think maybe it's slightly timing-sensitive or
something?

Would you mind trying to re-do the bisection, and for each kernel try
the mount thing at least a few times before you decide a kernel is
good?

Bisection is very powerful, but if _any_ of the kernels you marked
good weren't really good (they just happened to not trigger the
problem), bisection ends up giving completely the wrong answer. And
with that bisection commit, there's not even a hint of what could have
gone wrong.

             Linus
