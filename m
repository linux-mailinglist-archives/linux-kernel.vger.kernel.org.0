Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F244241B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409063AbfFLLfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 07:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409013AbfFLLfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:35:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE7C208CA;
        Wed, 12 Jun 2019 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560339341;
        bh=vbsw585KDfkQ9OMAtYE48UzasxfW4XpuvOipncFkOos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfhEZHdWvIVOIl+FQ+wF81+ulljztmT93OH6xbszdCsAVrKp9QFuYFpvClBk5GlNi
         c1yJZQfoe2nfI4J4lnsVVCJY43D/NYRGSDOoLwHJArqJLlyMOui5i1UDExmOMmiayW
         /jUUpguH9t3vew2IlD6lP0A1OVVmi0kXUN7faIgE=
Date:   Wed, 12 Jun 2019 13:35:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Julien Freche <jfreche@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmw_ballon: no need to check return value of
 debugfs_create functions
Message-ID: <20190612113538.GA14793@kroah.com>
References: <20190611185528.GA4659@kroah.com>
 <5A5203EB-A789-4C48-9C25-EF0C0CBCE5CD@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5A5203EB-A789-4C48-9C25-EF0C0CBCE5CD@vmware.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:36:36PM +0000, Nadav Amit wrote:
> Please change the title of the patch to “vmw_balloon” (it is currently
> “vmw_ballon”).

Oops, will fix, sorry about that.

> > On Jun 11, 2019, at 11:55 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> I remember I saw a discussion about it, and didn’t know the resolution.
> 
> If that's the decision (assuming debugfs initialization always succeeds),
> and after fixing the title of the patch:
> 
>   Acked-by: Nadav Amit <namit@vmware.com>

Thanks for the review!

greg k-h
