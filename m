Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0DDE6A54
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 01:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfJ1Aq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 20:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfJ1Aq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 20:46:29 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133F12070B;
        Mon, 28 Oct 2019 00:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572223588;
        bh=dUrfIt9ulQVATvgyr+HDIEG155LRe+2kRKFH8+5OlIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zruWzOHfKq5ZGevrQIPMaNo/nYXLq6hunFdZSO9sRqfWCqJDHhfKpONYcxXQJu1nB
         U8e7tbgw1BWYtj1XikjiixINEDkDq1oqI9chrE/Axx0CO0di6bwn3Cng1SionQqYjG
         yYXyVKOCsPsHYvaMk/FDlW7TZ0sUXMpiIG6sHrxI=
Date:   Mon, 28 Oct 2019 08:46:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] arm64: dts: zii-ultra: Add node for accelerometer
Message-ID: <20191028004604.GA16985@dragon>
References: <20191015152654.26726-1-andrew.smirnov@gmail.com>
 <20191015152654.26726-3-andrew.smirnov@gmail.com>
 <20191026115524.GJ14401@dragon>
 <CAHQ1cqHQar8ZoVa3p+LfuPyJixcwfeWv7spkmwyJc60cekEywQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqHQar8ZoVa3p+LfuPyJixcwfeWv7spkmwyJc60cekEywQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:54:13AM -0700, Andrey Smirnov wrote:
> On Sat, Oct 26, 2019 at 4:55 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Tue, Oct 15, 2019 at 08:26:53AM -0700, Andrey Smirnov wrote:
> > > Add I2C node for accelerometer present on both Zest and RMB3 boards.
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: linux-arm-kernel@lists.infradead.org,
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  .../boot/dts/freescale/imx8mq-zii-ultra.dtsi   | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > > index 21eb52341ba8..8395c5a73ba6 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > > @@ -262,6 +262,18 @@
> > >       pinctrl-0 = <&pinctrl_i2c1>;
> > >       status = "okay";
> > >
> > > +     accel@1c {
> >
> > s/accel/accelerometer
> >
> > I fixed it up and applied the series.
> >
> 
> I'm fine with that change, but FYI, I originally had it as
> "accelerometer', but changed to "accel" to match the name in DT for
> RDU2.

We should change RDU2 instead, IMO.

Shawn
