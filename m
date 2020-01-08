Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10B13480B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgAHQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 11:34:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39353 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgAHQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:34:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so3975630lja.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WZNI1+DqZ7dhOcGMBf3FOgqzvgP3U/gwSgh20Voslag=;
        b=IgCye+Rg1Qso0tNKnWBaqrOq/tpUwyMVLrvrGqITdm77sy5HoA41W3TaF7A+qhs73e
         vtKtEJF3uPLapRgWABQLYVfyFOUtcMTZ6zT32PgK9aCZgpjeElk7wnHq7/dMvk2Zc9eJ
         K54CVWCUxs7pcnkif/DJAikpCnOhMCPzvpSQ7kOYOQy5Wp2X7tiDNAgBKATzxTzQdxDM
         aZyJ6oBqnw7s95n/pIHAxqBNPiddN7maU411jZtgTCRyGeEQFUoSwv41ZBZrn/YlP1bc
         /yD5CM0Pmd9k2ZXLliTPqCiBNYjhfnwCddc3pf/fYIRqS0KEmouqAZgZjjhfZANmEv3L
         NUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZNI1+DqZ7dhOcGMBf3FOgqzvgP3U/gwSgh20Voslag=;
        b=BgQYcLQL1uT5tubFi6jKEf6MuFyChTpLzrMENOIDKLa4IrA3GDdNZ15RHgy1R0F17J
         cF/dBiuSuXVhqsffGoPyrHS70+pZrDMQnHUB2w0kvW55qJLcG8gmd1KnxY3bIYtetJJ+
         G9aDNlMJS8I16Aa0xQ/Z4OYSlZEiwFHZHr3on6A1fC71Qqy9W+4IcWmjkkVkADcQcIqv
         Ws3uMeje2jrPNYLsmn4WXeZRgekDbE01FB0u1cJ5td5w5NVTTm2RB1UQLUZYeWsaC+n5
         jmoZS/IdkXqOkyJzbHP7HikEInMCPhc/F4S7qipnSstNL39mV4ukIICyUyGFi8tHHCkD
         0LKA==
X-Gm-Message-State: APjAAAXiYQv+9/YtoF3PkA3V3OVS+84aRTDZ9vMusKakQsT3DKZl0+9L
        sYJVBYyynATrh02YDb0mFiGbdFtNprL4vn7RepWLDA==
X-Google-Smtp-Source: APXvYqxwB0RrWmAOtoWeUcYHTSMCYJPWSib2Fa+SEwlkoXikltrHGicbKSEc2VBd9hBYyhzHhdoJPLJ9R7MydSJ8lK4=
X-Received: by 2002:a2e:868c:: with SMTP id l12mr3076780lji.194.1578501275374;
 Wed, 08 Jan 2020 08:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20200107205332.984228665@linuxfoundation.org> <20200107212436.GA18475@roeck-us.net>
 <20200108064251.GC2278146@kroah.com>
In-Reply-To: <20200108064251.GC2278146@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Jan 2020 22:04:23 +0530
Message-ID: <CA+G9fYt8hN=4NnnAO01JXmEQehcZ-csM5cT5AKa8i_BvzJ6-7A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/191] 5.4.9-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, 8 Jan 2020 at 16:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Thanks for letting me know, Jens also pointed this out and I've now
> dropped it and will push out a -rc2 in a few minutes with it removed.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.9-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: dd269ce619cbf8cc25d38f1872f7c5a29336500e
git describe: v5.4.7-382-gdd269ce619cb
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.7-382-gdd269ce619cb


No regressions (compared to build v5.4.6-434-g6d21990a6f6c)

No fixes (compared to build v5.4.6-434-g6d21990a6f6c)


Ran 20015 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* spectre-meltdown-checker-test
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-fs-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* network-basic-tests

--=20
Linaro LKFT
https://lkft.linaro.org
