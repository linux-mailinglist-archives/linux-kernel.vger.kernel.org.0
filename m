Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDDEF56A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 07:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfKEGLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 01:11:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35136 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbfKEGLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:11:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id y6so14149411lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qlJl4mbXSw7+uh4kopQ3iY5UJy6wrbK7LblI0yVyqOY=;
        b=VkM5MnuozAgQOZBr/WQ+qwvI2pdtw5W0NkpXw/2Lku13vkQ++4IXIJd+jl6/LG3keG
         TE88vlAe7DfEYUFHRMWSoGol4jYqLl57V+Is2j/sOi4ch0HEFeW+wpiSpAg1AAA/JsdM
         uk/bZQCJ2721JxtoaLWN0QekCYB/cLld0gFTrTM9o+poX9mel/6RFE88ITP2sa193a+z
         aifmOY4/VghDFmC8n+V9rQK7QAmbrKvu8XgMYgmbT9I23tyOPV/QVJOtwHzcECJZMdAV
         sgJMUvVUd1qG+m0GTMweZvrQE2ONgnNN40ckAtzUCWg+8KstVhdcZA8OkvRTjVNwqOvH
         Ki4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qlJl4mbXSw7+uh4kopQ3iY5UJy6wrbK7LblI0yVyqOY=;
        b=kKYkRoQEEZLeLf5rFmzgxJDOieYDGCdlkLtoi8RUHjJ9tTLZuTxZyVifppl6qqY4MD
         zxcsIZjBBA3Qvi5DjL82QLd6LGw6H8VgNpMYIdxnD3/qZVaiq8140pKv6S2kPAT4QRq0
         jMawQHPP1iGxiUwe6DIovMx3Tsf8lLdeqL+ImIa20udEHKMuUp1nigGTfkBjr1+gsW8A
         9VqgOOIlqRFbpx55u8m+Bp9QeqOcZozB9GKSoO/11gV5AbJFGKRmQxA5hwMqKAFlLdq/
         0o3fSJxfV3h5ZcRqTMiPkfivP5APOQQ/3HD6zHOE0rOh07eSXH+ZjiI1x7DetQAN0jr9
         m2LQ==
X-Gm-Message-State: APjAAAX2b7JDCpo2Uu1Bk6C72Ni17WGaNvvx0jT6WUZTani5KD7/d7K0
        dRT4jbpFGtNPial+q9DDB3qx71QGR0L9zrABVaBCrQ==
X-Google-Smtp-Source: APXvYqxyPwdw+W/2W0V+PcEuGeOd+UjmrBp8J4e6OiHTc1XvxSFprME7arLc1C0Ecy3faYuCE+OrwLMbLRBODBRi4lc=
X-Received: by 2002:a19:cbd2:: with SMTP id b201mr18876470lfg.192.1572934265722;
 Mon, 04 Nov 2019 22:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20191104212038.056365853@linuxfoundation.org>
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Nov 2019 11:40:54 +0530
Message-ID: <CA+G9fYvuRyfuaw1wbx3BttsDiz7jC5qnFrnYkc5SfHpRrC2vbw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/95] 4.14.152-stable review
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

On Tue, 5 Nov 2019 at 03:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.152 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 06 Nov 2019 09:14:04 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.152-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.152-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: a9ad8ad8b3efffde7dfb6853480bb74579a0b973
git describe: v4.14.151-96-ga9ad8ad8b3ef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.151-96-ga9ad8ad8b3ef

No regressions (compared to build v4.14.151)

No fixes (compared to build v4.14.151)

Ran 24210 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
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
* ltp-ipc-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
