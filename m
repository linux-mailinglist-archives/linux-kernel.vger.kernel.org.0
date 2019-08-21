Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268F4986EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfHUV5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 17:57:03 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21408 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfHUV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:57:03 -0400
X-Greylist: delayed 26469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 17:57:02 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1566424615; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=UvpBdk+fuAuGtPQhKcAnsqebddmhEzTWNzoCg4Ic8cl6e2L7+YGANoTQNMWwCmMzWrZJgyh04Wj6ZfzBUVxSq8gjZ0zdeHlPC/sTMZ1+1UzfExmBLqez4F93lXClYOa23+DaqWLH1R6sPikcvUSWEHwJIOi9qGyUvoLLRpHVP/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566424615; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=K6p3Ii3/R2/6F+qjk0FyJxibjg29ELjDMma7R5Romts=; 
        b=mvxN036wW0pVPX0RiDCv+VX/gb7OFxvHW+ZawQISxK3GEdiBWt5r8a2fHKJAiM4W2ruHQO+vLmNI/pj1DYqbNHayPERhwuMAahVsvLcsRX3wKzS24eUbkRcXElgBRqZuJhRvkXlouYutEOMEhh5DrCwBNr2qGKoMFAijQPRlt/Q=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566424615;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=429; bh=K6p3Ii3/R2/6F+qjk0FyJxibjg29ELjDMma7R5Romts=;
        b=KFvuWT5sOYWq1qZBxbJIqHdZrR4jtVpruSPFTvjn6qSuQLkY0myd7aS/5EmGMD9E
        dI2aUzhcL4Kl04L0mdOmBoASU7c4rWffS8Dp66b1v1znZnS6lNT3h/jLYgVFxQlnv8Z
        2WQ1ZpSGBIoL2yS49rAv8/WxYbHdgWgzWUzC5aeU=
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2]) by mx.zohomail.com
        with SMTPS id 1566424614832454.3465790795368; Wed, 21 Aug 2019 14:56:54 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:56:53 -0700
From:   stephen@brennan.io
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org,
        Jerry Chuang <jerry-chuang@realtek.com>,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: Added Realtek rtl8192u driver to staging - static analysis
 report.
Message-ID: <20190821215653.GA8199@pride>
References: <cb1222a8-4c67-8fac-f1d9-755e97699caa@canonical.com>
 <20190821205531.GC17415@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821205531.GC17415@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Either way, it's not clear to me and I think the code needs cleaning 
> > up.
> > Any ideas?
> 
> 10+ year old code, yeah!!!
> 
> Just guess, who knows, no one seems to care :(

I'm at least interested in helping with cleaning the code and learning 
about the driver, maybe fixing up logical errors like this at some point.  
But I have had some trouble finding the hardware to test on. Maybe that's 
part of the issue?

