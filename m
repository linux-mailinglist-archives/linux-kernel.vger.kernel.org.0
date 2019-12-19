Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF55125938
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 02:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSB3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 20:29:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57603 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbfLSB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576718974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LhO4qnJS45ZijWda0VRuzykvBdUDahmQTHCJMOmgGs=;
        b=QPlHRIHbQjUaUS9DdNlALFjTRxw7T88lvqrmSDQeUxD3A/aQrxixAcRNLvXXqU38aAYhxZ
        VDwEgELfl3OiPP9oPGTX5alRLv0T/n4w/X6FXAw/tIIa1hxQRw/sq+fiNfBzaNgcn237jP
        dHNZOCU+PngC0PerSTEmKi/Z1+lefh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-fS7bsj_0OvSazFPteXhE0Q-1; Wed, 18 Dec 2019 20:29:31 -0500
X-MC-Unique: fS7bsj_0OvSazFPteXhE0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB361854334;
        Thu, 19 Dec 2019 01:29:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E894F5C28C;
        Thu, 19 Dec 2019 01:29:19 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:29:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 1/3] sched/core: add API for exporting runqueue clock
Message-ID: <20191219012914.GA6080@ming.t460p>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-2-ming.lei@redhat.com>
 <20191218095101.GQ2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218095101.GQ2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:51:01AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 03:19:40PM +0800, Ming Lei wrote:
> > Scheduler runqueue maintains its own software clock that is periodically
> > synchronised with hardware. Export this clock so that it can be used
> > by interrupt flood detection for saving the cost of reading from hardware.
> 
> But you don't have much, if any, guarantees the thing gets updated.

Any software clock won't be guaranteed to be updated in time, however,
they are still useful.

Thanks,
Ming

