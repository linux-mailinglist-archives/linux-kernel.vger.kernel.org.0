Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A20133098
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 21:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAGUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 15:33:57 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35739 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgAGUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:33:57 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so469553qvi.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3zhpjGKRs5oCN7gE0zJUv09fBYY5DJxxWR8yhyAhckI=;
        b=LzfATNAFVRCE8SAl1d6Ctk4/lJ3RQSwN2ruwf6LC27wA411ljbwylPEOr6fqE9gRJK
         /aW3Q/ojQqDrhd3inOEO0hHNcy6SAQJ1vTsbc9lFG5jVP3pvqSdDSaU8Pa5owAqvBU8B
         luGS4iid5TYnlqBU3ecv9aw61bsN9ZpBz3F+DDSVAdrPb4wNO92hWHqqoQxhrBdpv5Ph
         oPrKDojhIIATLeooNxbXC9kMnsP5qZA1e90aV/Tz4jgc5sIqaT9AIJXuDHRgZ+XbpjTv
         +nk4SnEi+FeRmci7r55ERdAASdZgPpAY02r9b46vZe0iLEDR3Xge2WCmwVarMRF8iPmL
         g1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zhpjGKRs5oCN7gE0zJUv09fBYY5DJxxWR8yhyAhckI=;
        b=GxfriBa9LKz3BuGlKA7z1HbK3c6uuOLePXbLv8BXK2crJjKBaVQ9UBhOpSkna5wmcm
         Alo5jf3vSfk/Tek1OVJj4q7ltse3NH4Cohe5uJs7ktn1RvRm6dx9vmUocqfCT1J2KtST
         DVNUhaEmiUxc7mWuzNc5Z6MK1kDgbv1TAYntlmSrn98bPn1rPQy90iH1TMtXmAq+cDo3
         K64TGycmF/q3I6J60t+XUOhlSDhzz0Zgla0VFeFISH2TOAaGGnxeBPTaFTNebbP3zUFs
         1XXZkSrd1K97vkkLTuXHVi0T+BmmcYxADU7FcYVufHhGyPVLooV4HRQegh6W0vdIhEuV
         JGUA==
X-Gm-Message-State: APjAAAXlo0l+HtOeZ79rKeQsQGF/wWbwbrZjzGQiqZpJZ5qKn6TpaVqq
        uBWNzamfxSg18IXv8b+RJOHkVw==
X-Google-Smtp-Source: APXvYqzWbftKZEr84YWD8iGrR1oDz0h1VmVb/RITKJH7Bi68eIZnbK/lkG9EUM5l75oi0+8mHGJU/Q==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr1181882qvt.71.1578429235967;
        Tue, 07 Jan 2020 12:33:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i28sm446729qtc.57.2020.01.07.12.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:33:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iovY2-0001Xd-Ue; Tue, 07 Jan 2020 16:33:54 -0400
Date:   Tue, 7 Jan 2020 16:33:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     madhuparnabhowmik04@gmail.com
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200107203354.GD26174@ziepe.ca>
References: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 12:59:12AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>  drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index 089e201d7550..e6abdbcb4ffb 100644
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
>  				       opa_get_lid(packet->dlid, 9B));
>  		if (!mcast)
>  			goto drop;
> -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> +		list_for_each_entry_rcu(p, &mcast->qp_list, list,
> +					lock_is_held(&(ibp->rvp.lock).dep_map)) {

Why .dep_map? Does this compile?

Jason
