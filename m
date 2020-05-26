Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976F11989D9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 04:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgCaCRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 22:17:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33730 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729239AbgCaCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585621024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NoKfyvDtclhsXXCgoG9PQCptBCeb8aNEYNrgbbOSSA4=;
        b=LCCAWaEoljAZ13gZvLS81UqBr4Hypv8b7cpTcznwYZqvG7Rbi/3mRJiso9kpzvRq8sC3fP
        oQNfQBjAAblKTr3B6j3JSV4PfNIrAd7p1QKRlIwdy8oLiKlQyKy1JKpEEQM4kAMmsmLcC3
        IOx+BfiXI7l2HC4j6VHbJ++mCOS/UxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-a6JbvxOQPwahM5QOk59Uqw-1; Mon, 30 Mar 2020 22:17:00 -0400
X-MC-Unique: a6JbvxOQPwahM5QOk59Uqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5769418B9FCC;
        Tue, 31 Mar 2020 02:16:57 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D63F5DC18;
        Tue, 31 Mar 2020 02:16:53 +0000 (UTC)
Date:   Tue, 31 Mar 2020 10:16:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Kairui Song <kasong@redhat.com>, anthony.yznaga@oracle.com,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        Dave Young <dyoung@redhat.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dwmw@amazon.com,
        benh@amazon.com, Jan Kiszka <jan.kiszka@siemens.com>,
        alcioa@amazon.com, aggh@amazon.com, aagch@amazon.com,
        dhr@amazon.com, Laszlo Ersek <lersek@redhat.com>,
        Lianbo Jiang <lijiang@redhat.com>, brijesh.singh@amd.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org,
        "Schoenherr, Jan H." <jschoenh@amazon.de>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200331021649.GM9942@MiWiFi-R3L-srv>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
 <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/20 at 10:42pm, Alexander Graf wrote:
> 
> 
> On 30.03.20 15:40, Konrad Rzeszutek Wilk wrote:
> > 
> > 
> > 
> > On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
> > > On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
> > > > 
> > > > On 03/26/20 at 05:29pm, Alexander Graf wrote:
> > > > > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > > > > DMAable data. It is usually used for the compatibility case where devices
> > > > > can only DMA to a "low region".
> > > > > 
> > > > > However, in some scenarios this "low region" may be bound even more
> > > > > heavily. For example, there are embedded system where only an SRAM region
> > > > > is shared between device and CPU. There are also heterogeneous computing
> > > > > scenarios where only a subset of RAM is cache coherent between the
> > > > > components of the system. There are partitioning hypervisors, where
> > > > > a "control VM" that implements device emulation has limited view into a
> > > > > partition's memory for DMA capabilities due to safety concerns.
> > > > > 
> > > > > This patch adds a command line driven mechanism to move all DMA memory into
> > > > > a predefined shared memory region which may or may not be part of the
> > > > > physical address layout of the Operating System.
> > > > > 
> > > > > Ideally, the typical path to set this configuration would be through Device
> > > > > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > > > > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > > > > instead configure the system purely through kernel command line options.
> > > > > 
> > > > > I'm sure other people will find the functionality useful going forward
> > > > > though and extend it to be triggered by DT/ACPI in the future.
> > > > 
> > > > Hmm, we have a use case for kdump, this maybe useful.  For example
> > > > swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
> > > > kernel we have to increase the crashkernel reserved size for the extra
> > > > swiotlb requirement.  I wonder if we can just reuse the old kernel's
> > > > swiotlb region and pass the addr to kdump kernel.
> > > > 
> > > 
> > > Yes, definitely helpful for kdump kernel. This can help reduce the
> > > crashkernel value.
> > > 
> > > Previously I was thinking about something similar, play around the
> > > e820 entry passed to kdump and let it place swiotlb in wanted region.
> > > Simply remap it like in this patch looks much cleaner.
> > > 
> > > If this patch is acceptable, one more patch is needed to expose the
> > > swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
> > > second kernel.
> > 
> > We seem to be passsing a lot of data to kexec.. Perhaps something
> > of a unified way since we seem to have a lot of things to pass - disabling
> > IOMMU, ACPI RSDT address, and then this.
> > 
> > CC-ing Anthony who is working on something - would you by any chance
> > have a doc on this?
> 
> 
> I see in general 2 use cases here:
> 
> 
> 1) Allow for a generic mechanism to have the fully system, individual buses,
> devices or functions of a device go through a particular, self-contained
> bounce buffer.
> 
> This sounds like the holy grail to a lot of problems. It would solve typical
> embedded scenarios where you only have a shared SRAM. It solves the safety
> case (to some extent) where you need to ensure that one device interaction
> doesn't conflict with another device interaction. It also solves the problem
> I've tried to solve with the patch here.
> 
> It's unfortunately a lot harder than the patch I sent, so it will take me
> some time to come up with a working patch set.. I suppose starting with a DT
> binding only is sensible. Worst case, x86 does also support DT ...
> 
> (And yes, I'm always happy to review patches if someone else beats me to it)
> 
> 
> 2) Reuse the SWIOTLB from the previous boot on kexec/kdump
> 
> I see little direct relation to SEV here. The only reason SEV makes it more
> relevant, is that you need to have an SWIOTLB region available with SEV
> while without you could live with a disabled IOMMU.
> 
> However, I can definitely understand how you would want to have a way to
> tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse its
> memory for its own SWIOTLB. That way, you don't have to reserve another 64MB
> of RAM for kdump.
> 
> What I'm curious on is whether we need to be as elaborate. Can't we just
> pass the old SWIOTLB as free memory to the new kexec'ed kernel and
> everything else will fall into place? All that would take is a bit of
> shuffling on the e820 table pass-through to the kexec'ed kernel, no?

Swiotlb memory have to be continuous. We can't guarantee that region
won't be touched by kernel allocation before swiotlb init. Then we may
not have chance to get a continuous region of memory block again for
swiotlb. This is our main concern when reusing swiotlb for kdump.

