Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2B6CC39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfGRJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:47:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36587 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:47:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so26677459ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gB/oduENd+BsIOwUuYphtc1vzkjElb07KQmk4tLhZ+k=;
        b=Ld5E5T2K8hVgwFFOff/9cRz2gKQO9y9uZAcvK8SP+bc4Je0gSSTe/FKRtZgtZEXw7t
         DnblUc8wgSnJXjsVfhKMGdKmn/w13KUN91N3SXIOfavdfIGvfbx/cMP2nkJOCT+J/PGz
         h8WCC1JsMkF5DFDipcCaVngk/w/0zVEm57kdWZmwe6CYY3t6Tm/Hr6Ctv2ZCXBf69QOD
         B9Oqr65TxOR/D083DUmi/oyRMz2E+zsYG6E/lk9qDrepxo/zcmA1Y4rqHeunGyGK523x
         ofnyIam5q6Rl30rrPPsxRIVn+Z3VjFgaEQDCCNDCIalrpVk4VMaTLnj77gKvML2KW6kR
         U02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gB/oduENd+BsIOwUuYphtc1vzkjElb07KQmk4tLhZ+k=;
        b=aFHz0Q0FMC4yJSnt5qglfhlW0YUsKDzw9Z1U+PahoaD4lR9hIoHBTEkpHN48nl2D3p
         ReF6QSRbHsMBjUrXyorlZD2WoKnR1tDJZd0Q+DLiSa+tORlRbb11wIEaov7VZZnKymha
         3NApxuXYndHAORYlMGWFtms1+FmPv9suondbraUsohbthoWqqHD8nU6AJMWedfO4mUAF
         4TqIFoYHKPOgH77nkAnD56GcKadcscvOMbSB6l2beFF21UH6SsXcm0dmI78xxlDrOTri
         QmYMBLL+CPhfC/R1KvJPHzbDyNPCGn48KolhMZHIk6F8SvxkZ0PDdpNaGSiFsYfH37m4
         V1fg==
X-Gm-Message-State: APjAAAWXQH3zN0gno/SMM3HrqHNyHlJjGnrTqWMN0aqb8DmC6rHeU6n0
        6PLQK/XY2GGY6zCObMif2ovMUuKQZS5CzvmlOYyaDHJxXuk=
X-Google-Smtp-Source: APXvYqyPOVhOhLnR8svjNFZbpJrFSBq7iSO7H0EK0jJu3qsF114ar1jgWWIPRpjlhgl1TEjutHazAuvG976Gy28vOLM=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr24191221ljj.137.1563443240961;
 Thu, 18 Jul 2019 02:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190718030045.780672747@linuxfoundation.org>
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 Jul 2019 15:17:09 +0530
Message-ID: <CA+G9fYtZUsz3eOV5_6im60EGrhi+ncD4ootvZfmDNiBzqNm0Tg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/47] 4.19.60-stable review
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

On Thu, 18 Jul 2019 at 08:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.60 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 20 Jul 2019 02:59:27 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.60-rc1.gz
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

kernel: 4.19.60-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: aa9b0c7579bacf570e7e430fa563e52b6b4ab15f
git describe: v4.19.59-48-gaa9b0c7579ba
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.59-48-gaa9b0c7579ba


No regressions (compared to build v4.19.59)

No fixes (compared to build v4.19.59)

Ran 24058 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cve-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
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
* ltp-timers-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
