Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CF18652C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 07:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgCPGny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 02:43:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgCPGnx (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=V2Oh9I9sRzHiHuQuyd493WlQ6nb4CCI92/2hHbEbFmo=; b=epOdFQDCZdGZ5+GlrlV5SqkKPF
        7kb2wY1dyGr1AVZSmUgldgrA6l0S476BXHl+CxShWtYw9Ay5hQaoRsERK8QPiwjJ/Ymmdjwp2WxjG
        mBAG5ZDSCpJNUeGtCLMv13+Z2dJ//wNvZEu3v4IOZsN99HleXejDWAudh6SyaYcoTldjh5ftQjDP0
        SzOmZKvF1nW8VRoaOriIYiThGOCTPYl7D5tcHgyLpymYyLdJhRY6PmDY1eFCLgNzrL/ZD2A8mkrG6
        4G6ZOM3HZqyUNfHO1EPyoIxXrgr+bXGidZv/0qkskznmfXUm5Y0aSYtLFcvKnnXNkQHhuZb9grDtq
        FlJMKevQ==;
Received: from ip5f5ad4e9.dynamic.kabel-deutschland.de ([95.90.212.233] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDjTc-0005Pm-VS; Mon, 16 Mar 2020 06:43:53 +0000
Date:   Mon, 16 Mar 2020 07:43:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     A Smith <hiker31415@gmail.com>
Cc:     Linux-kernel@vger.kernel.org, Linux-media@vger.linux.org
Subject: Re: Build Problems Starting With 5.5.6
Message-ID: <20200316074343.719fd355@coco.lan>
In-Reply-To: <CAKp3MvRRZmDEr9to2=XkQHTNzhWV5AF0uvoLUwy+AB+bFsvMNA@mail.gmail.com>
References: <5e6ea8e9.1c69fb81.c5f42.834aSMTPIN_ADDED_MISSING@mx.google.com>
        <CAKp3MvRRZmDEr9to2=XkQHTNzhWV5AF0uvoLUwy+AB+bFsvMNA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 15 Mar 2020 17:21:18 -0500
A Smith <hiker31415@gmail.com> escreveu:

> Hi,
>  Building the 5.5.5 kernel works and boots, applying the 5.5.6 (and later)
> patches causes the build to fail when linking:
> 
>   LD      .tmp_vmlinux1
> ld: drivers/media/i2c/tvp5150.o: in function `tvp5150_probe':
> tvp5150.c:(.text+0x1096): undefined reference to `__devm_regmap_init_i2c'
> make[1]: *** [/usr/src/kernel/linux-5.5.y/Makefile:1078: vmlinux] Error 1
> make[1]: Leaving directory '/usr/src/kernel/x86_64'
> make: *** [Makefile:179: sub-make] Error 2
> 
> The patch below seems to fix it (no idea if it is the right thing to do or
> not).
> 
> Resulting kernel builds and runs.
> 
> Results of git bisect below the patch.
> 
> I can post my config if it is needed.

There is already a patch addressing it at the media devel tree (and at
Linux-next):

commit 6de18fa3bd1dd5114106abf6217587d6f6cb051d
Author: Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed Feb 26 15:34:05 2020 +0100

    media: Fix build failure due to missing select REGMAP_I2C
    
    While upgrading from 5.5.2 -> 5.5.6 I was surprised by:
    ld: drivers/media/i2c/tvp5150.o: in function `tvp5150_probe':
    tvp5150.c:(.text+0x11ac): undefined reference to
    `__devm_regmap_init_i2c'
    make: *** [Makefile:1078: vmlinux] Error 1
    
    The fix was quick enough, make VIDEO_TVP5150 select REGMAP_I2C
    And a quick grep showed that it was needed by more targets.
    
    Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
    Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I'll cherry-pick and send it with a c/c stable.

Regards,
Mauro

> 
> Thanks,
>    Art
> 
> --- /tmp/Kconfig        2020-03-12 18:58:13.062003610 -0500
> +++ drivers/media/i2c/Kconfig   2020-03-12 18:58:00.419003010 -0500
> @@ -379,6 +379,7 @@ config VIDEO_TVP5150
>         tristate "Texas Instruments TVP5150 video decoder"
>         depends on VIDEO_V4L2 && I2C
>         select V4L2_FWNODE
> +       select REGMAP_I2C
>         help
>           Support for the Texas Instruments TVP5150 video decoder.
> 
> 
> Bisecting: 196 revisions left to test after this (roughly 8 steps)
> [1f85ea289449d84b5411ea55a8325b5ae3dc7ec1] ALSA: sh: Fix unused variable
> warnings
> Bisecting: 97 revisions left to test after this (roughly 7 steps)
> [67f7a2e43fa3126d405ff61ea4457d5e01c79533] clk: qcom: Don't overwrite 'cfg'
> in clk_rcg2_dfs_populate_freq()
> Bisecting: 48 revisions left to test after this (roughly 6 steps)
> [1c70f45e24d2ff7bd12efd12fe0ab0a3d9081168] char/random: silence a lockdep
> splat with printk()
> Bisecting: 24 revisions left to test after this (roughly 5 steps)
> [175a45ac8168b06302ac81df4293da19a7a09754] pwm: omap-dmtimer: Simplify
> error handling
> Bisecting: 12 revisions left to test after this (roughly 4 steps)
> [75d10af05874e153575246681bc9e400f60e7be5] ath10k: Correct the DMA
> direction for management tx buffers
> Bisecting: 6 revisions left to test after this (roughly 3 steps)
> [0d0a95537fdb66a589109458d1385c0ac5308e9b] tracing: Simplify assignment
> parsing for hist triggers
> Bisecting: 2 revisions left to test after this (roughly 2 steps)
> [3c52259634a101c24146ed0c0d9473d0ebb859ef] selftests: settings: tests can
> be in subsubdirs
> Bisecting: 0 revisions left to test after this (roughly 1 step)
> [fc1be5273e93dc951d9e0e6590101a8f15a8f963] drm/amd/display: Retrain dongles
> when SINK_COUNT becomes non-zero
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [fe0ed403e082358eea51ad2a2a56f92896f4a1cf] rtc: i2c/spi: Avoid inclusion of
> REGMAP support when not needed
> fe0ed403e082358eea51ad2a2a56f92896f4a1cf is the first bad commit
> commit fe0ed403e082358eea51ad2a2a56f92896f4a1cf
> Author: Geert Uytterhoeven <geert@linux-m68k.org>
> Date:   Sun Jan 12 18:13:49 2020 +0100
> 
>     rtc: i2c/spi: Avoid inclusion of REGMAP support when not needed
> 
>     [ Upstream commit 34719de919af07682861cb0fa2bcf64da33ecf44 ]
> 
>     Merely enabling I2C and RTC selects REGMAP_I2C and REGMAP_SPI, even when
>     no driver needs it.  While the former can be moduler, the latter cannot,
>     and thus becomes built-in.
> 
>     Fix this by moving the select statements for REGMAP_I2C and REGMAP_SPI
>     from the RTC_I2C_AND_SPI helper to the individual drivers that depend on
>     it.
> 
>     Note that the comment for RTC_I2C_AND_SPI refers to SND_SOC_I2C_AND_SPI
>     for more information, but the latter does not select REGMAP_{I2C,SPI}
>     itself, and defers that to the individual drivers, too.
> 
>     Fixes: 080481f54ef62121 ("rtc: merge ds3232 and ds3234")
>     Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>     Reported-by: kbuild test robot <lkp@intel.com>
>     Reported-by: kbuild test robot <lkp@intel.com>
>     Link: https://lore.kernel.org/r/20200112171349.22268-1-geert@
> linux-m68k.org
>     Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> :040000 040000 7af0ef769382c4c3ecbeb3174e5e6ea90bd99025
> 0e71dd49a6f897dfa6771eb19c04c9148edc644d M      drivers



Thanks,
Mauro
