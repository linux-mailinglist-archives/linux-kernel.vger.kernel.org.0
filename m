Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE50415D556
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgBNKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 05:16:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41783 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbgBNKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:16:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so10096029ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9vtdtRNIMj0zHhpd832lxgs5E0HQ+0o2GaDpP88VB5I=;
        b=Gp5TGctPtrEhK7n/wlHjG3iY5Bku+gm8te/mYL2IaGs5h2tg91UJje/nTRoiLmic/M
         Qq6aAUERhideSPFO83OSAWSeVAnn026efhiZ8BolYhrWWcBtp97FMPlIZsCT3/qT8zWQ
         3c7TwS0qCOc+nBYPBcriRvix3NziupXxs7ONdIK8tabA7+BJyqykoTumHoPBXAi2fu2t
         xYR7YXqRM0uYEM5+A97owr8N55ozmjbguN+opEZgA0s6tjZ3ObjohqLtW6GrQQeQVXyf
         5yZdsmG9cLDsJ+OEdX5C2gbGK481bi2LKJ0geFBHDF3DF1LZAsJIbLwkbDORX07hb+uv
         wuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9vtdtRNIMj0zHhpd832lxgs5E0HQ+0o2GaDpP88VB5I=;
        b=WEy0CNlM73rHdhWkhLH7kft9GrX91/GJIlzwok11irP8H7HssVsVcpc3kDUljM8YQd
         Q1cyEX7CU8y0JzZXWLAeSFRCpN9lSAHrDn9tvzh+o3qdVh3hyzXDWp5TP8nOrLuBF/4n
         uCpmff6X3CldWOApEsn71TvLTf1m1L7KDdY8lifzPblkHfnRnyqmJDNjKTiK+heF31D0
         F6bT0hyHsekBgoGkvjXmtxKdU0SteTk6lR357+bQbruXn4UOyLT7y02TdJLEFlMogqsm
         ELNVj6QeCrdtv3L9MgcUkTYn7LM7vJypQrDl2J53z36sHX1lkaYH88Jl0f8VQpAS2jZ+
         //mQ==
X-Gm-Message-State: APjAAAW6iRnlrNT/G7f0j+EFG+EhZvjuOoB5+XLkual3o66Ne+0dBWfv
        a4XAFYS+/R2S/auUMICngBngBIHJk5GHKGaawkXGng==
X-Google-Smtp-Source: APXvYqxjvoxKd1QgTBWAOCzCfI9QzASaBgu4/jFlhc06O+kBOYez53iQMQX4zfaSPipxYq4OblNYv/OpOINDi9vJfWY=
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr1645807ljh.38.1581675413931;
 Fri, 14 Feb 2020 02:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20200213151931.677980430@linuxfoundation.org>
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Feb 2020 15:46:42 +0530
Message-ID: <CA+G9fYt5pJPnADgNs9CpfoVcUAn6q5ZU+KedmHWt=t6WbBF8tw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/173] 4.14.171-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 20:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.171 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2020 15:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.171-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.171-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: fc30e3f7ed49e3e207a81a7945cd2524bc6a9cb7
git describe: v4.14.170-175-gfc30e3f7ed49
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.170-175-gfc30e3f7ed49


No regressions (compared to build v4.14.170)

No fixes (compared to build v4.14.170)

Ran 24192 total tests in the following environments and test suites.

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
