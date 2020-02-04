Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8355C152147
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 20:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBDTmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 14:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgBDTmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:42:52 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56D82082E;
        Tue,  4 Feb 2020 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580845371;
        bh=OwjUyYXK8t3y2DVJJLuvBpmv/CS5hDc7JBBI4aQM4/0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KLJstslFYOxpkOBDRvdD6/szsz9T5truuZ8aboKpf+wDPktP1GzjbwLmAcLe7owCT
         t6fRlPNhI2G/Sly1q+PzZ4FN6n1jLfq5bgbLHe0uZt+kKW6rjd+cyl/rOh+WM33tuc
         slZNN4ndtc+38FMeJe0kkstpu1T2geStIffGDxqs=
Message-ID: <0834b616a1c13570bffdf598034f09695362eb00.camel@kernel.org>
Subject: Re: [PATCH v3 1/1] ceph: parallelize all copy-from requests in
 copy_file_range
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Feb 2020 14:42:49 -0500
In-Reply-To: <20200204153050.GA18215@suse.com>
References: <20200203165117.5701-1-lhenriques@suse.com>
         <20200203165117.5701-2-lhenriques@suse.com>
         <0ab59ba87c07ffec6a05b2ed39bc0c112bcf5863.camel@kernel.org>
         <20200204153050.GA18215@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-04 at 15:30 +0000, Luis Henriques wrote:
> On Tue, Feb 04, 2020 at 08:30:03AM -0500, Jeff Layton wrote:
> > On Mon, 2020-02-03 at 16:51 +0000, Luis Henriques wrote:
> > > Right now the copy_file_range syscall serializes all the OSDs 'copy-from'
> > > operations, waiting for each request to complete before sending the next
> > > one.  This patch modifies copy_file_range so that all the 'copy-from'
> > > operations are sent in bulk and waits for its completion at the end.  This
> > > will allow significant speed-ups, specially when sending requests for
> > > different target OSDs.
> > > 
> > 
> > Looks good overall. A few nits below:
> > 
> > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > ---
> > >  fs/ceph/file.c                  | 45 +++++++++++++++++++++-----
> > >  include/linux/ceph/osd_client.h |  6 +++-
> > >  net/ceph/osd_client.c           | 56 +++++++++++++++++++++++++--------
> > >  3 files changed, 85 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > index 1e6cdf2dfe90..b9d8ffafb8c5 100644
> > > --- a/fs/ceph/file.c
> > > +++ b/fs/ceph/file.c
> > > @@ -1943,12 +1943,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >  	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
> > >  	struct ceph_object_locator src_oloc, dst_oloc;
> > >  	struct ceph_object_id src_oid, dst_oid;
> > > +	struct ceph_osd_request *req;
> > >  	loff_t endoff = 0, size;
> > >  	ssize_t ret = -EIO;
> > >  	u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
> > >  	u32 src_objlen, dst_objlen, object_size;
> > >  	int src_got = 0, dst_got = 0, err, dirty;
> > > +	unsigned int max_copies, copy_count, reqs_complete = 0;
> > >  	bool do_final_copy = false;
> > > +	LIST_HEAD(osd_reqs);
> > >  
> > >  	if (src_inode->i_sb != dst_inode->i_sb) {
> > >  		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
> > > @@ -2083,6 +2086,13 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >  			goto out_caps;
> > >  	}
> > >  	object_size = src_ci->i_layout.object_size;
> > > +
> > > +	/*
> > > +	 * Throttle the object copies: max_copies holds the number of allowed
> > > +	 * in-flight 'copy-from' requests before waiting for their completion
> > > +	 */
> > > +	max_copies = (src_fsc->mount_options->wsize / object_size) * 4;
> > 
> > A note about why you chose to multiply by a factor of 4 here would be
> > good. In another year or two, we won't remember.
> 
> Sure, but to be honest I just picked an early suggestion from Ilya :-)
> In practice it means that, by default, 64 will be the maximum requests
> in-flight.  I tested this value, and it looked OK although in the (very
> humble) test cluster I've used a value of 16 (i.e. dropping the factor of
> 4) wasn't much worst.
> 

What happens if you ramp it up to be even more greedy? Does that speed
things up? It might be worth doing some experimentation with a tunable
too?

In any case though, we need to consider what the ideal default would be.
I'm now wondering whether the wsize is the right thing to base this on.
If you have a 1000 OSD cluster, then even 64 actually sounds a bit weak.

I wonder whether it should it be calculated on the fly from some
function of the number OSDs or PGs in the data pool? Maybe even
something like:

    (number of PGs) / 2

...assuming the copies go between 2 PGs. With a perfect distribution, you'd
be able to keep all your OSDs busy that way and do the copy really quickly.

