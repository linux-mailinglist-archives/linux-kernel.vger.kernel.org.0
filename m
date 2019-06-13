Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD743A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfFMPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732118AbfFMNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:01:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A481A20B7C;
        Thu, 13 Jun 2019 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560430874;
        bh=APn3yraPudU3cLqd76qubM31tWBb/tFI2DoF6bMlBq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBBtAgBYZbGBvR6fnmX4BT+ftxnnRFvm8wayCVymaNinsDI/ij/Lxow9rg08wkrEY
         6zJ6lnQ9mPqf5UKGMoMcysNsyzs2Eaa9/69hQfALxSuU+NFprRtWbUTK/KjMwl7AD6
         KDKLwQvYoX3F2txsYMBzYED1PsNP6gVl0oRv7VvI=
Date:   Thu, 13 Jun 2019 15:01:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] msm: no need to check return value of debugfs_create
 functions
Message-ID: <20190613130110.GA803@kroah.com>
References: <20190613122402.GA30678@kroah.com>
 <0c09e99e-5cce-5899-d1c6-98791fbd82e0@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c09e99e-5cce-5899-d1c6-98791fbd82e0@free.fr>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 02:37:46PM +0200, Marc Gonzalez wrote:
> On 13/06/2019 14:24, Greg Kroah-Hartman wrote:
> 
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> Naive question: if callers are supposed to ignore the return value,
> why not change the prototype to void (no return value) ?

I am trying to do that, but sometimes you need the return value (like
for debugfs_create_dir()).  I have removed the return value from a
number of debugfs calls already, but the kernel is vast and big, and the
tendrils of debugfs use is deep, it is taking a while :)

Don't worry, there are more patches to come, this is just the first
wave.

thanks,

greg k-h
