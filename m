Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8882F158489
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBJVEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 16:04:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgBJVEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581368668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ+2dKU8yIsABCyjypziP41Gbgfmk467AaFM3bLT4b0=;
        b=H+xr67T0f5HRzQod68WHV60Q5OMEuEuoXrZkGl16L0RB2q4nKAyY80MZ+D8vawbiuZoIoI
        wxDIP55Meyx91bskUqCggIUvre8BVRQR5nFTci4rLFnTpBq6TE3Gr/bwT5tlHdecLZMez5
        yXd+GRHtF3k0+kkkpwe40GSA+DUMvFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-1ouHzz-oMR-os2cMib18hA-1; Mon, 10 Feb 2020 16:04:26 -0500
X-MC-Unique: 1ouHzz-oMR-os2cMib18hA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75368017CC;
        Mon, 10 Feb 2020 21:04:24 +0000 (UTC)
Received: from krava (ovpn-204-37.brq.redhat.com [10.40.204.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FCC219C70;
        Mon, 10 Feb 2020 21:04:22 +0000 (UTC)
Date:   Mon, 10 Feb 2020 22:04:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Show percore counts in per CPU output
Message-ID: <20200210210419.GD36715@krava>
References: <20200206015613.527-1-yao.jin@linux.intel.com>
 <20200210132804.GA9922@krava>
 <f749694f-b3b3-c498-74ea-ec2e6bb0d0f1@linux.intel.com>
 <20200210140120.GD9922@krava>
 <20200210170159.GV302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210170159.GV302770@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 09:01:59AM -0800, Andi Kleen wrote:
> > > With --percore-show-thread, CPU0 and CPU4 have the same counts (CPU0 and
> > > CPU4 are siblings, e.g. 2,453,061 in my example). The value is sum of CPU0 +
> > > CPU4.
> > 
> > so it shows percore stats but displays all the cpus? what is this good for?
> 
> This is essentially a replacement for the any bit (which is gone in Icelake).
> Per core counts are useful for some formulas, e.g. CoreIPC
> 
> The original percore version was inconvenient to post process. This
> variant matches the output of the any bit.

I see, please put this to the changelog/doc

thanks,
jirka

