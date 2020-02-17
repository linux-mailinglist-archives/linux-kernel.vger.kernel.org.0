Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7954C16154F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBQO7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 09:59:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41364 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgBQO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:59:23 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 356FA27636B;
        Mon, 17 Feb 2020 14:59:21 +0000 (GMT)
Date:   Mon, 17 Feb 2020 15:59:17 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org
Subject: Re: [RFC v2 1/4] i3c: master: export i3c_masterdev_type
Message-ID: <20200217155917.592e8ded@collabora.com>
In-Reply-To: <20200217155623.13a94802@collabora.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <7c742fba6c488b29f6fb15a5b910e799d50c5051.1580299067.git.vitor.soares@synopsys.com>
        <20200217155623.13a94802@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 15:56:23 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 29 Jan 2020 13:17:32 +0100
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> 
> > Exporte i3c_masterdev_type so i3cdev module can verify if an i3c device
> > is a master.
> > 
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> >  drivers/i3c/internals.h | 1 +
> >  drivers/i3c/master.c    | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> > index 86b7b44..bc062e8 100644
> > --- a/drivers/i3c/internals.h
> > +++ b/drivers/i3c/internals.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/i3c/master.h>
> >  
> >  extern struct bus_type i3c_bus_type;
> > +extern const struct device_type i3c_masterdev_type;
> >  
> >  void i3c_bus_normaluse_lock(struct i3c_bus *bus);
> >  void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 7f8f896..8a0ba34 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -523,9 +523,10 @@ static void i3c_masterdev_release(struct device *dev)
> >  	of_node_put(dev->of_node);
> >  }
> >  
> > -static const struct device_type i3c_masterdev_type = {
> > +const struct device_type i3c_masterdev_type = {
> >  	.groups	= i3c_masterdev_groups,
> >  };
> > +EXPORT_SYMBOL_GPL(i3c_masterdev_type);  
> 
> No need to export the symbol, removing the static and adding the
> definition to internal.h should work just fine (i3c.o contains
> both master.o and device.o).

Hm, my bad. Looks like i3cdev is a separate module/driver. If that's
the case, it should not have direct access to internals.h. I see 2
options here:

1/ make the i3cdev logic part of the core
2/ provide helpers to find devices by type

But maybe none of that is needed if you let userspace bind i3c devices
to the i3cdev driver.

> 
> >  
> >  static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
> >  			    unsigned long max_i2c_scl_rate)  
> 

