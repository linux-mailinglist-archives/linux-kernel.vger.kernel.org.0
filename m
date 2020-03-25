Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19E219203B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 05:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCYEul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 00:50:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35569 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCYEul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 00:50:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id k21so1081380ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 21:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qiUPewOd/5czYbVwyunCDVVRVz+6K1hlh+LYVUDWDAI=;
        b=fyDxva++dKPVmJpMc1UNYixdtpptpLXNP0vne78JJoPfPQ5VqYYES+1hRvKsOBCksd
         bgm3MFOxlcQ74zK0nkE1O9UATNIaJw8yTnN2Q3WL+TebkfVBRpMTy4wQVto16x/bT0TY
         8pUOJOn6hOrWSfiWL5ATYD41GifiBkSt5qGoXhvBdONcrIvoqhtrWtOooZigLHFagpk1
         5GbDOwmzfnj80WxlUibRHU6lwE/d7CyPQ8ptBRyf8hVVDWMhJooZRMFMWnREDBP0+A3Q
         F1xMwFcwgvx+JB4hZjY7PGL4dKzx60jTmyCvsoMCeKveHom70mch/8TIl2PdORyVM7+F
         TdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qiUPewOd/5czYbVwyunCDVVRVz+6K1hlh+LYVUDWDAI=;
        b=kDSwfwERPny05OQ3mIhUgnT7N+xC14b5f7GeXjuBSK3fobAB6GwEW1LXrRdN/5ZSRi
         W0pbyhvsh44ajTaUO2Npeml6WsINepmqBeLVpzaQ0D5Rfa1XDB6qZRoc0YtXSGeIJFOb
         iXfIkvXTu8kUY7Ucmrxq9BjYw+SE0Q+4KVQfyrRA5Mu8PV+qQv8oKUDrVvFWM1yzYh64
         ftmVE4sfv3xqLQ8hE+qtf7YfJ9EIYkNraS41cnJg5/vD2H2y5+Zye5Z1Ep0Vl7JxIIP8
         TjHAXvvOXW7C31qsgIrqQOMw4H+Hdo0NtXzu3wq9hHMl/CXjWLKBt/GfU/wq359Hkp6O
         Jmhw==
X-Gm-Message-State: ANhLgQ35wLe29Es7LNBhCO/M2fqiEhCI16JadU5KW0gVvacRsxj5HjSY
        qnX4IfnRUS15hf5opo84ILB4B7/uKRSGfC+4E0AseQ==
X-Google-Smtp-Source: APiQypLumcneypmhNRcz5X0RuGTVan1NQ52SOXC/GITbzdZ5rJLcsDvYsWr1tJ1QnfJ17abPLYr/qRtv4JzKd2faAkE=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr688744ljg.165.1585111837401;
 Tue, 24 Mar 2020 21:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200324130756.679112147@linuxfoundation.org>
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 10:20:26 +0530
Message-ID: <CA+G9fYv5MoKj6OVmLe=nRZy23sKjiqBMbhoT6MTQ0gj7wCORng@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/65] 4.19.113-rc1 review
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

On Tue, 24 Mar 2020 at 18:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.113 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Mar 2020 13:06:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.113-rc1.gz
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

kernel: 4.19.113-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 69e7137de31c53890ed823aee0818a6a6563c445
git describe: v4.19.112-66-g69e7137de31c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.112-66-g69e7137de31c


No regressions (compared to build v4.19.111-44-gd078cac7a422)


No fixes (compared to build v4.19.111-44-gd078cac7a422)

Ran 24703 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* perf
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* ltp-fs-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
