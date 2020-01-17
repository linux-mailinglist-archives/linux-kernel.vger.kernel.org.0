Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF362140C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAQOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:20:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39683 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAQOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:20:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so18461123lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=52SkNZCDjqwxNsCcswgc3O2QxOVfgfXytI8P8HG/hjw=;
        b=Qjj9nW9dxWRF+Ax36+7qhoA1Px7MXOMy+ceUUUE6CKRjaeHNEOMfCQBKHcfvx3qtgJ
         8L2Z31hEkJdFjf/gQI9JwTVIe6aZ+Pkjcqc9v5prj78+Wp3LSPEdSsJl8+8TfNHDGaDF
         ta7wGQZtv3ou6yFIuhjgkMxR4NK8rV5EPnrii55f9yut23+YyqZwRItoAlG5R0lcLa9F
         84etdt9fwpulHMXMRhFEWxdIsqG0NVyRgB181x7lNbUy9Exui1Gw0O4SJbCtlfDeWo2M
         vJmD/0kxbMVPiuUeA7CnFDj36GE8+Qt56pqouhfaeku7wIR2flOP2CFr7fvld/O9KcVC
         DPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=52SkNZCDjqwxNsCcswgc3O2QxOVfgfXytI8P8HG/hjw=;
        b=rUUptzxHhLnCAGvdZ5DQFoWLcGxSsrDhf6zuhfnqe3JWiqTsHupX3IGEx0GGG7e/JP
         W7iH6E3r6ZpVgOh+JaiVieOpyVrGLFDnnp9cQM65hk/1A28tI+c98qEpkNp9VysgM915
         leKP9TMXAcF0b8/4p/z6CfwDMTQb+M1VEk7/Gq+hHbwu2ffNGCAJinvs/aRR0NdouAfY
         PxXJwWpOgaxR+6QERWqH4/NmY4EXda8FCuxf7SBVqt67ZYPq8TNoxmR6z05+IJyyc5M8
         PBEjYi0DopPIhXV5vkQgFK9eeTGsbUQuzjwg4WWgDj7x7PkH6e2M67cqIQjjzGY1vCIU
         MtCw==
X-Gm-Message-State: APjAAAVi9BGlr5bf8x+1xOEEeWxrG4QQZ53dHUY9xSd9HtOaDR3mvOsM
        zDbFCc7hY2f0AY6/Oy/yT/UcbsFNr8t69AuVf02mFg==
X-Google-Smtp-Source: APXvYqzn27YvmjJNXYMQoWyCdW5HlsnNohXOOvT7SYPL0O7k6CJ4/XyfF0XM6atuASauDlszTUTZx9PkubYB4Fgkeug=
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr5576756lfp.82.1579270821671;
 Fri, 17 Jan 2020 06:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20200116231745.218684830@linuxfoundation.org>
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 17 Jan 2020 19:50:10 +0530
Message-ID: <CA+G9fYvRAU-4xF_Kxrz6A39HvX8020joox_rUtgb=ATq2czDOg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/203] 5.4.13-stable review
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

On Fri, 17 Jan 2020 at 04:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.13 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 Jan 2020 23:16:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 3c8b6cdc962e6e3a21ee5786133fdab225fa26b9
git describe: v5.4.12-204-g3c8b6cdc962e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.12-204-g3c8b6cdc962e

No regressions (compared to build v5.4.12)

No fixes (compared to build v5.4.12)

Ran 23712 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* libgpiod
* libhugetlbfs
* linux-log-parser
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
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kselftest
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
