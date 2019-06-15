Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFB46D80
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfFOBZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 21:25:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45943 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfFOBZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:25:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so2869101lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhXaXfPHsuikNWasyzKXz0OqNXyjMi6Ezr2AgMsWHQs=;
        b=NS9MlD3R5svs5s75KxD3ghJDb0sd5ay6dkFHCdDXXvPag4n3UyYdkxrl15zWReDUxp
         qbkCOMcJNhWXHtKjBXrnjnaBwTcRwDbbtpVOG5zP/B9dtFcErBth+QcPwR+oTA9CbLXi
         /TXfiKSzI6R0mpTTVqWvxESFh6bli4iVzzlWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhXaXfPHsuikNWasyzKXz0OqNXyjMi6Ezr2AgMsWHQs=;
        b=JOj1Ho8Aw6kVVt48iLV/hlfBgTaSxmx5qnudWT9WPePAtOnDNHUZd84IRfpNaKEZ9w
         BkfaLTWXYzaA03AVGb4JG1cR0nlJ4jx2SZSN6/UR5Csv92jwvrliNgEf9no8u79aV1rp
         mX2xAChBU3HqzGcM/AaWrnq1t+4hy21XuH4Wd0zN9gBzKRrgrMIhpuhdmV6CvMCXQfcS
         Z7AMhpJ+8al8alL0eU9XtpFjlOWcdZKsyqGBvQr7bDlMp8lbPnFDLd0urJYx+vrTkZr+
         i5YCXXh+JEQc9Kc5vXvCCBuJ7mFPmMSRqaWiKCD9y2VY61SipzpNqWqGEdjSKacoMpN1
         dEMA==
X-Gm-Message-State: APjAAAV6588mlDrrtTj6N9W19oeoPHc3e9HiWTDfeS0vKpHjGk/L5EXt
        38Cm6CirgkzfouUa62o5mQPS7LhEJ/g=
X-Google-Smtp-Source: APXvYqw9HZ2+uglMyM8dH0FYw17iaiSnWg57ib6UvXN3XwAQP+eaFC02ieg8n+T2/3W6w5lxm/8wRw==
X-Received: by 2002:a19:230f:: with SMTP id j15mr11037789lfj.122.1560561911144;
        Fri, 14 Jun 2019 18:25:11 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 24sm953305ljs.63.2019.06.14.18.25.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 18:25:10 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h10so4133615ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 18:25:10 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr14664531ljk.90.1560561909767;
 Fri, 14 Jun 2019 18:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190614161707.24380-1-will.deacon@arm.com>
In-Reply-To: <20190614161707.24380-1-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 15:24:53 -1000
X-Gmail-Original-Message-ID: <CAHk-=whnnZu=Ed88Cs4=K4d1O2_=ppdkhayDOwJJSSmecPu1xA@mail.gmail.com>
Message-ID: <CAHk-=whnnZu=Ed88Cs4=K4d1O2_=ppdkhayDOwJJSSmecPu1xA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my email address to use @kernel.org
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>, arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 6:21 AM Will Deacon <will.deacon@arm.com> wrote:
>
> When I say "stop working" I really mean "will go to my line manager", so
> send patches there at your peril because they may reply with roadmaps
> and spreadsheets. You have been warned.

Oh we'd better avoid _that_.

> Unless Linus wants to pick this up directly, I can include it in the
> arm64 pull request next week. Just thought I'd send it out now as an
> 'FYI' for the people on CC.

I'll wait for the real pull request, it doesn't look like this is
timing crtitical yet. And at worst, I'm sure I can handle a
spreadsheet or two.

But now I'm replying to your arm.com email anyway, because that's what
the Reply-to was set for.

                Linus
