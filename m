Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD6337D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFCS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:28:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:28:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so8738928pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=H2KnmQlRLCh5oos58tvSfHMS/oTy7vw/weDNkzQ9mXw=;
        b=Osy9dyJU8mdbqfn/ryTBYyAnuCi6ddWgc13JdPVa61y5Mybc50GsPEf2EtnfwsORrX
         r+odil30tLtdjFnlTTgYnmlG2pjYqNngRqiNjD/4HsiQmPhqdUCRMSmLDEWcUdMLp2Gm
         X2bR5uMN3LaGiz3uIGesI2PMeSIKnwJX0dtgIENMpbozWXhKIjVKdEVHWqO6vXKbvMh4
         snnH5m6kkQ+Ipp41Yz5yIXWKfS4p6KoFJtvPIZbXW0ZEn0tzQtUkUD5UQG8Wn/Mh5Ef1
         letYrDo0dPUMie4oVzcjwJwU6v9kg2MFmkzTJOBVqMor2RLWm28f0ICk22PxeuNcvjdH
         +AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=H2KnmQlRLCh5oos58tvSfHMS/oTy7vw/weDNkzQ9mXw=;
        b=mh2G3EWXkIkcFMKvQgIxaKSph0j20q5dr7x/K5EqZ9m+hInu7OIi7WBZkafl4/SYfh
         nWQ3ePstUc3TjL3/5VSDL2PMQ9ZBBJQ8noI0fEy4Guck7ZnwZ4E6mvmyCPyLnXNuWo8u
         03kx10ty7u/QraxgCCM6rdxG35AuHEGemfnxmBpkLF/Xlrd5RQFVOJ4DROCh8HWtk3CH
         l/aSuCtwTGf6KPLpxuJrWnhQUGOfLouJdW/SIATiOj7xcdIPDgHdodui9FLovMWZmMMS
         QE0zU9gl2BtG47+WSgtPydeK7ABZ3ibcQTAE2r/58aiakimXjMkKWHYWgLeG1CK+zjvT
         fypQ==
X-Gm-Message-State: APjAAAU/gcjcuLPecfW1xwJsMK/G1e3Hd1MixfxG1q1DbB2zjBfd+nI2
        MlfY+01G2gpgMd3SR2w0RTb/Iw==
X-Google-Smtp-Source: APXvYqxc+sUBtBlkORTYGFxV2li2uxx7HGoc6f+neIPlW/4tH9Sa9FrWSa0kVEmT7JKTnxiDBuojsg==
X-Received: by 2002:a65:62cc:: with SMTP id m12mr30152306pgv.237.1559586505034;
        Mon, 03 Jun 2019 11:28:25 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id z3sm418119pjn.16.2019.06.03.11.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 11:28:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.1 00/40] 5.1.7-stable review
In-Reply-To: <5cf53378.1c69fb81.9dd1b.494b@mx.google.com>
References: <20190603090522.617635820@linuxfoundation.org> <5cf53378.1c69fb81.9dd1b.494b@mx.google.com>
Date:   Mon, 03 Jun 2019 11:28:23 -0700
Message-ID: <7hmuiyjzg8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kernelci.org bot" <bot@kernelci.org> writes:

> stable-rc/linux-5.1.y boot: 132 boots: 1 failed, 131 passed (v5.1.6-41-ge674455b9242)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-5.1.y/kernel/v5.1.6-41-ge674455b9242/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.1.y/kernel/v5.1.6-41-ge674455b9242/
>
> Tree: stable-rc
> Branch: linux-5.1.y
> Git Describe: v5.1.6-41-ge674455b9242
> Git Commit: e674455b924207b06e6527d961a4b617cf13e7a9
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 73 unique boards, 23 SoC families, 14 builds out of 209
>
> Boot Failure Detected:
>
> arm:
>     multi_v7_defconfig:
>         gcc-8:
>             bcm4708-smartrg-sr400ac: 1 failed lab

FYI, this one has been fixed and marked with Fixes tag[1], but it
appears the patch hasn't yet landed in mainline.

Kevin

[1] https://lore.kernel.org/lkml/20190509171527.2331-1-f.fainelli@gmail.com/
