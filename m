Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2CC1814F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfEHUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:47:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33725 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEHUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:47:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so130461ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl7kj2b06Id0IxhmFMyLAcUIYwHokUW4lI1UxzzHebQ=;
        b=MsCQeMlAMaTmmu8liuRJhw+OqSjOca9Yk5ZDE0pnUCLgqqGXwt4Eikr9dYZgUYu5Jn
         j2QcOzHlWVto3PMTTHCuxunWuX0TtJT7Iaw65vU84UEVIKAjU+Vmn4PXRVoqwYuqwxUC
         AByIFENIWIymm8SeSM3zdJOt7V8lGp1b7jec4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl7kj2b06Id0IxhmFMyLAcUIYwHokUW4lI1UxzzHebQ=;
        b=gb0I0YihUKEBNAvWLjG0Ipf83Jm+edTMUOum5izwlstuKEUSFS1c/cmn/I5Q0+lU8p
         ouW5Pyl1YaJRnyfqDWjsl41rYJ/C0QV9nS5RsFsa0Q5q6JtOBjlqep4WOj/iLcUxccZ5
         JW1/IsDFkiyZ3v7R607kNfZHDPg+vrSg5ndXdANdggqUBIlGHr3p+K1qIrGho+IRS15a
         riyCiHQ8ckw6OVlnk6FpsTrCggwIODQdGw7yLZrie6uf1n3/ZNVGtGOi1OZHK7KcpVv2
         Uh35Vu+aSyasT/G6VCW8s9IQsRZBLpil0paOl+ubkFNOw5Xx8kHNhqiBqOkGdE6yoN0Z
         2BRw==
X-Gm-Message-State: APjAAAU6mgpc3qIYbqQXIhdu8esLIvp9twiDULymvaZ6KBBZ2DyPAcZx
        Mnt8CQ5XVOzX7DEmnSN89wi/X70MGwM=
X-Google-Smtp-Source: APXvYqyRxDxh1chHaIFyIbaPdzM1NRtd+bC0g4eOmyDHg6E6hcyM0ZUgXDDEB9kkSPVUHWkcAk+EYg==
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr22384064ljk.12.1557348422406;
        Wed, 08 May 2019 13:47:02 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u65sm2648265lja.39.2019.05.08.13.47.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 13:47:01 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r76so67824lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:47:01 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr7056458ljg.94.1557348420782;
 Wed, 08 May 2019 13:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv=4JsaF-8v=U4JR3jrOyPfhtUsJPogNudLejDh09xGSA@mail.gmail.com>
 <CAHk-=wiKoePP_9CM0fn_Vv1bYom7iB5N=ULaLLz7yOST3K+k5g@mail.gmail.com>
In-Reply-To: <CAHk-=wiKoePP_9CM0fn_Vv1bYom7iB5N=ULaLLz7yOST3K+k5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 13:46:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZd2cLsobjBWU6_YZo2RWWqAm_fVzLpPQsh+yoG7fk-w@mail.gmail.com>
Message-ID: <CAHk-=wiZd2cLsobjBWU6_YZo2RWWqAm_fVzLpPQsh+yoG7fk-w@mail.gmail.com>
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 1:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So don't do the whole "rebase the day before" in the first place, but
> *DEFINITELY* don't do it when you then pick a random and bad point to
> rebase things on top of!

I've pulled, but I really hope this never happens again.

You could have rebased your work on top of 5.1 if you needed to.

Or you could have just tried to avoid rebasing in the first place.

But picking a random commit that was the top-of-the-tree on the second
day of the merge window (pretty much when things are at their most
chaotic) is just about the worst thing you can do.

I'm considering adding some automation to my pull requests to warn
about craziness like this. Because maybe you've consistently done
something like this in the past, and I've just not noticed how crazy
the pull request was.

               Linus
