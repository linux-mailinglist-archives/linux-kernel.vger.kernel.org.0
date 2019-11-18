Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683BE100DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 22:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRV3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 16:29:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38615 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:29:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id z25so15913402oti.5;
        Mon, 18 Nov 2019 13:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+YO38WgStB7nYPSXcUR6YrSTtp1l2WDphJUjDsiG8A=;
        b=Rd0khKdGWFLZCMWcTi8To1dfnR/6INLiQJhum3+0UdRjcg8hS7IaeGb1fSfIFqWPS2
         bOYWucd4oMYYpz1aZRcMcxs7UHe5gA5F49aCge/EvywDRSnfFPUM2IiQMQMGqfdX1PLH
         l/QVnSfu6qhwquawFv14RbvwBZhMoSBDbH8JZJloxfOQ+8LEoGPgK3VVFaULG0wCqxee
         fWFUtfyuOErpYhGmEtia6nIYNT/9hYlqOUIWO3A6NM3aA0XLgOKwRBXMrjF959zuyO0X
         bnItAArHUw4GBmEYkDEJBnA+KhxBIz4VjtUmRwUAaIKQiJiwZ7tv17uK+lTbDultLAq0
         aerQ==
X-Gm-Message-State: APjAAAUfId7xP+3Wi/f6cSCwpjh1u0VosPAC7SsQ0he8zDimYKdKiAVk
        TTQKJDJqt9dBSsTvhK4jbw==
X-Google-Smtp-Source: APXvYqzrzbwSYe5wu/iJKT9qZvzRqWrX+EPEq/49EneSWuAZ5oGeI5ckJK8JP2PSx39iTQehpaZz8w==
X-Received: by 2002:a9d:154:: with SMTP id 78mr1031136otu.294.1574112554132;
        Mon, 18 Nov 2019 13:29:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l40sm6634725ota.24.2019.11.18.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:29:13 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:29:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Oliver Graute <oliver.graute@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL
 compatibles
Message-ID: <20191118212912.GA16329@bogus>
References: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
 <1573593892-25693-1-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5DYssbnVsemV+U24wbVoYM3LM3ZZtFwWHonXLHKF0Y+kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DYssbnVsemV+U24wbVoYM3LM3ZZtFwWHonXLHKF0Y+kg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:19:44PM -0300, Fabio Estevam wrote:
> On Tue, Nov 12, 2019 at 6:25 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> >
> > Add the compatibles for Variscite i.MX6UL compatibles
> >
> > Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index f79683a..d0c7e60 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -182,6 +182,7 @@ properties:
> >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> >                - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> >                - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
> > +              - variscite,6ulcustomboard" # i.MX UltraLite Carrier-board
> 
> I guess what you mean is:
> 
> variscite,imx6ul-var-6ulcustomboard # i.MX6 UltraLite Carrier-board

It matched the .dts file. However the '"' in there is an error. Make 
sure 'make dt_binding_check' passes.

Rob
