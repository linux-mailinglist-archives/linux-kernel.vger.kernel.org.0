Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48C1567DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 22:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBHVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 16:41:50 -0500
Received: from gentwo.org ([3.19.106.255]:41332 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgBHVlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:41:50 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 535B33F3D6; Sat,  8 Feb 2020 21:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 510343F242;
        Sat,  8 Feb 2020 21:41:49 +0000 (UTC)
Date:   Sat, 8 Feb 2020 21:41:49 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Wen Yang <wenyang@linux.alibaba.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
In-Reply-To: <5373ce28-c369-4e40-11dd-b269e4d2cb24@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2002082138070.21534@www.lameter.com>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com> <5373ce28-c369-4e40-11dd-b269e4d2cb24@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2020, Wen Yang wrote:

> I would greatly appreciate it if you kindly give me some feedback on this
> patch.

I think the measure is too severe given its use and the general impact on code.

Maybe avoid taking the lock or reducing the time a lock is taken when reading /proc/slabinfo is
the best approach?

Also you could cache the value in the userspace application? Why is this
value read continually?




