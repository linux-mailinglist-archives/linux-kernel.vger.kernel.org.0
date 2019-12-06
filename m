Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7A115873
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLFVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 16:12:22 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40247 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFVMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:12:21 -0500
Received: by mail-ot1-f54.google.com with SMTP id i15so7023998oto.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=carlosedp-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdHciF5HT4NgfVYmLECpZu4mij9jceu5at9ZUMTKa8I=;
        b=FTHx5Isvz6SuxSV1Rd1sZ40+c2jk+n33PkfKHk95d+A+bKwo22yAGaCCYkdXj7a5JQ
         HE2x3Hs9THsDgn6T9rAWmjvtnyeOZs3u6XJxDmLSFL2Fy8tuJrYj/uqwM8YIN9u+rNwn
         Ks9L7x6JzcbgtzxbgZCY/bBCL/yNb5GnRumltg3nUX6qvvyb5qNyi7zQ2HrYSub41PwX
         P2VbyOtUe3kp/XU15AsrBQBB6CM34g+PTPX7MqHmszjw+/5H1/Hh6NlxsYE1t2ZpbtWU
         PcLAi4I/dLQsszkDjSESEOIZ02d/Oy9L1IrjvOsxBAcFwLig/B6FdLcCORr3uMbtlhe0
         hWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdHciF5HT4NgfVYmLECpZu4mij9jceu5at9ZUMTKa8I=;
        b=O8Cn90bBXffKhCROmNRcPIZDSS3jgCqm53pWRerf30L9q10IIgYeCuFuWQ1mClNaNw
         paiaJGxxM0yyLNhxKzEvMsD0vxE7Y9FuSrSAw0LZC0etrLtQ4YQiFHeJAecFsnfSo+gc
         zXSHNKQATseYL7cMa6ImEaqlegZ+UliMxwzktK9iLv9Nqd5zAe5IKZhEQmRBi/2UPxdK
         LQs5pRb868dUmueqIq5+mEvx76ex4bemrpJbosn9L5TNWJ7JC4S5banq9pe91QRMfjdJ
         UoJx8S+4a8kUqc+ettP0nMXKATK4dQw8k5jVaWzwFSfWEz9eOju53aMzfbxyUo+bnoMT
         7plg==
X-Gm-Message-State: APjAAAV7LZ4BcYDVboNdji9eqi6rFe11RkaT2IBYU0dv39gaBXyIWeZW
        ezqWP0UzZHSnnfL0g6gLSzixrH8TbC0DSQ==
X-Google-Smtp-Source: APXvYqzJJ2a/ClqGc88oQsiD5FYs4zp+uoWkohVOMkMREgeV4AnUzcsRKZMG/gn2najV0jgRHWvatg==
X-Received: by 2002:a9d:644:: with SMTP id 62mr13237876otn.287.1575666739838;
        Fri, 06 Dec 2019 13:12:19 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id x15sm5047018otq.30.2019.12.06.13.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 13:12:19 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id d17so7075009otc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:12:18 -0800 (PST)
X-Received: by 2002:a9d:2073:: with SMTP id n106mr12773659ota.145.1575666738241;
 Fri, 06 Dec 2019 13:12:18 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
 <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
 <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com> <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
 <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com> <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com>
 <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com> <alpine.DEB.2.21.9999.1912051435130.239155@viisi.sifive.com>
 <99bbf5710da82c8b52e59ad5fc4e44471573ecd3.camel@wdc.com> <3286a00cb9c8033872f533ec3e7f3db3e652c30c.camel@wdc.com>
