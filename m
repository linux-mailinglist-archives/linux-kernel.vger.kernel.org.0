Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E667225C23
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 05:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfEVDYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 23:24:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfEVDYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:24:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B04933025F;
        Wed, 22 May 2019 03:24:09 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5581D646BB;
        Wed, 22 May 2019 03:24:06 +0000 (UTC)
Date:   Wed, 22 May 2019 11:24:02 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org
Subject: Re: [PATCH v4 2/3] x86/kexec/64: Error out if try to jump to old
 4-level kernel from 5-level kernel
Message-ID: <20190522032402.GA31575@dhcp-128-65.nay.redhat.com>
References: <20190509013644.1246-1-bhe@redhat.com>
 <20190509013644.1246-3-bhe@redhat.com>
 <20190522032029.GB31269@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522032029.GB31269@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 22 May 2019 03:24:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/19 at 11:20am, Dave Young wrote:
> On 05/09/19 at 09:36am, Baoquan He wrote:
> > If the running kernel has 5-level paging activated, the 5-level paging
> > mode is preserved across kexec. If the kexec'ed kernel does not contain
> > support for handling active 5-level paging mode in the decompressor, the
> > decompressor will crash with #GP.
> > 
> > Prevent this situation at load time. If 5-level paging is active, check the
> > xloadflags whether the kexec kernel can handle 5-level paging at least in
> > the decompressor. If not, reject the load attempt and print out error
> > message.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/kexec-bzimage64.c | 5 +++++
> 
> How about the userspace kexec-tools?  It needs a similar detection, but
> I'm not sure how to detect paging mode, maybe some sysfs entry or
> vmcoreinfo in /proc/vmcore

meant /proc/kcore ...

Thanks
Dave
