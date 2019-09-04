Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67A0A77F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfIDAu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 20:50:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42700 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfIDAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:50:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so10193962pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/sKpokSgV0d78qiyD9dXj1DJgXdYj7e/Ymk+1/2JYWk=;
        b=SNlV5oiI+D2sgp94B0oOXIg8DZWw36LWldCdfiJzkSHTqiwEare9/eJF6DtSgwmOEM
         R4P7sui524O56UG2FcjdzH2ljGyDRDI6HgjRL9eozhjlpYOrtuIRnmk2+q55NddxYlid
         HihwnE2DOUwfGNfdXWn25eKblO0rmV3BKLF65rFgVLUZjDFlLwx18Qpyaw+FhP1pEDNE
         TL9fZQ8fm2T/7m68hCGY5KQtRsYvTErMhDlWlo4+JUxVc96D/956cOV0gFvpcdTMO1Xx
         tzHAb5uBvkN1sH5NPQvaSmLO5vHaQTm1RNlMTksVWiBG3JglFbejcbxKDniCz50fGRUF
         u6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/sKpokSgV0d78qiyD9dXj1DJgXdYj7e/Ymk+1/2JYWk=;
        b=k2dv6NXpUErFr3u5j4Rol+2UppAIXQey9igdhEkh90NrRmZYDh11rY4hUPUrjMBZt0
         x9DEyusJ81rgUgsMtxi6BX4nbem8KFTbSC+/itPAGvBLHDQ3c1Cw8JrghGhUIAkuz1fD
         Gkvg6x24FMyH5LDNQFCHkinIE3CIR3zUjbH2Ayk9T1OeqoiTwyOltmtGEdDRKGYHKzwf
         hq58gAeRPMshAf/UqbKBZns3/8r9AammcQmd3hHSGqFmPRSx2NqXR2BZsEc/IInzbevk
         cJxiIIIC0zp58VsP3FOSk6IsWS6m7+H/c///38ioJvTMyIcA6CQ0smKB2ELONPBsX2AK
         pMKQ==
X-Gm-Message-State: APjAAAUTp8Sp00jAOLnUCS4QPe6Quf8IQkUiX43fErtaNZQLp571QC1O
        kaB7bWD6Tnvm5GZ4Tb/69J8=
X-Google-Smtp-Source: APXvYqxOn0oZhYNIxi9cLbyYf3DsnT419iGLBWyPrdi6RNgWvrvq0gtBTFWY/4T3SCYegvnVbQbTsQ==
X-Received: by 2002:a17:90a:e292:: with SMTP id d18mr914211pjz.100.1567558258044;
        Tue, 03 Sep 2019 17:50:58 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id e66sm36363111pfe.142.2019.09.03.17.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 17:50:57 -0700 (PDT)
Date:   Wed, 4 Sep 2019 00:50:54 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq: move debugfs option to kernel hacking
Message-ID: <20190904005053.hnk3hh35vqagnikt@mail.google.com>
References: <20190901035539.2957-1-changbin.du@gmail.com>
 <alpine.DEB.2.21.1909010814360.3955@nanos.tec.linutronix.de>
 <20190901101032.7pysfrpincyrci35@mail.google.com>
 <20190901114936.5e2f3490@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901114936.5e2f3490@why>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 11:49:36AM +0100, Marc Zyngier wrote:
> On Sun, 1 Sep 2019 18:10:33 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > On Sun, Sep 01, 2019 at 08:23:02AM +0200, Thomas Gleixner wrote:
> > > On Sun, 1 Sep 2019, Changbin Du wrote:
> > >   
> > > > Just like the other generic debug options, move the irq one to
> > > > 'Kernel hacking' menu.  
> > > 
> > > Why?
> > > 
> > > Kernel hacking is a inscrutable mess where you can waste a lot of time to
> > > find what you are looking for.
> > >  
> > yes, the 'kernel hacking' menu has many items now and are not well structured.
> > Let me see if it can be improved.
> > 
> > > If I want to debug interrupts then having the option right there where all
> > > other interrupt related configuration is makes tons of sense.
> > > 
> > > I would be less opposed to this when the kernel hacking menu would be
> > > halfways well structured, but you just chose another random place for that
> > > option which is worse than what we have now.
> > >   
> > We already have an irq debug option CONFIG_DEBUG_SHIRQ here. Maybe we can group
> > them into a submenu.
> 
> DEBUG_SHIRQ is extremely different from GENERIC_IRQ_DEBUGFS. The former
> is a test option, verifying that endpoint drivers have a correct
> behaviour. The latter is a dump of the kernel internals, which is
> mostly for people dealing with the internals of the IRQ subsystem.
> 
> Preserving this distinction between the users of the IRQ API on one
> side and the debugging of the IRQ subsystem on the other is important.
> Moving these two things close together could make it even more confusing
> for the users (who usually do not need to mess with the IRQ subsystem's
> internals...).
>
IMHO, these are two distinct irq *debug* options. If we prefer
preserving current position, please skip this patch. Thanks.

> Thanks,
> 
> 	M.
> -- 
> Without deviation from the norm, progress is not possible.

-- 
Cheers,
Changbin Du
