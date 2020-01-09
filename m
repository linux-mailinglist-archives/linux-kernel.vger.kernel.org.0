Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1040C1350E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 02:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgAIBKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 20:10:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgAIBKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:10:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9118AAA6;
        Thu,  9 Jan 2020 01:10:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D357DA791; Thu,  9 Jan 2020 02:10:26 +0100 (CET)
Date:   Thu, 9 Jan 2020 02:10:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware
 compression
Message-ID: <20200109011025.GM3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200107143058.GU3929@twin.jikos.cz>
 <20200108105103.29028-1-zaslonko@linux.ibm.com>
 <75a2d45c-fd7b-9542-403d-caea7d977add@toxicpanda.com>
 <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e06859-6174-c80d-3eb6-065f67fbe95d@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:48:31PM +0100, Zaslonko Mikhail wrote:
> >> +        } else if (workspace->strm.avail_out == 0) {
> >> +            /* get another page for the stream end */
> >> +            kunmap(out_page);
> >> +            if (nr_pages == nr_dest_pages) {
> >> +                out_page = NULL;
> >> +                ret = -E2BIG;
> >> +                goto out;
> >> +            }
> >> +            out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> >> +            if (out_page == NULL) {
> >> +                ret = -ENOMEM;
> >> +                goto out;
> >> +            }
> > 
> > Do we need zlib_deflateEnd() for the above error cases?  Thanks,
> 
> The original btrfs code did not call zlib_deflateEnd() for -E2BIG and 
> -ENOMEM cases, so I stick to the same logic.
> Unlike userspace zlib where deflateEnd() frees all dynamically allocated 
> memory, in the kernel it doesn't do much apart from setting the return 
> code (since all the memory allocations for kernel zlib are performed in advance).

Agreed, deflateEnd is not necessary in the error cases.
