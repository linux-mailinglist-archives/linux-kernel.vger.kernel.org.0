Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672257B4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfG3VJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 17:09:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33623 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfG3VJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:09:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so47649718qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6d3g5Eb7RssGimuUVLnc9Oe3VuINI0PuovERS1dVP0w=;
        b=gzLohxw1KICcCmeuRUZVXP9epaqSm+vrgI5WCC9J+aToe9PC2rF0glarw3xaa2IbwE
         0bc5EB8OXSoI6WRvHu0jzFyX8TL1O1CmWE9vcxRh/Tnb60a+EUQhczGyYFvFfXq7ebjM
         fnxxc8MftflpLvsidbMbapkmb2G29SCYE5ara/fZle8vEAmzWpfZuBQbsik54w6atLnK
         MwHJiYB4Fu9oVBi2Eok+PBgFDeNKpL8vQ69pxPAWweWB6UhOJ9OtVRWV+e3a4ylYfaV2
         VJ9BfAwl0RnTrOrVCk4jP00W2Kl/G69cKc2+r/o0MdpP9nC32rb9OV6Bsl62e3eq+7+A
         yjRw==
X-Gm-Message-State: APjAAAX3hbLoj56p1BgxbPKTYTcXfUtUIflpLSZhREp16yZtvzNjhWQY
        /OR+FP83XJ6ZbcYJgtYFg4s=
X-Google-Smtp-Source: APXvYqxMSvB5TKi/+chiBT7wCFVw5w/PWL6aSh+LFGiBGlU52oTw/IDUNyDM/wE/qDgVVzAvy7l85w==
X-Received: by 2002:a37:9b92:: with SMTP id d140mr76382522qke.443.1564520995282;
        Tue, 30 Jul 2019 14:09:55 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:6988])
        by smtp.gmail.com with ESMTPSA id k33sm33021721qte.69.2019.07.30.14.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 14:09:54 -0700 (PDT)
Date:   Tue, 30 Jul 2019 17:09:52 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
Message-ID: <20190730210952.GA62702@dennisz-mbp.dhcp.thefacebook.com>
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190730204643.tsxgc3n4adb63rlc@pc636>
 <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d121eb22-01fd-c549-a6e8-9459c54d7ead@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:54:06PM -0700, Dave Hansen wrote:
> On 7/30/19 1:46 PM, Uladzislau Rezki wrote:
> >> +		/*
> >> +		 * If required width exeeds current VA block, move
> >> +		 * base downwards and then recheck.
> >> +		 */
> >> +		if (base + end > va->va_end) {
> >> +			base = pvm_determine_end_from_reverse(&va, align) - end;
> >> +			term_area = area;
> >> +			continue;
> >> +		}
> >> +
> >>  		/*
> >>  		 * If this VA does not fit, move base downwards and recheck.
> >>  		 */
> >> -		if (base + start < va->va_start || base + end > va->va_end) {
> >> +		if (base + start < va->va_start) {
> >>  			va = node_to_va(rb_prev(&va->rb_node));
> >>  			base = pvm_determine_end_from_reverse(&va, align) - end;
> >>  			term_area = area;
> >> -- 
> >> 2.21.0
> >>
> > I guess it is NUMA related issue, i mean when we have several
> > areas/sizes/offsets. Is that correct?
> 
> I don't think NUMA has anything to do with it.  The vmalloc() area
> itself doesn't have any NUMA properties I can think of.  We don't, for
> instance, partition it into per-node areas that I know of.
> 
> I did encounter this issue on a system with ~100 logical CPUs, which is
> a moderate amount these days.
> 

Percpu memory does have this restriction when we embed the first chunk
as we need to preserve the offsets. So that is when we'd require
multiple areas in the vma.

I didn't see the original patches come through, but this seems like it
restores the original functionality. FWIW, this way of finding space
isn't really smart, so it's possible we want to revisit this.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
