Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6613B31A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 20:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgANTlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 14:41:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38515 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgANTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:41:50 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so2771717qtp.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VD1VewVfYzcowrTTTc3p/NP2nAZZrqrdh/Y1+DTe6+o=;
        b=fBEWXnlXPRTh7yxZ1lkX1I9O8Fi9nn1GRvSKPOkv4DsNb4xxnzRKN8cEU9sILm04e0
         bKvt9UFvIMbTWGHhe7YTvvPlQDW+At6DCbGnIalW77Mbrd7GEnLW6iSGjbYNeu/LHoc5
         iegGOQZeFHQqNfRl+EQxvE6XDKCXAbG+HJQYE6lRK68aUkQrvSPcn1A3DLI0/KEYibSL
         T07NUjLYFcugJNpLRYOyA2oRhrN5Yz6XOqlLyfGujguLHbb+3HFst8+rveOYK2bbSlGF
         qycO77V5ORIVqXJ3o9WXJXxXx4OJDebAszpViFXpFugNQPa7rt0a9cOcZDK9ZBsZZiFo
         uKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VD1VewVfYzcowrTTTc3p/NP2nAZZrqrdh/Y1+DTe6+o=;
        b=HAkVq1RbijB/oKfW+a9nWLQL/wUYCQ3DWAgNUkqTn+O1Ozz4vS2qH4VrPkKfrr69pw
         tV/itsCS0ySB4ARXkxb4rVxzlEFs0cZezuGWdn9MpLsGqs07I6QnmNJGcfNP2mRC8XdE
         s+8F+XIBXpQW4yFw7MMVs4ebuRiRlNOH2aZUe9DdwDdMuc/CeGJF2JabvWPEZZ/uZA6H
         2WMMKs481Zmcrf0mrW91WfodGlLyogtmx7kot8dUKjrR9uDKvgUmMCmsfB8GwOYXavUo
         sb7XsoZOz4Wo+4rPeGjVdtILTCdQbt42CDF4XXVVxxdUekRmf5UpGwj7/Z7/RBdUyxMU
         hniA==
X-Gm-Message-State: APjAAAVcoPVQ0o+W56GkQMEVQ9rfpQymHUJ9+IehK9TA/mO0F9RiEuxM
        QvZxkDgkPchtdLhEMw+/PPq+dQ==
X-Google-Smtp-Source: APXvYqyZXNJxL/f6fEf8lTGkE6lao/zdKc6zFDFvbpLKofSirhqC8ULCTv5Dyqi9Xe7jEJK/Am2mwg==
X-Received: by 2002:ac8:4289:: with SMTP id o9mr173201qtl.277.1579030910016;
        Tue, 14 Jan 2020 11:41:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k4sm7189056qki.35.2020.01.14.11.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 11:41:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irS4S-0006jm-U1; Tue, 14 Jan 2020 15:41:48 -0400
Date:   Tue, 14 Jan 2020 15:41:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     madhuparnabhowmik04@gmail.com, mike.marciniszyn@intel.com,
        paulmck@kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200114194148.GD22037@ziepe.ca>
References: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
 <20200114165740.GB22037@ziepe.ca>
 <74adec84-ec5b-ea1b-7adf-3f8608838259@intel.com>
 <25133367-6544-d0af-ae30-5178909748b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25133367-6544-d0af-ae30-5178909748b1@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:24:00PM -0500, Dennis Dalessandro wrote:
> On 1/14/2020 12:00 PM, Dennis Dalessandro wrote:
> > On 1/14/2020 11:57 AM, Jason Gunthorpe wrote:
> > > On Tue, Jan 14, 2020 at 09:53:45PM +0530,
> > > madhuparnabhowmik04@gmail.com wrote:
> > > > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > > 
> > > > list_for_each_entry_rcu has built-in RCU and lock checking.
> > > > Pass cond argument to list_for_each_entry_rcu.
> > > > 
> > > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > >   drivers/infiniband/hw/hfi1/verbs.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/hfi1/verbs.c
> > > > b/drivers/infiniband/hw/hfi1/verbs.c
> > > > index 089e201d7550..22f2d4fd2577 100644
> > > > +++ b/drivers/infiniband/hw/hfi1/verbs.c
> > > > @@ -515,7 +515,7 @@ static inline void hfi1_handle_packet(struct
> > > > hfi1_packet *packet,
> > > >                          opa_get_lid(packet->dlid, 9B));
> > > >           if (!mcast)
> > > >               goto drop;
> > > > -        list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> > > > +        list_for_each_entry_rcu(p, &mcast->qp_list, list,
> > > > lockdep_is_held(&(ibp->rvp.lock))) {
> > > 
> > > Okay, this looks reasonable
> > > 
> > > Mike, Dennis, is this the right lock to test?
> > > 
> > 
> > I'm looking at that right now actually, I don't think this is correct.
> > Wanted to talk to Mike before I send a response though.
> > 
> > -Denny
> 
> That's definitely going to throw a ton of lock dep messages. It's not really
> the right lock either. Instead what we probably need to do is what we do in
> the non-multicast part of the code and take the rcu_read_lock().

Uh.. why is this using the _rcu varient without holding the rcu lock?
That is quite wrong already.

Jason
