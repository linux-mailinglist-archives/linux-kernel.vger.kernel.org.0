Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217B1163A92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgBSCzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:55:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45381 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728027AbgBSCzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582080915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ssQCDVM74SPVby1fTm4z6JcG59jAK5ps2tKRPOXbU4=;
        b=GVL4OezXwz3mU/QWmyOMkaWGZqdBaccYOwBHEAMVervBCWK2C6O7YogLiTlyZE0WHpIFZn
        ey3s0CMGC0gnpqDAkJcf3HClHNJhpNOpXJBJ8MVt3QDECurayKZ7W229K3fiUNZNAa+/vK
        sVK9T6a2HYJjxZe8ZwvX1cNHaOaPAoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-_wNmUkm6NrOlf5L7e8yLSw-1; Tue, 18 Feb 2020 21:55:11 -0500
X-MC-Unique: _wNmUkm6NrOlf5L7e8yLSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB950107ACC5;
        Wed, 19 Feb 2020 02:55:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8A085C13B;
        Wed, 19 Feb 2020 02:55:01 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:54:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Salman Qazi <sqazi@google.com>, Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
Message-ID: <20200219025456.GD31488@ming.t460p>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p>
 <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org>
 <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
 <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
 <20200215034652.GA19867@ming.t460p>
 <CAJmaN=miqzhnZUTqaTOPp+OWY8+QYhXoE=h5apSucMkEU4nvtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=miqzhnZUTqaTOPp+OWY8+QYhXoE=h5apSucMkEU4nvtA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:11:53AM -0800, Jesse Barnes wrote:
> On Fri, Feb 14, 2020 at 7:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> > What are the 'other operations'? Are they block IOs?
> >
> > If yes, that is why I suggest to fix submit_bio_wait(), which should cover
> > most of sync bio submission.
> >
> > Anyway, the fix is simple & generic enough, I'd plan to post a formal
> > patch if no one figures out better doable approaches.
> 
> Yeah I think any block I/O operation that occurs after the
> BLKSECDISCARD is submitted will also potentially be affected by the
> hung task timeouts, and I think your patch will address that.  My only
> concern with it is that it might hide some other I/O "hangs" that are
> due to device misbehavior instead.  Yes driver and device timeouts
> should generally catch those, but with this in place we might miss a
> few bugs.
> 
> Given the nature of these types of storage devices though, I think
> that's a minor issue and not worth blocking the patch on, given that
> it should prevent a lot of false positive hang reports as Salman
> demonstrated.

Hello Jesse and Salman,

One more question about this issue, do you enable BLK_WBT on your test
kernel?

Thanks,
Ming

