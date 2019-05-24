Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9DF293D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbfEXIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 04:54:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44095 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389661AbfEXIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so6500283lfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DQIdJ2/CcHWy9HbQvYRwgW3WOk6Q3Bxku3s7YuyTSZw=;
        b=WT/JOm4yJ16UrUKMb0DY12vmu6Tdhgrn8AUijuq5NcTbP5+RRJkPqvOPLMVlyjwuRz
         /M6O62ZF507XeFkgQhPOv5AHV4tRPQgF8ifQgL21zyC116Rqu2VhNy9lnqWFKCibAxNJ
         emAOPcG38i+NylY98Cp9zcJKS92MelFSdJjAnd1jvPx/YJcegD9XWcDzMni22+ju27hn
         dG+HkFHFQKu4yb63uJqLnqcZD2DAgNGOfUNSaCM7h062iMyBQevgF2TtYAvtfLwVZ9PE
         Ka1ZUYUW4LAbCXWTRhmayATDVytmhozpPpOYBe0roph9bmQksU6a9Y7oYKmvyfhA5wZO
         rM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DQIdJ2/CcHWy9HbQvYRwgW3WOk6Q3Bxku3s7YuyTSZw=;
        b=oqULhtW8ElrLiB9U14frOAIXErgBPGzOys4VdAiG/HLQz9RYlgUusSh5CeFkghTu2Q
         pYJ95e7ZeVsWfgIeJ/oOUMndpg7jMgay98mYezr09FAFQ93rzQ77kwYuBFLZcLxtfyNc
         FF+aNknxsqRiP0Jjge9zMnuua/K2LOuebbL1u1Cpq5yePYNJcGnv7uPYuhSVwijUUVTW
         tmRxvM99a99OPUmJwabgRPVoPvCwALYYtI9qgSW/x9FYVDAhbxvLSFxAdbiZIcmuCYwM
         YSM8wFgYqCUqnviD02B30zgo0eBktwzikVivUFNZdFCu3IJEeay7t+MqdbhXdoIh1ysl
         0fjA==
X-Gm-Message-State: APjAAAWx8cz0VlipnP8gKY4+U0QAY7KfExEmJvj7v6stxSG+UYnYLtjY
        LhsKz9OKw7b9F2swPiEkTHwdmRVVIqSIPRA9ApQdkw==
X-Google-Smtp-Source: APXvYqwyG31YQepEVIOauyKxGTnQfkz0KjdaxJGlwZlXsMBFKW/x8xvNNvsjZ9MVD7zMNkgAc2uteT/hW5m6EqyyJ1Q=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr12030067lfh.152.1558688040903;
 Fri, 24 May 2019 01:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190523181705.091418060@linuxfoundation.org>
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 May 2019 14:23:49 +0530
Message-ID: <CA+G9fYsY+=+kMgc+Wz88YP-L5zba0iTn0c1JfCFQEHKDHhFAxg@mail.gmail.com>
Subject: Re: [PATCH 5.1 000/122] 5.1.5-stable review
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

On Fri, 24 May 2019 at 00:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.1.5 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 25 May 2019 06:14:44 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.1.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.1.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.1.y
git commit: ad8ad5ad6200a933bc774415620bb31dd8b2da66
git describe: v5.1.4-123-gad8ad5ad6200
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.1-oe/bui=
ld/v5.1.4-123-gad8ad5ad6200

No regressions (compared to build v5.1.4)

No fixes (compared to build v5.1.4)

Ran 22302 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
