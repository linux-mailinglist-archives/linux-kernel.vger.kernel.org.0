Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C5826B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfHEVSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 17:18:25 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43385 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbfHEVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:18:25 -0400
Received: by mail-oi1-f178.google.com with SMTP id w79so63475742oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Quv5LKbs49OA0A7kUkrESPHUpmixy0uCyhJoYZPtdP4=;
        b=Ef/4gIpz8Estc4b2dD1u9XsH48FqtGNZcuSUKZu6Go6rAtTAAwWYccI8oKPC/WeJ9s
         eysXbXa5OjK92WFBIdmQOFtQvHIJGzoKD57djmO5UaLJxjlxMp6Car2c12JLfpa34aZN
         1Q6ieMCMAte89kX+rw6vzaT6YfO+GF9EZBdMse9zBu8zsuy5dU5aNtdjaZC6gbPBtE39
         OrqyKgioDnWIl5vFaHtViPMuxeiJxdx5IYMb1sPP90jo1ue+CQsVIW2Q00EQppIKoa/I
         9LJnItZ7EHKdOtSwtstrd/EJ35SOTuQ42F0ThDXr5eT4KHpYYhohWvO32EO2xXdtrMrq
         y3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Quv5LKbs49OA0A7kUkrESPHUpmixy0uCyhJoYZPtdP4=;
        b=gJdvHNcjmndd8B/1KQZWRtEmJUL5H35xhW9W/5HN73Tcy5rYnHsXOBZQ2W6FFUsItS
         Hhl8qaSuk0zKdA2QyT75IirF+pEsGfzvW7BdIJX3rYa0S3gMvF1E0HW/JkHrwEH/sV0h
         YerOBjSXP4Hb5sKiaPENFb2RRL/9XfLJJ4SSgqK1vGsA20g5NdHEGltKZJ010LF6VRbW
         PYhHwpZUFoO1f368JvKzBj7ai2L5WuI38wXkNItSTO1wujbWhBM2VsMC2qwuUO0Axe5W
         uXPlzDrbNrStvWJNvLEyfksE7auseitY9BD6S2WsJ2P1ZfxsXugkzPkzo1mZ45uBrCsD
         ce+Q==
X-Gm-Message-State: APjAAAWYWydkI10FhEAgqO0j0k9+W5Xgyd2b12DwGm6sI7UB/VVSVv6d
        VxCri9F556/gUVEzK4Ahrw==
X-Google-Smtp-Source: APXvYqx6jU8h4cOhrS0fGYgjYoVtMAHXM3guXHC1cBcm4h7gVHA3pxgSsuez4bR3WHgjD/Auu/IoRw==
X-Received: by 2002:aca:bb45:: with SMTP id l66mr291841oif.108.1565039903877;
        Mon, 05 Aug 2019 14:18:23 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id c21sm27381174oib.4.2019.08.05.14.18.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 14:18:23 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:395d:f792:3095:bcc7])
        by serve.minyard.net (Postfix) with ESMTPSA id A12A81800D1;
        Mon,  5 Aug 2019 21:18:22 +0000 (UTC)
Date:   Mon, 5 Aug 2019 16:18:21 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190805211821.GG5001@minyard.net>
Reply-To: minyard@acm.org
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
 <20190709220908.GL657710@devbig004.ftw2.facebook.com>
 <20190709230144.GE19430@minyard.net>
 <20190710142221.GO657710@devbig004.ftw2.facebook.com>
 <20190801174002.GC5001@minyard.net>
 <20190805181850.GI136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805181850.GI136335@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:18:50AM -0700, Tejun Heo wrote:
> Hello, Corey.
> 
> On Thu, Aug 01, 2019 at 12:40:02PM -0500, Corey Minyard wrote:
> > I spent some time looking at this.  Without the patch, I
> > measured around 3.5ms to send/receive a get device ID message
> > and uses 100% of the CPU on a core.
> > 
> > I measured your patch, it slowed it down to around 10.5ms
> > per message, which is not good.  Though it did just use a
> > few percent of the core.
> > 
> > I wrote some code to auto-adjust the timer.  It settled on
> > a delay around 35us, which gave 4.7ms per message, which is
> > probably acceptable, and used around 40% of the CPU.  If
> > I use any timeout (even a 0-10us range) it won't go below
> > 4ms per message.
> 
> Out of curiosity, what makes 4.7ms okay and 10.5ms not?  At least for
> the use case we have in the fleet (sensor reading mostly), the less
> disruptive the better as long as things don't timeout and fail.

Well, when you are loading firmware and it takes 10 minutes at
max speed, taking 20-30 minutes is a lot worse.  It's not reading
sensors, which would be fine, it's tranferring large chunks of
data.

> 
> > The process is running at nice 19 priority, so it won't
> > have a significant effect on other processes from a priority
> > point of view.  It may still be hitting the scheduler locks
> > pretty hard, though.  But I played with things quite a bit
> 
> And power.  Imagine multi six digit number of machines burning a full
> core just because of this busy loop to read temperature sensors some
> msecs faster.
> 
> > and the behavior or the management controller is too
> > erratic to set a really good timeout.  Maybe other ones
> > are better, don't know.
> > 
> > One other option we have is that the driver has something
> > called "maintenance mode".  If it detect that you have
> > reset the management controller or are issuing firmware
> > commands, it will modify timeout behavior.  It can also
> > be activated manually.  I could also make it switch to
> > just calling schedule instead of delaying when in that
> > mode.
> 
> Yeah, whatever which makes the common-case behavior avoid busy looping
> would work.

Ok, it's queued in linux-next now (and has been for a few days).
I'll get it into the next kernel release (and I just noticed
a spelling error and fixed it).

-corey

> 
> > The right thing it do is complain bitterly to vendors who
> > build hardware that has to be polled.  But besides that,
> 
> For sure, but there already are a lot of machines with this thing and
> it'll take multiple years for them to retire so...
> 
> > I'm thinking the maintenance mode is the thing to do.
> > It will also change behavior if you reset the management
> > controller, but only for 30 seconds or so.  Does that
> > work?
> 
> Yeah, sounds good to me.
> 
> Thnaks.
> 
> -- 
> tejun
