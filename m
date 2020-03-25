Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5D1920B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 06:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCYFp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 01:45:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44189 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:45:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so1104847lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lYD4gV2aiMtygPtwbX++wP+dM6O7K0V0RGjep/0vOgo=;
        b=tvnkhHvm4PdvQZoTz5e5X+Zuh1SFtGki8xsPdRgux9SuV490qyjLdAXhHXfl6YUc7b
         TKA6AB+0uG0vcllAzYR41yl6Uk3pFSL6KpsvlEVd7LvAyBb2oAIwhBNVNibfYH3Eu1mI
         +W+Zm/S3JCVEiXosbVrpeyegBqZQRR2dyZG+mWK1IAuFfIHqLb1/egL8DarnDe4yfsGL
         l6ejO9jXdwKHZXGaUKbKYLAoESeEk3PNkGTm5zfbI78CaA8waQiHOfPVzwftKJCKKkrZ
         oTPheye5pAZndL+1O6AGancWuRiU9OUpEz7aNX+rxmRAbqcdgKomLFCf75wpTs9NIFln
         9+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lYD4gV2aiMtygPtwbX++wP+dM6O7K0V0RGjep/0vOgo=;
        b=ZTFVADlnSuA2H0/NiSB1nezE8fVFAHKw5eLiEOxE5dFqrui7wDZvMYj60Gb++7KZwR
         OCfFq3uWR3vUx097d98afimTxOLP0461kNuLWk/0M/7FAUnO38OEvQ7bJvJ1WVL9JyS3
         EgEzzYDqROTrMB2YjtSMAEjaiqueSeCXzO4OVCFyKhbVc8Ffq4TitfNnbrU9CYzOUqCM
         +XHekOYQDLk3IjpftzQH28Wy7JMx9h8xROiE9o84gEbr2ObeaQXk194+BvAa3kohiy4f
         8l4pcGeBnuevl+B2PuZmjjwHYqCpFNxy79JIQx8eBH+KdcEZxa2svhsQiyp4h7mm8Tsf
         lhEQ==
X-Gm-Message-State: AGi0PuYH1JHetfEbXKWP0LEJ+mpin/EvX+kOA3jeQwv/2U3WgmZ6mndS
        5a/f8ForfsI+3Tuy48S0ma641bscfAMWiDTUtjVF7Vh1+/krtg==
X-Google-Smtp-Source: APiQypJEZ5vvAF9MO4gXQ+t7bUi6zsTgvnRPAe7WZWydS2OyyM8x5YA29XYUAWgjrddMaB02h7sWA6m1G5a7LVftCtY=
X-Received: by 2002:a2e:990b:: with SMTP id v11mr856142lji.243.1585115125736;
 Tue, 24 Mar 2020 22:45:25 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 11:15:14 +0530
Message-ID: <CA+G9fYuAib1xN5gKwr1_xrjPd=zE-qsAA53VZL6npvZWgJ_fTQ@mail.gmail.com>
Subject: perf failure list
To:     open list <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dan Rue <dan.rue@linaro.org>, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been noticing multiple perf test failures on LKFT test plan.
I request you to investigate these problems.
Please guide us to enable missing Kconfigs and userspace tools.

The listed failures are from stable rc 5.5 branch.

arm beagleboard x15 device [1] & [2]
----------------------------
PERF_RECORD_* events & perf_sample fields: FAILED!
'import perf' in python: FAILED!
Watchpoint subtest 1: FAILED!
Watchpoint subtest 2: FAILED!
Watchpoint subtest 4: FAILED!
Object code reading: FAILED!
LLVM search and compile subtest 1: FAILED!
Session topology: FAILED!
Merge cpu map: FAILED!
time utils: FAILED!
DWARF unwind: FAILED!
PERF_RECORD_*-events-&-perf_sample-fields FAILED!
'import-perf'-in-python FAILED!
Watchpoint-subtest-1 FAILED!
Watchpoint-subtest-2 FAILED!
Watchpoint-subtest-4 FAILED!
Object-code-reading FAILED!
LLVM-search-and-compile-subtest-1 FAILED!
Session-topology FAILED!
Merge-cpu-map FAILED!
time-utils FAILED!
DWARF-unwind FAILED!

arm64 Juno  [3] & [4]
-----------------
PERF_RECORD_* events & perf_sample fields: FAILED!
'import perf' in python: FAILED!
Number of exit events of a simple workload: FAILED!
Object code reading: FAILED!
LLVM search and compile subtest 1: FAILED!
Session topology: FAILED!
PERF_RECORD_*-events-&-perf_sample-fields FAILED!
'import-perf'-in-python FAILED!
Number-of-exit-events-of-a-simple-workload FAILED!
Object-code-reading FAILED!
LLVM-search-and-compile-subtest-1 FAILED!
Session-topology FAILED!

x86_64 [5] & [6]
-----------
PERF_RECORD_* events & perf_sample fields: FAILED!
'import perf' in python: FAILED!
LLVM search and compile subtest 1: FAILED!
Session topology: FAILED!
PERF_RECORD_*-events-&-perf_sample-fields FAILED!
'import-perf'-in-python FAILED!
LLVM-search-and-compile-subtest-1 FAILED!
Session-topology FAILED!



[1]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311723/suite/perf/tests/
[2]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311723/log

[3]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311746/suite/perf/tests/

[4]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311746/log

[5]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311665/suite/perf/tests/

[6]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311665/log
-- 
Linaro LKFT
https://lkft.linaro.org
