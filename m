Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7702DADA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE2Kcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 06:32:41 -0400
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:6940 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfE2Kcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:32:41 -0400
Received: from localhost (unknown [120.132.1.243])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id 1966BE01AC1;
        Wed, 29 May 2019 18:32:33 +0800 (CST)
Date:   Wed, 29 May 2019 04:05:54 +0800
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Mike Christie <mchristi@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nbd: notify userland even if nbd has already
 disconnected
Message-ID: <20190528200554.GA21633@192-168-150-246.7~>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
 <20190524130856.zod5agp7hk74pcnr@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <20190527182323.GB20702@192-168-150-246.7~>
 <5CED6385.3000802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CED6385.3000802@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HM-Spam-Status: e1kIGBQJHllBWUtVQ01JQkJCQ05NT0xJS0pOWVdZKFlBSUI3V1ktWUFJV1
        kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6USo*Vjg0OiI9KgoSPyhD
        OBNPCzhVSlVKTk5CSklOQk5ISUtIVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQUhOTk83Bg++
X-HM-Tid: 0a6b03260a5320bdkuqy1966be01ac1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:36:21AM -0500, Mike Christie wrote:
> On 05/27/2019 01:23 PM, Yao Liu wrote:
> > On Fri, May 24, 2019 at 09:08:58AM -0400, Josef Bacik wrote:
> >> On Fri, May 24, 2019 at 05:43:55PM +0800, Yao Liu wrote:
> >>> Some nbd client implementations have a userland's daemon, so we should
> >>> inform client daemon to clean up and exit.
> >>>
> >>> Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> >>
> >> Except the nbd_disconnected() check is for the case that the client told us
> >> specifically to disconnect, so we don't want to send the notification to
> >> re-connect because we've already been told we want to tear everything down.
> >> Nack to this as well.  Thanks,
> >>
> >> Josef
> >>
> > 
> > But in userland, client daemon process and process which send disconnect
> > command are not same process, so they are not clear to each other, so
> > client daemon expect driver inform it to exit.
> > In addition, client daemon will get nbd status with nbd_genl_status interface
> > after it get notified and it should not re-connect if status connected == 0
> > 
> 
> When using the netlink interface you get the NBD_CMD_LINK_DEAD first
> then the configs_refs goes to zero right?
> 
> nbd_disconnect_and_put -> sock_shutdown -> nbd_mark_nsock_dead
> 
> then later we do the final nbd_config_put?
> 
> Maybe it would be best to add a new netlink event to signal what has
> happened, because the above nl and stat algorithm seems like a pain. The
> NBD_CMD_LINK_DEAD will be sent, then userspace has to possibly poll the
> status to check if this was caused due to nbd_genl_disconnect instead of
> a downed link due to something like a command timeout, because the
> refcount may not be down when userspace gets the NL event.
> 
> Or, I guess the admin/tool process could just send a msg to the daemon
> process to tell it to do the netlink disconnect request.
> 

Adding a new netlink event sames good.
