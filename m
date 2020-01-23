Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B71146FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAWR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:28:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727590AbgAWR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579800510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOo86XYx2XlckK7VO6n+fr3sTCswBT7TBWfyx1cJOOc=;
        b=YySNIKSZuBkRGdSaBl99+UpdJzCz87HiA7jMNnhllosix6PS+HdLc2/6GX7iwmun9WBCVp
        NeIa4SUTZAYdJnCa+8FU3cr3Y5sxz0gh+I20dNXnZ4D1icZ5wJyAn4Tc9+HSlVqxgqE7q+
        kQQUkk5pHIjmS11KWaJL8TokmDYkY08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-e2SK6Eb_PMGXILK14ERXWA-1; Thu, 23 Jan 2020 12:28:21 -0500
X-MC-Unique: e2SK6Eb_PMGXILK14ERXWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46061137858;
        Thu, 23 Jan 2020 17:28:19 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C8058CCEC;
        Thu, 23 Jan 2020 17:28:17 +0000 (UTC)
Date:   Thu, 23 Jan 2020 12:28:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stefan Bader <stefan.bader@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Tyler Hicks <tyler.hicks@canonical.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
Message-ID: <20200123172816.GA31063@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
 <20200123103541.GA28102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123103541.GA28102@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2020 at  5:35am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Jan 23 2020 at  4:17am -0500,
> Stefan Bader <stefan.bader@canonical.com> wrote:
> 
> > When device-mapper adapted for multi-queue functionality, they
> > also re-organized the way the make-request function was set.
> > Before, this happened when the device-mapper logical device was
> > created. Now it is done once the mapping table gets loaded the
> > first time (this also decides whether the block device is request
> > or bio based).
> > 
> > However in generic_make_request(), the request function gets used
> > without further checks and this happens if one tries to mount such
> > a partially set up device.
> > 
> > This can easily be reproduced with the following steps:
> >  - dmsetup create -n test
> >  - mount /dev/dm-<#> /mnt
> > 
> > This maybe is something which also should be fixed up in device-
> > mapper.
> 
> I'll look closer at other options.
> 
> > But given there is already a check for an unset queue
> > pointer and potentially there could be other drivers which do or
> > might do the same, it sounds like a good move to add another check
> > to generic_make_request_checks() and to bail out if the request
> > function has not been set, yet.
> > 
> > BugLink: https://bugs.launchpad.net/bugs/1860231
> 
> >From that bug;
> "The currently proposed fix introduces no chance of stability
> regressions. There is a chance of a very small performance regression
> since an additional pointer comparison is performed on each block layer
> request but this is unlikely to be noticeable."
> 
> This captures my immediate concern: slowing down everyone for this DM
> edge-case isn't desirable.

SO I had a look and there isn't anything easier than adding the proposed
NULL check in generic_make_request_checks().  Given the many
conditionals in that  function.. what's one more? ;)

I looked at marking the queue frozen to prevent IO via
blk_queue_enter()'s existing cheeck -- but that quickly felt like an
abuse, especially in that there isn't a queue unfreeze for bio-based.

Jens, I'll defer to you to judge this patch further.  If you're OK with
it: cool.  If not, I'm open to suggestions for how to proceed.  

