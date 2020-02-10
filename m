Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0553156DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 03:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgBJCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 21:33:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726915AbgBJCdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581301983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NW3KiB3sl0JCR2c177SsndQZiB8C+f9+dGA/UqJoXIs=;
        b=E0rKUPVwNGLeVC7rF22Y+wZGpMA1PELGw+pRn4Eh7CW0qaGLMX4tLB0Wx/0ZpvOblWFr/U
        Xyy+5WM30zexKwInfelbIR1eLow2vMUYRTTBEGppPPzSEPmQnCR0+4mxYl63oNWK+Gzl1j
        Xc4p3apK483TUvkxXdZP+nqkhh9+eGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-OjsEz-KPMTiA8RVggJXFOg-1; Sun, 09 Feb 2020 21:32:59 -0500
X-MC-Unique: OjsEz-KPMTiA8RVggJXFOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73C48017DF;
        Mon, 10 Feb 2020 02:32:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D4C27FB60;
        Mon, 10 Feb 2020 02:32:45 +0000 (UTC)
Date:   Mon, 10 Feb 2020 10:32:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        dhowells@redhat.com, asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com,
        luoshijie1@huawei.com, jan kara <jack@suse.cz>
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
Message-ID: <20200210023240.GA10029@ming.t460p>
References: <20200206111052.45356-1-yukuai3@huawei.com>
 <70ce8830-2594-2b7b-9ca9-5fb7edd374d7@acm.org>
 <f89ae154-d6b7-0a3b-060d-f3131b0c1c1d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89ae154-d6b7-0a3b-060d-f3131b0c1c1d@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:13:22AM +0800, yukuai (C) wrote:
> On 2020/2/10 9:00, Bart Van Assche wrote:
> > Have you already noticed patch "[PATCH] blktrace: Protect q->blk_trace
> > with RCU"? If not, have you already tried to verify whether that patch
> > fixes the use-after-free detected by syzbot?
> 
> I just tested and confirmed the patch didn't fix the problem.

Right, the two are for fixing different issue.

> 
> By the way, I think Ming is right about "So release not by wq just
> reduces the chance, instead of fixing it completely.", and "move
> blk_mq_debugfs_unregister() into blk_unregister_queue()" is a good
> choice. However, blk_trace_shutdown() and blk_mq_exit_queue() also
> remove some files or dirs, and they may need to move to
> blk_unregister_queue().

Right.

Fortunately, we hold sysfs_dir_lock in blk_unregister_queue(), so
the issue can be fixed by check & remove with holding the same lock
in blk_trace_free().


Thanks, 
Ming

