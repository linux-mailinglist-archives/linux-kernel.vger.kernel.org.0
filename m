Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93E110B145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfK0O1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 09:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfK0O1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:27:08 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E8A20674;
        Wed, 27 Nov 2019 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574864827;
        bh=GKX7EG2gsuqike/iGhVOQHvsxUfyW3BYSHoQohWUpIY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yq+Otw3Qy3Nb0X7125ZNOAUI0RyKattNT+iUTDEVXRJuSD3XjGiyWqSS7G6FDQ7Fc
         gSv8CAuPm+kBe1PHEJbk6ERrR5+s1NHxeChoMf0dvvvapUYNVVFhBH7cFrwWN9Cq+2
         ZL1wsfLMF5cGBTb+oA5kthO+fGaWI09ipuMANtwo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AD89B352083A; Wed, 27 Nov 2019 06:27:07 -0800 (PST)
Date:   Wed, 27 Nov 2019 06:27:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj38.park@gmail.com>, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: Update ko_KR translations
Message-ID: <20191127142707.GB2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191121234125.28032-1-sj38.park@gmail.com>
 <20191126222144.GW2889@paulmck-ThinkPad-P72>
 <20191127071205.723a33d4@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127071205.723a33d4@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:12:05AM -0700, Jonathan Corbet wrote:
> On Tue, 26 Nov 2019 14:21:44 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Fri, Nov 22, 2019 at 12:41:18AM +0100, SeongJae Park wrote:
> > > This patchset contains updates of Korean translation documents and a fix
> > > of original document.
> > > 
> > > First 4 patches update the Korean translation of memory-barriers.txt.
> > > Fifth patch fixes a broken section reference in the original
> > > memory-barriers.txt.
> > > 
> > > Sixth and seventh patches update the Korean translation of howto.rst.  
> > 
> > The sixth and seventh probably have some other more natural path,
> > but I queued them.  Any chance of a Reviewed-by from one of our other
> > Korean-language kernel hackers?
> 
> I applied the whole set to docs-next a few days ago...apologies if that's
> not the way you wanted these handled.

Even better!  I will drop them from -rcu.

							Thanx, Paul
