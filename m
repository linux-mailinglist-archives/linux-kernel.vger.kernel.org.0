Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC38AD694
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390432AbfIIKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 06:18:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390297AbfIIKS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:18:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0DFCAD88;
        Mon,  9 Sep 2019 10:18:26 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ceph: allow object copies across different filesystems in the same cluster
References: <20190906135750.29543-1-lhenriques@suse.com>
        <30b09cb015563913d073c488c8de8ba0cceedd7b.camel@kernel.org>
        <87sgp9o0fo.fsf@suse.com>
        <afce4ec5a02c17121e615423a2e7e1b664aa77a3.camel@kernel.org>
Date:   Mon, 09 Sep 2019 11:18:25 +0100
In-Reply-To: <afce4ec5a02c17121e615423a2e7e1b664aa77a3.camel@kernel.org> (Jeff
        Layton's message of "Sat, 07 Sep 2019 09:53:29 -0400")
Message-ID: <87k1ahojri.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff Layton" <jlayton@kernel.org> writes:

> On Fri, 2019-09-06 at 17:26 +0100, Luis Henriques wrote:
>> "Jeff Layton" <jlayton@kernel.org> writes:
>> 
>> > On Fri, 2019-09-06 at 14:57 +0100, Luis Henriques wrote:
>> > > OSDs are able to perform object copies across different pools.  Thus,
>> > > there's no need to prevent copy_file_range from doing remote copies if the
>> > > source and destination superblocks are different.  Only return -EXDEV if
>> > > they have different fsid (the cluster ID).
>> > > 
>> > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
>> > > ---
>> > >  fs/ceph/file.c | 23 +++++++++++++++++++----
>> > >  1 file changed, 19 insertions(+), 4 deletions(-)
>> > > 
>> > > Hi!
>> > > 
>> > > I've finally managed to run some tests using multiple filesystems, both
>> > > within a single cluster and also using two different clusters.  The
>> > > behaviour of copy_file_range (with this patch, of course) was what I
>> > > expected:
>> > > 
>> > >   - Object copies work fine across different filesystems within the same
>> > >     cluster (even with pools in different PGs);
>> > >   - -EXDEV is returned if the fsid is different
>> > > 
>> > > (OT: I wonder why the cluster ID is named 'fsid'; historical reasons?
>> > >  Because this is actually what's in ceph.conf fsid in "[global]"
>> > >  section.  Anyway...)
>> > > 
>> > > So, what's missing right now is (I always mention this when I have the
>> > > opportunity!) to merge https://github.com/ceph/ceph/pull/25374 :-)
>> > > And add the corresponding support for the new flag to the kernel
>> > > client, of course.
>> > > 
>> > > Cheers,
>> > > --
>> > > Luis
>> > > 
>> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> > > index 685a03cc4b77..88d116893c2b 100644
>> > > --- a/fs/ceph/file.c
>> > > +++ b/fs/ceph/file.c
>> > > @@ -1904,6 +1904,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>> > >  	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
>> > >  	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
>> > >  	struct ceph_cap_flush *prealloc_cf;
>> > > +	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
>> > >  	struct ceph_object_locator src_oloc, dst_oloc;
>> > >  	struct ceph_object_id src_oid, dst_oid;
>> > >  	loff_t endoff = 0, size;
>> > > @@ -1915,8 +1916,22 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>> > >  
>> > >  	if (src_inode == dst_inode)
>> > >  		return -EINVAL;
>> > > -	if (src_inode->i_sb != dst_inode->i_sb)
>> > > -		return -EXDEV;
>> > > +	if (src_inode->i_sb != dst_inode->i_sb) {
>> > > +		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
>> > > +
>> > > +		if (!src_fsc->client->have_fsid || !dst_fsc->client->have_fsid) {
>> > > +			dout("No fsid in a fs client\n");
>> > > +			return -EXDEV;
>> > > +		}
>> > 
>> > In what situation is there no fsid? Old cluster version?
>> > 
>> > If there is no fsid, can we take that to indicate that there is only a
>> > single filesystem possible in the cluster and that we should attempt the
>> > copy anyway?
>> 
>> TBH I'm not sure if 'have_fsid' can ever be 'false' in this call.  It is
>> set to 'true' when handling the monmap, and it's never changed back to
>> 'false'.  Since I don't think copy_file_range will be invoked *before*
>> we get the monmap, it should be safe to drop this check.  Maybe it could
>> be replaced it by a WARN_ON()?
>> 
>
> Yeah. I think the have_fsid flag just allows us to avoid the pr_err msg
> in ceph_check_fsid when the client is initially created. Maybe there is
> some better way to achieve that?

I guess the struct ceph_fsid embedded in the client(s) could be changed
into a pointer initialized to NULL (and later dynamically allocated).
Then, the have_fsid check could be replaced by a NULL check.  Not sure
if it would bring any real benefit, though.  Want me to give that a try?
Or maybe I misunderstood you question.

> In any case, I'd just drop that condition here.

Ok, I'll send v2 in a second, without this check.

[ BTW, looks like my initial post didn't made it into vger.kernel.org.
  It was probably dropped because I screwed-up the 'To:' field in my
  email (no idea how I did that, TBH). ]

Cheers,
-- 
Luis
