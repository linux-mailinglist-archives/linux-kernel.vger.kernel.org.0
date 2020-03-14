Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621C718582F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 02:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCOB5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 21:57:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34683 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCOB5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:57:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id i24so13489883eds.1;
        Sat, 14 Mar 2020 18:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGvteHNkCAAe9RzBu1B2j4q+4lEY8L8k3NmOvCcX8OE=;
        b=KhwANvBcrTq2q2W5HVumXxXVfw3LRtfnYku9FMQ1suJpsKfm1z2FlTffMfi3FsbB/z
         IVMP/udmVbpgTjKW5cNUjWgiV1tKC8kDYSO0gLZpwjEWBWrION7WTmd0TM8EJEgQOH8Z
         eTNelbIFbn3OAHSNgYbM8h0d7qMMar0Bl4C/Siv215MIThh7Rb/Hf0UciLgjp0hufgBs
         MnR1vOy4s76cXpYBYvMXauY51h/rWdykIJmS97Fx3tj838dCUXZmEtIBBj0R4eAOSpVR
         EBiUdAe2DM/dJPL/nSR1jjY9CpXC1ER/ag4dJbFKldpE8HvCU6JNzqH4ubhvlpC7RmUQ
         G6SA==
X-Gm-Message-State: ANhLgQ2UywbPP/WnWS3yPZBN1VwWm8GBWPebJYVOudtwHeZJK9YCOcaC
        R5m0GQ0kZ9ASWJ39wq6Xl9I4uG1JtWA=
X-Google-Smtp-Source: ADFU+vvqta4B+r9p/W0zTELooOA9Cc7fWz4UD77LqxM6UYcl+Sd+u1u4HEDyOkSEfBTCw7OTPTESnQ==
X-Received: by 2002:a50:d657:: with SMTP id c23mr19074934edj.18.1584210014117;
        Sat, 14 Mar 2020 11:20:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id n6sm2172656ejy.23.2020.03.14.11.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 11:20:13 -0700 (PDT)
Date:   Sat, 14 Mar 2020 19:20:10 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCHv3 2/5] ARM: dts: exynos: Add missing usbdrd3 suspend clk
Message-ID: <20200314182010.GB17580@kozik-lap>
References: <20200310194854.831-1-linux.amoon@gmail.com>
 <20200310194854.831-3-linux.amoon@gmail.com>
 <CANAwSgR4fJK0uVANv-x-=iSL_hAKD8kvazACUsY9Meu5xonuqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgR4fJK0uVANv-x-=iSL_hAKD8kvazACUsY9Meu5xonuqQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 07:02:33PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Wed, 11 Mar 2020 at 01:19, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add new compatible strings for USBDRD3 for adding missing
> > suspend clk, exynos5422 usbdrd3 support two clk USBD300 and
> > SCLK_USBD300, so add missing suspemd_clk for Exynos542x DWC3 nodes.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> 
> My assumption based on the FSYS clock source diagram below was bit wrong.
> [0] https://imgur.com/gallery/zAiBoyh
> 
> And again re-looking into the driver source code, it turn out their
> are *6 clock*
> Here is the correct mapping as per the Exynos5420 clock driver.
> 
> USB-(phy@12100000)
> |___________________CLK_SCLK_USBD300
> |___________________CLK_SCLK_USBPHY300
> 
> USB-(phy@12500000)
> |___________________CLK_SCLK_USBD301
> |___________________CLK_SCLK_USBPHY301
> 
> USB-(dwc3@12000000)
> |___________________CLK_USBD300
> USB-(dwc3@12400000)
> |___________________CLK_USBD301
> 
> Note: As per Exynos 5422 user manual, There are some more USB CLK
> configuration missing in GATE_IP_FSYS. So we could enable another dwc3 clk,
> If needed I would like too add this missing clk code and enable this
> clk for dwc3 driver.
> 
> For some reason we already use CLK_USBD300 and CLK_USBD301
> for PHY nodes, which lead to this confusion. So we need to update PHY clock
> CLK_USBD300 with CLK_SCLK_USBD300 and clock CLK_USBD301 with CLK_SCLK_USBD301.
> 
> Please share your thought on linking PHY nodes above and add new DWC3 clock
> and enable this clock.

The real clock topology of Exynos5422 is not properly reflected in the
kernel. However cleaning this up is quite big task.


Best regards,
Krzysztof

