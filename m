Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6804E15B47B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgBLXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:07:08 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47354 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727692AbgBLXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:07:07 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01CN6rwI006237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 18:06:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CAA92420324; Wed, 12 Feb 2020 18:06:52 -0500 (EST)
Date:   Wed, 12 Feb 2020 18:06:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
Message-ID: <20200212230652.GA145444@mit.edu>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a problem we've been strugging with in other contexts.  For
example, if you have the hung task timer set to 2 minutes, and the
system to panic if the hung task timer exceeds that, and an NFS server
which the client is writing to crashes, and it takes longer for the
NFS server to come back, that might be a situation where we might want
to exempt the hung task warning from panic'ing the system.  On the
other hand, if the process is failing to schedule for other reasons,
maybe we would still want the hung task timeout to go off.

So I've been meditating over whether the right answer is to just
globally configure the hung task timer to something like 5 or 10
minutes (which would require no kernel changes, yay?), or have some
way of telling the hung task timeout logic that it shouldn't apply, or
should have a different timeout, when we're waiting for I/O to
complete.

It seems to me that perhaps there's a different solution here for your
specific case, which is what if there is a asynchronous version of
BLKSECDISCARD, either using io_uring or some other interface?  That
bypasses the whole issue of how do we modulate the hung task timeout
when it's a situation where maybe it's OK for a userspace thread to
block for more than 120 seconds, without having to either completely
disable the hung task timeout, or changing it globally to some much
larger value.

					- Ted
