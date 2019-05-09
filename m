Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E9186BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEIIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 04:23:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38502 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:23:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id a64so937637qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 01:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFT1vB8Ia4opzNsYEQvDePR21FiapilD338d0lHR4o8=;
        b=tPxMF5TIZibttUB0Mg1eZeguPLY+u7Mz5SEb03beeEiPZ9+fkuVNtb5Pn4kjqRKK5f
         VWotKrLzvjMfdZrChopRkeTBMjTvUud7waprpWWL8KcE07AaM5ZV2vZC1Je/yYSybBZp
         UvWxt8coxeXlIR2ZDwSZFCqXLaFhMNR1anjHx4j6HjJWDZEpFmfjvbXiYsPVDi23INa+
         P6v2Htfv3CiLdok1uzZVynGnnejvaiUNE+xUZSr1UYalirC0Biq72ZpGdx51KmluOtvT
         3ToBxW8gJPGjUxCbxhfrY2cQGrQ4c4bhXsKBqt+qK3VycHKRMGOM7Ic4h6zZnjS1kqGN
         6IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFT1vB8Ia4opzNsYEQvDePR21FiapilD338d0lHR4o8=;
        b=XAW6+6+CfXQCzCLieR0kvH1Egr5N7vHnK1HYPEsYr4XFClWEOfgfgHFEU0+BF9wSy9
         ycHpBakwo0v2cMOyMZ977Q7Rq/lZTYppHPVL79fAkdRrKssTRUAFp3Ckc19aWqOYwkmN
         ICevH2coX9wVZdn+PlnLUeJx8esQ86vr4g6dZyaSEBmcwO5Gcu/G4KfwICVYIIekcCX2
         U2UqV4JhgkTayePasj9STkXsNNZZ39YxhPFWIJX3PI9dqaLo7looSF+wxmHMyeDCdhc/
         liuN9kBwMEBzQ6dDAYGN7CNezdVHZk+f4ImAD5ytuRu6+3reSGNyYVmyrE1yys+u1wwo
         Xayg==
X-Gm-Message-State: APjAAAVTZBqIGKOwhW+PQRKS/u28HgfT+Acjuv8QovCLArNRlGgirKlY
        RORynM6TgeguevYW2LXdajisH3kwoma6I3xLMBEW5Xdo
X-Google-Smtp-Source: APXvYqzNATcpB6ItFy0KqLc9ZTufcZjj7iqnPu0NOYCIEA6Aip7FwxseECZ8wFA4+19//wNpWZE/IFr5+O0/Euiz8zU=
X-Received: by 2002:a37:620d:: with SMTP id w13mr2119251qkb.131.1557390213283;
 Thu, 09 May 2019 01:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
 <CAHk-=wg6imuGGw_4d6ywhu=0Kxr+H2S=hHavoDXYjN6o7SqMUg@mail.gmail.com>
In-Reply-To: <CAHk-=wg6imuGGw_4d6ywhu=0Kxr+H2S=hHavoDXYjN6o7SqMUg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 9 May 2019 18:23:21 +1000
Message-ID: <CAPM=9twww4shPTifuQKOaUMtkKOZWFN1LY=FTLGmXkH-SxFJnw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 at 14:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Dave,
>
> On Wed, May 8, 2019 at 8:28 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > This is the main drm pull request for 5.2.
>
> Thanks. I've merged it, but I got a couple of conflicts with fixes
> (reverts) to mainline in the meantime.
>
> The one to the i915 driver you seem to have applied again (after the
> function was moved and renamed).
>
> The one to the virtgpu driver, I really don't know if is needed any
> more. I suspect I completely unnecessarily merged that
> virtgpu_gem_prime_import_sg_table() function that came in because I
> decided to do the merge of the revert.
>
> It's a trivial function that just returns an error, and your tree just
> leaves it as NULL, and I suspect my merge doesn't hurt, but it also
> probably doesn't matter.
>
> So you should check my merge.

Thanks,

That explains the "I know I had something else to say" feeling. I did
a test merge yesterday and then forgot to write the details down.

I had a look and it seems fine, and it's Gerd's code so if he's happy
with the result.

Dave.
