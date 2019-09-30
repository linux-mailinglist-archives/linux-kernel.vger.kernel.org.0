Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B75C19D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 02:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfI3ADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 20:03:24 -0400
Received: from namei.org ([65.99.196.166]:40832 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfI3ADX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 20:03:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x8U03Ej3023032;
        Mon, 30 Sep 2019 00:03:14 GMT
Date:   Mon, 30 Sep 2019 10:03:14 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
In-Reply-To: <CAHk-=wg=7y82dJYeLzQeup70CHBT7MpCC155d85cPFctNsxUYA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1909301002020.22854@namei.org>
References: <alpine.LRH.2.21.1909101402230.20291@namei.org> <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm> <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com> <CAHk-=wg=7y82dJYeLzQeup70CHBT7MpCC155d85cPFctNsxUYA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019, Linus Torvalds wrote:

> On Fri, Sep 27, 2019 at 11:19 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This is one of the pull requests that I have to go through commit by
> > commit because of the history of this thing.
> >
> > And I've yet to empty my queue of all the _regular_ things that came
> > in this merge window, so I haven't had time.
> 
> I've emptied my queue (well, in the meantime I got new pull requests,
> but what else is new..) and went through the security pulls yesterday
> and this morning, and found nothing objectionable.
> 
> So it's merged now.

Thanks.

Matthew has agreed to maintain this code now that it's merged.

Matthew: please submit a maintainer entry for this.


-- 
James Morris
<jmorris@namei.org>

