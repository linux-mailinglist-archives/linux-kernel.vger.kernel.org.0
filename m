Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407511582E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBJSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 13:45:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726816AbgBJSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581360324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5raNMTAVRb/PEnA4MMky/l8xEhbFC7BwZGHg9uA2fk=;
        b=ULy3k0SJwuJwUH9Sqwl5LQFje/ei9gr6hdZGhbBYPKji0gb+0xj8f3/iSiLaF8d3bvA7K+
        ANu72RvUZvVLjbpyjxVWYe81uDTavUoE4SEE+HLe5Wo5s9kmI02Hdfph0jInz6xgInmjD9
        PykdINK56+ZyW/y0fL7va3JJzp98ykg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-6Pd3NwZwP12W-w5F_Q55Zw-1; Mon, 10 Feb 2020 13:45:19 -0500
X-MC-Unique: 6Pd3NwZwP12W-w5F_Q55Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B95C2192299C;
        Mon, 10 Feb 2020 18:45:17 +0000 (UTC)
Received: from treble (ovpn-122-45.rdu2.redhat.com [10.10.122.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65CDE1001281;
        Mon, 10 Feb 2020 18:45:16 +0000 (UTC)
Date:   Mon, 10 Feb 2020 12:45:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 7 (objtool warning)
Message-ID: <20200210184514.phyq462bvpxwdiss@treble>
References: <20200207115949.7bd62ec3@canb.auug.org.au>
 <cc2b942d-d29d-710c-a9f3-e762c76c3d06@infradead.org>
 <20200210102951.GD14879@hirez.programming.kicks-ass.net>
 <20200210172603.ujtupdib5gcpmo6v@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210172603.ujtupdib5gcpmo6v@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:26:03AM -0600, Josh Poimboeuf wrote:
> On Mon, Feb 10, 2020 at 11:29:51AM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 07, 2020 at 08:17:25AM -0800, Randy Dunlap wrote:
> > > on x86_64:
> > > 
> > > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x6c7: call to gen8_canonical_addr() with UACCESS enabled
> > 
> > > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> > > CONFIG_64BIT=y
> > 
> > That's just really sad, stupid compiler.
> > 
> > Something like so I suppose...
> 
> This looks familiar... here's the approach we decided on before, before
> I subsequently dropped the ball:
> 
>   https://lkml.kernel.org/r/20190923141657.p6kpqro3q4p4umwi@treble

Though that patch looks broken because it masks off the UPDATE bit in
the first loop (via PIN_OFFSET_MASK) before checking UPDATE in the second
loop.

-- 
Josh

