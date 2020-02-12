Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00815B429
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgBLW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 17:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgBLW4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:56:17 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF592173E;
        Wed, 12 Feb 2020 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581548176;
        bh=mTJZ+UJfMT24SAW6HUVPaH/0W+EjuQ/Qksp9vL1UmDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gnL3Rr/nGogf72hp1kDcNGDR6W17loTSy71/2IsyhZorCKrzy6xx2QvuBuJiq2r7o
         ILzvJR6yiF0KRWR9fMRHfO/s2zGrRNBjj5gpZwyOQPcLnLzEiC9Z8O60UM1Fp2U7bZ
         GYy2uyMjkYdTALoZiyWGZL7umma+8n/WuM5iRON4=
Date:   Wed, 12 Feb 2020 14:56:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
Message-Id: <20200212145615.3518e29ec90d580817c14dc8@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.2002082138070.21534@www.lameter.com>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
        <5373ce28-c369-4e40-11dd-b269e4d2cb24@linux.alibaba.com>
        <alpine.DEB.2.21.2002082138070.21534@www.lameter.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2020 21:41:49 +0000 (UTC) Christopher Lameter <cl@linux.com> wrote:

> On Sat, 8 Feb 2020, Wen Yang wrote:
> 
> > I would greatly appreciate it if you kindly give me some feedback on this
> > patch.
> 
> I think the measure is too severe given its use and the general impact on code.

Severe in what way?  It's really a quite simple change, although quite
a few edits were needed.

> Maybe avoid taking the lock or reducing the time a lock is taken when reading /proc/slabinfo is
> the best approach?
> 
> Also you could cache the value in the userspace application? Why is this
> value read continually?

: reading "/proc/slabinfo" can possibly block the slab allocation on
: another CPU for a while, 200ms in extreme cases

That was bad of us.  It would be good to stop doing this.
