Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D772F7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfE3HJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:09:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37211 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfE3HJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:09:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so3077592wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=ypF/KA9Dic146WE/lXlqQwn2IzYwEkhGA3zkwEb1X2U=;
        b=DFy2fpqwoTUFgW2qOg07bSC2ixFFoft5m4+BSbp/H87lv4iICgp+a96NCg3OGa8QQs
         1CoYS/ZIA22TtxOAmmjsj0JzBeWu4hZzn2L5GWcPsYy3DHivE4mxrh47xif5Pvna0Z5e
         NbQSZWOo/5qrj9nQCamsZwicmicpNqiAt6K1+F/t9LmuhRxpbCbr/27YexJpPmipe7qB
         eTlqt+XgCU9diss+sfDfLEnsa7FbRopKm5FzdNFob11w7sCxBn4yVRGKZqD53QqseumC
         AZXCKkYZOw6w1k7e5vnExL3bdlNBPQDk+NMIuwCtxiW+/cMDZKh6zfAdyCYp1mGARKI1
         4CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=ypF/KA9Dic146WE/lXlqQwn2IzYwEkhGA3zkwEb1X2U=;
        b=fTXLoApDt//wpFKi5QtqUalIDmyPtv1P95FUOIeE6198OrqpHP/9wV6u+2IiPg2H6S
         5LPbl1m9jhlBjFWiyWAPZQZ3fvvoKYrz7PfgaGzSEDcyfh1OE0v8x1LBA1GCpo7oJws/
         QM0Q6ObIaguqAzMuHwOrMwT2Yz7nNABCruRJkI7mNa/Eysid5G/QwAn+VWrLuPkTNuu/
         u6/gO0bvOEYSZGaqj6fcsk1lFsZAbNbh6YcoIEKzqEyJlyPZSQEgmss/3q2O4FIos4uX
         OB3mdyf8VNrYObf3Y6jwDwyFFteD5Jt2hwqTlzb9F9bT3KzvHS3qg8ngR78TyiB+cCbj
         x5ig==
X-Gm-Message-State: APjAAAWZwLr5hYP+Wrii+n/e/uAaZB3/bdigrmoyPPu1hLvk2Ne4v9Nt
        iE2aKo7wHAREOyDA8/pTKmcgzMpkArAKXQ==
X-Google-Smtp-Source: APXvYqzzodbAAWfuewNL4CI+ghqNeMlF5k6WfDSCQe7720gxF8AVmauVoOtvs2XZU9/QVbZwnnq8AA==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr1194431wmz.171.1559200145818;
        Thu, 30 May 2019 00:09:05 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id q11sm1439616wmc.15.2019.05.30.00.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 00:09:05 -0700 (PDT)
Message-ID: <5cef8191.1c69fb81.72200.711f@mx.google.com>
Date:   Thu, 30 May 2019 00:09:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.1.y
X-Kernelci-Kernel: v5.1.5-406-ge151dd0525b9
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
Subject: Re: [PATCH 5.1 000/405] 5.1.6-stable review
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

stable-rc/linux-5.1.y boot: 125 boots: 1 failed, 122 passed with 2 untried/=
unknown (v5.1.5-406-ge151dd0525b9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-5.1.y/kernel/v5.1.5-406-ge151dd0525b9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y=
/kernel/v5.1.5-406-ge151dd0525b9/

Tree: stable-rc
Branch: linux-5.1.y
Git Describe: v5.1.5-406-ge151dd0525b9
Git Commit: e151dd0525b9aaeac84987d2790c30d8a89ae274
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Tested: 69 unique boards, 22 SoC families, 14 builds out of 209

Boot Failure Detected:

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm4708-smartrg-sr400ac: 1 failed lab

---
For more info write to <info@kernelci.org>