In-Reply-To: <3286a00cb9c8033872f533ec3e7f3db3e652c30c.camel@wdc.com>
From:   Carlos Eduardo de Paula <me@carlosedp.com>
Date:   Fri, 6 Dec 2019 18:12:07 -0300
X-Gmail-Original-Message-ID: <CADnnUqe-=yTAFbwin_Lti6mQKqO2ABVYMa1XgTv_J=usT5w2gg@mail.gmail.com>
Message-ID: <CADnnUqe-=yTAFbwin_Lti6mQKqO2ABVYMa1XgTv_J=usT5w2gg@mail.gmail.com>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 8:46 PM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Thu, 2019-12-05 at 15:29 -0800, Alistair Francis wrote:
> > On Thu, 2019-12-05 at 15:12 -0800, Paul Walmsley wrote:
> > > On Thu, 5 Dec 2019, Alistair Francis wrote:
> > >
> > > > On Wed, 2019-12-04 at 18:54 -0800, Paul Walmsley wrote:
> > > > > On Wed, 4 Dec 2019, Alistair Francis wrote:
> > > > >
> > > > > > It is too much to expect every distro to maintain a defconfig
> > > > > > for
> > > > > > RISC-V.
> > > > >
> > > > > The major Linux distributions maintain their own kernel
> > > > > configuration
> > > > > files, completely ignoring kernel defconfigs.  This has been so
> > > > > for a
> > > > > long time.
> > > >
> > > > That might be true for the traditional "desktop" distros, but
> > > > embedded
> > > > distros (the main target for RISC-V at the moment) don't
> > > > generally
> > > > do
> > > > this.
> > >
> > > Maybe in this discussion we can agree to use the common
> > > distinction
> > > between distributions and distribution build frameworks, where
> > > users
> > > of
> > > the latter need to be more technically sophisticated - as opposed
> > > to
> > > downloading a disk image.
> >
> > Why is there a distinction?
> >
> > There are lots of disk images that you can just download which are
> > based on OE or buildroot. Lots of people use OE images and never
> > realise it.
> >
> > In the same way that there are build enviroments based on the
> > standard
> > "desktop" distros. In both cases these are distros.
> >
> > > > > > Which is why we currently use the defconfig as a base and
> > > > > > apply
> > > > > > extra features that distro want on top.
> > > > >
> > > > > As you know, since you've worked on some of the distribution
> > > > > builder
> > > > > frameworks (not distributions) like OE and Buildroot, those
> > > > > build
> > > > > systems have sophisticated kernel configuration patching and
> > > > > override
> > > > > systems that can disable the debug options if the maintainers
> > > > > think
> > > > > it's a good idea to do that.
> > > >
> > > > Yes they do. As I said, we start with the defconfig and then
> > > > apply
> > > > config changes on top. Every diversion is a maintainence burden
> > > > so
> > > > where possible we don't make any changed. All of the QEMU
> > > > machines
> > > > currently don't have config changes (and hopefully never will) as
> > > > it's
> > > > a pain to maintain.
> > >
> > > I'm open to your concerns here.  Can you help me understand why
> > > adding a
> > > few lines to the kernel configuration fragments to disable the
> > > debug
> > > options creates maintenance pain?  Isn't it just a matter of adding
> > > a
> >
> > For one, we have the same burden as you do.
> >
> > You feel that it's too much of a burden to have a config fragment in
> > tree to enable debug. You clearly feel that having a
> > `extra_debug.config` fragment for you is too much of a burden, why is
> > it not a burden for distros?
> >
> > > few
> > > lines to disable the debug options, and -- since you clearly don't
> > > want
> > > them enabled for any platform -- just leaving them in there?
> >
> > Leave them in where?
> >
> > No other architecture does this. Now we have to have a special config
> > fragment added just for RISC-V. Why is RISC-V so special that it
> > needs
> > it's own fragment that other arches don't have?
> >
> > > > > > > distros and benchmarkers will create their own Kconfigs for
> > > > > > > their
> > > > > > > needs.
> > > > > >
> > > > > > Like I said, that isn't true. After this patch is applied
> > > > > > (and
> > > > > > it
> > > > > > makes it to a release) all OE users will now have a slower
> > > > > > RISC-V
> > > > > > kernel.
> > > > >
> > > > > OE doesn't have any RISC-V support upstream, so pure OE users
> > > > > won't
> > > > > notice
> > > >
> > > > That is just not true.
> > >
> > > After getting your response, I reviewed the OE-core tree that I
> > > have
> > > here,
> > > which is based on following the OE-core "getting started"
> > > instructions.
> > > The result is a tree with no RISC-V machine support.  Looking again
> > > at
> > > those instructions, I see that they check out the last release,
> > > rather
> > > than the current top of the tree; and the current top of tree does
> > > have a
> > > QEMU RISC-V machine.  So this statement of yours is correct, and I
> > > was in
> > > error about the current top-of-tree OE-core support.
> >
> > The last release (Zeus) also has RISC-V support....
>
> Whoops, I left the dots to remind me to come back and double check
> this, but then I forgot to remove them.
>
> >
> > > > You talk later about misinformation but this is a blatent lie.
> > >
> > > This isn't acceptable.  We've met each other in person, and I've
> > > considered you an enjoyable and trustworthy person to discuss
> > > technical
> > > issues with.  This is the first time that you've ever publicly
> > > accused me
> > > of misrepresenting an issue with intent to deceive.  There's a big
> > > difference between stating that someone is quoting misinformation
> > > and
> > > accusing someone of bad intentions.  I expect an apology from you.
> >
> > I didn't say you had bad intentions. I was just pointing out that you
> > spent the time researching points that match your argument, but
> > didn't
> > check to see what current RISC-V support is.
> >
> > I don't see a difference between saying someone is spreading
> > misinformation and lying, but I am sorry if it upset you.
>
> Just to clarify, I am sorry that I upset you. I did not mean to do
> that.
>
> I do not appriate you saying that I am spreading misinformation,
> espicially when there are numbers to back up the claim of slowing down
> defconfig users.
>
> Alistair
>
> >
> > > > > > Slowing down all users to help kernel developers debug seems
> > > > > > like
> > > > > > the wrong direction. Kernel developers should know enough to
> > > > > > be
> > > > > > able
> > > > > > to turn on the required configs, why does this need to be
> > > > > > the
> > > > > > default?
> > > > >
> > > > > It's clear you strongly disagree with the decision to do
> > > > > this.  It's
> > > > > certainly your right to do so.  But it's not good to spread
> > > > > misinformation about how changing the defconfigs "slow[s] down
> > > > > all
> > > > > users," or
> > > >
> > > > What misinformation?
> >
> > Somehow it looks like you dropped this paragraph from my response,
> > I'll
> > just add it back in:
> >
> > ******
> > Anup shared benchmarking results indicating that this change has a
> > 12%
> > performance decrease for everyone who uses the defconfig without
> > removing this change.
> > ******
> >
> > > You've already acknowledged in your response that the major Linux
> > > distributions don't use defconfigs.  So it's clear that your
> >
> > What do you mean major?
> >
> > AFAIK OE and buildroot are the only distros that have first class
> > RISC-
> > V support. That seems pretty major to me.
> >
> > > statement is
> > > false, and rather than admitting that you're wrong, you're doubling
> > > down.
> >
> > Doubling down on what? I never claimed all distros use defconfigs.
> >
> > > > > exaggerating the difficulty for downstream software
> > > > > environments
> > > > > to
> > > > > back this change out if they wish.
> > > >
> > > > If you think it is that easy can you please submit the patches?
> > >
> > > For my part, I'd be happy if the current RISC-V OE and Buildroot
> > > users who
> > > don't change the kernel configs run with the defconfig debug
> > > options
> > > enabled right now.   So, I don't plan to send patches for them.
> >
> > That is what will continue to happen. All users will be expected to
> > live with a 12% performance impact.
> >
> > > > I understand it's easy to make decisions that simplfy your flow,
> > > > but
> > > > this has real negative consequences in terms of performance for
> > > > users
> > > > or complexity for maintainers. It would be nice if you take other
> > > > users
> > > > /developers into account before merging changes.
> > >
> > > As stated earlier, I'm open to reconsidering if it indeed is
> > > onerous,
> > > and
> > > not just a matter of patching a few lines of kernel configuration
> > > fragments in OE and Buildroot once.
> >
> > I don't understand, if patching a config is so easy why not just have
> > a
> > fragment in the kernel tree and you can use that when you build a
> > kernel? This is what Daniel Thompson pointed out. That would avoid
> > this
> > issue and have it easy for you to build a kernel with debug support.
> > How is that not the best solution?
> >
> > AFIAK no other architecture has all these debug options enabled in
> > the
> > defconfi, why is RISC-V so special?
> >
> > Alistair
> >
> > >
> > > - Paul

Folks, isn't viable having a defconfig and a defconfig_debug. This
would address both cases and avoid putting a penalty on people that
are already using Risc-V boards or VMs for building software.

-- 
________________________________________
Carlos Eduardo de Paula
me@carlosedp.com
http://carlosedp.com
http://twitter.com/carlosedp
Linkedin
________________________________________
