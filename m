Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09E9A57BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfIBNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:36:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37052 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbfIBNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:36:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so14644283wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgluUPyzTE3k7AyBs9nIV6ho5+oXFx0a+s2dE+u1Fk8=;
        b=UlCl3abuuJFpLnHk0GD3eI2rM9n0Azzsrf1m9RwHiYwS5Exwkvc49cN6lZTg4HtDf7
         te3wGTJ/Q7Wy8QRj0FtydbX8PZLAfGrl8vo+++PDn7mkgS4TL0jgQ8+bXY/N6sFSQR3M
         x0K8Ptix0M+imYJ3mhqS5fJkHGT7j2yIVNZAkfhf0gYNF27aoG1kW2R+jzzT9GQG+BTU
         /vd3Ju6jWcKst2NaTlSZuIDgXKK13QwQqMJNF8Isx+KN9LAtfuCbQfAPBoEmmM5r8hsX
         uKBnW3Nmo8MVLpnhW97mSpcRSvhQ1UBMILml1T2Gdw/Kt2s825Bz4yoJXO3Nff6npHJR
         lCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgluUPyzTE3k7AyBs9nIV6ho5+oXFx0a+s2dE+u1Fk8=;
        b=g2KyAZ3APG6b0wLJPO30VoJSO0+zffjLXD6jmxFJsRh/RPffakWijfnoFn/JsUJqUn
         +PN8AdOtF7EDkrqfZxZIviP4i3zy53pM9nKjgIYqpuCi9ueRcuJeaCxJ+Kwms4yBStpc
         scABO6Ly4BdRLrxDVYGiRehYi5B80qBPNJfCRgBsGDZa0cE9dWp0dve/Vr3LrQaC+xsT
         cdCkWkI96iXud+6jjW1vNclVeQkNSGpnbSaxcr6E2J72A6TDppe3QAMys3hZg0nZU1Ur
         CswEQ+PtdGuyVpXgTo0QAAWEkY4jCtF4aRldnwV069rYQ6NTFYbIcvInHehyNi1Wz1w5
         JE7w==
X-Gm-Message-State: APjAAAVe7gcguAi19VeVTK9bPHb6xW+cAqjoqFCi192A3Pca7vYkJuRf
        k9Ls8MCMnRbxj5Du1psps7EUx5wAxoQeJw4r6TOcDX3h
X-Google-Smtp-Source: APXvYqxXTnz3j1+58ZXipucuYWcIzBAoeW6774ATixJZMau34AMCKmrFZUDfhSF4cmAZHiIFE4a5YsMhxy4Bn6/LgVQ=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr9324398wma.171.1567431367725;
 Mon, 02 Sep 2019 06:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190830225514.5283-1-daniel.baluta@nxp.com> <20190902123944.GB5819@sirena.co.uk>
In-Reply-To: <20190902123944.GB5819@sirena.co.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 2 Sep 2019 16:35:56 +0300
Message-ID: <CAEnQRZDmVoSkpf47mTHeEKodX9_x4Y_9EVrkS=ta4sWU8tD3Zw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 3:42 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Aug 31, 2019 at 01:55:14AM +0300, Daniel Baluta wrote:
>
> > Fix this by setting CHMOD to Output Mode so that pins will output zero
> > when slots are masked or channels are disabled.
>
> This patch seems to do this unconditionally.  This is fine for
> configurations where the SoC is the only thing driving the bus but will
> mean that for TDM configurations where something else also drives some
> of the slots we'll end up with both devices driving simultaneously.  The
> safest thing would be to set this only if TDM isn't configured.

I thought that the SAI IP is the single owner of the audio data lines,
so even in TDM
mode SAI IP (which is inside SoC) is the only one adding data on the bus.

Now, you say that there could be two devices driving some of he masked
slots right?
I'm not sure how to really figure out that SAI is running in TDM mode.

RM says:

When enabled, the SAI continuously transmits and/or receives frames of
data. Each
frame consists of a fixed number of words and each word consists of a
fixed number of
bits. Within each frame, any given word can be masked causing the
receiver to ignore
that word and the transmitter to tri-state for the duration of that word.

Will try to ask IP designer about this, thanks a lot for your comment!

Daniel.
