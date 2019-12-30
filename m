Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0638412D174
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 16:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfL3Pac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 10:30:32 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44456 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3Pac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:30:32 -0500
Received: by mail-yb1-f195.google.com with SMTP id f136so11073126ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 07:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PT5AYVBG8ze7MmJ0pij7dPQPT0MFfSk0Gv5539zJ7QE=;
        b=Ya0G7HI6/8LYyGOiVw8D19AnkDkDjGVuSfiuguonUzsum1K8vD9q97Nu+fhEw+CGUe
         Qzuqvup4Qe6FJzFjUXsVkEXaApLj2QRlKtKkEnqynAJg+uC7P7L4BMH9h+SsZoPh+fvL
         6qqIY9CvYNngksuc1xyoJospbEfmisscnpjTYeMs6WK1f+0IfpTbY240FgtuNPIrJ1Xx
         yfZxnVL70OCJpKZ3GdowNXvSHYfCeKSTcjSYqF8BQ71c9fVUckvXUtk9tSOmFCPdPoPz
         TbCBnCAqe5WgZ2R9diVDLYGr2XUt8vRlPSpSymXEueFg9XiX6Ga0/eUXIdy/ySuAxyt1
         YqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=PT5AYVBG8ze7MmJ0pij7dPQPT0MFfSk0Gv5539zJ7QE=;
        b=TYRrLu0MNmd8gdP7bEsreHKyAWABL6bWO2eLZ1UXe3tfu2U5PKMXN43SFVQ2DzRo43
         c4Wm6Rs1LdOvhDE9CmV0LEndf6XLWsUywTOTPW0Za4zMxxVed4LbkIV78C4kdU8ol8KW
         fQ6gOvnGtGP/y4pR8W5WVqBitWEBjZpphNUd0uHQUCPGpzlZ3SqcoB4qmdCXmMR4OVWS
         bx+uNCz0ai8DIDH0mNDyrpxpY85SEnh3N+Nis5U2owC0yYDYf+Ch2L9uzniD+pe9Oknc
         B1AbxSXpnvteakyoPozJ6W6+/MNjtVSgNRsAWtTN1j7kkqH8892/yYaFmqt4ckARfWQ5
         OcZg==
X-Gm-Message-State: APjAAAVUjskf3+1oLxgLQRevEkWzg5azcct2lMZaNffbmoDUsXt+sSJC
        eZOn+FHrU/YqRhHOpclUN34reg==
X-Google-Smtp-Source: APXvYqxYDsQ6lt+v/VGyEx984yXWB69Auykckie+ntmEC3fgXH0WDxGfF/51fE3I200mYbvzrxamUQ==
X-Received: by 2002:a25:32d6:: with SMTP id y205mr45395971yby.457.1577719830948;
        Mon, 30 Dec 2019 07:30:30 -0800 (PST)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id a23sm17626325ywa.32.2019.12.30.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:30:30 -0800 (PST)
Date:   Mon, 30 Dec 2019 09:30:29 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/161] 4.14.161-stable review
Message-ID: <20191230153029.35zasheymdjckips@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20191229162355.500086350@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 06:17:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.161 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.161-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 9973cdd1885ac46b53c6db9f07b9e22003b8b1fd
git describe: v4.14.160-162-g9973cdd1885a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.160-162-g9973cdd1885a


No regressions (compared to build v4.14.160)

No fixes (compared to build v4.14.160)

Ran 24205 total tests in the following environments and test suites.

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
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
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
* ltp-dio-tests
* ltp-io-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

-- 
Linaro LKFT
https://lkft.linaro.org
