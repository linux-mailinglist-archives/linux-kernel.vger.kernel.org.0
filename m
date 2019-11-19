Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC71023CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfKSMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 07:02:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKSMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:02:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so10695760wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 04:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=0DNtwBvozh9fqGSsAXWPMP3mT78xGFgP7ic/0T1B4Rk=;
        b=WJlmMsQ+fQu5l3fJSfoQ8lUkg2QHxDrmSgaP6iO4qn6+X+x98Xx7wLd6L0sM8xLMXC
         iqttXxJs9LBJlUM6i1jVl5KPBCBzVjWAglnzXBW8oPkqsD/SWkhTUUZUwB20immV1bmG
         4fAuT7I8+jGRpJCQJaXy1vrqZVG8cWny+IGZaqbIn2hWF/1uOoyn7M7MosxAV+qFyzYl
         kSFpF0bgrdAShfwz2dOkkeB7NyJg8GwJ1WzLwZoiHRgk2RIwF4RYLGwSfRr5M3muAuFZ
         eDvB3Bnosa7hofff3H4GbqOZ9uSL6D2CSgniJS19aNQMuHQSh7ApFDGPj9zS5U21tTZL
         XyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=0DNtwBvozh9fqGSsAXWPMP3mT78xGFgP7ic/0T1B4Rk=;
        b=bjld8x09v6itxycBwjxZy42RCtunEROz3hoXvBXL80uRBqB79iM8P8CYo1UqlIYD38
         CDAFez70qtsCByBIYXaXAId0lB+NP0KQQhI/9IhjN+dRf0CtyJl6XM8hj5eebEIqzK3k
         gEJi5w++F5FxPT5eb3GTOAJTMm/aziYVTB/NLxEPCGJi040avTzPygiMO51ZkSgfs/Sw
         Ero8qzkte85uCMjVXmCDJwjXAPvvDTZ+2Lz3zOT7iehh8/A1/uWGvyBrYF/AqYDixO63
         +aU7vkF2NKDCPNxiM2BKMUn5+mhnnvrA6u61s5QcivUVMJ0lJ8iJhccGiLJzXH4d+UP5
         IiQw==
X-Gm-Message-State: APjAAAVgwcL6vl2k134GQWuzq6rO6wO7U2u2Lfi+4A3pFGNjrAYnqDqm
        e0Fo30RkxL3grSJ2fI4T1oVPMg==
X-Google-Smtp-Source: APXvYqz0D8b2XZRzO5SG5UHZfNyYilwiJlRBZ+LqFlImYbyTc2V3JBhh4YJx8CVkHpk6L9Jge/tAgw==
X-Received: by 2002:adf:d091:: with SMTP id y17mr38319573wrh.182.1574164929677;
        Tue, 19 Nov 2019 04:02:09 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c9sm2798419wmb.42.2019.11.19.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 04:02:08 -0800 (PST)
Message-ID: <5dd3d9c0.1c69fb81.9978d.cff1@mx.google.com>
Date:   Tue, 19 Nov 2019 04:02:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.84-423-g1fd0ac6484bb
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
Subject: Re: [PATCH 4.19 000/422] 4.19.85-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-4.19.y boot: 67 boots: 1 failed, 60 passed with 6 offline (=
v4.19.84-423-g1fd0ac6484bb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.84-423-g1fd0ac6484bb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.84-423-g1fd0ac6484bb/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.84-423-g1fd0ac6484bb
Git Commit: 1fd0ac6484bbc5a0a4e64547a3a27a510d647fc1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 59 unique boards, 17 SoC families, 15 builds out of 206

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        gcc-8:
          bcm2835-rpi-b:
              lab-baylibre-seattle: new failure (last pass: v4.19.84)

    exynos_defconfig:
        gcc-8:
          exynos5422-odroidxu3:
              lab-baylibre: new failure (last pass: v4.19.84)

Boot Failure Detected:

arm:
    exynos_defconfig:
        gcc-8:
            exynos5422-odroidxu3: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        gcc-8
            juno-r2: 1 offline lab
            mt7622-rfb1: 1 offline lab

arm:

    bcm2835_defconfig:
        gcc-8
            bcm2835-rpi-b: 1 offline lab

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            alpine-db: 1 offline lab

---
For more info write to <info@kernelci.org>
