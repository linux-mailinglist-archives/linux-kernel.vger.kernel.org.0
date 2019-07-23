Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB971F51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 20:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbfGWSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 14:31:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbfGWSbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:31:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 366E8AC93;
        Tue, 23 Jul 2019 18:31:02 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Ilya Dryomov" <idryomov@gmail.com>, "Sage Weil" <sage@redhat.com>,
        <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ceph: fix directories inode i_blkbits initialization
References: <20190723155020.17338-1-lhenriques@suse.com>
        <c657b0d65acd5e8bc9d5d726d68e2ad1fff38b51.camel@kernel.org>
Date:   Tue, 23 Jul 2019 19:31:00 +0100
In-Reply-To: <c657b0d65acd5e8bc9d5d726d68e2ad1fff38b51.camel@kernel.org> (Jeff
        Layton's message of "Tue, 23 Jul 2019 13:18:31 -0400")
Message-ID: <87o91k61sr.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff Layton" <jlayton@kernel.org> writes:

> On Tue, 2019-07-23 at 16:50 +0100, Luis Henriques wrote:
>> When filling an inode with info from the MDS, i_blkbits is being
>> initialized using fl_stripe_unit, which contains the stripe unit in
>> bytes.  Unfortunately, this doesn't make sense for directories as they
>> have fl_stripe_unit set to '0'.  This means that i_blkbits will be set
>> to 0xff, causing an UBSAN undefined behaviour in i_blocksize():
>> 
>>   UBSAN: Undefined behaviour in ./include/linux/fs.h:731:12
>>   shift exponent 255 is too large for 32-bit type 'int'
>> 
>> Fix this by initializing i_blkbits to CEPH_BLOCK_SHIFT if fl_stripe_unit
>> is zero.
>> 
>> Signed-off-by: Luis Henriques <lhenriques@suse.com>
>> ---
>>  fs/ceph/inode.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> Hi Jeff,
>> 
>> To be honest, I'm not sure CEPH_BLOCK_SHIFT is the right value to use
>> here, but for sure the one currently being used isn't correct if the
>> inode is a directory.  Using stripe units seems to be a bug that has
>> been there since the beginning, but it definitely became bigger problem
>> after commit 69448867abcb ("fs: shave 8 bytes off of struct inode").
>> 
>> This fix could also be moved into the 'switch' statement later in that
>> function, in the S_IFDIR case, similar to commit 5ba72e607cdb ("ceph:
>> set special inode's blocksize to page size").  Let me know which version
>> you would prefer.
>> 
>
> What happens with (e.g.) named pipes or symlinks? Do those inodes also
> get this bogus value? Assuming that they do, I'd probably prefer this
> patch since it'd fix things for all inode types, not just directories.

I tested symlinks and they seem to be handled correctly (i.e. the stripe
units seems to be the same as the target file).  Regarding pipes, I
didn't test them, but from the code it should be set to PAGE_SHIFT (see
the above mentioned commit 5ba72e607cdb).

Anyway, I can change the code to do *all* the i_blkbits initialization
inside the switch statement.  Something like:

switch (inode->i_mode & S_IFMT) {
case S_IFIFO:
case S_IFBLK:
case S_IFCHR:
case S_IFSOCK:
	inode->i_blkbits = PAGE_SHIFT;
        ...
case S_IFREG:
	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
	...
case S_IFLNK:
	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
	...
case S_IFDIR:
	inode->i_blkbits = CEPH_BLOCK_SHIFT;
	...
default:
	pr_err();
        ...
}

This would add some code duplication (S_IFREG and S_IFLNK cases), but
maybe it's a bit more clear.  The other option would be obviously to
leave the initialization outside the switch and only change the
i_blkbits value in the S_IF{IFO,BLK,CHR,SOCK,DIR} cases.

Cheers,
-- 
Luis


>
>> Cheers,
>> --
>> Luis
>> 
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 791f84a13bb8..0e6d6db848b7 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -800,7 +800,12 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
>>  
>>  	/* update inode */
>>  	inode->i_rdev = le32_to_cpu(info->rdev);
>> -	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
>> +	/* directories have fl_stripe_unit set to zero */
>> +	if (le32_to_cpu(info->layout.fl_stripe_unit))
>> +		inode->i_blkbits =
>> +			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
>> +	else
>> +		inode->i_blkbits = CEPH_BLOCK_SHIFT;
>>  
>>  	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
>>  
