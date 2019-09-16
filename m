Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E1B3887
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfIPKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 06:44:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46822 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfIPKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:44:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so26996593lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9b+i2LgNvSZhIDKWf4kZrv/OWLqCoOQLxc1wziOXbVc=;
        b=byga18GGYdSWCY7Gz7mf31ZQ3xQa4/yqv1yqcNxMsiBCeF8FpifFLz2rG5G4s71crZ
         /gEh6URmUkd6+3kBndkTnkLcGMYDRkZp7bi0CSLt0vfXNKgwsj00GsBzuYoztY81X07S
         i8kMBd1CvMgatzDGZwtu7PzdIjlXSebK+ZJD+du5E/FFb6kkNdIGL2mZB4A2nmJ0ULup
         B+JtfrsExSnWeEkFv56nX31I57ezQIVwHsAs3ibLNkJ5+VXumEfvI89Z+Cb2uwure8fy
         SubWhhBVsxoslZDbDZOrSEKRjEeBYCMbzGORkUeeyWoIZQeQpFD3XZ+Enyxa8gMUrX7J
         K6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9b+i2LgNvSZhIDKWf4kZrv/OWLqCoOQLxc1wziOXbVc=;
        b=XGT8S3G68wtd3GKKwqHxxUSVN60cVyMt2XjVARR3ylyejH4UgT8a+2cg+/nDS32Lp5
         dK66Sk8lTyQkxcbGDSbQutHJo2ILD/VHYMCmjkaMM8BzeO36z/2B7dsdSITReGZ05UUD
         rPm55zOMg488Qdlr+ImMj4SMd1sD122Dy4by2WmYPSNNu7WihgJpa0zD6o3Jh35N1lbl
         LMLqQmhuRpjEeGjobTqjApOXQMF8vsdKPLQHOtb5/F99U09dvqeoV3sCNLRtSqW3KJSL
         SvASfBhQELEdWhfg+DzWSkAzL6YAAjnfmRp1ohJdWM/NMViwX5IXRQP7nYLLpNMkw1HS
         5Hlg==
X-Gm-Message-State: APjAAAVGXiOoo+f5GUiysDKATRBfUwZ9TOuylwGtcHBDs5d3CaHWAL0v
        EfxYUSuB18AudBbOVs0FukKWAJNmK8/ySXDyNxbXHw==
X-Google-Smtp-Source: APXvYqy5UsR7ERNYhyxw1Cy/aq5DUM3ig+zsV3XCIHFEPgAfHbTm5vfrczhbyzrPct+LfsstuOY23MrqbNj1bXDeXU4=
X-Received: by 2002:a19:ef05:: with SMTP id n5mr36802703lfh.192.1568630688217;
 Mon, 16 Sep 2019 03:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130440.264749443@linuxfoundation.org> <20190915133553.GD552182@kroah.com>
In-Reply-To: <20190915133553.GD552182@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 Sep 2019 06:44:34 -0400
Message-ID: <CA+G9fYu5b-zyttOx1Wxu-bi+hopRvYNQ1otS7qujx+xuLrA8xA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/14] 4.9.193-stable review
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

On Sun, 15 Sep 2019 at 09:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 13, 2019 at 02:06:53PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.193 release.
> > There are 14 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun 15 Sep 2019 01:03:32 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.193-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> > and the diffstat can be found below.
>
> I have released -rc2 to resolve a reported build issue:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.193-rc2.gz

-rc2 looks good.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.193-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 61edd63129aea7800898aec66b9a420f765883c4
git describe: v4.9.192-14-g61edd63129ae
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.192-14-g61edd63129ae


No regressions (compared to build v4.9.192-15-g8e25fc1750f0)


No fixes (compared to build v4.9.192-15-g8e25fc1750f0)

Ran 23432 total tests in the following environments and test suites.

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
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* prep-tmp-disk
* ssuite


--=20
Linaro LKFT
https://lkft.linaro.org
