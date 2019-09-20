Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B29B8D35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408342AbfITIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 04:51:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39545 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405346AbfITIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:51:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so4468684lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zIK1gtR2VAgqI25bOAo9P0A+M/0NEfNWxEFQpC0ed4g=;
        b=IL2YeVVOQFHRdWlofI9jH/napiLP/qrH7Ep+y9faHSgo7WQEIKTUdAzpuaQA8SqkY1
         scHjmFrFGgRc8tQhjHg3NT7myRyx+8zO+VvvFLRWckOHUqWDotd+jCuAZA3HI2eoA+Lt
         Sj9pi0lv7bBTGFlpxGvCtVQ1PDbnkhLqIkSNL7/0y5GU9rcD3LafVlRyAH5U/U6NL3//
         BdlSb2lSdTuL2HwmPGUt0UUejIgAtXwu3QAgavvSUCr90mcJh9j/AR/mO4VqIIGmw85P
         M9X+Akh6tnZ6XoZe+3lLLzJYmjyHgGrBIaIIFK7Uxjz/zJXRsaoXNu3xHKpIggDR3UuZ
         oSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zIK1gtR2VAgqI25bOAo9P0A+M/0NEfNWxEFQpC0ed4g=;
        b=kP1o/aBPFY1scuYB+GdjRu4aICSkKVejCQu36UDbDXjd9dGK3MayOD49FylXpPl6Hx
         ojJ+Y7TrqATsZyrjbuxwG87dYZHZoguFBtRnUhxlpol6qMhXv4IZhy+bDIqd1EvLOgxT
         ixbqXO/icfv5r2x1ywZuIwdpAfRHO+ENSKB6MOkUoikAS7pVk3E/G+l7Em1by1QaD4r2
         D1U70g8KLQ5ozUsTnKFxDOTeeAn8c6ORjaFElfhqdEdn67KOPZGhih9AXF72xBEAIxBF
         2HHV8LVnfAHAG3Y1zCXnT8B/kfkIr2eqxpa5VWf9GI0hyl52r0b235GGpDelHVbEeGMG
         B3lg==
X-Gm-Message-State: APjAAAW7PD+Kvw6IVoHCRhGZkv66nN5jiG7XkNh6g3zrJZUbpNpX4wtQ
        5cQUADw7sNJqHewGiiSCyOmst0f2CU4Z/lHUnDauIiYJiLk=
X-Google-Smtp-Source: APXvYqzbbTB32LmFOnnaWg0hpAl48UhlO/D6hLTKcniCdSi+QI6Ez7Rr3AFYweJqmrlLoL0DbkygDkqR35iMC/3w/+s=
X-Received: by 2002:ac2:48af:: with SMTP id u15mr8312303lfg.75.1568969471206;
 Fri, 20 Sep 2019 01:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190919214807.612593061@linuxfoundation.org>
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Sep 2019 14:21:00 +0530
Message-ID: <CA+G9fYsdAOWeRSxnrWOJVaw1tp7QVgOgHw-i58Ek7hknAEq0cA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/79] 4.19.75-stable review
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

On Fri, 20 Sep 2019 at 03:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.75 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.75-rc1.gz
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

kernel: 4.19.75-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 42a609acc1b2b5a744dd9ad3d3eb6a71906e4bcc
git describe: v4.19.74-80-g42a609acc1b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.74-80-g42a609acc1b2


No regressions (compared to build v4.19.74)

No fixes (compared to build v4.19.74)


Ran 21908 total tests in the following environments and test suites.

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
* libhugetlbfs
* libgpiod
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
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
