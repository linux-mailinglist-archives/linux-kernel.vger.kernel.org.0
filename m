Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA2145A85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAVRDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 12:03:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38110 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAVRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:03:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so167542lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zM+sYNfN68/VlMHBQ28OqftNF6xyw8Hnnx+TFdLsACk=;
        b=YngsELv1j2RQ0Pv9zae+M720BMjOkELwpWeRg3c+s3lZovhBORsoZy2y/4p6hxw8fZ
         8Ec80r27bcCippPbe6fyRQYUEalliO+qqoxv0Xv/74zVHsu5NdhRl5DeseVsI3JVYvCj
         BWtPy83jor2v6kn/6wYSvAQ2do464r2qKn4T0ui8bGaJzaRTBnc1OHkENK/s1rR3w3IH
         40jTkTXcsYe14e6y/EbfiQoP0/BjibXht1iq3/n+dhZD08YeNIMDV7snggWYsBePUClm
         5jE8mHjcDEMDuJ3179r1ihmJBdgUBRy3GWS7gLJXyoO9tg9ZTUIpSSZRz/82RjCrGLbY
         6cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zM+sYNfN68/VlMHBQ28OqftNF6xyw8Hnnx+TFdLsACk=;
        b=BxUy80yJJyJI2gdQddAaV7hhdlCJJN9r0y63qDxeHxf+fRqTxyaAk84yF2e40acozN
         Sl+PU9yKQAR8IMB/W54BIQEbMcLFxOhHmfHoz+P8zjMHtLZAT1Szg8vlhGBBWdvvc+4g
         1xa9iCbGnn/8MynD4vjlsW/XhdkIR4eT+1xxgK6Z5M+63B4hNaNWm3U1EiSI6nHLeHvn
         mEMEeFXm4ZaANZvTIPFELekKxp94TZ0VsltwHzE3s17eOeOEvPoDws5aEyJyqq2Faqr9
         SP2lk2Zpm1QIRS87a3AqYWO+7mrI0YCYX0bLevey4bAYBIs4PP3S7jHyDTTdFRm7rMSm
         D9DA==
X-Gm-Message-State: APjAAAVb4PtiL3ZH31Zcw3oFp4EbxrkamwsIsFttbzrL+qNZWDnB/0yh
        yECahD+YJai4YqvpS0G4gPQ9qaGnA7ryK2S9pOSZNg==
X-Google-Smtp-Source: APXvYqzzit4eCBkk59mE0XMjvsu19Ne34Er8Ak0RDXpP1K30LgYouyYzJTPnA3czMddxdbn1/jz6SIY9PKXwY89NeT8=
X-Received: by 2002:ac2:4adc:: with SMTP id m28mr2340757lfp.26.1579712612116;
 Wed, 22 Jan 2020 09:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20200122092803.587683021@linuxfoundation.org>
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jan 2020 22:33:20 +0530
Message-ID: <CA+G9fYv+9iscZ+Xp85Gh=JbXhtPBOO5uigLuWsn8_7zOOvqdiA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/103] 4.19.98-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 at 15:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.98 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2020 09:25:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.98-rc1.gz
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

kernel: 4.19.98-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 0ed30079b15d245f5a148a4ff156dff23d9569df
git describe: v4.19.97-104-g0ed30079b15d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.97-104-g0ed30079b15d


No regressions (compared to build v4.19.97)


No fixes (compared to build v4.19.97)

Ran 18532 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* spectre-meltdown-checker-test
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* perf
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* v4l2-compliance
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
