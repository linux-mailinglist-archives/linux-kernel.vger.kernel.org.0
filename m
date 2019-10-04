Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5DCB2C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 02:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfJDA0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 20:26:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38131 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfJDA0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 20:26:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so6262175qta.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8ElgbBjvldS7RCANTQX7NP8jCNmVhBUpMx/X3yJJnI=;
        b=V0gIeyikeiCZtCt6Rp3QBzMia/OIN1ZrMPfARnjDaPkm4V//Ololtz3g2tINpmwTOM
         G4h8ADErSWenuWSneClOPnP5fwYjruCLrrB20mTMLMCJ+FPhdKuV4zfQWKP3JjGzRzXL
         sTx9OnXRZidfyv67LSy5DkJNVLGYLoXokm0bt4xU9ppGISWuCXP2y4GP9+Qu2uXgzloY
         fBNANHNH14MZZlVD0T6Z0xJa9gQERDhjGALPG4oO9r+soBJpU7fkNYTBV63b6GmlTvJi
         aqb5QEgOLOytxsQe37CBgS+/bZVAipGHyyr3JBkRMMAVOOpcXjXpQIRK2+XQuswuA4Ee
         TBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8ElgbBjvldS7RCANTQX7NP8jCNmVhBUpMx/X3yJJnI=;
        b=A6HqP/OiJsTmtSNxovwWRHQnMC6EN39ar6Cal2hk7G3aObDptfRITeiNmdScet/Xgo
         YrUlByFu0qNbEa2YbdZUojMQ6Hz6T2Ugq7X3owKGo7ZvcNKHES1NRej51CKMh5dnCb7b
         rb8o15sX/RDs0iNSKJTRiwYw3I0OYrzdCQXEuWK4EUsN8c5XK2Q0Beudnt7KIM5k8wLY
         XpVcJqvzHV1Js3uNQ/W7P1gUTtKbJhTF6S2BfUf8g+5jnMV4LMyIHNrmhZ/9/2aTqAQW
         7qc6JznB5cI38wzWeRmbBGEVhfsLXWcSYAwPoNY1T/bAK+krjkhYrVP9+wHvoyioxFZD
         zsqA==
X-Gm-Message-State: APjAAAVNlWldfed1MQvxqL+neeOC9kpim+Q8E6kEyU0mzCgn737CcGIn
        IKCbiQccSHppFAclON7pKpZFScZySnQ=
X-Google-Smtp-Source: APXvYqy9wrqjsmrH13crtv8A8dB2SxbngdCHEaX3ber47YeIGRtVSMUgPxvnncxcC4QOMG1vCzGS/Q==
X-Received: by 2002:ac8:34c9:: with SMTP id x9mr13318619qtb.65.1570148770503;
        Thu, 03 Oct 2019 17:26:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id i13sm1951713qtm.68.2019.10.03.17.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 17:26:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGBQ9-0000yM-JC; Thu, 03 Oct 2019 21:26:09 -0300
Date:   Thu, 3 Oct 2019 21:26:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191004002609.GB1492@ziepe.ca>
References: <20191003201858.11666-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:47PM -0700, Davidlohr Bueso wrote:
> Hi,
> 
> It has been discussed[1,2] that almost all users of interval trees would better
> be served if the intervals were actually not [a,b], but instead [a, b). This
> series attempts to convert all callers by way of transitioning from using
> "interval_tree_generic.h" to "interval_tree_gen.h". Once all users are converted,
> we remove the former.
> 
> Patch 1: adds a call that will make patch 8 easier to review by introducing stab
>          queries for the vma interval tree.
> 
> Patch 2: adds the new interval_tree_gen.h which is the same as the old one but
>          uses [a,b) intervals.
> 
> Patch 3-9: converts, in baby steps (as much as possible), each interval tree to
> 	   the new [a,b) one. It is done this way also to maintain bisectability.
> 	   Most conversions are pretty straightforward, however, there are some
> 	   creative ways in which some callers use the interval 'end' when going
> 	   through intersecting ranges within a tree. Ie: patch 3, 6 and 9.
> 
> Patch 10: deletes the interval_tree_generic.h header; there are no longer any users.
> 
> Patch 11: finally simplifies x86 pat tree to use the new interval tree machinery.
> 
> This has been lightly tested, and certainly not on driver paths that do non
> trivial conversions. Also needs more eyeballs as conversions can be easily
> missed (even when I've tried mitigating this by renaming the endpoint from 'last'
> to 'end' in each corresponding structure).
> 
> Because this touches a lot of drivers, I'm Cc'ing the whole thing to a couple of
> relevant lists (mm, dri, rdma); sorry if you consider this spam.
> 
> Applies on top of today's linux-next tree. Please consider for v5.5.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/lkml/CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com/

Hurm, this is not entirely accurate. Most users do actually want
overlapping and multiple ranges. I just studied this extensively:

radeon_mn actually wants overlapping but seems to mis-understand the
interval_tree API and actively tries hard to prevent overlapping at
great cost and complexity. I have a patch to delete all of this and
just be overlapping.

amdgpu_mn copied the wrongness from radeon_mn

All the DRM drivers are basically the same here, tracking userspace
controlled VAs, so overlapping is essential

hfi1/mmu_rb definitely needs overlapping as it is dealing with
userspace VA ranges under control of userspace. As do the other
infiniband users.

vhost probably doesn't overlap in the normal case, but again userspace
could trigger overlap in some pathalogical case.

The [start,last] allows the interval to cover up to ULONG_MAX. I don't
know if this is needed however. Many users are using userspace VAs
here. Is there any kernel configuration where ULONG_MAX is a valid
userspace pointer? Ie 32 bit 4G userspace? I don't know. 

Many users seemed to have bugs where they were taking a userspace
controlled start + length and converting them into a start/end for
interval tree without overflow protection (woops)

Also I have a series already cooking to delete several of these
interval tree users, which will terribly conflict with this :\

Is it really necessary to make such churn for such a tiny API change?

Jason
