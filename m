Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63E8701F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 05:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404992AbfHIDQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 23:16:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45773 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:16:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id t3so2241613ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ap+UfHyCcDfWJ28GS6VDod2lJYk3U20UyDyDSk+YgNU=;
        b=Ad2T/wcrh/0oEXeHX+SN5YRB9puIjAlohZaaMUIvhceDwH3JF8ZKIjoCAg9lldYX2W
         8/Ir7mgcvabwfL5bs/7Kd83XFlYluOyFuF4VUskly3mm3AGMQSOXun8db9EFbx2XDvzv
         uIY5FoDXcOvZnGIcA3w8stkT7c7kAFcQ2qMzHV7/SQvTtidvwSgx2N931zW59AOUV9lJ
         NN3hgAlhFkwqiRheXQWmvLpGsrvvaZmB2TNy6P4ZjRHbdGTq5El1k6gCf+fMi75t2t9w
         aGKDwwbfBsyrVP8NN16pDOpWEn91qhDQvyXFQEff51es5PR+6qkSTeJBIEBY8Z0WMsd7
         uKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ap+UfHyCcDfWJ28GS6VDod2lJYk3U20UyDyDSk+YgNU=;
        b=lEkQ9HHDh+G/cJIXgfzvjH3ykd6hNqaQdgTHJ8t0RH/Rle6/AkQhKFc1LRq/mOl0ZS
         INx6eg3xePND6T58uaLuR+UC3M/bBO4lwEmi+cge3lTXhgqU3P7Dx1KWBmqsmxWS94yQ
         cm+3fxPQJmzqeem0g7fiOJ5RmkUUzTCXr+Thd65/4JSbF/lJZVMdNKHDatG6TGNXkkOK
         VBqoWbpiW5t+lhiA+s81TVHPecMzwnQdB7VIQptKEgKqG5Dedh6MZMKYrjw4ZMkUrLd6
         72FSHH0V00c1Ybgb1Zdin9Dmw44tv7fuxO71rjreQy3IoFjlGkwr35tQFlWpFNUrXc09
         SDjg==
X-Gm-Message-State: APjAAAVentbLUg9o/dTU8OplTqtNjySxkH9BiNTKludaCeRi5AJQjAtw
        yiqdjOPZg0CO1dfi05FQT4V8cweuv33lynizxRyUDQ==
X-Google-Smtp-Source: APXvYqxlp5q6mYbtSqoReypwJRxhrw81dFQn4P8NzUodkeL8WzZVOx2GcgcoAVn2lbSsALhesp4E3fB6eHfv29F3oj0=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr10140284ljj.137.1565320610979;
 Thu, 08 Aug 2019 20:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190808190453.582417307@linuxfoundation.org>
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 08:46:38 +0530
Message-ID: <CA+G9fYtkahD0+otEc_+-nA1hA6o7euOCHbarSZQJWgUyx5HyyA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/33] 4.14.138-stable review
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

On Fri, 9 Aug 2019 at 00:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.138 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.138-rc1.gz
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

kernel: 4.14.138-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 4ec3ef9505a33da8c993347fc2e178b46356bb92
git describe: v4.14.136-94-g4ec3ef9505a3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.136-94-g4ec3ef9505a3


No regressions (compared to build v4.14.136)


No fixes (compared to build v4.14.136)

Ran 23722 total tests in the following environments and test suites.

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
* ltp-containers-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
