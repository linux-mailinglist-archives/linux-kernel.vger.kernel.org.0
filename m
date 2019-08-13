Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35958BFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHMRkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 13:40:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52427 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfHMRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:40:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so2138284wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uc9OGgJkXEQLVzLUg29afYIlM/c0XiV4/R2vY7HBFgQ=;
        b=pG72l78w45KvG+5Zfl0HjCP8EGjxgk1KfJsnjgxznRwF4w1D5LvXcOLgFo+pYVhkfs
         Nue9VxhklvujK3dLfnu2yHuaCAZM5DtvwfboOLBdKfXW7IKKaQkLJTKWH5fHzfj7alEA
         T/SScbEd/AH05LrsoGDoIBr+BjZ0qhjvTQ4N3kRMK5cWqFeM2gaUNjICmMQ03qgKpSA4
         hVrWp1dyP0YoQO7mBJvCcaFVcNPw/YjFDgfDdNzcUE5b9uEQgiDG+IyDHVDD+b+wM9oG
         QIcLRIEq2uVLGaEODfRK6a4REB511/ORaq63o86p45jGlGMbPhpactqgqudLEf7ZcXk+
         En1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uc9OGgJkXEQLVzLUg29afYIlM/c0XiV4/R2vY7HBFgQ=;
        b=C9qpE75ZC5fMTjEKY5U1TM6bVBHOaZeXl3CRdSjUmX35FGCg0P/sGnY6SM2yES1Z8t
         KLb0XwEVuMsCCYISrja17MZn7ukC096US1qnxOuOE8FS2F+qobH+WI9OC7xmeylinEnv
         QM6/HKIj7smx/LMPw6WiHFFcfsUDhNyeqjJglip6cvdMqwuCayuFv7nb41bJCVNmKECY
         UAu2TJXaUo9cO4K0zz/iMuFEoYutF7IRkFwL1O+mmiDF5Jalwo/CTxJBoohUnGLon6Ov
         XzzVelygGvxXzv5EsU0CjzH9PgunIU1JtPKid3+p77CeM0ZtUqIAyPjjoreX1Z5FcvfT
         BkyA==
X-Gm-Message-State: APjAAAWiZjVu6L5/nKx0G7l8P9UmDRLtF1DnitSYOKRXOmVIx6c4WLL4
        fVoUBLcSY6G1T5kCqyxAEJc=
X-Google-Smtp-Source: APXvYqy3XERKihuiXKn39bAzfUK9rYQJ6WpUYbDKEj6CpD/ldDppvP6u6aC12tO0Kz+zhhtUvsSaUA==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr4240596wmh.65.1565718000233;
        Tue, 13 Aug 2019 10:40:00 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id s2sm1566914wmj.33.2019.08.13.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:39:59 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:39:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] soundwire: Don't build sound.o without
 CONFIG_ACPI
Message-ID: <20190813173957.GA96879@archlinux-threadripper>
References: <20190813061014.45015-1-natechancellor@gmail.com>
 <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:22:29AM -0500, Pierre-Louis Bossart wrote:
> On 8/13/19 1:10 AM, Nathan Chancellor wrote:
> > clang warns when CONFIG_ACPI is unset:
> > 
> > ../drivers/soundwire/slave.c:16:12: warning: unused function
> > 'sdw_slave_add' [-Wunused-function]
> > static int sdw_slave_add(struct sdw_bus *bus,
> >             ^
> > 1 warning generated.
> > 
> > Before commit 8676b3ca4673 ("soundwire: fix regmap dependencies and
> > align with other serial links"), this code would only be compiled when
> > ACPI was set because it was only selected by SOUNDWIRE_INTEL, which
> > depends on ACPI.
> > 
> > Now, this code can be compiled without CONFIG_ACPI, which causes the
> > above warning. The IS_ENABLED(CONFIG_ACPI) guard could be moved to avoid
> > compiling the function; however, slave.c only contains three functions,
> > two of which are static. Only compile slave.o when CONFIG_ACPI is set,
> > where it will actually be used. bus.h contains a stub for
> > sdw_acpi_find_slaves so there will be no issues with an undefined
> > function.
> > 
> > This has been build tested with CONFIG_ACPI set and unset in combination
> > with CONFIG_SOUNDWIRE unset, built in, and a module.
> 
> Thanks for the patch. Do you have a .config you can share offline so that we
> add it to our tests?

I just took the arm64 defconfig and deleted CONFIG_ACPI and added
CONFIG_SOUNDWIRE=y or =m to produce this warning. I initially found this
on an arm64 allyesconfig build.

> 
> > 
> > Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/637
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >   drivers/soundwire/Makefile | 6 +++++-
> >   drivers/soundwire/slave.c  | 3 ---
> >   2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> > index 45b7e5001653..226090902716 100644
> > --- a/drivers/soundwire/Makefile
> > +++ b/drivers/soundwire/Makefile
> > @@ -4,9 +4,13 @@
> >   #
> >   #Bus Objs
> > -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> > +soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
> >   obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
> > +ifdef CONFIG_ACPI
> > +soundwire-bus-objs += slave.o
> > +endif
> 
> I am fine with the change, but we might as well rename the file acpi_slave.c
> then?

Sure, I can do that rename and send a v2.

> 
> > +
> >   #Cadence Objs
> >   soundwire-cadence-objs := cadence_master.o
> >   obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
> > diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> > index f39a5815e25d..0dc188e6873b 100644
> > --- a/drivers/soundwire/slave.c
> > +++ b/drivers/soundwire/slave.c
> > @@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
> >   	return ret;
> >   }
> > -#if IS_ENABLED(CONFIG_ACPI)
> >   /*
> >    * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
> >    * @bus: SDW bus instance
> > @@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
> >   	return 0;
> >   }
> > -
> > -#endif
> > 
> 
