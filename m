Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AE81FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfHEPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 11:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728952AbfHEPMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:12:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DBA4216F4;
        Mon,  5 Aug 2019 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017967;
        bh=CdHJI1xxjYQT/XPUsv9iLn5EoLIKEmIfLcVw5q3BXpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGXhUgRDv+erRZ4lwM7QApypM09xE32YoD3Zl7OF3eNOe99mLFBmfJibfFyxKNDMg
         dgsAy3gWqi21y2uy4qw6txC9V6vTeiPdIEmIdRbg86RFnuzqaE9HF/PE3BDOiaQT+t
         mtBURjAst7g/FByoUbmewut+mbUk9i/YgS4zcaSs=
Date:   Mon, 5 Aug 2019 17:12:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190805151244.GA28296@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 02:17:00AM +0200, Jiri Kosina wrote:
> On Thu, 25 Jul 2019, Greg Kroah-Hartman wrote:
> 
> > To address the requirements of embargoed hardware issues, like Meltdown,
> > Spectre, L1TF, etc. it is necessary to define and document a process for
> > handling embargoed hardware security issues.
> 
> I don't know what exactly went wrong, but there is a much more up-to-date 
> version of that document (especially when it comes to vendor contacts), 
> which I sent around on Thu, 2 May 2019 20:23:48 +0200 (CEST) already. 
> Please find it below.

Ah, sorry, don't know what happened here, we had too many different
versions floating around.

I'll take your version, make the edits recommended and send out a new
one in a few days, thanks!

greg k-h
