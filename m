Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77EAB6CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 21:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfIRTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 15:31:46 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40722 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfIRTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:31:45 -0400
Received: by mail-lf1-f43.google.com with SMTP id d17so514302lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvhEddV5arJ7kaE02ns4J/avAB+kinH7CQEi/JKElsk=;
        b=hyt7b1C+ejKMUOkm3wdH5sM3HZ0Yx3jENhtBKmZzMXUDrLLnMX0hYCGd4/JdZv8YEE
         TyVAlXluZqwjYt7TpfNih3FI/oO6rDGTrPOj8NLmh/zNBX46U2iKHHALvbYoY65a8plv
         eQvWR+ESaaepqApPmlM6BFf/L6h5y1J1D9bNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvhEddV5arJ7kaE02ns4J/avAB+kinH7CQEi/JKElsk=;
        b=qSPYKuOaDJh1lVUf1B38jRxe2uDaT1szCQIhYBncJkkKcDIMztIO8PpYKAP1LpUgFh
         ejQgxu/rVmop2NHPJHfijfelrBgIaLXk8QqXLvjlRw+MiEHzWdXbwRQhz3J5gTkBs8aC
         hT6Ck8F/Q1LLUBeFfEyha/i0WjKUW3YeCKOCI8NSv2OzXCqEEaYMYMOrmdmTPrQTC4GE
         icamaaA2FM0yYVlIBxUBSpfMyXPOAzNfHGwSBwSX7BNILBiwvdfkvVfG9sAQWvwCqDpR
         R3ZjnVlNmRnZH3wumRQOQP+cn38+4hNy5s81jPzpyGSNpgQQM3USYCsFadAzRkILpmzk
         bWIA==
X-Gm-Message-State: APjAAAUHFRAl3XNafD4wsA04HqXHbnQYh0NLDAAHLsgINMfcc8Vi776r
        XaaJBdAf3bxqZ9oo6EAJFSFwAUAufiM=
X-Google-Smtp-Source: APXvYqzdNpaZ8v0WRQCphsVkxLbNgEGSbAPekjsuyQj2Wo3Dk6afL/5+0JbXsvxT0OsooYXu81Mk5w==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr3118475lff.184.1568835102344;
        Wed, 18 Sep 2019 12:31:42 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q124sm1188161ljb.28.2019.09.18.12.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:31:41 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id d5so1075655lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:31:41 -0700 (PDT)
X-Received: by 2002:a2e:1208:: with SMTP id t8mr1170191lje.84.1568835100782;
 Wed, 18 Sep 2019 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
 <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com> <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
In-Reply-To: <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 12:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whORuqf+e=G5vfjXZfzj0wv4zzyPoojfi4SkgLjuvHy0g@mail.gmail.com>
Message-ID: <CAHk-=whORuqf+e=G5vfjXZfzj0wv4zzyPoojfi4SkgLjuvHy0g@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 2:33 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> And unrelated to the non-use of the RTC (which I agree seems weird), but
> because there's no better place in this thread: How "random" is the
> contents of RAM after boot?

It varies all over the place.

Some machines will most definitely clear it at each boot.

Others will clear it on cold boots but not warm boots.

Yet other environments never clear it at all, or leave it with odd patterns.

So it _could_ be useful as added input to the initial random state,
but it equally well might be totally pointless. It's really hard to
even guess.

There would be nothing wrong by trying to do add_device_randomness()
from some unused-at-boot memory area, but it's unclear what memory
area you should even attempt to use. Certainly not beginning of RAM or
end of RAM, which are both special and more likely to have been used
by the boot sequence even if it is then marked as unused in the memory
maps.

And if you do it, it's not clear it will add any noise at all. It
_might_. But it might equally well not.

             Linus
