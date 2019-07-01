Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B9128B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfECH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 03:26:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41664 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfECH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:26:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id d8so3699075lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dsx2nXK+/+DVPRawdRuGNY4tbTYcOzkd9mRb77NUkhc=;
        b=fLL9islumkeJwquqsV3AdztTa9UUhx1CJKwMbsNVK9OO+1EwAtB32SOYwN8vs95wj9
         IpS8pZoRPR8XTQ5oIQV2bu2sG25Y7vVHBx6wqJiH/FaFQrRqzi26+o3PVrcNeCOBzHh2
         88RmLANWQER0iphjz4xHyMxz2BGYwB2//UBRP0nMle+WvWSJV6T9AzmFsI90x42fBmk1
         rtOp5i++qLQyuwkTvmUlXRkhe5yZ9ptpPvDtLQOcHHW+AZA3Nuj00gR/aRifhw+OxTqC
         R8t9uXF0K4dO7rjZcaMP3JhoWmXUsJcMe8JtkWGA27lUcebVQUyP9i32/stOyLpkpCsA
         ZCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dsx2nXK+/+DVPRawdRuGNY4tbTYcOzkd9mRb77NUkhc=;
        b=j0pO59UVcAA3OzoRLd4A7d3NXQbQif4uiZT/H5kDk1J3k+5fXq9jWpPBvlO13hfltv
         dZzBPiKTLCbrvkzQqB3CGZJErvq5K5GUU5rkU2zMauJvRZovMMGpdMsRovNHdiikx8RI
         ztB+y6pUy2Mk+Smbh1fK1TyZRmqFGRP2yokEqRQp/rMAXht9Kd0LhDE2lB/sB/UtnDDx
         1V6wPh7mvmG2GKo73DOfwNUc3k6EqZinu0OIXIT/DHcPGOz2AX9mXyKivn60wLS4Md6u
         iU0pmm63xk8qSRj4gp1ZIS9FjPcUG179Rqdr4/9kHmF2e2uyD+36MT++bBWWCROu3UtF
         ZxHg==
X-Gm-Message-State: APjAAAUA6v+T1gcdkHOuNmACFM+A3CL+WJXTFmvb/MeULrbwo5lIzdkd
        MeLbqvWWfS96IRBCUKmDbYSDw5xUoZ7eOBsLdyOyOuYMYl4=
X-Google-Smtp-Source: APXvYqwWLW9DwsPqwigRfqef/inQX/vsQrqYzz9NOhx4A4hUCtjln4I6wv88+OD37fuI8tCCb228uIu1fOsGRh9Zd3c=
X-Received: by 2002:ac2:4246:: with SMTP id m6mr1659473lfl.0.1556868379684;
 Fri, 03 May 2019 00:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190502143333.437607839@linuxfoundation.org>
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 May 2019 12:56:08 +0530
Message-ID: <CA+G9fYtv_aPXHZ7JtA1HzfQ-j2nzRabnA1tWWG-_Xwkf8UK4_g@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/72] 4.19.39-stable review
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

On Thu, 2 May 2019 at 20:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.39 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 04 May 2019 02:32:17 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.39-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.39-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: db2d00a74567be6e93472fcc4bfa8ada96cc6397
git describe: v4.19.38-73-gdb2d00a74567
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.38-73-gdb2d00a74567

No regressions (compared to build v4.19.38)

No fixes (compared to build v4.19.38)


Ran 21232 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
