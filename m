Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA641B9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfEMPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 11:14:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33750 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfEMPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:14:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so18103557edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=b3ZsxbY91h2byIdigyViRztW48WAaM07J61Fsufp2zg=;
        b=Ytf5rDGs1k8Tv4JCFwOIHXj93yat5az5zLREOibB9Io7ACItmsO2sG1iDQpG8Qa9I1
         zSDszGlTwMs7OT8u2Y6VhPYJ5IcwuPJfsKri52BI1GSq3l5D4Sp15bYGVRl2/wVArCTL
         na9u1qZRUsjLMa5jtO89frg3gLnKi5Hwt+lBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=b3ZsxbY91h2byIdigyViRztW48WAaM07J61Fsufp2zg=;
        b=sAeyifUM+3pAZPZgkAlAOf8J4sjcSyjAnqOQlvGxt+RYYh0LBOQRtYxOxJZTwT+eaV
         6tJlfedPyLTdDM1ulG5u9/eDxLj/iU3whrqJ2cLqXkClFGSGmRyFmAMUTlWsW0S4iLrG
         IT3+1eKLSSj/ZluELkQhZ2+kvj599QLUqoNUg/X0fDSfL5WJy4dHOwQFjrHN9e4WR+9m
         ZD2m9HJ7jpccmv86bRL2LE4reitnN3S35VCn/NS9q6UhpcffE/uB1jhuujSItkiUVgwU
         foyApLY2cwJL6oPyDK1y3f9Ic5hSpEgUUilxn/Pb7laDbJz6TfYUD+KxRYHiw38f6Hv0
         HjKA==
X-Gm-Message-State: APjAAAWFpSnPJO7rsusn7GzaHgUiudBYEitbfrJuvnCsXQw5FA/aWJ0q
        TnFgj+k0t0VbFie4XDLCH9s8wg==
X-Google-Smtp-Source: APXvYqz90G91DTeR9OP/EpXrfldPUD2lfY202QZGhScBhFkopAxaDjX2LA1QA1yYZgJhko7DSYIOJg==
X-Received: by 2002:a17:906:4244:: with SMTP id r4mr8073761ejl.211.1557760449369;
        Mon, 13 May 2019 08:14:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gt16sm909611ejb.60.2019.05.13.08.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:14:08 -0700 (PDT)
Date:   Mon, 13 May 2019 17:14:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     peron.clem@gmail.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
Message-ID: <20190513151405.GW17751@phenom.ffwll.local>
Mail-Followup-To: peron.clem@gmail.com, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
References: <20190512174608.10083-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote:
> From: Clément Péron <peron.clem@gmail.com>
> 
> Hi,
> 
> The Allwinner H6 has a Mali-T720 MP2. The drivers are
> out-of-tree so this series only introduce the dt-bindings.

We do have an in-tree midgard driver now (since 5.2). Does this stuff work
together with your dt changes here?
-Daniel

> The first patch is from Neil Amstrong and has been already
> merged in linux-amlogic. It is required for this series.
> 
> The second patch is from Icenowy Zheng where I changed the
> order has required by Rob Herring.
> See: https://patchwork.kernel.org/patch/10699829/
> 
> Thanks,
> Clément
> 
> Changes in v4:
>  - Add Rob Herring reviewed-by tag
>  - Resent with correct Maintainers
> 
> Changes in v3 (Thanks to Maxime Ripard):
>  - Reauthor Icenowy for her patch
> 
> Changes in v2 (Thanks to Maxime Ripard):
>  - Drop GPU OPP Table
>  - Add clocks and clock-names in required
> 
> Clément Péron (6):
>   dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
>   arm64: dts: allwinner: Add ARM Mali GPU node for H6
>   arm64: dts: allwinner: Add mali GPU supply for Pine H64
>   arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
>   arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
>   arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
> 
> Icenowy Zheng (1):
>   dt-bindings: gpu: add bus clock for Mali Midgard GPUs
> 
> Neil Armstrong (1):
>   dt-bindings: gpu: mali-midgard: Add resets property
> 
>  .../bindings/gpu/arm,mali-midgard.txt         | 27 +++++++++++++++++++
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
>  6 files changed, 61 insertions(+)
> 
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
