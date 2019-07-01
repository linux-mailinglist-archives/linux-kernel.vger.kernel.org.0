Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD8E28E52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 02:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfEXA2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 20:28:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34944 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfEXA2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:28:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so7178024otk.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SWiyWthljNQ7VNEkCygmHboKWcT6XUx7JVipC05KjDg=;
        b=jucs7WVQ7kNR5atWWx0zasZyghet4ifmoRQmBhjgZs93FkeSnHZVPIGy3enbOpq7lZ
         AsaSz6vekWPQro3Y39NSS4yzHV288yhxN/cL0d+XHgH9sgrx06/A9Ao2mTSK6QXD+vYK
         DDAQV/l3lm3CRMlOtn219DYTi5yPTWGQdVVuM1BLydzguF5IGltamF4/E8tE2zgvQTQj
         J1wQcNZGAoBwjWvMRyLGb2oY9CfuJY8r3YWDPh4010BVKkpfyI+OjrJ2kIdrJ7AlI3+y
         x2m0IJFGocFqeqVVMogMoL5pehMYo1UYiS2O3tFT5VQ+rdnlzrI0zY+dLg8P6c4XZhrx
         RAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SWiyWthljNQ7VNEkCygmHboKWcT6XUx7JVipC05KjDg=;
        b=hrAciAkcCyDodvuY7TI4avOpH+lwIRXrTB6IkTYaK/uV1gKAUkcnMVXtU0WQxC6Mec
         ZIeE5OgCPZipSzr/Ywe7gzKcuNb6MLOPpKzO7TmdcUmqrWupEmaOQc1SkhRCO1ensi4g
         QBLSS+hs8WRhFdxw3Cre6QVZM3lAVdgvTp9vgIwczBy3k/x+SPjVKLZCwZ7bt3Ru+coF
         6XYy70cxI1X1ZTjKv201Pj+nOKdOoYutbw1vTyr7Dwweam6JKV8Jm9Pcfwv9JmzXb7HJ
         GiiUJSFukqDYXgB0j9SQVCFwnYfigpt29P/1vjtIY/JWbmK2XU2970WeSXsd8SfxYRov
         OFVg==
X-Gm-Message-State: APjAAAXWTtMD9XYdvcKlx5NZEWXf7JvYdRpWgcH0MeX1HH9YkaTQazbi
        NdqWG116PNaSwcOBOM4l1Ycr2zOJ4HJqrsKvuCqlaXQ=
X-Google-Smtp-Source: APXvYqzaOQp1P7QwyV69l1j5Q9ks6Ew10gliLAEEYuY1JAHcjc01+znLUPe1lJYMRL3MOAX4cIkoil1Lm2teqyIxXZ8=
X-Received: by 2002:a9d:ec5:: with SMTP id 63mr30426336otj.333.1558657711574;
 Thu, 23 May 2019 17:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190523181719.982121681@linuxfoundation.org>
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Fri, 24 May 2019 09:28:05 +0900
Message-ID: <CABMQnVK9pg8ZsZWYtc48TzVDnvYU7XSPj6FPOBGipayKfnmHSA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/77] 4.14.122-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>, linux@roeck-us.net,
        shuah@kernel.org, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2019=E5=B9=B45=E6=9C=8824=E6=97=A5(=E9=87=91) 4:11 Greg Kroah-Hartman <greg=
kh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 4.14.122 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat 25 May 2019 06:15:09 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.122-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.14.122-rc1
>

<snip>

>
> Yifeng Li <tomli@tomli.me>
>     fbdev: sm712fb: fix crashes and garbled display during DPMS modesetti=
ng
>

There is a problem in this commit, which is fixed in the following commit:
    9dc20113988b9a75ea6b3abd68dc45e2d73ccdab

commit 9dc20113988b9a75ea6b3abd68dc45e2d73ccdab
Author: Yifeng Li <tomli@tomli.me>
Date:   Tue Apr 2 17:14:10 2019 +0200

    fbdev: sm712fb: fix memory frequency by avoiding a switch/case fallthro=
ugh

    A fallthrough in switch/case was introduced in f627caf55b8e ("fbdev:
    sm712fb: fix crashes and garbled display during DPMS modesetting"),
    due to my copy-paste error, which would cause the memory clock frequenc=
y
    for SM720 to be programmed to SM712.

    Since it only reprograms the clock to a different frequency, it's only
    a benign issue without visible side-effect, so it also evaded Sudip
    Mukherjee's code review and regression tests. scripts/checkpatch.pl
    also failed to discover the issue, possibly due to nested switch
    statements.

    This issue was found by Stephen Rothwell by building linux-next with
    -Wimplicit-fallthrough.

    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Fixes: f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled
display during DPMS modesetting")
    Signed-off-by: Yifeng Li <tomli@tomli.me>
    Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
    Cc: Kees Cook <keescook@chromium.org>
    Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

And this is also necessary for other stable-rc tree.
Please apply this commit to 4.9.y, 4.14.y, 4.19.y, 5.0.y and 5.1.y.

Best regards,
  Nobuhiro

--
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
