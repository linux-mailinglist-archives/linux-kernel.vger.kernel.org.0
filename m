Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8EA158150
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBJR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:26:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25478 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727558AbgBJR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581355576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2s1gDfRQPEphs0FPrG9hlZiiOmO11uK8jAyv8OWxt4g=;
        b=Db4Z7V8H9iiAAvf2n1BEJL0xbukBwYgzdtYWwR1XEw29UyUX6uCKGiA3IR3nZ7fML1ItGM
        n+O+2J52eXasTn+y4N0VkEvJ1n3/6SPGuBRwEUIU74p7ePckpyHlfKMgcCKY4WC3qHewR5
        qZdQDaCXou5Ymhuj7/xljyDAdU0b3A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-yNksjaJwOSaqImH12t_PcQ-1; Mon, 10 Feb 2020 12:26:07 -0500
X-MC-Unique: yNksjaJwOSaqImH12t_PcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63205477;
        Mon, 10 Feb 2020 17:26:06 +0000 (UTC)
Received: from treble (ovpn-122-45.rdu2.redhat.com [10.10.122.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7222810013A7;
        Mon, 10 Feb 2020 17:26:05 +0000 (UTC)
Date:   Mon, 10 Feb 2020 11:26:03 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 7 (objtool warning)
Message-ID: <20200210172603.ujtupdib5gcpmo6v@treble>
References: <20200207115949.7bd62ec3@canb.auug.org.au>
 <cc2b942d-d29d-710c-a9f3-e762c76c3d06@infradead.org>
 <20200210102951.GD14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210102951.GD14879@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:29:51AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2020 at 08:17:25AM -0800, Randy Dunlap wrote:
> > on x86_64:
> > 
> > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x6c7: call to gen8_canonical_addr() with UACCESS enabled
> 
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> > CONFIG_64BIT=y
> 
> That's just really sad, stupid compiler.
> 
> Something like so I suppose...

This looks familiar... here's the approach we decided on before, before
I subsequently dropped the ball:

  https://lkml.kernel.org/r/20190923141657.p6kpqro3q4p4umwi@treble

-- 
Josh

