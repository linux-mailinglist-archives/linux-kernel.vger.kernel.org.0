Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4910DECA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfK3TKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 14:10:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34272 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3TKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:10:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so27975596ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QRHezkunwRrIMa14MxefFzwV3YRpouLMEO2wmjXPok=;
        b=X015xVKVQrz9jE331+LcTdxT7VNHCtQzr/vjU3xYa4QlcG1JXeywX3xGEh0GNCNpi1
         a9d2l9Wl+c3I+5dmpta0uvHpfuARxl96ZLsictnm6+giQbVx3OoDdMmNlHQ5psP1cENw
         JiaESZKNPd622sJQjh2IClD6t70XnifDVj9H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QRHezkunwRrIMa14MxefFzwV3YRpouLMEO2wmjXPok=;
        b=aNNRb2wrCDSNWbFh8SIvTV/oxuDacawQhINWq05s//JoSUDqgYksVyGqLmj50img9P
         rc85ZEdT4bAM+427hlXsts3ICC4Qzg6exOrXhkb0lWWwvY7gJNvHaysFIvVpJ3zkpWGb
         rXttng1d1sy1IpvmNW3OIq939vZ3HMWu6HXL+EMFTLUxupghHcBsifeXUju3tQPlFDFU
         OF0dll2y4IQah6/flDwaUk+N+RIaxGx0zA+gtND1PBEvVRUhl18tlU6hqUvdbkBUFdQu
         YnNgDdvcqnGOFC39/1KjgFGnNIDmEVLp/iaqGrAoL9zis+P8wGGnY2yy3QibCud07sX7
         sjpQ==
X-Gm-Message-State: APjAAAVofszG7/pDSnmSajcgGDCoq/UEtz4T6znbA3Gla2djyTiDrP1F
        xP0bUMs46DNLbGr9OqlcFENyZ1LGfGY=
X-Google-Smtp-Source: APXvYqwOucVIHVF/4cfTVjbj/2RBbaN8i8L4kBFgsVfVVpbGhXx3CvX2h8xd03pKXILvdQ240+SfQw==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr40416905ljj.41.1575141017203;
        Sat, 30 Nov 2019 11:10:17 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g26sm1699414ljn.89.2019.11.30.11.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 11:10:16 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id j6so26334322lja.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:10:15 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr2479024ljs.26.1575141015377;
 Sat, 30 Nov 2019 11:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20191126125304.GA20746@mit.edu>
In-Reply-To: <20191126125304.GA20746@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 11:09:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqR7T_UuKX0JvOFK48RdiViOTPkNxxfjwh70FxjoxE0Q@mail.gmail.com>
Message-ID: <CAHk-=whqR7T_UuKX0JvOFK48RdiViOTPkNxxfjwh70FxjoxE0Q@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 updates for 5.5
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 4:53 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
>  * Direct I/O via iomap (required the iomap-for-next branch from Darrick
>    as a prereq).

I appreciate you telling me this, but why didn't you say anything at
all in the merge?

Ted, this merge commit message is simply not acceptable:

    Merge branch 'iomap-for-next' into mb/dio

That's literally all you wrote about the iomap merge.

Not ok.

Merges are commits too. And merges need commit messages too. They need
an explanation of what they do - and why - the same way a normal
commit does.

You wouldn't make a one-liner "Do this" message for a regular commit
that has big implications. Why do you think it's ok for a merge
commit?

When you merge something, the individual commits that get pulled in
hopefully have their own explanations for each individual change -
otherwise you definitely shouldn't merge them. So the merge doesn't
need to replicate all of that.

But the merge itself still needs a "why am I merging these commits" explanation.

We pride ourselves on good commit messages. But that merge commit
message is pure and utter garbage.

               Linus
