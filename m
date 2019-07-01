Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92D4DF77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFUD6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 23:58:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39264 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUD6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:58:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so3963711lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 20:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hiQnwYn3e0CeuW7tkIYX12tgeuH4qCgsRKEwMXIWg0s=;
        b=Qd9yTeft04wG4RF7HBN36wlbFTLzNPkb5qMFXP3dcpFq4k0o/QPbmqxMU5vhB2OkN7
         gg2hg71Eg8UuITNB81+BEfCr9SvARVHu42Vd2yRWKBfqihdmwSPHIpF+/zYVBihIzW7I
         g597O3dLrkkvxqhXdLTmYtOeGcjhP/hjs+2IfMSsk6mu/QsHTtjxNImhytHF4tltwGGy
         3fAJYOFVhkSgzKYWNcQ92HC9Hb3GbqdDsNx0f3cGELciCE0NC+nFeVwq8LOGx03QwuiL
         mxBdjccSHEjr4wylxZllt86kOlyWDjn4pPSTzL/5GYXs0F6trmTkHJrmPQKw2OC2/LfR
         D9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hiQnwYn3e0CeuW7tkIYX12tgeuH4qCgsRKEwMXIWg0s=;
        b=LleQU8/mvBG3gJNhHx+6DqeDMic1eqyGuGj9Kv5aNBrPeUVYJ8E4Gq5TlOwIUEGk/H
         aQw+GYRl+UkLRAAga8SSY0CC7S5wIS8WWpzyu1FXBAWpm0R+gvd7XPe0fX9olfzjUmM8
         LmrAiWTGWGZmyKM2AQfgxGyv1Wv5z+wY16AlMsQuotuL+PB8DK3QPpAEzbzI8+hi2T+a
         G34ztt82sgm/EhmiPRpcsQW+KrA2vwHklbr1XkDwUt7mXUqnWhIgL3HCKzOOkIhMTZlo
         Ugtvk+zlxSuevp1brQJz1GVXm5kZEpue6nQfmCZef/zkuc6lmXWQ9tRW3WEx9xfIGkKx
         10AQ==
X-Gm-Message-State: APjAAAWlMTgzK4TrTLKcnMnYdfgjYHZGl3gGNelthvHH6wA3YNUz6bUg
        lsO3turs3R3N+8ae+oGIddziS39kJPjYoPnP9bS4xA==
X-Google-Smtp-Source: APXvYqzkRkyBqQUprpT26PX+N9iAVKmKORRkSBhjEtLu1kwzYAeDBypYF8vczndNrg9khhceQt37i0wZJt4oTRWyrmo=
X-Received: by 2002:ac2:482d:: with SMTP id 13mr23001314lft.132.1561089486985;
 Thu, 20 Jun 2019 20:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190620174337.538228162@linuxfoundation.org>
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jun 2019 09:27:55 +0530
Message-ID: <CA+G9fYtCRkMNiOC=sHxc5u+Sx5CSWMn1RU+gJc5=J1feKDzsFA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/84] 4.4.183-stable review
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

On Thu, 20 Jun 2019 at 23:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.183 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 22 Jun 2019 05:42:15 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.183-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.183-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 847c345985fd296caa81af3820e8185f0d716159
git describe: v4.4.182-85-g847c345985fd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.182-85-g847c345985fd


No regressions (compared to build v4.4.182)

No fixes (compared to build v4.4.182)

Ran 20007 total tests in the following environments and test suites.

Environments
--------------
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* network-basic-tests
* perf
* prep-tmp-disk
* spectre-meltdown-checker-test
* kvm-unit-tests
* v4l2-compliance
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.183-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.183-rc1-hikey-20190620-466
git commit: 3e8bd9046c869be462eabbeff74037861c7b2c22
git describe: 4.4.183-rc1-hikey-20190620-466
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.183-rc1-hikey-20190620-466


No regressions (compared to build 4.4.183-rc1-hikey-20190620-465)

No fixes (compared to build 4.4.183-rc1-hikey-20190620-465)

Ran 1550 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
