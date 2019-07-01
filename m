Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927302C1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE1IuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:50:07 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:52779 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1IuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:50:07 -0400
Received: from localhost (unknown [120.132.1.243])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 4128A41B45;
        Tue, 28 May 2019 16:50:03 +0800 (CST)
Date:   Tue, 28 May 2019 02:23:23 +0800
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 2/3] nbd: notify userland even if nbd has already
 disconnected
Message-ID: <20190527182323.GB20702@192-168-150-246.7~>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
 <20190524130856.zod5agp7hk74pcnr@MacBook-Pro-91.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524130856.zod5agp7hk74pcnr@MacBook-Pro-91.local.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HM-Spam-Status: e1kIGBQJHllBWUtVQ01DQkJCTExCSUlPSEJNWVdZKFlBSUI3V1ktWUFJV1
        kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6Pio4HDg5OiM*SBc3Py4C
        Qh0wCyxVSlVKTk5CS0hIT0tIT0lJVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQUlIQk43Bg++
X-HM-Tid: 0a6afda1d7ae2086kuqy4128a41b45
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:08:58AM -0400, Josef Bacik wrote:
> On Fri, May 24, 2019 at 05:43:55PM +0800, Yao Liu wrote:
> > Some nbd client implementations have a userland's daemon, so we should
> > inform client daemon to clean up and exit.
> > 
> > Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> 
> Except the nbd_disconnected() check is for the case that the client told us
> specifically to disconnect, so we don't want to send the notification to
> re-connect because we've already been told we want to tear everything down.
> Nack to this as well.  Thanks,
> 
> Josef
> 

But in userland, client daemon process and process which send disconnect
command are not same process, so they are not clear to each other, so
client daemon expect driver inform it to exit.
In addition, client daemon will get nbd status with nbd_genl_status interface
after it get notified and it should not re-connect if status connected == 0
