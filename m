Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934756719C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfGLOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 10:43:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47072 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGLOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:42:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id r4so6515707qkm.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3BdLjsUkgLwHfdAsKdRe62P0E0PJoOA0Fuha9hcEks=;
        b=QOEsPXPs/lkmtClQEqCWD2PByv8luGSKD7glXzSwu8n9xHK8eP7l9Nz7VxMP+dgpQZ
         qVt7cABY3efBX0yb1aliiIl0/W41qPs/TM6/fVjlXBl/bkIuDI7AeoPm8UdZb6/KrnVN
         CdjzVLYtvsLTECEdKD83FTAcxu25liR75c2DgFdBsd94ztwb+PijBlBUQ1Cmiyk6MuAA
         y48Xn+z1WWX9I1qcC2KO8mLCNUnVkIcsQcmK4sxttJsKe+f+iWnTYr9O8RARpxIaBASI
         TLnpK3kgRTPdcts3zst0PAXGUo4qZbVxZTyixyxRarYgg8OA1a/8Pk8JYXfpRzt7CIwg
         xHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3BdLjsUkgLwHfdAsKdRe62P0E0PJoOA0Fuha9hcEks=;
        b=mqqDwXm9jf0LC65wqSFPg276sp9Eh8kAYNgrmYjxGSgpsFB0Ybz+gm63tBnb8tTvBD
         GGHbm2sK72xlyJ7LBTbtWq3Vq7IsD8hCgZTiN/LGUVwdKO0oGqIuH3Cuzmc/ttNGEOXt
         t2sNmy2R1WO7yLfDbIVR35rcWQJuqD56Ct6lVOXl8GWviakJ/GaCju2us9TVRCVlsNCe
         Jgs7riAdk0TzvManIyCVEKXGS823XyUOwCBk0Jr4Op2v3lU/W6eNU0Lwy5//4elloovx
         ZLe8EFKjdwUE5qXEnQGSnnsRp+ISJwTXVr15AqE4B/yp0gb15CnUPody2prX9hiMvkIK
         bhAA==
X-Gm-Message-State: APjAAAXQKYTCiRVLWC2r9vXtq0Y3mwV1lfAzJagwsLDJ00fW80tVKIAS
        FRIf0zm4/t0HR9Kw5BoQHu4mUoMu8WY1oQ==
X-Google-Smtp-Source: APXvYqy/Pcvk8vVNUL2Et1UN+2Fg3a/OfJoXceL8cmfop9PGLqawx6jAHDxYaoDBtMhcGI2fvtYt3Q==
X-Received: by 2002:a37:c448:: with SMTP id h8mr6570665qkm.308.1562942578921;
        Fri, 12 Jul 2019 07:42:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j78sm3781711qke.102.2019.07.12.07.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 07:42:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlwlF-0001tF-Iv; Fri, 12 Jul 2019 11:42:57 -0300
Date:   Fri, 12 Jul 2019 11:42:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712144257.GE27512@ziepe.ca>
References: <20190712135339.GC27512@ziepe.ca>
 <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:35:50PM +0000, Bernard Metzler wrote:

> >This looks wrong to me.. a userspace notification re-arm cannot be
> >lost, so have a split READ/TEST/WRITE sequence can't possibly work?
> >
> >I'd expect an atomic test and clear here?
> 
> We cannot avoid the case that the application re-arms the
> CQ only after a CQE got placed. That is why folks are polling the
> CQ once after re-arming it - to make sure they do not miss the
> very last and single CQE which would have produced a CQ event.

That is different, that is re-arm happing after a CQE placement and
this can't be fixed.

What I said is that a re-arm from userspace cannot be lost. So you
can't blindly clear the arm flag with the WRITE_ONCE. It might be OK
beacuse of the if, but...

It is just goofy to write it without a 'test and clear' atomic. If the
writer side consumes the notify it should always be done atomically.

And then I think all the weird barriers go away

> >> @@ -1141,11 +1145,17 @@ int siw_req_notify_cq(struct ib_cq
> >*base_cq, enum ib_cq_notify_flags flags)
> >>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
> >>  
> >>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> >> -		/* CQ event for next solicited completion */
> >> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> >> +		/*
> >> +		 * Enable CQ event for next solicited completion.
> >> +		 * and make it visible to all associated producers.
> >> +		 */
> >> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
> >
> >But what is the 2nd piece of data to motivate the smp_store_mb?
> 
> Another core (such as a concurrent RX operation) shall see this
> CQ being re-armed asap.

'ASAP' is not a '2nd piece of data'. 

AFAICT this requirement is just a normal atomic set_bit which does
also expedite making the change visible?
 
Jason
