Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB0CC1D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbfJDRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:38:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbfJDRi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:38:26 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGRX7-0004R3-8T; Fri, 04 Oct 2019 17:38:25 +0000
Date:   Fri, 4 Oct 2019 19:38:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] process fixes for v5.4-rc2
Message-ID: <20191004173823.3q3ik6azezuqykpq@wittgenstein>
References: <20191004093947.14471-1-christian.brauner@ubuntu.com>
 <CAHk-=wgNpZdAy3G+6zekugbV+SObfPQRy=fneqwPomFRX3Ym+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNpZdAy3G+6zekugbV+SObfPQRy=fneqwPomFRX3Ym+A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:24:05AM -0700, Linus Torvalds wrote:
> On Fri, Oct 4, 2019 at 2:40 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This pull request contains a couple of fixes:
> 
> Pulled.
> 
> Small note: it is sad, and I'm ashamed of my life, but to me "process"
> these days is about development process rather than about a group of
> threads sharing a VM.
> 
> I know, I know. I feel like a (shudder) manager. But when I see a pull
> request for "process fixes", my mind goes to documentation about our
> processes for pull requests and sending patches etc.

Well, there are an aweful lot of mails about development process
recently...

> 
> You don't need to change anything in your life or emails - you've got
> it right - but this just explains why your pull request is now labeled
> "clone3/pidfd fixes" in my tree, and why it might be better to talk to
> me about "treads" rather than processes.

Noted. Next pr will be "thread".

Christian
