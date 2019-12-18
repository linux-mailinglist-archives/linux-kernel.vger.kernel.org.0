Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254FC123E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 05:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLREFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 23:05:17 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfLREFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:05:13 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47d1cl32N3z9sSF; Wed, 18 Dec 2019 15:05:11 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e352f576d345e5bf1fb62c8559851448a6c1d9cd
In-Reply-To: <20191216103058.4958-1-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] powerpc/pseries/cmm: fix managed page counts when migrating pages between zones
Message-Id: <47d1cl32N3z9sSF@ozlabs.org>
Date:   Wed, 18 Dec 2019 15:05:11 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 10:30:58 UTC, David Hildenbrand wrote:
> Commit 63341ab03706 (virtio-balloon: fix managed page counts when migrati=
> ng
> pages between zones) fixed a long existing BUG in the virtio-balloon
> driver when pages would get migrated between zones.  I did not try to
> reproduce on powerpc, but looking at the code, the same should apply to
> powerpc/cmm ever since it started using the balloon compaction
> infrastructure (luckily just recently).
> 
> In case we have to migrate a ballon page to a newpage of another zone, th=
> e
> managed page count of both zones is wrong. Paired with memory offlining
> (which will adjust the managed page count), we can trigger kernel crashes
> and all kinds of different symptoms.
> 
> Fix it by properly adjusting the managed page count when migrating if
> the zone changed.
> 
> We'll temporarily modify the totalram page count. If this ever becomes a
> problem, we can fine tune by providing helpers that don't touch
> the totalram pages (e.g., adjust_zone_managed_page_count()).
> 
> Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e352f576d345e5bf1fb62c8559851448a6c1d9cd

cheers
