Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF41234C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfLQSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 13:25:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47096 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:25:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so12024163ljk.13;
        Tue, 17 Dec 2019 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jo3/k6HeLWByk3JzqbzlDt3Xg6ep2UUq9K6e/8xjHQg=;
        b=nuCpdps6sZn78SQU9DzoRiw3IkjpyX3fMC68SuUg1v8a4/ryJ7bFCfXkRH1s7Acdd7
         CnJ9S8UWiu5pXovzcoDEVWKANwWy4+QDo8DGKSMuAHP+t1i5A7Ky/u9lzXlq3tkV2Psc
         SJ0ptyxgT8lfa9ilAFG1ucc1muLf3QzTFrvVlUtPalcJSYToEB2jV+P7nfDAG/1p75Ug
         4RlvmQ4srs+k2wfj0AXgsPm8+bAbQY8gcO7NRwZ3x1sjJ5yTBw6LwHeyJ7zf2+RpxnCT
         234STMIOJNdnX1Nb5tW1QQMSg9Ve0mp+AXT+TqPUShwZS/mr5eic1Y18meRO9drwnmBU
         eM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jo3/k6HeLWByk3JzqbzlDt3Xg6ep2UUq9K6e/8xjHQg=;
        b=IDMVw/svVyYe/L6tQGa1SmLEvZP5LAsVfuZ3cN1pp4MUp6nQQbksmVT7bJHZJ97gdm
         88H/85nSZmVCed8TGwasXrHKQOq8EhPQ2D9yZN1fnVXKM0LjQCbyud0pyN3Ry+dWuoQV
         0dVRrZ5N6tnNQNcaeHvmnDPOAtINtaEgF//Fn+SEvoXjDHbRHT1MruqUquyliuv6VsBo
         Vu3mzp8tzPa+N8hDdwI9EqKgsnK7eTZrttHION1aSxt3wPHS5smIXEBvepic/zuPXjMp
         qGp5hBAaXpqHcmrBgT1oSNE43+F9iGoQ53Zg5Huvw3JZsyeHhqFM+um9sSq8VAxkmQO5
         Y9kQ==
X-Gm-Message-State: APjAAAVwtpwFSCHN5+tEWEHjd8QGVTYJcHLDdAXtGAhi1piutgLGCWr0
        hfE1U3Li20aQ4CW/kEGwpOTRYHpJfSEVBScdzUUMU0nn0kQ=
X-Google-Smtp-Source: APXvYqzW1YksSJ6QtiK3LM0rolkvX9vCpmJdwLz7NfDCGnoVddPs0R2yuhQXciocVIc/pbFL+gJfSbYSUFtAqLX4HOs=
X-Received: by 2002:a2e:b5ac:: with SMTP id f12mr4472796ljn.0.1576607110175;
 Tue, 17 Dec 2019 10:25:10 -0800 (PST)
MIME-Version: 1.0
References: <20191213153910.11235-1-aford173@gmail.com> <20191213153910.11235-3-aford173@gmail.com>
 <VI1PR0402MB3485AB1908AD6B6617CFC08C98500@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAHCN7xLrX0R7Uag2vc1qMp4z=1r3haCWrcp4qJT0H0eC3RiA4Q@mail.gmail.com>
In-Reply-To: <CAHCN7xLrX0R7Uag2vc1qMp4z=1r3haCWrcp4qJT0H0eC3RiA4Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Dec 2019 15:25:04 -0300
Message-ID: <CAOMZO5B_CCEf_cdAWs_FDC1c6t0RG1KjRjGidoDPmPmgxY=ebg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: defconfig: Enable CRYPTO_DEV_FSL_CAAM
To:     Adam Ford <aford173@gmail.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Dec 17, 2019 at 10:07 AM Adam Ford <aford173@gmail.com> wrote:

> Out of curiosity, what is the rule for when things are 'm' vs 'y'?
>
> In the Code Aurora repo, it is set to 'y' and the mainline kernel for
> the i.MX6/7, the imx_v6_v7_defconfig is also set to 'y' which is why I
> used 'y' here.
>
> I can do a V3 to address the other items you noted, but I want to
> understand the rules about the defconfig so I don't make the same
> mistake again.

In arch/arm64/configs/defconfig we try to select modules whenever possible.

The exceptions are drivers that are vital for boot such as PMIC,
pinctrl, clks, etc.

The CAAM driver does not fall into this category, so selecting it as
module is preferred here.

Thanks
