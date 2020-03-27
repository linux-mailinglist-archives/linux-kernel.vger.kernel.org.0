Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051FD195436
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 10:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0Jlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 05:41:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33500 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgC0Jlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:41:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id 22so9085853otf.0;
        Fri, 27 Mar 2020 02:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pRUyDjYyeIGWdFrrBAFuClW27244MF+xsnVK2iYKKw=;
        b=JtvLTC1dJepj94IrM9mRIOFlCv5IGBl8dIKXWJzEsBdy6OD6CjBxW/uu/mJPRtTKjH
         HPbDUgBPAj+7eHX4W/a/oYFK8p5PY8zwrYQtDiiKKzQSO7/H2VXK/2/giI+KekeCDqJS
         imUf/LSFaIRsMeAxfhoqoTzz6zRSg7bZ5n0sLJhQzqOSOW71K93sLhi1S+lso7j8oEx9
         zhkUutvNapLDztz3SwByhEMGmGQ5lbyz8CGIMv1OxU7SnC+HVNr1c1v9pKjGMNKvxCqt
         YZBWpO6TzRot91MRYfGBQCDgDuJZY+0G3gTlKhtr/spHClJ1cnB1JADNLVXoT2ZLQOAN
         PLqQ==
X-Gm-Message-State: ANhLgQ3Zw4RXGTPSexysYAQtDtpcmUfqdkhP8Y8CZqbZPF4HJJKocuDv
        ZPkaXLa0fi1oQknc4qeGUhErGJAQNSSQMsKgUCM=
X-Google-Smtp-Source: ADFU+vvXqH472B9jWUmfNhyz4EIDwEKYs/4rmy+cd5SzmFWSSSyhFlwsJmbrkB+/4h/Be4mguI+O5+StgQHvMsH7grI=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr9517019otk.250.1585302095432;
 Fri, 27 Mar 2020 02:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200326213251.54457-1-aford173@gmail.com>
In-Reply-To: <20200326213251.54457-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Mar 2020 10:41:24 +0100
Message-ID: <CAMuHMdU9tQwQHkX0MdQLkMfz-2ymDzfNTFGnzPoq=JQF+28HOg@mail.gmail.com>
Subject: Re: [RFC] clk: vc5: Add bindings for output configurations
To:     Adam Ford <aford173@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, aford@beaconembedded.com,
        charles.stevens@logicpd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

CC Marek

On Thu, Mar 26, 2020 at 10:33 PM Adam Ford <aford173@gmail.com> wrote:
> The Versaclock can be purchased in a non-programmed configuration.
> If that is the case, the driver needs to configure the chip to
> output the correct signal type, voltage and slew.
>
> This RFC is proposing an additional binding to allow non-programmed
> chips to be configured beyond their default configuration.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> index 05a245c9df08..4bc46ed9ba4a 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> @@ -30,6 +30,25 @@ Required properties:
>                 - 5p49v5933 and
>                 - 5p49v5935: (optional) property not present or "clkin".
>
> +For all output ports, an option child node can be used to specify:
> +
> +- mode: can be one of
> +                 - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
> +                 - CMOS
> +                 - HCSL
> +                 - LVDS: Low voltage differential signal
> +
> +- voltage-level:  can be one of the following microvolts
> +                 - 1800000
> +                 - 2500000
> +                 - 3300000
> +-  slew: Percent of normal, can be one of
> +                 - P80
> +                 - P85
> +                 - P90
> +                 - P100

Why the P prefixes? Can't you just use integer values?
After the conversion to json-schema, these values can be validated, too.

> +
> +
>  ==Mapping between clock specifier and physical pins==
>
>  When referencing the provided clock in the DT using phandle and
> @@ -62,6 +81,8 @@ clock specifier, the following mapping applies:
>
>  ==Example==
>
> +#include <dt-bindings/versaclock.h>

Does not exist?

> +
>  /* 25MHz reference crystal */
>  ref25: ref25m {
>         compatible = "fixed-clock";
> @@ -80,6 +101,13 @@ i2c-master-node {
>                 /* Connect XIN input to 25MHz reference */
>                 clocks = <&ref25m>;
>                 clock-names = "xin";
> +
> +               ports@1 {
> +                       reg = <1>;
> +                       mode = <CMOS>;
> +                       pwr_sel = <1800000>;
> +                       slew = <P80>;
> +               };
>         };
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
