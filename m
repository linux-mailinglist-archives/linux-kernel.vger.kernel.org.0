Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE09CD2B47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfJJN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 09:27:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39818 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbfJJN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:27:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so6206188ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wSfnhh7pJQiBQCHnp2dx9cNnQXOTNXCwiKvUTXHls9s=;
        b=sC5o2B2KL+o9KXnLPyGWy2YzOGLzNu23iATLIiYZCX4rLNyxquUzu+9alJc+sWbro3
         ks+jQ3cPkU57lh/1E5UQz4M6Ooqc/YR3H031k8e9Pe4AljOh1qfe/u2eRJts0Mz3l0/m
         MADeui9VjQfYLfryeyB0QEeBvgie8HaYquwiWu+EKdHQhhemw8n+obsbZ2yyQxnT0z6p
         dVsAhULIHlWJ/2vznjfkIL4GUIiD95PwawPTh74+VYYt7nEZHFUqSBCdFjGHhSZFhQar
         7e5gZVkTH559wMP3SWdHtcVGZbdeJSvny0oP1s/FM9SeVt1y5FlQaGHMM8VRxHDWf2df
         ttEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wSfnhh7pJQiBQCHnp2dx9cNnQXOTNXCwiKvUTXHls9s=;
        b=lb6yF7gVTpXZYKhjKTxOWk5B2I52Dz6duHD2r62OZxBaLgJ+XgurvFnPoF7GK3o8f+
         eAw/umpSBTczfF8x+n9aUICkn+mAIMT+xhEvGqCkgwEdmE4O0Fy1ae+I+zVl1wyQzWXv
         bDUzQ2GygdCPEGJSYD5TBzS5n1TcZCjCciD6bsj4RuPtuBcOUbD5DmVTI1InDnj9cT46
         eZL+DrHkru32QyWDUJJzkcufiejbOoO0Dbt+g2RvGeXIQk+HuhT7ZzRHNMoCMhuhwLmU
         r3SC1sdFg1sU+pfxOdaoYAQMy9m8Ym9i+zg0NGbnZFmHZmzX5qMcQf2IDMdVXe4vqj7Y
         An8A==
X-Gm-Message-State: APjAAAVvbfYBmtUyLTDn10yioZM6GG4y457PaOjcdZ3G2HDDZxASOsxq
        rusj92SwDBn97gBaxJ3i/sGMYcYXkxUetgKNmWAlUg==
X-Google-Smtp-Source: APXvYqwWgaamQ7xQg73/8LDBZE4Hd8IF7OptzYL8/5w7fGJUZpUeKf1dRo4DimzGb2L1KK2Yj68nb1n2SVM7EiZDyzA=
X-Received: by 2002:a2e:8602:: with SMTP id a2mr6610254lji.20.1570714053772;
 Thu, 10 Oct 2019 06:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191010083449.500442342@linuxfoundation.org>
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Oct 2019 18:57:22 +0530
Message-ID: <CA+G9fYuPLhXNYbW9WSRQnv9Bq-q8WS9pHFL7BDgbLEDfGNZxwg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/61] 4.14.149-stable review
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

On Thu, 10 Oct 2019 at 14:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.149 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 12 Oct 2019 08:29:51 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.149-rc1.gz
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

kernel: 4.14.149-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 8952ae7352b2ed94c2a5f3c8ac3f5d1c96b43bb5
git describe: v4.14.148-62-g8952ae7352b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.148-62-g8952ae7352b2


No regressions (compared to build v4.14.148)

No fixes (compared to build v4.14.148)


Ran 22253 total tests in the following environments and test suites.

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
* network-basic-tests
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
