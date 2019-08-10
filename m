Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659C588C70
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfHJRVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 13:21:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35304 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:21:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so4941639lje.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VW8idH99KA3pRF/4NW+1lhavjZazU3KwsFXq96WTi+4=;
        b=HDMdkQiKKd2sdXTYF0z3XbUmQCw+4+wsjbbal6Z9A6xiGaDfIQd3bDBhzoPUeJV6h2
         mB7DjLWktp8oNjn4jgp661sDPED3TTL+L4fDrqK+wA9scti8LJhXTmAHVEKLW5ArbTzV
         z4NHzTn525eeLifuS3lDIysMSxLCOvitxRtuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VW8idH99KA3pRF/4NW+1lhavjZazU3KwsFXq96WTi+4=;
        b=DnFpIOzY8xs8NxXLbE1wsHm4AoY9nwgVEPBAi15n+OkmS1Gl9UjyEkGasLYmNdF0bZ
         R4eNu1d2n8gyb85mkZ2dP7L91lC0Dudq/2bIfBoZEAxM7wkIy7vIJR3J55s9m64JWTdL
         yWzSUvIJViC8ae1rBTPzYQJ/SJKnUWYx6t2X8RBvWFpCMEQMF4DiQPopicYFW6R9hWJV
         CuA3gZR3yXK69M9EgtyXRQCDZK/8QXfaaKTDM9YokxZk3mkzHieMoiJLobvgN6s/Aiey
         Dwe6gm/q+YsK276+U/Rj1JHrWG5nUczHMDmB62GOKu4cpMRqYgeKdf2kbeVdcgFlHkW7
         3jag==
X-Gm-Message-State: APjAAAVxC3kVKBlZO3G9edbofUYxTPUPwx8vwQVMn7jNFLs+wOcnb+R3
        VzPPbOSySlcW7Ao5x4ZeZetGhdl5h8I=
X-Google-Smtp-Source: APXvYqxG3u56B7aFoM9SMGm8j4cci286Vhk3lEvqf7pOWOfUTmzqxK01NdAjTmVXEtK6mn/9CstLXQ==
X-Received: by 2002:a2e:8705:: with SMTP id m5mr3496824lji.9.1565457678599;
        Sat, 10 Aug 2019 10:21:18 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q4sm4243997lfn.54.2019.08.10.10.21.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 10:21:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id i21so15636471ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 10:21:17 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr14032162ljk.90.1565457677266;
 Sat, 10 Aug 2019 10:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <87imr5s522.fsf@concordia.ellerman.id.au>
In-Reply-To: <87imr5s522.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Aug 2019 10:21:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnEp5+EM53MaT-3ep1xjhrUqCdcfBfTF9YxByGsmDMRw@mail.gmail.com>
Message-ID: <CAHk-=whnEp5+EM53MaT-3ep1xjhrUqCdcfBfTF9YxByGsmDMRw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-4 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 3:11 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Just one fix, a revert of a commit that was meant to be a minor improvement to
> some inline asm, but ended up having no real benefit with GCC and broke booting
> 32-bit machines when using Clang.

Pulled, but whenever there are possible subtle compiler issues I get
nervous, and wonder if the problem was reported to the clang guys?

In particular, if the kernel change was technically correct, maybe
somebody else comes along in a few years and tries the same, and then
it's another odd "why doesn't this work for person X when it works
just fine for me"..

                 Linus
