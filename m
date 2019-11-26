Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C874B109B00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 10:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfKZJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 04:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfKZJTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:19:31 -0500
Received: from localhost (unknown [84.241.194.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411842073F;
        Tue, 26 Nov 2019 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574759970;
        bh=Iqz6aTqwrpGHW7R4infB/EOGkNdfCfDKkSzCxC6kw14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBf8P9OwXY/kAat+PpZvnrDhYOsTxpOHy1o62o6qi6+RiG/Sr5MVqvy20q1IWiY0k
         +bgDn/K9hTRbqGZvo8UpA5JbElIhKq/2ijMXUMCR5a7OhpBmiFl/iircUikAGSUX88
         b67L/U1Z/fc3mQi1fCRozVw3hrI+9ofixjPJXEdw=
Date:   Tue, 26 Nov 2019 10:19:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] litex: add common LiteX header
Message-ID: <20191126091926.GB1372654@kroah.com>
References: <20191023114634.13657-0-mholenko@antmicro.com>
 <20191023114634.13657-2-mholenko@antmicro.com>
 <20191120192648.GA3087498@kroah.com>
 <CAPk366QgcOYPZJXM46o3Gn8ksFYYoNwJvnunUe7y0aLNgJuSRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPk366QgcOYPZJXM46o3Gn8ksFYYoNwJvnunUe7y0aLNgJuSRg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:02:18AM +0100, Mateusz Holenko wrote:
> śr., 20 lis 2019 o 20:26 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> napisał(a):
> >
> > On Wed, Oct 23, 2019 at 11:47:04AM +0200, Mateusz Holenko wrote:
> > > +#ifdef __LITTLE_ENDIAN
> > > +# define LITEX_READ_REG(addr)                  ioread32(addr)
> > > +# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off)
> > > +# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr)
> > > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr + off)
> > > +#else
> > > +# define LITEX_READ_REG(addr)                  ioread32be(addr)
> > > +# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + off)
> > > +# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, addr)
> > > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, addr + off)
> > > +#endif
> >
> > I just noticed this.
> >
> > Ick, this is not good.  You will run into problems in the future with
> > this, I can guarantee it.  What about systems where the CPU is one
> > endian and the hardware in the other?  It will happen trust us.
> 
> As mentioned in the previous comment, LiteX CSRs are guaranteed to be
> always little-endian - this includes configurations with both
> big-endian and little-endian CPUs.

What enforces that guarantee?

> The aim of including the ifdef section was exactly to target situation
> where endianness is different for CPU and devices. As such this
> approach *should* work.

"should" :)

We have seen it happen all the time that some hardware team hooks this
up backwards, no matter what the "spec" required.  So be careful here.

good luck!

greg k-h
