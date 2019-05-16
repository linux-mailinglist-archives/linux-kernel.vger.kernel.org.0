Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1175D204EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 13:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfEPLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 07:37:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37583 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:37:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id h19so2796136ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXUeXWtueI/SRp2XGDGI4tujyZJgGWV3Vx6BdAbE6Tw=;
        b=GAB2TBybwnrbbzz5U5edahybkOdVxbKuvBTTOpS77XmomE3UDRw4K6CZe10rKBfmR8
         xz/yUaXuq41PR6WRwc+6ZtJ3UPU0POOUybLoNNa/74XANRIjpuuEAlTJ9l46jk9kErpj
         2+YfBHk1klTbBCtw+pGROHC3P9nfbhaKLA+ZP+lt5mtkg7fVJ73s7iGCK0EqH6podywm
         BSm8S2XF5eRoBbBmNoBF+fvGBeJLU9fV95sicaz7a86J+o332NpDNl4QMSlQ2+O568Ed
         p8KEe8qJgf2EBzSVIxAS8/P+zdlZUMYs5hMepoHfgtVKphlNL1aNcp9j1dg0TxX4Orn2
         1rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXUeXWtueI/SRp2XGDGI4tujyZJgGWV3Vx6BdAbE6Tw=;
        b=Nk6ti6fQQ6ImvIOM79AAUxsMLWxcDJz0jaODVPFp/2xkWbL8kJ2zTQcu7S3OhQs+fb
         M/obu+6AhCy9f7XCtu7YjT5Z9LSMPVUztf2PWn9qzG+HmXWND1YmNgfVB12ALTDaor/B
         +JQC4OxmBVHW3pSS8nuh/QJdCCDl4spxFK4mrIdz3iSi6QpvIgwRY5j/uKqZpG6WoUGS
         3r4tFR7HsoDJKBh2TCDc+hSP93zPANVYVYYQXWd+dTi0VSkcs1aqAukzmS1XevR2NBni
         4psqz0CKyD2M2SP3Hg1zX4UTUmMDei2hoIjFvr/w2fi8/6apO7uOOsC9F8xu1n49yRh7
         i2JQ==
X-Gm-Message-State: APjAAAURCj562a3LZaKUdTFPM4bSl1or2bxbAdi86BR0Vwj+PbC7g4pR
        qosKMsnfYABzmuPVcjoVBEKOlDfIwHgzosXq75M=
X-Google-Smtp-Source: APXvYqy4pZiMsXLPP+8UUC1PaKtH+ASVj8jh2pfOHOV5iIG7bDaF2KsjBwAoumu9NlWyONEjLzip8qU2dkymVwrFzYA=
X-Received: by 2002:a2e:2b81:: with SMTP id r1mr22051601ljr.138.1558006657987;
 Thu, 16 May 2019 04:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <7df2d60911f6c4323c9d11b5fe5341ee31e3940c.1558006342.git.shengjiu.wang@nxp.com>
In-Reply-To: <7df2d60911f6c4323c9d11b5fe5341ee31e3940c.1558006342.git.shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 08:37:27 -0300
Message-ID: <CAOMZO5DhbsCqO4ePKRXm=s=5Vf6rhBJgfeXKUe1w+_RRV5YWQg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4] ASoC: cs42xx8: add reset-gpios in binding document
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 8:36 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:

>  cs42888: codec@48 {
> @@ -25,4 +30,5 @@ cs42888: codec@48 {
>         VD-supply = <&reg_audio>;
>         VLS-supply = <&reg_audio>;
>         VLC-supply = <&reg_audio>;
> +       reset-gpios = <&pca9557_b 1 1>;

 reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;  please
