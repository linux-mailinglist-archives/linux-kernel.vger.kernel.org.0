Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BC6E556
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfGSMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 08:04:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46816 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:04:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so31986337wru.13;
        Fri, 19 Jul 2019 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8IFcivDoTqK2Ev9EUILZscktm0lR7SvblA9hq9LNWg=;
        b=j/bj0S4PAnoMQzdMr/jqG6zHX3uvlVV4jQWKFchLU2VUyGh6TOQ7NZK/qEEv9WMMMt
         mFolvVmLLT0Tiu04cvEdBVhpHbv2VKKvtzHbVl0jAexSvVIjQgXRMo6dz4pl9JlRQAgC
         Kz91969RlF85z7Hidel82qDRb6mdahXnAcvckGD6nMBOWfK5bMRuk30/I1EjocxaJlbe
         MwKxdqEHN5Mbpo+Fx5Xh00dnlS+f8GT18YRQo39Zd9NIFOqWadxyLySllGPcRsuS4nVG
         s28HKmZw7xMGb8K9Om2DN+nsp54I1cnKsJets1anYAbfvCATzz89M8sEf0sFSneJzAzE
         cZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8IFcivDoTqK2Ev9EUILZscktm0lR7SvblA9hq9LNWg=;
        b=RBtDhNFvWfGueYUEFMQPwz9a8joLwCbFpCkSx98hnRUOj7RaS/zWvxPKTt0ZM1zFHd
         QZDut12T+a1NWBpEqnY5EWNfWDbCQbxlUqBpGYj03HDHQHuI1TR8AbV9Rv4eV8RSTH/7
         4xtHUI9dIDqS8ZZCrGWqO/ZOdT4aaz3khuT1ngsWxmz/ULICcoHbO0sycxz+cvrJa7/b
         RBf+0fy2yRRJjFKvmXhj49eymH+ZiId95Icmfc2O0TbmFJSrHLvOvkPs6gBUZiD3NBTx
         O1IhTjxSxHTtAhleX3lyf5pWbr55WzNQtD4oWyjEI0LYQs7hSXYyuL7VQdeK9DehSFWE
         8CYw==
X-Gm-Message-State: APjAAAXqRWgM3gBesBCJcvJbhRYlXJx6bD3GluiEs16s/R/jQNoK5yAM
        D+cQC+ylVkonXZ4dcBH7Cq/Ep+eYKwIYy250tBnZHy8mIUg=
X-Google-Smtp-Source: APXvYqwBxjlxJegOY2UTKf4DLSgACoj1+MUtFGTXOMcJBBbqQCcN6MmCZg9QAv307R1lFOoMUph5BNq9+6hcKREQlao=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr58332007wrs.93.1563537857525;
 Fri, 19 Jul 2019 05:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190719104802.18070-1-andradanciu1997@gmail.com>
 <20190719104802.18070-2-andradanciu1997@gmail.com> <CAOMZO5Btu1Shou=dGRrG74e5UjHnh7NtR4+4ETK0t_1Zt48Crw@mail.gmail.com>
In-Reply-To: <CAOMZO5Btu1Shou=dGRrG74e5UjHnh7NtR4+4ETK0t_1Zt48Crw@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 19 Jul 2019 15:04:05 +0300
Message-ID: <CAEnQRZByhULeq14BLbH4JzJwgL2+5hUaPn8=osZqVWrEMpCN6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: fsl: pico-pi: Add a device tree for
 the PICO-PI-IMX8M
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andradanciu1997 <andradanciu1997@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ping Bai <ping.bai@nxp.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>,
        Li Yang <leoyang.li@nxp.com>, sriram.dash@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>, pankaj.bansal@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Richard Hu <richard.hu@technexion.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 2:22 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andra,
>
> On Fri, Jul 19, 2019 at 7:48 AM andradanciu1997
> <andradanciu1997@gmail.com> wrote:
>
> > +       pmic: pmic@4b {
> > +               reg = <0x4b>;
> > +               compatible = "rohm,bd71837";
> > +               /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_pmic>;
> > +               clocks = <&pmic_osc>;
> > +               clock-names = "osc";
> > +               clock-output-names = "pmic_clk";
> > +               interrupt-parent = <&gpio1>;
> > +               interrupts = <3 GPIO_ACTIVE_LOW>;
> > +               interrupt-names = "irq";
> > +
> > +               regulators {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
>
> #address-cells and  #size-cells are not needed and they cause warnings with W=1:
>
>   DTC     arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts:77.14-196.5: Warning
> (avoid_unnecessary_addr_size):
> /soc@0/bus@30800000/i2c@30a20000/pmic@4b/regulators: unnecessary
> #address-cells/#size-cells without "ranges" or child "reg" property
>
> Please remove them.

Thanks Fabio for review, we learned something new today :).

Daniel.
