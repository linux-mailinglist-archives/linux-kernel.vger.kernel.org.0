Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9587CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406994AbfHIOg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 10:36:28 -0400
Received: from verein.lst.de ([213.95.11.211]:55735 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIOg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:36:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E722868BFE; Fri,  9 Aug 2019 16:36:23 +0200 (CEST)
Date:   Fri, 9 Aug 2019 16:36:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Hellstrom <thomas@shipmail.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190809143623.GA10269@lst.de>
References: <20190808154240.9384-1-hch@lst.de> <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com> <20190808215632.GA12773@lst.de> <c5e7dbac-2d40-60fa-00cc-a275b3aa8373@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e7dbac-2d40-60fa-00cc-a275b3aa8373@shipmail.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 12:21:24AM +0200, Thomas Hellstrom wrote:
> On 8/8/19 11:56 PM, Christoph Hellwig wrote:
>> On Thu, Aug 08, 2019 at 10:50:37AM -0700, Linus Torvalds wrote:
>>>> Note that both Thomas and Steven have series touching this area pending,
>>>> and there are a couple consumer in flux too - the hmm tree already
>>>> conflicts with this series, and I have potential dma changes on top of
>>>> the consumers in Thomas and Steven's series, so we'll probably need a
>>>> git tree similar to the hmm one to synchronize these updates.
>>> I'd be willing to just merge this now, if that helps. The conversion
>>> is mechanical, and my only slight worry would be that at least for my
>>> original patch I didn't build-test the (few) non-x86
>>> architecture-specific cases. But I did end up looking at them fairly
>>> closely  (basically using some grep/sed scripts to see that the
>>> conversions I did matched the same patterns). And your changes look
>>> like obvious improvements too where any mistake would have been caught
>>> by the compiler.
>> I did cross compile the s390 and powerpc bits, but I do not have an
>> openrisc compiler.
>>
>>> So I'm not all that worried from a functionality standpoint, and if
>>> this will help the next merge window, I'll happily pull now.
>> That would help with this series vs the others, but not with the other
>> series vs each other.
>
> Although my series doesn't touch the pagewalk code, it rather borrowed some 
> concepts from it and used for the apply_to_page_range() interface.
>
> The reason being that the pagewalk code requires the mmap_sem to be held 
> (mainly for trans-huge pages and reading the vma->vm_flags if I understand 
> the code correctly). That is fine when you scan the vmas of a process, but 
> the helpers I wrote need to instead scan all vmas pointing into a struct 
> address_space, and taking the mmap_sem for each vma will create lock 
> inversion problems.


True.  So you'll just need to apply the same lessons there, and we
should probably fine with this series going into 5.3-rc.
