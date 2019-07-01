Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C64586BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0QK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 12:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0QK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:10:28 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903C520659;
        Thu, 27 Jun 2019 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561651827;
        bh=CTJeHFiaI+d+UKYintxuxasCkLNX1nctu8884Q3ttz8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=0Y82Gp1bKUV2zB4N2Yev8eOWxhDpl1pmDfR4dFvhNWtdXjs4D7CAgGiHF6nMxFtHE
         t5Jdnm7hJVMhK4pPWOYhISl/dOiaPVVdqZ+lKs/rebhq1vjgY2Wou1wRK2oQBEVE7T
         dk2cZfMI0RNLu93Zqsx9DRIMGosda+RKhhvSsEz8=
Message-ID: <c7fc812e444fee2fa7243044da5a48d1ad5b63ab.camel@kernel.org>
Subject: Re: [RFC PATCH] ceph: initialize superblock s_time_gran to 1
From:   Jeff Layton <jlayton@kernel.org>
To:     Sage Weil <sweil@redhat.com>
Cc:     Luis Henriques <lhenriques@suse.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 12:10:25 -0400
In-Reply-To: <alpine.DEB.2.11.1906271543440.17148@piezo.novalocal>
References: <20190627135122.12817-1-lhenriques@suse.com>
         <0459c2a46200194c14b7474f55071b12fbc3d594.camel@kernel.org>
         <alpine.DEB.2.11.1906271543440.17148@piezo.novalocal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 15:44 +0000, Sage Weil wrote:
> On Thu, 27 Jun 2019, Jeff Layton wrote:
> > On Thu, 2019-06-27 at 14:51 +0100, Luis Henriques wrote:
> > > Having granularity set to 1us results in having inode timestamps with a
> > > accurancy different from the fuse client (i.e. atime, ctime and mtime will
> > > always end with '000').  This patch normalizes this behaviour and sets the
> > > granularity to 1.
> > > 
> > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > ---
> > >  fs/ceph/super.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Hi!
> > > 
> > > As far as I could see there are no other side-effects of changing
> > > s_time_gran but I'm really not sure why it was initially set to 1000 in
> > > the first place so I may be missing something.
> > > 
> > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > index d57fa60dcd43..35dd75bc9cd0 100644
> > > --- a/fs/ceph/super.c
> > > +++ b/fs/ceph/super.c
> > > @@ -980,7 +980,7 @@ static int ceph_set_super(struct super_block *s, void *data)
> > >     s->s_d_op = &ceph_dentry_ops;
> > >     s->s_export_op = &ceph_export_ops;
> > >  
> > > -   s->s_time_gran = 1000;  /* 1000 ns == 1 us */
> > > +   s->s_time_gran = 1;
> > >  
> > >     ret = set_anon_super(s, NULL);  /* what is that second arg for? */
> > >     if (ret != 0)
> > 
> > 
> > Looks like it was set that way since the client code was originally
> > merged. Was this an earlier limitation of ceph that is no longer
> > applicable?
> > 
> > In any case, I see no need at all to keep this at 1000, so:
> 
> As long as the encoded on-write time value is at ns resolution, I 
> agree!  No recollection of why I did this :(
> 
> Reviewed-by: Sage Weil <sage@redhat.com>

Good enough for me. I went ahead and merged this into the testing
branch. Assuming nothing breaks, this should make v5.3.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

