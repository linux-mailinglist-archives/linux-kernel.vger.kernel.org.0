Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F056423100
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbfETKMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 06:12:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbfETKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so23035964edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKUbJ0nabf5vjDTsZYVumfuv6WeQYwIojeh97gWQ6LA=;
        b=s43tscla1tL8ZmD94TMbqT1HEzH9UUlFei9PT+lVu9MUmicIGUTGQJuavn43c4D01P
         N8v3nn2vT2XJyOjienaQOQu33+r7ZTOtgqucC6dtMZ8zYZ1uTT+k9YexHVpQY3wsdCyb
         +0caQnpaFeD30QGbaNp0U3SRdQSNNATPtNLDDNp9eYM9/7UhJ13hQWtkxUwpWvjgolbd
         9TK5XT8VE/6Aq2e2TTVymhaaspAbSnkC3RR/qYioHZZpNW6tGyq7AJji7WwKtW5PTDjF
         nzWdyqJAuwEPB4egAIencJq9qiY1QrZ6mbnm0Vp1EV1nfAeYPQCvXhMqNTVjHkXOYm5C
         Z4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKUbJ0nabf5vjDTsZYVumfuv6WeQYwIojeh97gWQ6LA=;
        b=i6xdtFRPAD8/TbxfF1UadlbMvNZ9nAUqnCRwU7Jbxqe4FVhkPw/TNHtV8S1e/7dw9r
         c3Tuo9aDe5xcx8rqkBy3RUenZZgOQAxZ3/FG86mAYDYq7bthVDtInwBmJj8m8l1KeOdx
         oUaqX2XlZzPqzNCldRWXGmRrPY/K+QyA2Y/OOqrgHfBea3Jo5KfLKGe7JAAUBjoeqzPc
         4MzSE6TAtH0IDiRH8XnJoIpgj1bR+2FMBL912Loe2qLHBdMhoHNvUsqK2IhH2P+wLWdX
         eAM/VP887sTF2KaX6WJ4eukzdftrWmecERjxMFnTTQI41Mm9OrouYYz0jsWyC3yxUH0h
         5lmQ==
X-Gm-Message-State: APjAAAU7DXNMjpg0kgcx2nmwPNUvjPBNiYdtsHwD7YHCxI0pOOAnV0HZ
        Fyl0c2hb6cXSeHoWU6OjVyOjrwLKCNOOzwudO5w=
X-Google-Smtp-Source: APXvYqx7MCl4STII4WM93luGOKwI3FDlJ5quO8LBfPNmsCfXkzNaPqn+Wez30dy68zP+xy9vW27uk364dUPjzXxx3xI=
X-Received: by 2002:a17:906:1611:: with SMTP id m17mr6704440ejd.13.1558347153764;
 Mon, 20 May 2019 03:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-3-daniel.baluta@nxp.com>
 <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com>
In-Reply-To: <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 20 May 2019 13:12:22 +0300
Message-ID: <CAEnQRZDazHW173hzERz+RiOAsiRQNVNOQihz8Lz=+Bp5cZzgpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<reduce audience to linux-imx>

Shengjiu,

Can you help me with this? Specifically: I couldn't find the schematic
showing the
exact connection pins between SAI and wm8524 codec.

I looked into our internal tree and the wm8524 codec always handles
CLK_SAIX_ROOT
but Fabio has a good point. This clock doesn't feeds the codec.

Unless, we can really look into the schematics and prove it otherwise.

On Thu, May 16, 2019 at 10:14 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> > +               simple-audio-card,codec {
> > +                       sound-dai = <&wm8524>;
> > +                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>
> IMX8MM_CLK_SAI3_ROOT is the internal clock that drives the SAI3
> interface, not an external clock that feeds the codec.
>
> It seems you should remove this 'clocks' entry.
