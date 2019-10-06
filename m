Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6CDCCF78
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 10:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfJFIlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 04:41:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52221 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfJFIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:41:07 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iH26C-0007lp-6Z; Sun, 06 Oct 2019 08:41:04 +0000
Date:   Sun, 6 Oct 2019 10:41:03 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: test_user_copy: style cleanup
Message-ID: <20191006084102.mhqrsyg5slbfwejd@wittgenstein>
References: <20191005233028.18566-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191005233028.18566-1-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 10:30:28AM +1100, Aleksa Sarai wrote:
> While writing the tests for copy_struct_from_user(), I used a construct
> that Linus doesn't appear to be too fond of:
> 
> On 2019-10-04, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Hmm. That code is ugly, both before and after the fix.
> >
> > This just doesn't make sense for so many reasons:
> >
> >         if ((ret |= test(umem_src == NULL, "kmalloc failed")))
> >
> > where the insanity comes from
> >
> >  - why "|=" when you know that "ret" was zero before (and it had to
> >    be, for the test to make sense)
> >
> >  - why do this as a single line anyway?
> >
> >  - don't do the stupid "double parenthesis" to hide a warning. Make it
> >    use an actual comparison if you add a layer of parentheses.
> 
> So instead, use a bog-standard check that isn't nearly as ugly.
> 
> Fixes: 341115822f88 ("usercopy: Add parentheses around assignment in test_copy_struct_from_user")
> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Fwiw, I think the commit message doesn't necessarily need to mention
stylistic preferences nor a specific mail. It's sufficient enough to say
that the new way makes things way more obvious. But ok. :)

I'll pick this up now.

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