> > > +	copy_count = max_copies;
> > >  	while (len >= object_size) {
> > >  		ceph_calc_file_object_mapping(&src_ci->i_layout, src_off,
> > >  					      object_size, &src_objnum,
> > > @@ -2097,7 +2107,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >  		ceph_oid_printf(&dst_oid, "%llx.%08llx",
> > >  				dst_ci->i_vino.ino, dst_objnum);
> > >  		/* Do an object remote copy */
> > > -		err = ceph_osdc_copy_from(
> > > +		req = ceph_osdc_copy_from(
> > >  			&src_fsc->client->osdc,
> > >  			src_ci->i_vino.snap, 0,
> > >  			&src_oid, &src_oloc,
> > > @@ -2108,21 +2118,40 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >  			CEPH_OSD_OP_FLAG_FADVISE_DONTNEED,
> > >  			dst_ci->i_truncate_seq, dst_ci->i_truncate_size,
> > >  			CEPH_OSD_COPY_FROM_FLAG_TRUNCATE_SEQ);
> > > -		if (err) {
> > > -			if (err == -EOPNOTSUPP) {
> > > -				src_fsc->have_copy_from2 = false;
> > > -				pr_notice("OSDs don't support 'copy-from2'; "
> > > -					  "disabling copy_file_range\n");
> > > -			}
> > > +		if (IS_ERR(req)) {
> > > +			err = PTR_ERR(req);
> > >  			dout("ceph_osdc_copy_from returned %d\n", err);
> > > +
> > > +			/* wait for all queued requests */
> > > +			ceph_osdc_wait_requests(&osd_reqs, &reqs_complete);
> > > +			ret += reqs_complete * object_size; /* Update copied bytes */
> > >  			if (!ret)
> > >  				ret = err;
> > >  			goto out_caps;
> > >  		}
> > > +		list_add(&req->r_private_item, &osd_reqs);
> > >  		len -= object_size;
> > >  		src_off += object_size;
> > >  		dst_off += object_size;
> > > -		ret += object_size;
> > > +		/*
> > > +		 * Wait requests if we've reached the maximum requests allowed
> > 
> > "Wait for requests..."
> > 
> > > +		 * or if this was the last copy
> > > +		 */
> > > +		if ((--copy_count == 0) || (len < object_size)) {
> > > +			err = ceph_osdc_wait_requests(&osd_reqs, &reqs_complete);
> > > +			ret += reqs_complete * object_size; /* Update copied bytes */
> > > +			if (err) {
> > > +				if (err == -EOPNOTSUPP) {
> > > +					src_fsc->have_copy_from2 = false;
> > > +					pr_notice("OSDs don't support 'copy-from2'; "
> > > +						  "disabling copy_file_range\n");
> > > +				}
> > > +				if (!ret)
> > > +					ret = err;
> > > +				goto out_caps;
> > > +			}
> > > +			copy_count = max_copies;
> > > +		}
> > >  	}
> > >  
> > >  	if (len)
> > > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > > index 5a62dbd3f4c2..0121767cd65e 100644
> > > --- a/include/linux/ceph/osd_client.h
> > > +++ b/include/linux/ceph/osd_client.h
> > > @@ -496,6 +496,9 @@ extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
> > >  extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
> > >  extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
> > >  				  struct ceph_osd_request *req);
> > > +extern int ceph_osdc_wait_requests(struct list_head *osd_reqs,
> > > +				   unsigned int *reqs_complete);
> > > +
> > >  extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
> > >  
> > >  extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
> > > @@ -526,7 +529,8 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
> > >  				struct timespec64 *mtime,
> > >  				struct page **pages, int nr_pages);
> > >  
> > > -int ceph_osdc_copy_from(struct ceph_osd_client *osdc,
> > > +struct ceph_osd_request *ceph_osdc_copy_from(
> > > +			struct ceph_osd_client *osdc,
> > >  			u64 src_snapid, u64 src_version,
> > >  			struct ceph_object_id *src_oid,
> > >  			struct ceph_object_locator *src_oloc,
> > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > > index b68b376d8c2f..df9f342f860a 100644
> > > --- a/net/ceph/osd_client.c
> > > +++ b/net/ceph/osd_client.c
> > > @@ -4531,6 +4531,35 @@ int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
> > >  }
> > >  EXPORT_SYMBOL(ceph_osdc_wait_request);
> > >  
> > > +/*
> > > + * wait for all requests to complete in list @osd_reqs, returning the number of
> > > + * successful completions in @reqs_complete
> > > + */
> > 
> > Maybe consider just having it return a positive reqs_complete value or a
> > negative error code, and drop the reqs_complete pointer argument? It'd
> > also be good to note what this function returns.
> 
> In my (flawed) design I wanted to know that there was an error in a
> request but also how many successful requests.  But after the last review
> from Ilya I'll probably need to revisit this anyway.
> 

Sounds good.

> > > +int ceph_osdc_wait_requests(struct list_head *osd_reqs,
> > > +			    unsigned int *reqs_complete)
> > > +{
> > > +	struct ceph_osd_request *req;
> > > +	int ret = 0, err;
> > > +	unsigned int counter = 0;
> > > +
> > > +	while (!list_empty(osd_reqs)) {
> > > +		req = list_first_entry(osd_reqs,
> > > +				       struct ceph_osd_request,
> > > +				       r_private_item);
> > > +		list_del_init(&req->r_private_item);
> > > +		err = ceph_osdc_wait_request(req->r_osdc, req);
> > 
> > ceph_osdc_wait_request calls wait_request_timeout, which uses a killable
> > sleep. That's better than uninterruptible sleep, but maybe it'd be good
> > to use an interruptible sleep here instead? Having to send fatal signals
> > when things are stuck kind of sucks.
> 
> Good point.  It looks like Zheng changed this to a killable sleep in
> commit 0e76abf21e76 ("libceph: make ceph_osdc_wait_request()
> uninterruptible").  I guess you're suggesting to add a new function
> (wait_request_uninterruptible_timeout) that would be used only here,
> right?
> 

Yes, basically. We're not dealing with writeback in this function, so
I'm not so worried about things getting interrupted. If the user wants
to hit ^c here I don't see any reason to wait.

-- 
Jeff Layton <jlayton@kernel.org>

