Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D11144C96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 08:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVHsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 02:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgAVHsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:48:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4279924656;
        Wed, 22 Jan 2020 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579679321;
        bh=Y+3AIPhelZvMyzyyNgMwljM/N8u04hwazgjoLNG8NZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGWrSViQ+Kqi84fNtmwtHLmei4RYl7jcYmtvd3GM985/iPGVHIgvVsnRh91ZzM4Z3
         Nh9z7YKPKQyVrsx11g2MQgmAr0DTbKjb/A1kmnp4/A9PswhItSSDqlH6RwdLHvGscA
         ya93dycoqf4X91OHpu+nPtszNZhqglzRMxCbJudA=
Date:   Wed, 22 Jan 2020 08:48:39 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: [External] Re: staging: Add MA USB Host driver
Message-ID: <20200122074839.GA2099857@kroah.com>
References: <VI1PR10MB19659B32E563620B4D63AF1A91320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB1965A077526FE296608D5B1191320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <20200122070312.GB2068857@kroah.com>
 <aba22f24-1124-2203-b9f6-4a5e9274a8a8@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba22f24-1124-2203-b9f6-4a5e9274a8a8@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 07:40:59AM +0000, Vladimir Stankovic wrote:
> Hi Greg,
> 
> Our intention was to follow Linux kernel development process and add our
> driver to staging first.

That's not the "normal" development process at all, where did you read
that?

staging is only for code that needs lots of work, and almost always
merging a driver through staging takes _more_ work from the submitter
than it does to submit it through the "normal" subsystem.

So if you want to do more work, hey, by all means, send it here :)

thanks,

greg k-h
