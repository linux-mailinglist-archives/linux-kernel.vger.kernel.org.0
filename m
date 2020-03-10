Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43471180904
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCJUTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 16:19:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33995 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJUTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:19:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id g6so15317002oiy.1;
        Tue, 10 Mar 2020 13:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AFq1DdnvEPEiWUIBZ8XMuzd1FRD5fPx8e3pkYB6x7lA=;
        b=eEZi5xsYYS+MEVVRmuKMdsQ9PSWiLL57+1rihYjAyQX5TAZN0jEHTaTPfMNEngdvvK
         Z7qa6hqGBharr+zUBjBXpaOHfCbqv7dBMj0W+RKTaJzMYhLA6YbAizJ/G4bl3JT49NTJ
         o1pKiaQTZv/Sk7Pdpwl27eObLkcdcpKRupwgn+eUOHiOfcL75Dh/RBwS/PAaGUJ6h+FS
         isnLTtc3WUIdRM6u4y/agViVA3RKzRST9ozVxUZjzV4WpEEOc9WhLnehNX6v94eT0qGE
         71LyNPdpKcjKBqfd8h6Yofmch9tctoToLgGGqyRJWKErCzQMVAK8Yl7Lyp3hawn+Fequ
         Hj8g==
X-Gm-Message-State: ANhLgQ2BbqhR6fLUV403cXS/aUDLxDXZFcaqOvZ4EshHL0zxBnTanK3/
        r0l6n6z672X+g01c+wpzAg==
X-Google-Smtp-Source: ADFU+vvvg/ETQnv8QslVQHIZ0sV61kxtcOyz2SY3bt9I0ZnGmiT8R7zO6pDr8Jh91tKE6yR0zXuznA==
X-Received: by 2002:aca:600b:: with SMTP id u11mr2481775oib.6.1583871554816;
        Tue, 10 Mar 2020 13:19:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm288460otp.76.2020.03.10.13.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:19:13 -0700 (PDT)
Received: (nullmailer pid 2066 invoked by uid 1000);
        Tue, 10 Mar 2020 20:19:12 -0000
Date:   Tue, 10 Mar 2020 15:19:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [RFC 10/11] reset: imx: Add audiomix reset controller support
Message-ID: <20200310201912.GA31651@bogus>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
 <1583226206-19758-11-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583226206-19758-11-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:03:25AM +0200, Abel Vesa wrote:
> The imx-mix MFD driver registers some devices, one of which, in case of
> audiomix, maps correctly to a reset controller type. This driver registers
> a reset controller for that. For now, only the EARC specific resets are added.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/reset/Kconfig                          |   7 ++
>  drivers/reset/Makefile                         |   1 +
>  drivers/reset/reset-imx-audiomix.c             | 122 +++++++++++++++++++++++++
>  include/dt-bindings/reset/imx-audiomix-reset.h |  15 +++

This should be in a binding patch which makes me wonder where is the 
binding patch?

Rob
