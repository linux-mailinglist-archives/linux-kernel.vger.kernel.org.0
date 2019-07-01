Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0242C1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfE1I4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:56:18 -0400
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:10709 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfE1I4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:56:17 -0400
Received: from localhost (unknown [120.132.1.243])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id 02FDBE01982;
        Tue, 28 May 2019 16:56:05 +0800 (CST)
Date:   Tue, 28 May 2019 02:29:25 +0800
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 3/3] nbd: mark sock as dead even if it's the last one
Message-ID: <20190527182925.GC20702@192-168-150-246.7~>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
 <20190524131714.i3lbkbokad6xmotv@MacBook-Pro-91.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524131714.i3lbkbokad6xmotv@MacBook-Pro-91.local.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HM-Spam-Status: e1kIGBQJHllBWUtVQ01DQkJCTExCSUlPSEJNWVdZKFlBSUI3V1ktWUFJV1
        kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6Qgw4IjgrCCNCIQscMQJR
        Iw9PFDRVSlVKTk5CS0hITE1OSk1MVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQUlISk83Bg++
X-HM-Tid: 0a6afda75c9820bdkuqy02fdbe01982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:17:15AM -0400, Josef Bacik wrote:
> On Fri, May 24, 2019 at 05:43:56PM +0800, Yao Liu wrote:
> > When sock dead, nbd_read_stat should return a ERR_PTR and then we should
> > mark sock as dead and wait for a reconnection if the dead sock is the last
> > one, because nbd_xmit_timeout won't resubmit while num_connections <= 1.
> 
> num_connections is the total number of connections that the device was set up
> with, not how many are left.  Now since we have the dead_conn_timeout timeout
> stuff now which didn't exist when I originally wrote this code I'd be ok with
> doing that, but not the way you have it now.  It would be something more like
> 
> 	if (nbd_disconnected(config) ||
> 	    (config->num_connections <= 1 &&
> 	     !config->dead_conn_timeout)
> 
> instead.  Thanks,
> 
> Josef
> 

Your solution is better indeed.
