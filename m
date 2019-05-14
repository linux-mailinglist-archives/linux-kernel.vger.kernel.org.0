Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CEB1C5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfENJXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 05:23:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43233 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:23:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so8311452pgi.10;
        Tue, 14 May 2019 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YuxfzalVyz39bS5lxDVxBPQxHNRqBsXyUAh+iAMKKQ=;
        b=vQSL1vI8y/pobIeEAf+6sVKN7MQRUqCOKfqM1PV+aH5OE0icjkzECfBzZmitQ98Svo
         XDXmRTZkyLfN5eIgZ0B6daFC5TZWFFedUokzmDo+74gY2ifevOAaozTMu8KDUuFHgKP9
         ZBvGng5nkXYXeXpoVAw3EUrjwdjr+MkdQ3oL89XiX/dNM+d8hx5ECzbkWs9V/wiqTffQ
         MO9dWCuiwA7T0ZP0xx84t21FGJIb2pHO8NalHjrMCPfbnqd8A6nIXYPQzWaeb87QfSJj
         1THQRYa+38c2f0GuRdugvKBnRTbY76ebqzhfQZpgmX+y5gGuto1ECPqS0yFggz6F8+mL
         Ui+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YuxfzalVyz39bS5lxDVxBPQxHNRqBsXyUAh+iAMKKQ=;
        b=jeQRRn18Bl76K2zvhBK3uiaGEmU3ESj60UtXql1dUByilr1xK7fY9dPXOFUYHTzu8H
         8mznUCbovoKeNw3rd+xCi8AcPY5V2YNqv9ORctZ3U9HjROj1VeEfIQLNsdCY1i5L1EgL
         8iIaQ4451v0UtKBCmoLAzSaCzUxzpF1og8AdioWYZyYjp4GziE/e4I2Jq04J4WwAkEJ+
         1SAt7HIjxppX+C0p2uACwdjUsl0um30pUDNP6QUJG6NZx7eTmPLMbjT6E9z4J52zpZsb
         76hzvUbVihtc4X5pQAelYzc+DN/J1cZ8nbLNq3MSEpho0KhtVI1D7ZavTeq2TbHWv8/a
         OZtQ==
X-Gm-Message-State: APjAAAXgtcs6e/B1CoHElrf1bBX9jVBaO1u4LUl6KzRU8n3b7+K0qUKA
        XbHe6G01ThkhajEPpG6Iu6O8Ydcv7fkBRDpB33ZIgDPY2ZA=
X-Google-Smtp-Source: APXvYqxijTaU+rkG79VpDp9pINfS+w4/WWN8EseUFB++/R49pbRj0MA3YmeqtZC5mrvUYTir5ATJZ3WL6YPAGz1RJXE=
X-Received: by 2002:a63:42:: with SMTP id 63mr37044591pga.337.1557825824401;
 Tue, 14 May 2019 02:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190430140416.4707-1-esben@geanix.com> <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk> <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk> <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk> <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk> <20190507150847.GW9224@smile.fi.intel.com> <87k1etmrfk.fsf@haabendal.dk>
In-Reply-To: <87k1etmrfk.fsf@haabendal.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 May 2019 12:23:33 +0300
Message-ID: <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:

> We are on repeat here.  I don't agree with you here.  I have a simple
> generic 8250 (16550A) compatible device, and cannot use it in a mfd
> driver using the standard mfd-core framework.

> The lacking of support for platform_get_resource() in the generic
> serial8250 driver is not a feature.  It should be supported, just as it
> is in several of the specialized 8250 drivers.

We are going circles here.
What exactly prevents you to use it? Presence of request_mem_region()?

> It would still mean that I would have revert to not using convenient and
> otherwise fully appropriate API calls like pci_request_regions() and
> mfd_add_devices().

Yes, here is the issue. 8250 requires the parent not to *request*
resources. Because child handles IO access itself.

> The mfd driver in question is for a PCI device.  Not being able to
> request the PCI regions seems silly.

Nope. Otherwise, the parent which *doesn't handle* IO on behalf of
child should not request its resources.

> Not being able to register all child devices with the call introduced
> for that sole purpose also seems silly.

> Please take a look at https://lkml.org/lkml/2019/4/9/576
> ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")

Thank you for this link.
Now, look at this comment:

+ /*
+ * Map all IOC3 registers.  These are shared between subdevices
+ * so the main IOC3 module manages them.
+ */

Is it your case? Can we see the code?

-- 
With Best Regards,
Andy Shevchenko
