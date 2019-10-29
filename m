Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25FEE8904
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfJ2NEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:04:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35461 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbfJ2NEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:04:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so15187693lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eolkio2X+wPF8zX1MLMOocwaEGUjLFeD4iEzYwB1UCw=;
        b=U2XMlrfMCLq8WlZOoFdhqhVmFWkkuoRQxAXUVWd9lkwiNnLjaeUlsAwSznJ39YXv3v
         jFBNWWWCfjpI4EmV3EsG/7OIZ8Kq7cqt80BHbh3ZfcjLBPvn2Lb0Y59hN9RPw92Lw1NP
         +xIsRyfZ3qXC3opdzo6mxdpVjo0nkBtZax4nEVG4xYbGej+MSDmwr8xNhJ5bgpKdWwcA
         73HjcXZR2OEmV4Tl0p9YLtzTYoYLh7rgMadM7vd4XrfHlM2KNyJp12F4DGKx5+iUeNoa
         DkJec2oBAtGbMSfMwNsJpuBHEKhkpDhe52lrqToU4x9noCC/MvQlz0Rzc63lsChtqJml
         fWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eolkio2X+wPF8zX1MLMOocwaEGUjLFeD4iEzYwB1UCw=;
        b=JI5/XlDcbU9zbwwo9VAoJ0gGuu4m8RXdTyqbycMrpWuFvMGFJXqUQubz33R4btriQJ
         gqsr8wulzKg1jr5KdTylQr7h+n+Q+jtrEhXADXXLFQsujYqxkM5cFvoJxI8LKT3vbrgy
         5f3nqavV582fP6QXq4LIpd9Oo5G/YH7vBEl/pzfcKnz0SVGB5W1+CwtoxAF1gCzUCfhH
         OaxYMcDgQ1UCeRFl9A9gJcq55Vri8PrS6ww6VHupDW6cneSgkf8HLV368AciqBib83oz
         HHFy+170xgbQYBwi9PfDN8hUZBnF3QPwi93sfbEkNEnwh5SlpZrA450z4Qxa/RNTVY5A
         FgsA==
X-Gm-Message-State: APjAAAV7JQEhVuoWvpTkcvC7OJo6X3++yrXfla47wk9UAHKnt9+ZFPcK
        JRybZZarEZIfgAW6wV5W90mQu1ml028xDv8O3ZAdug==
X-Google-Smtp-Source: APXvYqyW9zhmv297bu5tH11bxbPjFdxUwCIY8EX/Ti+kxND3sOM+BVJ85lrTWwVG5Q4bUUtPGWijr0taxJGIX1N5tsI=
X-Received: by 2002:a2e:814b:: with SMTP id t11mr1759624ljg.20.1572354247270;
 Tue, 29 Oct 2019 06:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191027203351.684916567@linuxfoundation.org>
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Oct 2019 18:33:56 +0530
Message-ID: <CA+G9fYtmCNbq+ywLe+RSDZqVHckzyJfaOCXYRbD+5-DaYm1yKg@mail.gmail.com>
Subject: Re: [PATCH 5.3 000/197] 5.3.8-stable review
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

On Mon, 28 Oct 2019 at 02:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.3.8 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.3.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Note:
The new test case  from LTP version upgrade syscalls sync_file_range02 is a=
n
intermittent failure. We are investigating this case.
The listed fixes in the below section are due to LTP upgrade to v20190930.

Summary
------------------------------------------------------------------------

kernel: 5.3.8-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.3.y
git commit: 96dab4347cbe9212292cb3934e4d16cf1dab94c3
git describe: v5.3.7-197-g96dab4347cbe
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.3-oe/bui=
ld/v5.3.7-197-g96dab4347cbe

No regressions (compared to build v5.3.6-112-gcbb18cd3e478)

Fixes (compared to build v5.3.6-112-gcbb18cd3e478)
------------------------------------------------------------------------

ltp-syscalls-tests:
    * clock_getres01
    * ioctl_ns05
    * ioctl_ns06
    * shmctl01
    * ustat02


Ran 16437 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
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
* ssuite
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
