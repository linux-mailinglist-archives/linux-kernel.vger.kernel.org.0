Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846A5F5CDA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 02:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfKIB5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 20:57:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36332 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfKIB5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:57:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so9071454wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 17:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=uVn2qkTljl+tTRkQyCgOVZ3dMV2RafY7lkEdIbVUGTM=;
        b=Qgf10WbIkEM/xHV5iRuiTZScuq9g/a64Sct14/6j+oWydq2mqwGZ31DKcJdoacJXxa
         cP/qfgfvCarIK2onx1Fp4953agNP4vG1Fcfk3Aa5uGTMVI2DOqTBO4zl7YCu/GIW6CjS
         /QSr4s8nnzPv1IoC46N3YgL/ijFoR0V+tmxTrc3Tb2/gUptaxR43RQQkMkKRH+Dfd1C6
         onT/WZW+kXwgpKfTFk5Jkud5vvMqVgPERy4CnxmIMCaR/Gh5ZoM6tNYoC5phTtR36Avc
         zsYSbvWViWWoN4YbpQwym9ukobb2sX4yealHesd6w1cd2xWeuIp1qyXEjZIbnRO3MQpT
         LaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=uVn2qkTljl+tTRkQyCgOVZ3dMV2RafY7lkEdIbVUGTM=;
        b=njhGZln3IlhzikcPYMC9DxeUY9Fkq9P0HZREeaaa0nG6AhN0tgpQh3QiwI/YbHws7Y
         TNKy7NAZcihce5E/A8GyM5ZR0cIRMbHjo4wimhqlaYIxVsZYu7YpLSMx3qzCCEIXFgaa
         AKBDmdE9guoF2ViRF+LtXWqwbTYYp/jt2qDGQXsI3vVS3JDubFxo1E5zTdmIEgZqP+Gm
         D2jZUokq1arJaqqibvjt6pDXM4jmWdpSbz95EAAle4q/sjKoY9P55ewNM2V6zqTJwJ2u
         7yct1ElAwM4RQ9tXjhHH6/u3G37pols0IGNkEz0Geii6RJYVFkphFjNMcV1IzmO9ai3s
         ziZQ==
X-Gm-Message-State: APjAAAVZKmtAICqszSSVZaM9x+WPSoX1Yh+4T9cY5qrObA1+VlFjj+PG
        KXENS2PsW64eZwY142zq68tcgg==
X-Google-Smtp-Source: APXvYqwcw4ZifV/oofafu6IRbacOTH+cEGSv0kN1zmRBGAirapoPWw/07jlUDOYgWvwTl4hI1RJjvw==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr11527422wrn.103.1573264672178;
        Fri, 08 Nov 2019 17:57:52 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id j66sm6835529wma.19.2019.11.08.17.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 17:57:51 -0800 (PST)
Message-ID: <5dc61d1f.1c69fb81.22380.3936@mx.google.com>
Date:   Fri, 08 Nov 2019 17:57:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.152-63-g2cfe0b7bdeef
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/62] 4.14.153-stable review
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

stable-rc/linux-4.14.y boot: 110 boots: 0 failed, 103 passed with 7 offline=
 (v4.14.152-63-g2cfe0b7bdeef)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.152-63-g2cfe0b7bdeef/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.152-63-g2cfe0b7bdeef/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.152-63-g2cfe0b7bdeef
Git Commit: 2cfe0b7bdeef09a0ffe2895928288ebca332b8be
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 61 unique boards, 21 SoC families, 13 builds out of 201

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
