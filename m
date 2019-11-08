Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790B1F5C14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 00:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKHX5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 18:57:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35089 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHX5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:57:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so7906137wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 15:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=8H3+XZQf7y0EzQqLefOV5zH9jSqy7tXDApOEueZQ9Xw=;
        b=WUR2587OERk2LPUvokhL/JNyHu0O8xvF60agK21DIer1gev24q1RIuxfo6ktrHNgxf
         EFln9l4XiEjX7DSMc4ORMDxFkKMSRITUpobwThCtFhfCvwQZ/WJhGi3oXiGW7YBUpfvI
         ie5P3xlTbHd1kxnIkKlaQ4pyDeiLowJ1OPZ91keEmFWZhNPGZQSPPKyJH3Z4GJ0tW+1T
         vKNWvgov0ena9kP5SLj+bWc2WKL81/W9lCCu+d+Yhbhg5plj2P1b5AMAJrykmhWtMGmK
         lNxLvZYR/gTFX4d4Em3R48tHCvXmn6VhgA8DdHA/TtHOK5iUp1kukElinVr/++uSMRBI
         OwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=8H3+XZQf7y0EzQqLefOV5zH9jSqy7tXDApOEueZQ9Xw=;
        b=QIfC7P2EpY77D2d63nJPvX2KPqWG/EXYu5M2W7MbjsdpPKQAZL83e6BAKp2b9KzJLJ
         +7dUkOpszMwK7l/VMYN8sxa0bQW4SRtS3l8MX8noiuaIbNPtk776FsG4KThvRsBl8oLf
         gXQ+41TD3W7zpZD5MgKuDOGs6KjXvkqiykRki7pYoVNl6ETwLIHW0J/m0W55uBOCmYEx
         lBwED/HdT5/MRgbHZNefVt7LDthVy+QZiW4yIhcfIegGBtXM9Zl+PDZhDVjdUHS7WZWe
         Aq5I4IAglQFbc+QYldy8ydRhQyzGveQBzUxAQ3pmJiTE+zuIH8D54B1zY0vrHa2QV4KI
         SzOQ==
X-Gm-Message-State: APjAAAWERWmRsJ58rGozKCVN5jM8IhRRFyniCvFBLyYrpNHChdhH6t2L
        DT1t7yJnpx/R3od7F3iaPWqkStCpoQ+8og==
X-Google-Smtp-Source: APXvYqw7BPZisKgcS2rzIeuzG0D8XKnJ9LC6hN9aZ9yYUrFHgYaO1QTETK+YJkMgWSr/RmcofNTc6g==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr11182468wmt.112.1573257471606;
        Fri, 08 Nov 2019 15:57:51 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u2sm6596358wrg.52.2019.11.08.15.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 15:57:51 -0800 (PST)
Message-ID: <5dc600ff.1c69fb81.8f91b.fea1@mx.google.com>
Date:   Fri, 08 Nov 2019 15:57:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.19.82-80-gb56f5a59d51a
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
Subject: Re: [PATCH 4.19 00/79] 4.19.83-stable review
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

stable-rc/linux-4.19.y boot: 116 boots: 0 failed, 109 passed with 7 offline=
 (v4.19.82-80-gb56f5a59d51a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.19.y/kernel/v4.19.82-80-gb56f5a59d51a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.82-80-gb56f5a59d51a/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.82-80-gb56f5a59d51a
Git Commit: b56f5a59d51ac99b2c9af3df39a0a7a573053bcc
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 68 unique boards, 22 SoC families, 14 builds out of 206

Offline Platforms:

arm:

    sunxi_defconfig:
        gcc-8
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    multi_v7_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab
            sun5i-r8-chip: 1 offline lab
            sun7i-a20-bananapi: 1 offline lab

    davinci_all_defconfig:
        gcc-8
            dm365evm,legacy: 1 offline lab

    qcom_defconfig:
        gcc-8
            qcom-apq8064-cm-qs600: 1 offline lab

---
For more info write to <info@kernelci.org>
