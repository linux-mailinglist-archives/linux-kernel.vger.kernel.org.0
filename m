Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7835110A717
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 00:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKZXZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 18:25:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44590 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKZXZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:25:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so22198847ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 15:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hXNe4v9OKZKvgLpYR0ravtB7ricFKxIDAh+9qn6mX0=;
        b=R0E7oRwQwZuFYY3eojhe1RrAwtf6b6k49KXQw73lwBG4yRs6k1VTASCPe50wnjz+Ns
         uA+v7uSj2YE046KDO05BG0YwHNrWiU9tZ/tu4G4C/Lx1t1/nqBo4S8U0XTowKxplDWzG
         hNyuOiBNgqFoItkexTbbG5sa3ZOrpXbV9ZKM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hXNe4v9OKZKvgLpYR0ravtB7ricFKxIDAh+9qn6mX0=;
        b=iDz0HPpHWNWO0/q3mt2pgtDjhMxtWE73Dneow+bukUFC4OeHiK3FlimfWto3KrP648
         sR0T2NC4cuORL33xgwR94LUqfR6dln88HJtjV8jqAyZhsIN9OmsgjBDYM2CIqIZcIIYy
         GHnXAyfNn3jI938YyrK2Ri2ao1zaB6a8xSoHgp091u7kq9KbGwaLC1LYrNXMco32t6/P
         NU/wLeM0ybsuQxEwZ7xpIMOhs03dSEdyuDF7f/aLoAnuXuwn+mjet6JEyrRxQA1e+x6N
         /icXtfET1WUEaHFxvPiO+J/5Ohfmp530MiJ7uGROj2DKcyX6XtsMxidmMgG9sxIjtjvR
         hm5A==
X-Gm-Message-State: APjAAAWxjF4XV1Vr6sKk173mk0m6ZSZ8/zmDFj6UNyavCgfRBeYJDaal
        zjSGI2F2y/in3y678cUx6ugOydI6MSk=
X-Google-Smtp-Source: APXvYqyFTT1OAcE/CNF4mLzGs44QuyinCOHjY5/JZ4M5jCmNrDtnCIrJMWk24I0+iSs2VxxNiqGwAQ==
X-Received: by 2002:a2e:9606:: with SMTP id v6mr16964227ljh.223.1574810733499;
        Tue, 26 Nov 2019 15:25:33 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w2sm1362382ljo.61.2019.11.26.15.25.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 15:25:32 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 203so15503518lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 15:25:32 -0800 (PST)
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr24137911lfa.61.1574810732084;
 Tue, 26 Nov 2019 15:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20191125125944.GA22218@gmail.com>
In-Reply-To: <20191125125944.GA22218@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Nov 2019 15:25:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wip1A+9X9+ceLFb8y9g=206GsAEB0Sx-H2inzxF1dkFGg@mail.gmail.com>
Message-ID: <CAHk-=wip1A+9X9+ceLFb8y9g=206GsAEB0Sx-H2inzxF1dkFGg@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v5.5
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 4:59 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> As such it's not really an iterative series, but replaces the old
> load-balancing logic with the new one. We hope there are no performance
> regressions left - but statistically it's highly probable that there *is*
> going to be some workload that is hurting from these chnages. If so then
> we'd prefer to have a look at that workload and fix its scheduling,
> instead of reverting the changes.

We may not have that opportunity. A lot of loads are various private
loads and you'll just get "this regressed by a huge amount".

So please do keep in mind that reverting this may be the only
reasonable model if it turns out to have bad effects.

               Linus
