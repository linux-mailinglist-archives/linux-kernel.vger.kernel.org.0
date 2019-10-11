Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2AD3971
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfJKGd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 02:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfJKGd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:33:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0C821D56;
        Fri, 11 Oct 2019 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570775604;
        bh=kexi/PchGIii51ijg5Yn+auK9EsQ/SD1LTZB9/0ChgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cORh7use8CI8YZX4RkK3+TPoQbKLkXaRcPc3EWaF9fgaWcKoI2KbDPYDwV+BhoeeR
         y+sGuOgQj1fB5GK2fhUwWAmznwnlTK9w/129p3t+iJSDPQ5bzoWbmonomPfM2Mz96v
         gGnFZYJswscfffOfOnEaOJ8JwazgYZGYKmAOwWMw=
Date:   Fri, 11 Oct 2019 08:33:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        linux-kernel@vger.kernel.org, simon@nikanor.nu,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 2/5] KPC2000: kpc2000_spi.c: Fix style issues (missing
 blank line)
Message-ID: <20191011063321.GB986093@kroah.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
 <20191011055155.4985-2-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011055155.4985-2-chandra627@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:51:52PM -0700, Chandra Annamaneni wrote:
> Resolved: "CHECK: Please use a blank line after.." from checkpatch.pl
> 
> Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>

Please fix the subject lines for all of these patches and resend.

Also, this is a second set of patches, right?  What changed from the
first ones?  You should properly version your patches and explain under
the --- line what changed as the documentation states to.

Please do that for when you resend these.

thanks,

greg k-h
