Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E954AC22B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfI3OIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 10:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfI3OIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDEF21855;
        Mon, 30 Sep 2019 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852496;
        bh=VDbhSD5QYW6zk202BDR/WM3sd0a3/efH6bZ7teyPZIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLDIOiNu3HLHg1pWpCztA/mt8Mea5HTJN4ba2+gjUsY+jmbEzHavx+BmVWVX2BfWl
         klpM4jXH1G60XMDJSDhAxpAK4Z94N2Bb0jF0kHt9CYCFW5DhvWi9lXHnWJsi8Gup/S
         9nc/VGhNm+ieC4lsH5nhBkgcnukj8sEkQq3qDsnA=
Date:   Sun, 29 Sep 2019 16:57:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Staging: exfat: exfat_super.c: fixed camelcase
 coding style issue
Message-ID: <20190929145758.GA2017443@kroah.com>
References: <20190929145057.37752-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929145057.37752-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 09:50:57AM -0500, Jesse Barton wrote:
> Changed function names:
> ffsUmountVol to ffs_umount_vol
> ffsMountVol to ffs_mount_vol
> ffsSyncVol to ffs_sync_vol
> 
> 

That says _what_ you did, but not _why_ you are doing this.

And is this really the best name for these functions?  Why the ffs_*
prefix?

Also, you didn't include the maintainer again, and you didn't thread
your emails using 'git send-email' :(

And finally, you sent a new version of the patch, but did not "version"
it, saying what changed from the previous version.  The documentation
says how to do this, so you might want to re-read that.

Can you please fix this all up and resend the series as "v3"?

thanks,

greg k-h
