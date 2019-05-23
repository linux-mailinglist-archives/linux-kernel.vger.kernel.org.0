Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2C327AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfEWKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:39:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40373 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:39:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id q62so4979003ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 03:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qv74DqO1FvoC14nBwYDubCDsUUhrYvH0YUJh7Uw9LZk=;
        b=jipXITIyZ3dRPmi5fkk/uGBpgLtjW4D/YReeJ3UzlD3C+bvtiR9ThRJVzCdTZSM9qj
         /2UfvpMktM3VYTssuiTiwA5CaYi602TEYRjbpmqweH27PnDWLZB6Qg6388J7jHzDl7ul
         lk477G/riNvpo5mSSSi2gVC23iuS30o6na5cilXfgPgWZ7y19PEZ+s66OZ4FKLHaOaRf
         Qox0fBmAZmFR6ULvQKyT+atS1JXUaHepmBexmGHk0NuYa+vuxI+Qebp7gPMsNeiWnwmf
         3hSirL0Uzz/XtVx5ZaOXFYGgVr+UT4I0S9O+wb1JBxcVKwa0L23lI4PuZtlo5RbyzyrM
         dgUw==
X-Gm-Message-State: APjAAAVUk+8iqEBA03nCcZHAn0y8h4GNCXNAGbW/h+uAxEreu6ipB1LR
        dSDMNfGAUB3CEh5whRHrIPk=
X-Google-Smtp-Source: APXvYqxUQE8mW0nZC2ys8mqpiYmn+pu/RF+Y5SX0hWGA9j+1zSh9t6rPfCJ7ZYjgjlbJioR0xVsdKA==
X-Received: by 2002:a2e:96da:: with SMTP id d26mr39081123ljj.9.1558607973094;
        Thu, 23 May 2019 03:39:33 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u2sm5595415ljd.97.2019.05.23.03.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 03:39:32 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hTl8B-0002np-JF; Thu, 23 May 2019 12:39:28 +0200
Date:   Thu, 23 May 2019 12:39:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tty: drop unused iflag macro
Message-ID: <20190523103927.GE568@localhost>
References: <20190426055925.13430-1-johan@kernel.org>
 <20190523092127.GD568@localhost>
 <20190523093109.GA24097@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523093109.GA24097@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:31:09AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 23, 2019 at 11:21:27AM +0200, Johan Hovold wrote:
> > On Fri, Apr 26, 2019 at 07:59:22AM +0200, Johan Hovold wrote:
> > > I noticed that the RELEVANT_IFLAG() macro was unused in USB serial and
> > > turns out there were a few more instances that could be dropped.
> > > 
> > > I have some pending changes that may conflict with the corresponding
> > > change to USB serial so I'll take that one separately through my tree,
> > > but perhaps the rest could go through Greg's tty tree.
> > 
> > > Johan Hovold (3):
> > >   tty: simserial: drop unused iflag macro
> > >   tty: ipoctal: drop unused iflag macro
> > >   tty: cpm_uart: drop unused iflag macro
> > > 
> > >  arch/ia64/hp/sim/simserial.c                | 2 --
> > >  drivers/ipack/devices/ipoctal.h             | 1 -
> > >  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 --
> > >  3 files changed, 5 deletions(-)
> > 
> > Greg, do you still have these clean-ups in your queue? Want me to resend
> > with Tony's ack?
> 
> They are still in my to-review queue.  Let me dig out from some more
> stable patches before I tackle the tty/serial stuff later today or
> tomorrow.

No rush. Just saw you applying some tty patches the other day so figured
I'd ask. Thanks.

Johan
