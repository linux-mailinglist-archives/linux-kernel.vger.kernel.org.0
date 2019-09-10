Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEBAE93C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfIJLfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 07:35:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:52258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfIJLfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:35:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3D19B6C1;
        Tue, 10 Sep 2019 11:35:21 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 133D9E03B1; Tue, 10 Sep 2019 13:35:21 +0200 (CEST)
Date:   Tue, 10 Sep 2019 13:35:21 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     josef@toxicpanda.com, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, emamd001@umn.edu,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nbd_genl_status: null check for nla_nest_start
Message-ID: <20190910113521.GA9895@unicorn.suse.cz>
References: <20190729130912.7imtg3hfnvb4lt2y@MacBook-Pro-91.local>
 <20190729164226.22632-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729164226.22632-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Just stumbled upon this patch when link to it came with a CVE bug report.)

On Mon, Jul 29, 2019 at 11:42:26AM -0500, Navid Emamdoost wrote:
> nla_nest_start may fail and return NULL. The check is inserted, and
> errno is selected based on other call sites within the same source code.
> Update: removed extra new line.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> ---
>  drivers/block/nbd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 9bcde2325893..2410812d1e82 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2149,6 +2149,11 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
>  	}
>  
>  	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
> +	if (!dev_list) {
> +		ret = -EMSGSIZE;
> +		goto out;
> +	}
> +
>  	if (index == -1) {
>  		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
>  		if (ret) {

You should also call nlmsg_free(reply) when you bail out so that you
don't introduce a memory leak.

Michal Kubecek
