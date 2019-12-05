Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA174113B62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 06:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLEFlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 00:41:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35690 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfLEFlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:41:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so2062508lja.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 21:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LUSxhcq+Xx4eOt/tOSOOI8FbTD83Nx78D42d78Vz7Ds=;
        b=HaTMRsbcguCy9HCpRDWIv1eR2um5KAqn+iINxpj98rbAY8OkuSTwta5otXbKFKtpRa
         ASygJGvW7PXJoB7CdK8vIu8o8tHL4/LAZV6VPZ4WmEppY8AYONLQTtO+xy/hXaqSr3GH
         W5+rRXB86V/iRJ+fQMZgJ6kwplSwIKipKEVEH/YzYU36T2ZgPQBlhe3RRn9SukkFI4qz
         aK72adYS9friK+XJcBpF//VnV70Vxk409Ey/Kxb8I5kGuGtqw/MItHHUrZzXcfMeWzjp
         yXLLiRGbfvPMy1quCvo8nh0BWV/vYqLD9JRUJmc9zTSK9W+ldm9CP0SacDY8jCm/wv8u
         pOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LUSxhcq+Xx4eOt/tOSOOI8FbTD83Nx78D42d78Vz7Ds=;
        b=C7SJR4WmqUAuQEcxwdTa2UsChtZru6WfL6IryztxjPh2JSgXoSKfjcD3j+j2L3UYr+
         ewzW0Mf6WNN1mU/qBPuV09RL0qxEvwYebS3/jtTghypIXFKYUDVGGhFkg+yfJv2e5eRU
         phOGwwFfpl1RaICEbYWuir8r9L1OETU9SLo1qTusSzKdIIPlsicFgS4SoQHqhNYo/trj
         YC5sy8ylLEOtyZT698MZcMmgfz0sD79IUJB/fmEhQWbE/Z0NUlHwyu3MYrLQRV4WkSOb
         662roe6ZaDVSbYNYuuOZAiEXIOQSi7YF2TjGUV59qLfFDJWalXW+laGwE5djlEzR1dzQ
         DZew==
X-Gm-Message-State: APjAAAUxY9udk2jS8B20bBOaKTkdlDTLzkeLtqnkMU/CIFMgj7U33XVv
        v8nIGoCidVgZ7MG/SsNm9uJs7yFHCmu3gbe76oFgwQ==
X-Google-Smtp-Source: APXvYqwfOBe4F2E2+TVRirzwUPV6UIGcCuR6xjdRp/7ONXLwtQl/GgZWw+iBpN1dyezJArnZxJq+TlmxGIdFH2ohC8E=
X-Received: by 2002:a2e:7202:: with SMTP id n2mr3756477ljc.194.1575524471576;
 Wed, 04 Dec 2019 21:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20191204174327.215426506@linuxfoundation.org>
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Dec 2019 11:11:00 +0530
Message-ID: <CA+G9fYtU9vvfTPEkoVPYoJZaLUWW_u1mkHpte=NzGp1kg7NgDQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/92] 4.4.206-stable review
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

On Wed, 4 Dec 2019 at 23:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.206 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Dec 2019 17:42:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.206-rc1.gz
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

kernel: 4.4.206-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 4fd2af91bc35d9c97085ffa7098b4bd9384cd9db
git describe: v4.4.205-93-g4fd2af91bc35
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.205-93-g4fd2af91bc35

No regressions (compared to build v4.4.205)

No fixes (compared to build v4.4.205)

Ran 19808 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* prep-tmp-disk
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.206-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.206-rc1-hikey-20191204-621
git commit: 424879c574f511c49c186d46a127184599a4d486
git describe: 4.4.206-rc1-hikey-20191204-621
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.206-rc1-hikey-20191204-621


No regressions (compared to build 4.4.206-rc1-hikey-20191204-620)


No fixes (compared to build 4.4.206-rc1-hikey-20191204-620)

Ran 1568 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
