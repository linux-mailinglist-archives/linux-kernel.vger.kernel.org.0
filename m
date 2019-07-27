Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD5776AA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 06:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfG0EkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 00:40:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44895 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfG0EkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 00:40:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so21489413lfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 21:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bc4Kuv3ObKxZ1YCHjNmJYwEV0MSACxlEgVDhz8oZI2c=;
        b=sg7DhheYw5wwyLGoGKZX4Zor9qgw3b7mrNgiraxkcys41RAxhSCJm3vow+YLC3rkpg
         nWAZoImJBkjr+xZOlrksUIce+d2GM+iHU7h2qbPe3cBLD7m2jlqdkSQWI3S7b5/r0VUg
         cZhmSS8PoNjQLGk3qHnQFUm9RepNix19zu87VNjVjHiWNH1UusbR9fijb4wKrYF/estB
         GH5NKgpNF/wXW6zlNU1D0qtP2CsAhwT7UB71P1zegxOOGKIbrpyzjdZrTAPl2muxoW4z
         OqL87DAh+kvUUz354NztEzb1Qi/sauogD25SbIT4UVr3GTu3FTlqCL4xcE1bm2xOWhRZ
         BgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bc4Kuv3ObKxZ1YCHjNmJYwEV0MSACxlEgVDhz8oZI2c=;
        b=hB7IxXFI5xxhPKW4dFfwqPofaddEM9tEIQC+4WcQ1BuYJd7hoVUk/Na6fm5dhVg13O
         T0lq3XcgQFn9Jl/MY9dwGniWewLwq6qO0hYnl4ejb3e2iMBCarTxLW7F/UC5zmIu+2UA
         52RMzA5DdLVRdpmMRSO2iDU3UAWNOxAHEhvbavNhqrqAIAHAYoCAV4cE1beFZ/heWSCv
         dBUbiBc2pklV9C7n4zTyDQvtdmXiD96hqFmu4JSWj96JzMq7R6U5WWyferKFTIV8AZcf
         WThlXn5ZxnS2J0j5Lkk93TLBddqEovwahlLx8PGHek62QA7LcKY+f7QGTLuOeZalAV00
         JaTw==
X-Gm-Message-State: APjAAAW+OzvskFggbH1eiALB4BgubXZzmupdld+ztNCzeKcEkAxpGUn3
        zyx95+BRTX5jPsWwsWy/dHX7mdDldyJnbUtJTlLIYA==
X-Google-Smtp-Source: APXvYqwFGF85Yf1JY3LahL7OO4PLKYG1Ua2l9Jchl/4Aa/VLMCvCCXhOe4jv/Yn6zbnNvNxxUC5xWIFIvmpFTjKAbxk=
X-Received: by 2002:a19:8c57:: with SMTP id i23mr45190136lfj.192.1564202420353;
 Fri, 26 Jul 2019 21:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190726152300.760439618@linuxfoundation.org>
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 27 Jul 2019 10:10:08 +0530
Message-ID: <CA+G9fYvtZ9A39toZDjjca48XoEp8cW3NAr7XYusfTmVMJH5vTQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/50] 4.19.62-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 21:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.62 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun 28 Jul 2019 03:21:13 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.62-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.62-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 213a5f3ac1f5e2af0e25fd4b26497590ec290be0
git describe: v4.19.61-51-g213a5f3ac1f5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.61-51-g213a5f3ac1f5


No regressions (compared to build v4.19.61)

No fixes (compared to build v4.19.61)

Ran 23490 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
