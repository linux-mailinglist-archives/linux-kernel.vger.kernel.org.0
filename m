Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE9FBA61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfKMVDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:03:14 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43799 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKMVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:03:11 -0500
Received: by mail-yw1-f65.google.com with SMTP id g77so1201357ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJhYbUCZoZhssl6K5r4Ehq2H+qIhg7nGukXk0RdP+Gk=;
        b=EetrAwPLwMqnEG+Kl0xMOCkfYNAkStwpuO6QgS7dedxs6MZAw88AIoBdDG7akyLNU2
         yWWk535bv9WzSYuJ9hfVLo4gYRLejUlK+XibrDhUONSDspvjlBCPM2Hq6g6D3R+GkBJk
         o6/S/ryMekyKsTWZsY8ZtlFbFhYWLcM+RSvgPx3oJVm4/fqZ5eMy8OiJTvv0fkMX1+q3
         lPotZ1Bcwf68RM7ECd65jMmO7VdvBD09VD8PwCoCMsl/YriM8fnApWoeY+DvGawvwoIh
         4DeFArKxFh2qkYAaGQboU/KL148HTHZ75Jg7ZjwrLrZ0B1sDshay6PrW5+n4q5fk4/cN
         0upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJhYbUCZoZhssl6K5r4Ehq2H+qIhg7nGukXk0RdP+Gk=;
        b=sj2VPL/arqvBhd0GGzx8BpVaMHM6KCay6ALvzXZM15wEEHHqqsLfkqzcklcu7ek56S
         TvBlOiKMTiFmB/1SmG7nKwypvotUV0ZxU92V6pvQKMIKVbWZRyg+vvV5MZ5kUsAfQeF9
         Z6CuhoJLyJSnYhAnmTaZxKd5tu6IrrOFqtLGlq/GRuPoX86DDvUeS69aA27QHyFsdm5L
         B5fGC0LmUhgsSeKwLoco6Z7cNFkLiYSRqPfvC+guJ7ccDHVHbzOzscuuOcIoysWja2Da
         +e/h2XjJx/nC8L3bTcfADrD7/6z5axEfs+ydndzNybjbV9uLZV20ZaZPyPBlLOzGFVHu
         DyHA==
X-Gm-Message-State: APjAAAU7zv3fhYpazVw+q+MYD8ynENhIgEXD2adFzNq3V6mGmSEjORV1
        gMi9gWkHY8sQzRZ5ZBEPsM5IwHId
X-Google-Smtp-Source: APXvYqygOT1q9WRP3Ql469rkBI520XDd7XGG49aINIkVibkWjQx3HtXkQeAnMUSS0whaJ7qsxRvr9w==
X-Received: by 2002:a81:9148:: with SMTP id i69mr3278497ywg.367.1573678989670;
        Wed, 13 Nov 2019 13:03:09 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id j66sm1277315ywb.101.2019.11.13.13.03.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:03:08 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id p128so1196853ywc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:03:08 -0800 (PST)
X-Received: by 2002:a0d:fe06:: with SMTP id o6mr3245637ywf.424.1573678987882;
 Wed, 13 Nov 2019 13:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20191113030333.GB6910@shao2-debian>
In-Reply-To: <20191113030333.GB6910@shao2-debian>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 13 Nov 2019 16:02:31 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdxO4TZm4t==kePydVY+qWRNQn6aaGKb3sK8sAJ8yFmLQ@mail.gmail.com>
Message-ID: <CA+FuTSdxO4TZm4t==kePydVY+qWRNQn6aaGKb3sK8sAJ8yFmLQ@mail.gmail.com>
Subject: Re: [tcp] f859a44847: stderr.fastopen-client.pkt:#:runtime_error_in_sendto_call:Expected_result#but_got-#with_errno#(Operation_now_in_progress)
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:04 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: f859a448470304135f7a1af0083b99e188873bb4 ("tcp: allow zerocopy with fastopen")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: packetdrill
> with following parameters:
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

The report shows the complete output of a complete packetdrill run.
From that it is not immediately obvious which packetdrill test output
changed.

The subject line calls out tcp/zerocopy/fastopen-client.pkt. The
result of that test are expected to change with this commit
f859a4484703 ("tcp: allow zerocopy with fastopen"), because this test
was added exactly to verify the feature introduced with that commit.

The report shows this specific test passing for ipv4 and
ipv4-mapped-v6. I cannot explain why that run failed for ipv6. On my
runs all three pass at this commit:

  $ git clone https://github.com/google/packetdrill
  $ cd packetdrill/gtests/net
  $ (cd packetdrill; make)
  $ ./packetdrill/run_all.py tcp/zerocopy
  Ran   33 tests:   33 passing,    0 failing,    0 timed out (7.28
sec): tcp/zerocopy

and fail on the previous commit, along with all three versions of
fastopen-server.pkt and closed.pkt:

  $ ./packetdrill/run_all.py tcp/zerocopy
  Ran   33 tests:   24 passing,    9 failing,    0 timed out (7.22
sec): tcp/zerocopy

All this is expected, so there is nothing to fix for this report.

This was on a kernel built with `make defconfig; make kvmconfig` and
additionally CONFIG_TUN=y. Though those details should be immaterial
here.

Great that the test robot is running packetdrill tests, btw! Good to
know we upstreamed them for a reason.

But how did it end up testing such an old kernel? This commit was added in 5.1.
