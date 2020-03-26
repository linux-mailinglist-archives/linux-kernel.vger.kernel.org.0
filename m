Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BC193DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 12:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCZL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 07:29:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38793 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbgCZL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585222158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xICPx43XxVzlN0L4ORBO4gJ+FNAFRx/9GJmSwyKx370=;
        b=jVEOvkyT12mArPy0tQugo/D/JvdDFFXkk7i5vNjxjxbSgpuaR1sxH40mFTqJvRDRm5flur
        JEvLTEVE50hrFevec8IHcILaQYtRteHhyQflNWdIsm3oqH73Hmc9sEvOv1RU+bf+krL683
        INRWj2GgL7Mf2/FMkwI8QsuNbE3+Eg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Y3J3kDn2MZi8GqVhdry_Zw-1; Thu, 26 Mar 2020 07:29:13 -0400
X-MC-Unique: Y3J3kDn2MZi8GqVhdry_Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C44C8024F4;
        Thu, 26 Mar 2020 11:28:50 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-39.gru2.redhat.com [10.97.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD2EA1036B44;
        Thu, 26 Mar 2020 11:28:49 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C6BA44198B39; Thu, 26 Mar 2020 08:28:32 -0300 (-03)
Date:   Thu, 26 Mar 2020 08:28:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Friesen <chris.friesen@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200326112832.GC17019@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 06:05:27PM +0000, David Laight wrote:
> From: Marcelo Tosatti
> > Sent: 24 March 2020 15:20
> > 
> > This is a kernel enhancement to configure the cpu affinity of kernel
> > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > 
> > When this option is specified, the cpumask is immediately applied upon
> > thread launch. This does not affect kernel threads that specify cpu
> > and node.
> > 
> > This allows CPU isolation (that is not allowing certain threads
> > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > making it possible to enable load balancing on such CPUs
> > during runtime
> ...
> 
> How about making it possible to change the default affinity
> for new kthreads at run time?
> Is it possible to change the affinity of existing threads?
> Or maybe only those that didn't specify an explicit one??
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

Hi David,

Problem with that approach is the window between kernel thread creation 
and cpumask change.

