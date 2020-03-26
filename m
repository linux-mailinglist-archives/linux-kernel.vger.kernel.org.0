Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3119453F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCZRS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:18:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38956 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:18:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id m1so2388135pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FuNH3TvottBd6Vom+HjZUn38bx12HjWSuxT5PFFp2NM=;
        b=bOPaTx6GdaN/kw3TDtNtl7YJvpKCdLmNpmXwiUaOV/H2Dyt1eisLQis+PnTqW9A+cy
         EpkaDdfA5uo4DCk1ebTh4faj0FTdvUrGM01MpAbv2nSbK+gGglpLa6jzzOF6TUBcNS18
         J+EdB85pXrJ9G1gjVsQGSBY1SA1XxTOvVWnGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuNH3TvottBd6Vom+HjZUn38bx12HjWSuxT5PFFp2NM=;
        b=pujXa8qKZgplmazhVdeJ+qAn52+EKFORRCAyhJZqrVa5n4cHeyPszTm4qMWov5ys/h
         tAlfTNeZt3Oxefx7xEtYmE5P8Qfv2dng+K9Aceol1NETnjZb7QDHwYjzZyA4zn80gigj
         OirQhwC89U677sKE7I9armbhLyps7PhqdVJLxAibYZLDodsuYs6dkTiOML4hmepGDY+/
         RTl5bzXqOt6xaeyDHpyp6mVqbujPaKbsIybTnePTZfgYI+fmPOpYezbGelSnfltyCJTy
         8dPd3PxZxwYA2eDejv8X4z5iB+iPdV6kF/LCbVppDKG7kteawP87QVDJ/cffiY0SGOYw
         L93g==
X-Gm-Message-State: ANhLgQ3gzB+m0x11LU/wSHhf8nTX+7hpbvOUvqCWAlOoAH5i4b9RQAMe
        3va89LKVh6JZZoQpoHcz5KD0Kw==
X-Google-Smtp-Source: ADFU+vuKz5FLrd/n++22UcE/kf4ftn3gYQmH2FDL1/qqMttDY074nJOuzLStkZh5VaZoPZM9xVSjkg==
X-Received: by 2002:a17:90a:3783:: with SMTP id v3mr1135572pjb.31.1585243134014;
        Thu, 26 Mar 2020 10:18:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m68sm6263454pjb.0.2020.03.26.10.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:18:53 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:18:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Optionally randomize kernel stack offset each
 syscall
Message-ID: <202003260932.510967DD@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <CAG48ez3yYkMdxEEW6sJzBC5BZSbzEZKnpWzco32p-TJx7y_srg@mail.gmail.com>
 <202003241604.7269C810B@keescook>
 <BL0PR11MB3281D8D615FA521401B8E320E7CE0@BL0PR11MB3281.namprd11.prod.outlook.com>
 <202003251322.180F2536E@keescook>
 <CAG48ez1RfvayCpNVkVQrdNbb6tNv1Wc=337Q7kZu80PrbMOP_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1RfvayCpNVkVQrdNbb6tNv1Wc=337Q7kZu80PrbMOP_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:20:19AM +0100, Jann Horn wrote:
> On Wed, Mar 25, 2020 at 9:27 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Mar 25, 2020 at 12:15:12PM +0000, Reshetova, Elena wrote:
> > > > > Also, are you sure that it isn't possible to make the syscall that
> > > > > leaked its stack pointer never return to userspace (via ptrace or
> > > > > SIGSTOP or something like that), and therefore never realign its
> > > > > stack, while keeping some controlled data present on the syscall's
> > > > > stack?
> > >
> > > How would you reliably detect that a stack pointer has been leaked
> > > to userspace while it has been in a syscall? Does not seem to be a trivial
> > > task to me.
> >
> > Well, my expectation is that folks using this defense are also using
> > panic_on_warn sysctl, etc, so attackers don't get a chance to actually
> > _use_ register values spilled to dmesg.
> 
> Uh... I thought that thing was exclusively for stuff like syzkaller,
> because nuking the entire system because of a WARN is far too
> excessive? WARNs should be safe to add almost anywhere in the kernel,
> so that developers can put their assumptions about system behavior
> into code without having to worry about bringing down the entire
> system if that assumption turns out to have been false in some
> harmless edgecase.

So, I'm caught in a tight spot between Linus's deprecation of BUG()[1],
and the desire for high-sensitivity security-oriented system builders
to have a "completely stop running that kernel thread" option. Linus's
entirely reasonable observation that BUG() destabilizes the kernel more
often than it doesn't means there isn't actually a safe "stop that kernel
thread" option, especially since many mitigations that detect badness span
a spectrum of "stops the badness before it happens" (e.g. NX memory) to
"I see badness has already happened" (e.g. stack protector). As a result,
the only way to provide a way for the security-prioritized users is to
downgrade corruptions to DoSes via panic(). I wish there was a magic
way to have a perfect kernel state unwinder to get us the BUG() we
wanted it to be, but given the kernel's complexity, it doesn't exist
(and is unlikely to be worth developing). Right now, we either get
"WARN() and keep going as best we can" or we get "WARN() and panic".

And with regard to "WARNs should be safe to add", yes, that's generally
true, but the goal is to not make them reachable from userspace because
of this need to be able to "upgrade" them to panic(). I have tried to
document[1] this:

  Note that the WARN()-family should only be used for "expected to
  be unreachable" situations. If you want to warn about "reachable
  but undesirable" situations, please use the pr_warn()-family of
  functions. System owners may have set the *panic_on_warn* sysctl,
  to make sure their systems do not continue running in the face of
  "unreachable" conditions. (For example, see commits like `this one
  <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)

[1] https://lore.kernel.org/lkml/202003141524.59C619B51A@keescook/

> Also, there are other places that dump register state. In particular
> the soft lockup detection, which you can IIRC easily trip even
> accidentally if you play around with stuff like FUSE filesystems, or
> if a disk becomes unresponsive. Sure, *theoretically* you can also set
> the "panic on soft lockup" flag, but that seems like a really terrible
> idea to me.

I understand your general objection to non-deterministic defenses,
as there will always be ways to weaken them, but I don't think that's
reason enough to not have them. I prefer to look at mitigations as a
spectrum, and to recognize that some are more effective with certain
system configurations. They become tools to choose from when building
defense in depth.

> As far as I can tell, the only clean way to fix this is to tell
> distros that give non-root users access to dmesg (Ubuntu in
> particular) that they have to stop doing that. E.g. Debian seems to
> get by just fine with root-restricted dmesg.

Totally agreed about that. Ubuntu may be hard to convince as one of
their design principles has been to make the first user able to use the
system completely with as little interruption as possible. (e.g. pop-up
confirmation dialogs are strongly discouraged, etc.)

So, for this series, I think the benefit-to-complexity value is high.
It's a simple solution even if it's not perfect (most things can't be
given the existing kernel design trade-offs).

-Kees

-- 
Kees Cook
