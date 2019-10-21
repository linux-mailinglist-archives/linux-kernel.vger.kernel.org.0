Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12139DE4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJUGmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 02:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfJUGmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:42:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A52F8B373;
        Mon, 21 Oct 2019 06:42:11 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D50D7E3C6D; Mon, 21 Oct 2019 08:42:10 +0200 (CEST)
Date:   Mon, 21 Oct 2019 08:42:10 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>, emamd001@umn.edu,
        smccaman@umn.edu, kjlu@umn.edu, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH v3] nbd_genl_status: null check for nla_nest_start
Message-ID: <20191021064210.GD27784@unicorn.suse.cz>
References: <20190910113521.GA9895@unicorn.suse.cz>
 <20190911164013.27364-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911164013.27364-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:40:12AM -0500, Navid Emamdoost wrote:
> nla_nest_start may fail and return NULL. The check is inserted, and
> errno is selected based on other call sites within the same source code.
> Update: removed extra new line.
> v3 Update: added release reply, thanks to Michal Kubecek for pointing
> out.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/block/nbd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e21d2ded732b..8a9712181c2a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2149,6 +2149,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
>  	}
>  
>  	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
> +	if (!dev_list) {
> +		nlmsg_free(reply);
> +		ret = -EMSGSIZE;
> +		goto out;
> +	}
> +
>  	if (index == -1) {
>  		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
>  		if (ret) {

Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
