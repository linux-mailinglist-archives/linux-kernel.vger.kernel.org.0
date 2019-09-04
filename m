Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C74A80F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfIDLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfIDLSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:18:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1172070C;
        Wed,  4 Sep 2019 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567595895;
        bh=yWHSdjU4d8AfL0jzEfSB6FGw86nKw1rLFil3xWXTB8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljyBKRce4TyB4opLJqu+fdtEWMtEIFm7m8rig7Tp3/dm4FtuiWPE1iccLLQ/57t4z
         OUpwFtU83OHzRA3y3GvY1atc6N+EVMfkUtJ0sSctOLFOfZ1/BnNs+BZeYwf/AVZjnN
         vhNst0tv4rVEAvIhnrjYEZXvklmBinztK/kXVOms=
Date:   Wed, 4 Sep 2019 13:18:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     hridya@google.com, devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        joel@joelfernandes.org, kernel-team@android.com,
        christian@brauner.io
Subject: Re: [RESEND PATCH v3 0/2] Add default binderfs devices
Message-ID: <20190904111805.GA10949@kroah.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190904110704.8606-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904110704.8606-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:07:02PM +0200, Christian Brauner wrote:
> Hey,
> 
> This is a resend of Hridya's series to add default binderfs devices. No
> semantical changes were made. Only Joel's Acks were added by me.
> 
> Binderfs was created to help provide private binder devices to
> containers in their own IPC namespace. Currently, every time a new binderfs
> instance is mounted, its private binder devices need to be created via
> IOCTL calls. This patch series eliminates the effort for creating
> the default binder devices for each binderfs instance by creating them
> automatically.

All now applied, thanks!

greg k-h
