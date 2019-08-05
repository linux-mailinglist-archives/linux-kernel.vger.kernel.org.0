Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633F082571
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 21:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfHETSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 15:18:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33189 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHETSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:18:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so59014107lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY3x1Neqw88a4kC5L8IILTg/Eusc/r1ujGUtxNuyElI=;
        b=LTJMiN3M9Ray9BoJ54bRh6ytuEphVXUvDhxBtPFmrc9/OnveqmvtMAWLk4lnLLf2H8
         h8a1EgEOvlM4gYUf3GXkWxjCp0Vwl4QzU9AqjxkwCPMwl7zRUsS95bisq7r97GLkGd7B
         m9N62FqdWsBfNzIvnLNSJFjdD4wMIbKk/uylc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY3x1Neqw88a4kC5L8IILTg/Eusc/r1ujGUtxNuyElI=;
        b=oRqMXzVBO9i3Kkyevt4XcCMB3NqpgfBQODwB5dQeIOLY1sCYoDutenV5pE11g/L1K3
         v4K3g7ziQXdQmSj9FkJQUEQhxzv+ijMP7Mfd9wF9YtfL+PaS7WHLNAmwIh4FXl99fCvZ
         QgBPEQVADEpir8jpFc6k4lF4BFJPOqltH6ML5hSJ//bq1L1I35J+D+zAIJqwAIMluKup
         V2ftuMTCFWyEvGLM2P93V56Pl+eDpFbt7mcSGlUK4wqlZKadwymEiMNFVbT2pGz9RbFU
         XOootNkKkMif+ynF5dYeczW2uSaGfhdyDT9emEQFp4pHJnmjVeDX0cu/HN9koachbcxQ
         bKdQ==
X-Gm-Message-State: APjAAAXjQEH/2fLWojArfgdth/tB/RK1VoEFkpRg96IptYk68z1vtCJM
        eI92qe0N2yfm2NyGIUbhyxrN2zyL9GY=
X-Google-Smtp-Source: APXvYqz/UeBh+i9ojuvxov810iKcWvw2J50PKGwjcONPwty0UjNWc82LglbxFaNF19lJnZq1ryCeMg==
X-Received: by 2002:ac2:5586:: with SMTP id v6mr4522900lfg.139.1565032687106;
        Mon, 05 Aug 2019 12:18:07 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id z17sm17386564ljc.37.2019.08.05.12.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 12:18:06 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c9so58847273lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:18:06 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr70249477lfb.29.1565032685615;
 Mon, 05 Aug 2019 12:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
 <20190805142756.GA4887@chatter.i7.local> <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
 <20190805191136.GB4887@chatter.i7.local>
In-Reply-To: <20190805191136.GB4887@chatter.i7.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Aug 2019 12:17:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
Message-ID: <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 12:11 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> However, I suspect that getting message-ids for all your pull requests
> would significantly complicate your workflow.

Yeah, that would be a noticeable annoyance. If I were to process pull
requests the way I used to process emailed patches (ie "git am -s" on
a mailbox) that would be a natural thing to perhaps do, but it's not
at all how it ends up working. Having to save the pull request email
to then process it with some script would turn it into a chore.

I think the pr-tracker-bot clearly catches most cases as it is, and
it's only the occasional "somebody did something odd" that then misses
an automated response. Not a huge deal. For me it was actually more
the "I didn't understand why the response didn't happen", not so much
"I really want to always see responses".

                Linus
