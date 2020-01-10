Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F381373B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAJQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 11:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgAJQbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:31:43 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65178205F4;
        Fri, 10 Jan 2020 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578673902;
        bh=Rrk4n1nHKqxj+BZCcSgnpXUKkWUtPTA1mv68Gy7dZO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrbMpNEO3empPNaJOZ9/BBjsosxffjbyeTmhwaC5ygwe1vlJhhVWfAh0XUUOmOySF
         nPLJuu4WDpKEvLXufBqY1wH+gLdayWRrZ2S6z2KwnwLWQ/Z/yLjN7KIp/aLEd+Sx26
         dThCEIS9BeCJC1ZHLa2ixTdNyl1x5Tb/XyRM+3G0=
Date:   Sat, 11 Jan 2020 01:31:34 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
References: <20200110132356.27110-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110132356.27110-1-frextrite@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> +#define subsys_lock_held() \
> +	lockdep_is_held(&subsys->lock)

This macro requires "struct nvmet_subsys *subsys" was previously declared
in the function using it, which isn't obvious when looking at the users. I
don't think that's worth the conciseness.

> @@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	} else {
>  		struct nvmet_ns *old;
>  
> -		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
> +		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
> +							subsys_lock_held()) {
>  			BUG_ON(ns->nsid == old->nsid);
>  			if (ns->nsid < old->nsid)
>  				break;
