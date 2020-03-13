Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062CB184CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCMQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 12:49:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43696 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCMQtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:49:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id n20so5100246lfl.10;
        Fri, 13 Mar 2020 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HX+MG1h0YhliW7/nTR7fuo8hAKf/TXs/lQQn0+5ul0=;
        b=r8m3ZxMXCJnAYJvxcKIzP4DKNMt5CNHRTJrMrjy7zK9Glr6lNmcQula6/X1Vl+uJs0
         kREHgmPiR2hebVMzl6lSLt5V+quIPMuUun+FWAfDq0M4zsZbC3VbDTjqJ8zrXFN5K1EF
         SE6sVlu281fjL5ZRSRipSkIHG/PONVQOaYlV8/XlfKeedjXrIg5mI1nEoENVxnThsZS+
         xVw6c/cAVxb52KfryDT4cW5thhu6rWRE8I4MS4iArpAL52ZOKenT8LQubyirph3EQzBG
         x6nJ5mXIqJ0om3Oqzofx9/3IkW9J1NZm+j4N7qSgV7ESw0zwCvo6W3ZoavcDdYBX52kJ
         lFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HX+MG1h0YhliW7/nTR7fuo8hAKf/TXs/lQQn0+5ul0=;
        b=oKQn0exrE7yReIvoMJq1QATbQZWKglL/R0uvIlJyLgf6B/b6XlrYfMI4f3mk+hBfs1
         vAQkSkcZiFTwh4bRw68KfKVYB+gx6F4c1EqIrTNmfjMd/qHGI5eyla4tuHbUBMUhIo+r
         AIsVhF3YCYquX/sIq6ySDhK6E1kvebfabL2bSFCVq5+4B/wSxwuFa04rrTn+t7c2XG+X
         6HR1L5/c5E6qB2LbFVum8J2L8btEOx3r6rPAS76LpAo7e65XXeeiZED1XoVuce6QUHJQ
         cgM2CHEq5biUEgXjgHnenoBdGeRT4opm9dUChF2Gf8QWfbb7zi2B1i2INOO1xt4x4CVT
         Tf4Q==
X-Gm-Message-State: ANhLgQ0qXaT9m/71A3bzkItiU3ywhHLwPhf27Olq3P+rAodvM2Qnww4S
        wgAmXGbAYClvKZGftvVP/hSRanrtGRpfFc3vdy2GRCX+Bss=
X-Google-Smtp-Source: ADFU+vsY14XjXkLoFjI7NDmr3II8WoKETAMUg2KCGH3NrtZT5x8A27d7VRQwV2dBBMN3CinEYLPhDO2UEQ8KQelxqmw=
X-Received: by 2002:a19:6101:: with SMTP id v1mr3243975lfb.56.1584118184013;
 Fri, 13 Mar 2020 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200306104219.6434-1-alifer.wsdm@gmail.com> <CAOMZO5BjAN8rJ25n2n3i=gVQ_noo-X8CTsFDZWBQB88SyZ-SNg@mail.gmail.com>
In-Reply-To: <CAOMZO5BjAN8rJ25n2n3i=gVQ_noo-X8CTsFDZWBQB88SyZ-SNg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Mar 2020 13:49:33 -0300
Message-ID: <CAOMZO5CNv3zzgDEK6R=K4f04NyJKHeSb_4sj8ynF_be1tKeV7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq-phanbell: Fix Ethernet PHY post-reset duration
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Franchi <marco.franchi@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 1:32 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Alifer,
>
> On Fri, Mar 6, 2020 at 7:41 AM Alifer Moraes <alifer.wsdm@gmail.com> wrote:
> >
> > i.MX8MQ Phanbell board uses Realtek RTL8211FD as Ethernet PHY.
> > Its datasheet states that the proper post reset duration should be at least 50 ms.
>
> The datasheet I found in the web states:
>
> "The RTL8211F(I)/RTL8211FD(I) has a PHYRSTB pin to reset the chip. For
> a complete PHY reset, this pin must be asserted low for at least 10ms
> (Tgap in Figure 9) for the internal regulator. Wait for a further 30ms
> (for internal circuits settling time) before accessing the PHY
> register"
>
> Where does the 50ms requirement come from? Do you have an updated
> datasheet that says 50ms instead?

Just found this one:
https://datasheet.lcsc.com/szlcsc/1909021205_Realtek-Semicon-RTL8211F-CG_C187932.pdf

Which says "Wait for at least 50ms* (for internal circuits settling
time) before accessing the PHY register.", so your patch is correct,
thanks.

This also fixes Ethernet in U-Boot, so:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
