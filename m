Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3BA10D622
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfK2Nco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 08:32:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfK2Nco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:32:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7E120869;
        Fri, 29 Nov 2019 13:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575034362;
        bh=Cfq5ZK607ycaOvEhaKgpcopj1W/rScjfdVMbA32VOQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxbH69XdPxZ6BmRWFheMW6GbMmQrJuQVVyBywQW6+vy9oPSY56QlEkRbjXj7Pl7sL
         fcjRYOQtfFNNJrx1WXcnwDPbbwATOJm6cWrNpFFCZ39I2FuC4jIGocdJkeyUcLdlx/
         m5LlegVXCkmbuJEgkd/EMRltQFjv9KkOo3gjvg48=
Date:   Fri, 29 Nov 2019 14:32:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: gigaset: fix crashes on probe
Message-ID: <20191129133239.GA3703941@kroah.com>
References: <20191129101753.9721-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129101753.9721-1-johan@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 11:17:49AM +0100, Johan Hovold wrote:
> Syzbot has been reporting a GPF on probe in the gigaset ISDN driver,
> which have since been moved to staging.
> 
> The first patch fixes that issue, and the next one fixes a second crash
> found during testing.
> 
> The third patch addresses a benign warning in USB core which syzbot is
> bound to report once the crashes have been fixed.
> 
> And while I hate playing checkpatch games, the final patch addresses a
> checkpatch warning introduced on purpose by the third patch.

I'll take these after 5.5-rc1, but then it is time to just delete all of
drivers/staging/isdn/ from my tree, so don't worry about them after that
:)

thanks,

greg k-h
