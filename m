Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66B7197BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 14:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgC3MeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 08:34:08 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51792 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbgC3MeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:34:07 -0400
Received: by mail-wm1-f48.google.com with SMTP id c187so19797895wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 05:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Em2aQuXf0JSg6irJFEUCAhD/JvrnovGDSXnE0eBhJyg=;
        b=Nxj2M3HCyyXYbO3nkFsm76279hm5/AE0hDqe5oUMNAdnItpb4RVce9fdxME1k2QxZK
         o67XvHScFbPPXm+lvKMHXokQM659Jl3vg0c6FEsRTZDBl/In2/bbRUCDCdETHL6p7fha
         Ux6LD3lf5jmEqSRdho/jws/7cTvI/xhD0gwbrzneOTSFc5WKccETu3gfR2lkNsj8LxFC
         t7DFeuEwbnHyC/F3VJ/IaK9aYz1dKVj39gNVHvb4hqWJo5jcvzJWJ3KiV22hDgy7C77h
         jSWSSMZhiYD22BCyszW8NwbYUgL8vJxb9HflZYRpcSnWqDQEI9+si2vDjlObEvMnYEDN
         ynPw==
X-Gm-Message-State: ANhLgQ17t4zPcZBuPhqfyxKO7abF8Zw9w7MMTpeoZpe92dUQ//HNUcX1
        e37ub9jrMemBfySW6/cAhPs=
X-Google-Smtp-Source: ADFU+vu41LA/m+g3AiN1pF7fnyL47hSltXVxaY1ddpeSVpuljI2zOSF9C7d78tJTM+jEETaTkTT08w==
X-Received: by 2002:a1c:4b19:: with SMTP id y25mr7612860wma.70.1585571644125;
        Mon, 30 Mar 2020 05:34:04 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id n186sm20346573wme.25.2020.03.30.05.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 05:34:03 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:34:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/page_alloc: Enumerate bad page reasons
Message-ID: <20200330123402.GI14243@dhcp22.suse.cz>
References: <1585551097-27283-1-git-send-email-anshuman.khandual@arm.com>
 <20200330084300.GC14243@dhcp22.suse.cz>
 <689b594f-c18a-4131-8049-ac917345099b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689b594f-c18a-4131-8049-ac917345099b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-03-20 17:55:14, Anshuman Khandual wrote:
> 
> 
> On 03/30/2020 02:13 PM, Michal Hocko wrote:
> > On Mon 30-03-20 12:21:37, Anshuman Khandual wrote:
> >> Enumerate all existing bad page reasons which can be used in bad_page() for
> >> reporting via __dump_page(). Unfortunately __dump_page() cannot be changed.
> >> __dump_page() is called from dump_page() that accepts a raw string and is
> >> also an exported symbol that is currently being used from various generic
> >> memory functions and other drivers. This reduces code duplication while
> >> reporting bad pages.
> > 
> > I dunno. It sounds like over engineering something that is an internal
> > stuff. Besides that I consider string reasons kinda obvious and I am
> > pretty sure I would have to check them for each numeric alias when want
> > to read the code. Yeah, yeah, nothing really hard but still...
> 
> Right these are very much self explanatory. Would moving these aliases into
> mm/page_alloc.c itself, make it any better for quicker access ?

Not really. Cscopes doesn't really care where it is. It is the fact that
the constant makes to have a look is what makes this not an improvement
from my POV.
 
> > So I am not really sure this is all worth the code churn. Besides
> 
> I understand but is not just repeating the same strings in similar functions
> bit suboptimal as well.

I do not really see why that would be suboptimal.
-- 
Michal Hocko
SUSE Labs
