Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826A715880F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 02:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBKBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 20:55:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40712 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgBKBz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:55:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so9721722ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 17:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NXHBR8PFG8088Oj2svgszSoKonXK0APyrwo7m2/s6gA=;
        b=dDB21FfV5bYOq6wLtFpHiiR3IpohTkQHgmI16d1GWTPExkB+1hQ8IvMoGEBZ7lmAoW
         tSb16ig+BRM5OmyCejawgkpg+ARQectjy1aYbUsVIq+KEv7Dr7pbZmHC2tmmTObwF5Fg
         wWSpGJRFJNlTydoqWKfam31e6zO1wJoAKrPkxyrPLe7sgT6VVy3+QN291CCwr/mTl3Ic
         h/u0YbcDutoVLxnW7NY83X0FpbvRG3fRqx2mb4VfFY1WqVPihHLucaSbPVTC9InwZUQE
         ONCGcmHbN0kETf2tmrX1ZC4FCdETDM85YocsV70Q5/ZEtB2iJTFuTJpZW86Wc7HS7KQW
         9gCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NXHBR8PFG8088Oj2svgszSoKonXK0APyrwo7m2/s6gA=;
        b=fM2twMYW6rZLR75fYGa39kL5bVIWOojyCWnPxGynFU6QGL5FI679DdER4FdcKs/72/
         9thuQ4WGS/3JinF1/fvGqR5t99Un5SkpQsHYJIoV7ma6357jiCksjuzo9M/C6Dcq7t8m
         k8wkuFdUeeR06E6z4d4x1aiHvFWaBhEKohKNzprbCnyUsWdyvLJ63ttm6JVD4aIoHDv5
         OwvUaC4ZMasMt4F1xewT1QwCaxnbSj/gpWDo2N2tAC47kTjMWJUpDL+lcGQax1PAO9Sa
         fhYOzC7KS3RGtAr7WMuUbEjLbrJdUPiezFPApBgqvoXWeO+ycYFDUQrr/qx3Juacq/1F
         wxYw==
X-Gm-Message-State: APjAAAWnjX1D4Im7ZXEyvHShiuyYyr2++KHs86bP0u5Jg8PLjUtVhrjM
        Rm/JSUHHTMwlNHqTPwm73Cy8W1Ymb10gQTgOyItRoQcVIPg=
X-Google-Smtp-Source: APXvYqwTWv11U9HEWFBbXUxfqYNZ7xr+aww190kFBLfsIfMaxh7F6FoO/DA/zd2vy4wxqC7z5nSkh2dqX70lu2UEomo=
X-Received: by 2002:a2e:9008:: with SMTP id h8mr2621750ljg.217.1581386125272;
 Mon, 10 Feb 2020 17:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20200210122423.695146547@linuxfoundation.org> <20200210180821.GA1030265@kroah.com>
In-Reply-To: <20200210180821.GA1030265@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Feb 2020 07:25:14 +0530
Message-ID: <CA+G9fYtcLUcs_LchTTpejwZea0+5kE8OZsRX1Ti54s3Ve2177g@mail.gmail.com>
Subject: Re: [PATCH 5.5 000/367] 5.5.3-stable review
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

On Mon, 10 Feb 2020 at 23:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 10, 2020 at 04:28:33AM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.3 release.
> > There are 367 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.3-rc1.gz
>
> -rc2 is out to fix an arm64 build issue:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.3-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.5.3-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: d9c695759fb3d975f591901ff86e5ed0c6b99a34
git describe: v5.5.2-369-gd9c695759fb3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5.2-369-gd9c695759fb3


No regressions (compared to build v5.5.2)

No fixes (compared to build v5.5.2)


Ran 25348 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-filecaps-tests
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
* kselftest
* ltp-fs-tests
* libgpiod
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-ipc-tests
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
