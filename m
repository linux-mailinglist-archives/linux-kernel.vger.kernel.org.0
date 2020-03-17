Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF73188EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCQU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 16:26:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41102 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCQU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:26:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id o10so24478341ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IUDQ6CemnSepNAfhTqvmK88Cb+1wupixNpF7ny5ZDK4=;
        b=wz79KUH2ObEjP2IvithwCLj/s8BBSB9UBRojmU+zfkPUJ8/eurkTsSIWx5Na7kJd3X
         vB70frIsMF2TPyOImlitSv2iQ2gjULWcNZdTzjo7rE04vja4AQzDzOdaoE6cqPqIMHFh
         haXgncz0D53yE08QjPbmhKEJdSfaXBn4HhqjGqFgOl+9MKS8j+queA3N/2XfbyE7MpH0
         8FjEUEQ7g1881iNVwl/TBM96QU09EHZXu3P5jKPLCow+tgdm0xhk/hAqwRFxoswgteL4
         rGmnGEGrKK4TBbPChTlB9FIUSaJUl9cjhKx8/+v6J4kRIAcAcLw9FrIaRwOc9477ddXf
         2MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IUDQ6CemnSepNAfhTqvmK88Cb+1wupixNpF7ny5ZDK4=;
        b=RAl0BmTTVPuX8Iqd2amRAjXdgS7DjVuf87N2s4uYXS4skfXykWchh92illDrS0Ymz5
         muEfcEeLsrbZAWAAQsXEIdD826sQSDkgtsgpy8/aiRSG+AaB1PXO+Uep3NrrCHuqq3AN
         98FmzuJ7RLwfPENxLTXecNOT+eca1h86rHlvUxCGcTJP5QlVcpcpB1+xL9MLnXIrjay0
         CDrTEJ/Ogxw4cqwA/qKfud1Jhz2PpgNpZR/rzcRxD+be/31wP/VfWQZLJE9TMBMgcZMp
         TQ5DPw5BxyL+xr+9olBAHbHsXQ2ILdhuBlMhf4xW97RPoigii9nOTmgbxYTHN6VyumG4
         uciw==
X-Gm-Message-State: ANhLgQ2dDgUL+UIcajAzw7TRvpX7B5rMq6kVcb489lSuHdhqTOlmRJKj
        bMcSXZZLcfTZ6aMmWXM4jZS2eIFhEvRnCzfy9IO3+w==
X-Google-Smtp-Source: ADFU+vtQ3Ylqb3KX+SgZ0YYy5xk6AnB3Aahd73Qs2sTHbj/d8fdgpaqlllHnjNy1X4VcDcTLd4CSutFtNMquEdzzUf0=
X-Received: by 2002:a2e:8885:: with SMTP id k5mr302202lji.123.1584476801643;
 Tue, 17 Mar 2020 13:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200317103259.744774526@linuxfoundation.org>
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Mar 2020 01:56:30 +0530
Message-ID: <CA+G9fYtOUpN_3Vj-x8UgbK8CCUrhssbSdhNE=4GkE9OmR_Nmag@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/89] 4.19.111-rc1 review
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

On Tue, 17 Mar 2020 at 16:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.111 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Mar 2020 10:31:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.111-rc1.gz
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

kernel: 4.19.111-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: ad35ac79caefa8ec9fbaaf4737d87fd7bc0329cd
git describe: v4.19.110-90-gad35ac79caef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.110-90-gad35ac79caef

No regressions (compared to build v4.19.109-92-gad35ac79caef)

No fixes (compared to build v4.19.109-92-gad35ac79caef)

Ran 17272 total tests in the following environments and test suites.

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
* linux-log-parser
* perf
* kselftest
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-dio-tests
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
* network-basic-tests
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
