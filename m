Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03070155FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGUiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 15:38:09 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45997 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGUiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:38:09 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so644978iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg4oON5J4q1fP44KHqOQveBtLzhE62D/XRXrye9zUFs=;
        b=H0AXpVHi3OoVTO5fMc/MD/deUKtMKczIoMcgUbYSgxYbrqJgdaHtDiU4YpHoR6SOQo
         ANzA42tykPyEQj6LIC+i+fKdwMEG7htXYQMrFnRkY+U8kTKi4GtgpLOfC/S92/LLUmzT
         H2IWFt8QKHw6JLdIu44Eq2stfN3FbZ4RU/vKyQszPtE2ujYpQfC411+6tlpTBOkEnc8R
         j9qUeuO76mFpi4ryetJraTCoBySQVeOqlGm3JKDYcstbMH+qbtBTGy16AwrE/4fvl8Uw
         prWpNBk8XfObuiJbH75+YPZQ39M85395DyhxR61gWaeBVnfMpFvt6ILxcSw+3YGlVbxu
         xc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg4oON5J4q1fP44KHqOQveBtLzhE62D/XRXrye9zUFs=;
        b=sC24njqLR10avanRhRNgTS99w9GrJxT1SYmEGaGKR5tcx1MScu8zjgZWGreK+V/INl
         1cpKDgFqbEK7vRzPsi6WFgIIYFdguEGD+eYK9SH6LuBgQeJwlJ71wtKgaqxbDIw7Obz2
         5DrmMhRnC/kw2ephESSpkG0tiRj+bPtH1+q+8+fyOcdlAGq4NOeSAhafEPl8M5qJNy17
         vvEXNBUAFIgfcwGx/YtNDH6BDANHSI5ni2hxu0OSBSHs5/58RmKxHo3vL/eFn8C75wiw
         u+s2NQpBQLMQKAbstbwLLqegXOK9cTQPWp1QBwO+KLJnFLQK/ZNe/9YMmu80OOhDLE/2
         zYKw==
X-Gm-Message-State: APjAAAVPB85VUV0e3JsoQhKxa92dilwOPZByOgh3pK4dldlOkvtqUhdR
        8lgD4ea56FleynZO6Js/J2w6XuSWYFzQg7OEk68cpw==
X-Google-Smtp-Source: APXvYqyTqUEaeiRszM4nM+OgnMVDTccPNheMsyBNPQIZ4n7gi3IrYrOGJJCZk5Op6+0SWXNMyDf3QEdg9TZqFqZVb4E=
X-Received: by 2002:a92:af99:: with SMTP id v25mr1287002ill.289.1581107888526;
 Fri, 07 Feb 2020 12:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20200206101833.GA20943@ming.t460p> <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org> <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
In-Reply-To: <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
From:   Salman Qazi <sqazi@google.com>
Date:   Fri, 7 Feb 2020 12:37:56 -0800
Message-ID: <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 12:19 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/7/20 10:45 AM, Salman Qazi wrote:
> > If I were to write this as a for-loop, it will look like this:
> >
> > for (i = 0; i == 0 || (run_again && i < 2); i++) {
> > /* another level of 8 character wide indentation */
> >      run_again = false;
> >     /* a bunch of code that possibly sets run_again to true
> > }
> >
> > if (run_again)
> >      blk_mq_run_hw_queue(hctx, true);
>
> That's not what I meant. What I meant is a loop that iterates at most
> two times and also to break out of the loop if run_again == false.
>

I picked the most compact variant to demonstrate the problem.  Adding
breaks isn't
really helping the readability.

for (i = 0; i < 2; i++) {
  run_again = false;
/* bunch of code that possibly sets it to true */
...
 if (!run_again)
    break;
}
if (run_again)
    blk_mq_run_hw_queue(hctx, true);

When I read this, I initially assume that the loop in general runs
twice and that this is the common case.  It has the
same problem with conveying intent.  Perhaps, more importantly, the
point of using programming constructs is to shorten and simplify the
code.
There are still two if-statements in addition to the loop. We haven't
gained much by introducing the loop.

> BTW, I share your concern about the additional indentation by eight
> positions. How about avoiding deeper indentation by introducing a new
> function?

If there was a benefit to introducing the loop, this would be a good
call.  But the way I see it, the introduction of another
function is yet another way in which the introduction of the loop
makes the code less readable.

This is not a hill I want to die on.  If the maintainer agrees with
you on this point, I will use a loop.
>
> Thanks,
>
> Bart.
