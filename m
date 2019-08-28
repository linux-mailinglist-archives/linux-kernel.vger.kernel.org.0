Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3DA0C41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 23:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfH1VR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 17:17:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45240 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1VR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:17:27 -0400
Received: by mail-io1-f65.google.com with SMTP id t3so2414100ioj.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Pid6vUuPUlJYXQ1gshe5GaMyymzgf1ptZw4JML3tNQ=;
        b=WseL6QFZVj5hjD4LSdeRDxgvi8R9OrWhijXgU4dVjGt1oetpvN2AyHUnm4zOKs8iqo
         at1k51orF9049/Ghe2jeEBeJmxckts5NjcvtT1cIG0yaAyYZEWumEgVeU71owQJjSuxV
         r+v1ZAVuEBOBRavO0JllTktHLYLN4aNtNFMaWm8dNulMO+VvauX+Kt+HVLPbDYhqEJlM
         1rW9s6pu2jiJxHyNKaOscZh63d6ouPB5aoh6Er2aGItp9wCPJ77A40bdtwAeyOjCFpKx
         LIeuQHiz5et647Kxo1j7BqaWjOzdldFmGfxT/0+FE94fDgJoz8xj/x1zdQGnq12nGCTB
         hjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Pid6vUuPUlJYXQ1gshe5GaMyymzgf1ptZw4JML3tNQ=;
        b=peYPLQ3a/JOt+9ctXGvF2FONNEKPSDmUcwJSHr2LFGAV1vCnx+ksfsaPSvhp22QkiY
         Ke99NSzBYn9BikERaBm+8+EebyVB4e65PJLLbZK81ye3Yv6jAPRGckfQeLEXKs4KE79A
         ehRDFFncicPnj6MZ6UH01Pp+lIG3G/jIqAY+vkJiswalduUFQ6ni0BJqOZZNDTf8ihud
         crzkBR7Y9yRNtFA6q4e8WFlf2N60vqHM2NZnQOQObeDmAMcHtn0EI+3fy00JX4rTreYS
         /hl3JFeZ1hJJE4X0gNvT54egASJro3XX/PMDqPrChbBsbdWUb4fRH43koMTeVqgjDicb
         7bSQ==
X-Gm-Message-State: APjAAAU0wnDoTnbHtpTe4OzjSL9SxPmGwjEkJy9VX9FD0uMYLD/RBTfL
        Mv8FGaHykR8snv3L2jSnp0DhRTJmIts6vaw7A3gIww==
X-Google-Smtp-Source: APXvYqzVzRPzdAPeHNOQBlR1nvJV0H0d2CsA0hvt0BTy4EMMSJLTlGYVNwIrII+XDJqGKBCcN398iLPUM0AbEzlm8wE=
X-Received: by 2002:a6b:3ed4:: with SMTP id l203mr6931699ioa.275.1567027046855;
 Wed, 28 Aug 2019 14:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz> <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
 <1567023536.5576.19.camel@lca.pw>
In-Reply-To: <1567023536.5576.19.camel@lca.pw>
From:   Edward Chron <echron@arista.com>
Date:   Wed, 28 Aug 2019 14:17:14 -0700
Message-ID: <CAM3twVQ_J77-yxg+cakUJy9-oZw+j-9xdunaAJdJdfZfCb5GSA@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 1:18 PM Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2019-08-28 at 12:46 -0700, Edward Chron wrote:
> > But with the caveat that running a eBPF script that it isn't standard Linux
> > operating procedure, at this point in time any way will not be well
> > received in the data center.
>
> Can't you get your eBPF scripts into the BCC project? As far I can tell, the BCC
> has been included in several distros already, and then it will become a part of
> standard linux toolkits.
>
> >
> > Our belief is if you really think eBPF is the preferred mechanism
> > then move OOM reporting to an eBPF.
> > I mentioned this before but I will reiterate this here.
>
> On the other hand, it seems many people are happy with the simple kernel OOM
> report we have here. Not saying the current situation is perfect. On the top of
> that, some people are using kdump, and some people have resource monitoring to
> warn about potential memory overcommits before OOM kicks in etc.

Assuming you can implement your existing report in eBPF then those who like the
current output would still get the current output. Same with the patches we sent
upstream, nothing in the report changes by default. So no problems for those who
are happy, they'll still be happy.
