Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E51F86C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEOQWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 12:22:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43867 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:22:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so536258oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WYwUsFSH86jSsfL1qchJ6LUvivM63x63FlzlKbdmfas=;
        b=uOrgnAPc8uE+qBTcPGAZ/2bMJlapwUBTljMhCFiyEwWUGqnQvxXHV8F+8obCeEJm8s
         4YEBF0qNhKDuYxgiEBDbbH6EhCxggKc1eEW4sDFugrOG2PktbT5uc67ibB2sLTrcPf+5
         ZhSA3Ngg82GvDbiMSF0TfjCxvmNMjxxAn2XNp3eOw4nhOFt9CDOK010JZ0FTXf2jMdFR
         NOlzt+CwucWaXURdPwb34To7dVoBPfvl45gkPIpLbI3iacAWIKZ//joKraLZuIchN8It
         LQY55M8O5+xi3GZO/972ZZM7qsHCyEvyUDOEBFPoUSvVfj8cTfhWkg7X6MFdUOSrPYNd
         IzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WYwUsFSH86jSsfL1qchJ6LUvivM63x63FlzlKbdmfas=;
        b=SCb+WiBtd1WYDsPAWoheAg3aQ8zk+F6TGCoDaEay460aj4Y6IU/biWamPIk1o4mShz
         Aud7S/BI2zeCKFNpSaPVZTLQ/B93ScF9vOsQUGFyL6pj8iIxaEa/BQzLAOlLkoht9WfV
         bNpSXnbBr91aMwYvXL3wb9n9MxvDvockaolTaFtzNrHr8WgTCgV5xb4FL4FK/JDZ7GvO
         96mpk52Kt8wkytJGMTn0JB1SCYl0Q7rgT61qIP2EzKdrXQuqaNyqLntGpbQmvEvjjv6D
         hrLzw4uhWzG77dwQ11O7F8nFf8fujwojmlOhssd5qeYPslo8zFEZP+KHSFcVGKPf6Z/H
         /pdw==
X-Gm-Message-State: APjAAAW37Zx+MJvBg2KXWPHpmThpWPS4YGMNsHD+Z5Ar1Gutdkefi/C9
        XcXil6/sO5bk3d1SF5k5zG+ccQJpDtbZMw==
X-Google-Smtp-Source: APXvYqx9YX6jALD3ezMYYUSQ97jbTW9srhfNABwloH1YvDooZkHcqR7PZkAP4Lndj8fbIzC9xyZS+w==
X-Received: by 2002:a9d:7657:: with SMTP id o23mr26614794otl.358.1557937334761;
        Wed, 15 May 2019 09:22:14 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:9c84:ae86:ff6:562c])
        by smtp.gmail.com with ESMTPSA id r23sm885582otg.49.2019.05.15.09.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 09:22:13 -0700 (PDT)
Date:   Wed, 15 May 2019 11:22:12 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, minyard@acm.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190515162212.GB6050@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
 <20190514084356.GJ2589@hirez.programming.kicks-ass.net>
 <20190514091219.nesriqe7qplk3476@linutronix.de>
 <20190514121350.GA6050@minyard.net>
 <20190514153647.wri6ivffbq7r263y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514153647.wri6ivffbq7r263y@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 05:36:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-14 07:13:50 [-0500], Corey Minyard wrote:
> > > Corey, would it make any change which waiter is going to be woken up?
> > 
> > In the application that found this, the wake order probably isn't
> > relevant.
> 
> what I expected.
> 
> > For other applications, I really doubt that very many are using multiple
> > waiters.  If so, this bug would have been reported sooner, I think.
> 
> most other do either one waiter/waker pair or one waker and multiple
> waiter. And then reinit_completion() is used for the next round.
> 
> > As you mention, for RT you would want waiter woken by priority and FIFO
> > within priority.  I don't think POSIX says anything about FIFO within
> > priority, but that's probably a good idea.  That's no longer a simple
> > wait queue  The way it is now is probably closer to that than what Peter
> > suggested, but not really that close.
> > 
> > This is heavily used in drivers and fs code, where it probably doesn't
> > matter.  I looked through a few users in mm and kernel, and they had
> > one waiter or were init/shutdown type things where order is not important.
> > 
> > So I'm not sure it's important.
> 
> Why did you bring POSIX into this? This isn't an API exported to
> userland which would fall into that category.

My understanding is that POSIX.1b scheduling classes affect everything.
So if you have two processes blocked on the same things for any reason,
you need to wake up the higher priority one first.  In reality, it
probably doesn't matter unless something more critical uses completions. 

> 
> Peter's suggestion for FIFO is that we probably don't want to starve one
> thread/waiter if it is always enqueued at the end of the list. As you
> said, in your case it does not matter because (I assume) each waiter is
> equal and the outcome would be the same.

Yeah, my case is not relevant to this, I'm more concerned with the cases
that are.

-corey

> 
> > -corey
> 
> Sebastian
