Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10646B41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 22:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFNUui convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jun 2019 16:50:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45522 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFNUui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:50:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so5246096edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lh0n1D7R2t0Y0d+wEjcTMFEBGes1xmgH+/nCCWSCn40=;
        b=tR362/5tKErWjWbTpcFHaFtocbfLlsbvtAcjS6roSR4asEYei4p4bPnwOGbcTu4Jbz
         5jT1zAFEbB6w/X7ZgyWJjPeoQd/01zFrQ09f2rpt7Dx0xjUSLVopulFNxDRcgCHhmg9u
         EAkWvZqE8tc3zqgwXz7FZlBGxlWkwq+M96ONQw0jUWNEFhgZtKjAkTp/RUq8EeHh9hWQ
         s+JV0We+nI082ggbJ6tJWU0LqOZuUaJYKE4dO79h/RLmaPbX77jxBfQabRgXZI/5/c6u
         XcC9VIo8EpkLRerAMqrhDl1sv+G+Z7ODLsAwupn7n+/54Dnk2CLVd2KK5rDEI7I/Mj/z
         6sag==
X-Gm-Message-State: APjAAAWXAmQpMzEceCTzDHJ9Ywwu3YZTRhAt41djopUNSOhaG02CJ3tg
        /Hjk5mHAIZm8W4YN2ex0a0t9rg==
X-Google-Smtp-Source: APXvYqw5ig+HTGJdDvIEyeCTt+dMoTZfjl/YqoKuroUVvyIcNYyXmfL0k5ThxMse9XKZpDPvdkdRJA==
X-Received: by 2002:a50:b4cb:: with SMTP id x11mr34441028edd.284.1560545436484;
        Fri, 14 Jun 2019 13:50:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u26sm1128548edf.91.2019.06.14.13.50.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:50:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6F021804AF; Fri, 14 Jun 2019 22:50:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-ioweight
In-Reply-To: <20190614150924.GB538958@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org> <20190614015620.1587672-9-tj@kernel.org> <87pnngbbti.fsf@toke.dk> <20190614150924.GB538958@devbig004.ftw2.facebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 14 Jun 2019 22:50:34 +0200
Message-ID: <87blyzc2n9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> Hello, Toke.
>
> On Fri, Jun 14, 2019 at 02:17:45PM +0200, Toke Høiland-Jørgensen wrote:
>> One question: How are equal-weight cgroups scheduled relative to each
>> other? Or requests from different processes within a single cgroup for
>> that matter? FIFO? Round-robin? Something else?
>
> Once each cgroup got their hierarchical weight and current vtime for
> the period, they don't talk to each other.  Each is expected to do the
> right thing on their own.  When the period ends, the timer looks at
> how the device is performing, how much each used and so on and then
> make necessary adjustments.  So, there's no direct cross-cgroup
> synchronization.  Each is throttled to their target level
> independently.

Right, makes sense.

> Within a single cgroup, the IOs are FIFO. When an IO has enough vtime
> credit, it just passes through. When it doesn't, it always waits
> behind any other IOs which are already waiting.

OK. Is there any fundamental reason why requests from individual
processes could not be interleaved? Or does it just not give the same
benefits in an IO request context as it does for network packets?

Thanks for the explanations! :)

-Toke
