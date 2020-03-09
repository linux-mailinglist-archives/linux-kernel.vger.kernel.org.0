Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A217E4C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgCIQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 12:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgCIQ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:29:02 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED40D2464B;
        Mon,  9 Mar 2020 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583771341;
        bh=M4hta4rO76KqNz2KpbfSKCytV36dh+QCi4nxP7/70Qc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ECUBHZzfDRkL9+lrtL8/IGT7DbZmO35UvWwclsqTqmkRcDexN6CHlkMzScuw7TMcm
         NzQH3V27LN71opJGS/wmkQrk/tDaJRTYQrHhqtHPvgLFnGlkNqVMXKwlQoAyqlKD/r
         t1FDTfmcoW3ym7RxHnJ5sNxFx8b+4/rmcWs6SXnc=
Received: by mail-qv1-f44.google.com with SMTP id o18so4658020qvf.1;
        Mon, 09 Mar 2020 09:29:00 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1vr3/JNnP1lP5H2ecnbHDUJpj3qbjb9rv6J9UnrktbxNgMFh6o
        XM+uiqEHpwJz4g6lvuJ4k4GCDZzlT7KiWLp2Mw==
X-Google-Smtp-Source: ADFU+vsPj8UzEH+o8HBMtD0nC79kmD3U8pOn1ISxPCZv+ibGYoRV/JlHc/4T3252S5sD41c4taRylKCtx1mQLcBqN+s=
X-Received: by 2002:a05:6214:17c3:: with SMTP id cu3mr9866831qvb.135.1583771340026;
 Mon, 09 Mar 2020 09:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190822092643.593488-1-lkundrak@v3.sk> <20190822092643.593488-7-lkundrak@v3.sk>
 <CAL_JsqLpDa0viedjBVDGGa9p1ytpRizw9hE3m1FE8_xVv6+FmQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLpDa0viedjBVDGGa9p1ytpRizw9hE3m1FE8_xVv6+FmQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Mar 2020 11:28:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WQEANnXVgiNyQe97dneD7GG0BsihgKanJP+eX99YMgA@mail.gmail.com>
Message-ID: <CAL_Jsq+WQEANnXVgiNyQe97dneD7GG0BsihgKanJP+eX99YMgA@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] irqchip/mmp: do not use of_address_to_resource()
 to get mux regs
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 11:25 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Aug 22, 2019 at 4:34 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
> > are offsets from intc's base, not addresses on the parent bus. At this
> > point it probably can't be fixed.
>
> Another option is for platform code to fixup the live DT and just add
> 'ranges' to make this work.

Nevermind my reply on this old thread. It caught my attention when
looking for the other thread and I missed the date.

Rob
