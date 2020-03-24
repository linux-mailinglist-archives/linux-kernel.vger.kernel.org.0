Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49BE190C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 12:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCXLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 07:39:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38215 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbgCXLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585049942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlHFCzqp2WVbkPpUmilX/qaIGNN4Lns/w3cApjljsW8=;
        b=CKX+tXLPs3Ry8erim5voFzX/IyZlayWd3sm5jAgAiKLk2Y/EFOKutpiKd/MdHdYtmvSGmM
        T7phvpjkZe7yhRg2RKUMgL+j5+mXjB5o8sRMLO64ZkKygD8U5g/BIjYAkUT/o5Y6K+AhBv
        vXSizBn0b8Qx+XOqOBDlFDvEMDZDtN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-Ir62qyZvNHKC2r3mEUc0OA-1; Tue, 24 Mar 2020 07:38:58 -0400
X-MC-Unique: Ir62qyZvNHKC2r3mEUc0OA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92792192D786;
        Tue, 24 Mar 2020 11:38:56 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-9.gru2.redhat.com [10.97.116.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F93A5D9C5;
        Tue, 24 Mar 2020 11:38:56 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8C43C416C887; Tue, 24 Mar 2020 08:38:29 -0300 (-03)
Date:   Tue, 24 Mar 2020 08:38:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] affine kernel threads to specified cpumask
Message-ID: <20200324113829.GA16502@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imiuq0cg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 09:31:59PM +0100, Thomas Gleixner wrote:
> Chris,
> 
> Chris Friesen <chris.friesen@windriver.com> writes:
> > On 3/23/2020 10:22 AM, Thomas Gleixner wrote:
> >> Marcelo Tosatti <mtosatti@redhat.com> writes:
> >>> This allows CPU isolation (that is not allowing certain threads
> >>> to execute on certain CPUs) without using the isolcpus= parameter,
> >>> making it possible to enable load balancing on such CPUs
> >>> during runtime.
> >> 
> >> I'm surely missing some background information, but that sentence does
> >> not make any sense to me.
> >
> > The idea is to affine general kernel threads to specific "housekeeping" 
> > CPUs, while still allowing load balancing of tasks.
> >
> > The isolcpus= boot parameter would prevent kernel threads from running 
> > on the isolated CPUs, but it disables load balancing on the isolated CPUs.
> 
> So why can't we just have a isolcpus mode which allows that instead of
> adding more command line options which are slightly different?
> 
> We just added some magic for managed interrupts to isolcpus, which is
> surely interesting for your scenario as well...
> 
> Thanks,
> 
>         tglx

Hi Thomas, Chris,

Works for me, will adjust and resend.

