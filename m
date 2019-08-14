Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67A8D27A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHNLrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 07:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHNLrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:47:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B806307C820;
        Wed, 14 Aug 2019 11:47:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D74A1600C8;
        Wed, 14 Aug 2019 11:47:02 +0000 (UTC)
Date:   Wed, 14 Aug 2019 19:46:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when
 possible.
Message-ID: <20190814114646.GA14561@ming.t460p>
References: <20190814103244.92518-1-maco@android.com>
 <20190814113348.GA525@ming.t460p>
 <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYHdaOTUKf5ix-oU7cXsV12ZW6YDYBsG+VKr6zk=RCW2NA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 14 Aug 2019 11:47:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:38:25PM +0200, Martijn Coenen wrote:
> On Wed, Aug 14, 2019 at 1:34 PM Ming Lei <ming.lei@redhat.com> wrote:
> > Another candidate is to not switch to q_usage_counter's percpu mode
> > until loop becomes Lo_bound, and this way may be more clean.
> 
> Thanks! I had considered this too, but thought it a bit risky to mess
> with the init flag from the loop driver. Maybe we could delay

blk_queue_init_done() is only called in blk_queue_init_done() for
this purpose, so this approach should be fine, IMO.

> switching q_usage_counter to per-cpu mode in the block layer in
> general, until the first request comes in?

This approach may not help your issue on loop, IO request comes
just after disk is added, such as by systemd, or reading partition table.

However, loop only starts to handle IO really after it becomes 'Lo_bound'.

thanks, 
Ming
