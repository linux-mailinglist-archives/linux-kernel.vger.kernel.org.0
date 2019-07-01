Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1945511
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFNGxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 02:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfFNGxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:53:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB3B20673;
        Fri, 14 Jun 2019 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560495221;
        bh=wuUTXFN56UvawcDpp0upIqE8jR1yiNkVbrzRRp7qMFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1FSemE9FNDYxmgCQYzMONszZilvyP63OswdHEot/o2wMC3VwlKk942CueY5gw/5WE
         VJwdcpZlJRWNZZfHgKE3MDbsQO9tHoASvSmr2J/CvWxHDgUTmBwbAcd8t0oi7itxZ4
         ESCybRUSBQv9D7x4hETjGfhG3vtXx1qWxhor05vM=
Date:   Fri, 14 Jun 2019 08:53:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] platform: x86: acer-wmi: no need to check return
 value of debugfs_create functions
Message-ID: <20190614065339.GB21447@kroah.com>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
 <CAHp75VeQy9o6tHtqKEE3o9ijBE4c11cWcc00+RqCj+P1FOky1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeQy9o6tHtqKEE3o9ijBE4c11cWcc00+RqCj+P1FOky1w@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:48:04AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 12, 2019 at 3:13 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Also, because there is no need to save the file dentry, remove the
> > variable that was saving it and just recursively delete the whole
> > directory.
> >
> 
> Through which tree you want to proceed this?

What ever is easier for you, I can take it through mine, as I have a lot
of other patches like this queued up already, or it can go through
yours.

thanks,

greg k-h
