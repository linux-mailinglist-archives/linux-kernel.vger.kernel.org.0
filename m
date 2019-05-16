Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF520458
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 13:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEPLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 07:16:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39935 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:16:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id f1so2318056lfl.6;
        Thu, 16 May 2019 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDfFPtrlnpqwUaUdqz5weQzlWggy+CkkkVDF2uvXW4I=;
        b=DuWdqyRah9rmU/k+o+K3d48/HAPTJkJgxRZ9XDa/YklYAsImS6XeUWpKtBMh5d0yH2
         YtdXAJjyue3cL1GW50nKH4D6WdwKZm+TBozHUNdP65lAaCMP/v4NB7nVtOYBEzH8fI6w
         dOSQ+81XOJqpSKGlDxjWZ9pRRwz2o8fC8p3JFVSUfyBgzC70UJypNP9Fa1P7+4PqsbvH
         9onkSJMVaEkSI77q8c1kmRtI/2zND9D4uG2ky5FO/o93vyyuLogJFjqzmEYYv6fRMpVt
         9d0hAh+utAmkiuJruuegMV1EaTp5h9JCt1AXSoilT5TlHSbIxJ75EJpT0bRy1tPeynil
         UDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDfFPtrlnpqwUaUdqz5weQzlWggy+CkkkVDF2uvXW4I=;
        b=DmHfBFnvjajGf9k+hoSAziTfHqGY/OP1scoAEDFEtkh8HUrAQCzhOEPZZZI60Q2DKy
         rCAM3Lz9AO39dmF4Ilat0rA6gmhuxaVJ95HprptPFNcW8/CNur4RjDCTzeZt7LtS0aIo
         FRno5XcdSqRjnlAlqbaqIos6YesXKQYKAx+JvVXmWtxo2M/1aP+3TW9qweXoWEYXn46Y
         wMDWhj/4d7p+INfRlp/78dzbCpHTTnSRxJuy0NnlgfBQGONY665IwF1qgnaxdMTa6wNo
         jcfJbHiSy9oiD3SMf3mmdzyrn62OCRD9xipPAQ9ee5DJelwzirIHLEHviYSFH7LrTIGr
         rV2w==
X-Gm-Message-State: APjAAAW/MTUPwXtYqUOkz02KG998TRstpwEAkHi8jC1PcwRoUotJD/Uh
        UTGBWrcEp2NUsmtfsV26eSx0GLcfX6vddpq14gg=
X-Google-Smtp-Source: APXvYqyAM7BbkaCaY4ubFbArKWx+xD3PbuXTEr4PfJLpk2m6wXskcVUzBXF+93mlhWBRgGZbJcXpkKdyke+2PldSGHU=
X-Received: by 2002:a19:c746:: with SMTP id x67mr23211530lff.152.1558005359664;
 Thu, 16 May 2019 04:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190516092157.29017-1-peng.fan@nxp.com>
In-Reply-To: <20190516092157.29017-1-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 08:15:49 -0300
Message-ID: <CAOMZO5CoqOUkvoHUNk1snPEwFG=v4Wpa6R0z3szBauHt=JJJ+g@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx8mm: fix int pll clk gate
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, May 16, 2019 at 6:08 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> To Frac pll, the gate shift is 13, however to Int PLL the gate shift
> is 11.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Please add a Fixes tag and Cc stable.

Thanks
