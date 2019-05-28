Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C129C2BFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 09:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfE1HK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 03:10:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44028 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1HK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:10:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so26812066edb.10;
        Tue, 28 May 2019 00:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sh90EuYxrh193Q7HMx34uXLBv/PVyFJE/lBow6rEA4k=;
        b=mvV7ZF8uWhYgBjffMM77I5Ql0OvSQtEllUykBqYO1LqPUptUBQ4Clj555ljFp5HxVB
         tBckbCbOVOLWEI507jR5cxLEYPcv/ryx77EQ82dXt2UJgPSyJ4DIYHQxIe2n5IfLP4F1
         zwXLmW47ZFSuqV5IbKxsIGoUh95Y4ol8HmxTUegtt+E0uYC4T9yp8jWlpqgfLBY8hc6M
         W7mDI5P+EBlppPHhvwyAF71G1KPnEW8JSczuerHrAPmaGNxqSQPQVVs6tEN+O3J6nZMG
         MJ9hP6X7ANVuNFMa4njp86xSk5DWoatQd5Hi86TEx/W2JcB3nUMBy9qb+IIujHqVuZzg
         26BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sh90EuYxrh193Q7HMx34uXLBv/PVyFJE/lBow6rEA4k=;
        b=ll9cupvjDuIrPArMzApTcZzpAYvXOA0z35fTNP6t8osXcP5CPPAwDqqgD89U7BFB7t
         aBTuyKPPPwB/ktOOgnge8BJT2FL2yftArrWq2KOuvwo0rk/r/n+rBo4ZJvAQ+cAT8Yyf
         vGelISF1Bvmri8yZ4rW8TIJXy6mvBNEqIpc60YlCbSG5HKSQOfuU/dBf0PGGzBIVewHq
         6CAYUCvRtZXn/Puchl0qNbk4mrrFFPsLnnT6659hTPDsnGaUT4QzmM2bH5q3JRo3QTS9
         LVwQmgfoIuiGXrmAO8mf/xVLH20mfJy2w5nkX17av8VTzjimz3z8HSKUoQPvtU4AS9Tm
         ETDA==
X-Gm-Message-State: APjAAAUrZH2qkyLlDgGjlULpOP5CBL33eEQnlt1auDpErfqmKqN56Twa
        4vYjTDc/EAB2XYqYisHnLedvOM5Uq8kZsnKPW+4=
X-Google-Smtp-Source: APXvYqxNBlLhlVAOzGwcr+/jjrcH1xjzXnuJsY4nwozQ6IgG1ptIELlUIhMGBLO4K8gY4sqaP7ZTZpxsWKMvSqs+/sg=
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr48087986eds.238.1559027454465;
 Tue, 28 May 2019 00:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-3-daniel.baluta@nxp.com>
 <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com> <CAOMZO5BTqwnun6d7G1vcHUu_Rs+xfvgxTzamWnBPy76W7eeF_A@mail.gmail.com>
In-Reply-To: <CAOMZO5BTqwnun6d7G1vcHUu_Rs+xfvgxTzamWnBPy76W7eeF_A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 28 May 2019 10:10:43 +0300
Message-ID: <CAEnQRZD98TKduVLshGrBANRB6NT7Se6CXD0cgd5XRYa6grAo4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:33 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Thu, May 16, 2019 at 3:35 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > > +               simple-audio-card,codec {
> > > +                       sound-dai = <&wm8524>;
> > > +                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> >
> > IMX8MM_CLK_SAI3_ROOT is the internal clock that drives the SAI3
> > interface, not an external clock that feeds the codec.
> >
> > It seems you should remove this 'clocks' entry.
>
> Just checked the schematics and the SAI3_MCLK pin clocks the codec, so
> the representation is correct:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Shawn,

Can you have a look?
