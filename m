Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EBBC6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 13:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504749AbfIXLfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 07:35:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40300 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440846AbfIXLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:35:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id v38so1501316edm.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wqOFMWe+mp3c8TorAc2H1VRjzI9RZ5AFH27KTf53AIk=;
        b=uWyTPD3jGEbt7pWGjVokh/v+Z7M2CKQjwY58Ka6aiG27oed2spgmG/Wx4Zmk6gOLLQ
         QWcXA22nTaG1vd1pP9sOjnsdEKRENH1pNUF8mSqlIxNrbyaVmHceZMnE22JpgMU1uWMP
         IGGvuR4vtQV1xZVttpPI0vus7ZuDfpXdlKcQZo1JtZgIKfl0Pow3+aKVjrAqmpUTu1p4
         ZWdlSnHNBni0pVowTTBeZTOOTzC6M+Bing8iI3+MDoMRst6qmXe+jlfAi3sGGWIFBwKB
         GpTwPFhYmuIcti7wrEtpHV9TqFDZMx7PydX3PMlQvt3ZMDJSfPS+DHwm+zYH1bVS3mcx
         8bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wqOFMWe+mp3c8TorAc2H1VRjzI9RZ5AFH27KTf53AIk=;
        b=dhKF7iQyQHaT/ApkMc1jAtQFcZxFlcogSZXuYkvypFn7zzTG0HTBiEExvi5oRDK6ZS
         PSavJcg3aiYkOBzOPClenmJ2jMrfL7qjXcLHvnuu54evE/6gK6Cnie+tn3ZdAej2BhLv
         j4gAsYx+5hVPcHJt8mjMMeoPGHO1fzyKINwk+fgFzRUzgw0CIpy/+AkiPE0QfjoswnkV
         mfpVzok49K7p3AkdL+VaN6ffmscpXFC+iHJHS6GfGOaSMOKM6EObkBkvzm1Y3XRXaJ4w
         BREfEM6unJWNPO2YZOOYfYfNYJgtQgfRYnYgyo9cY8MU3bM8wcqLwUB0YIguhOxlaJuK
         yTDw==
X-Gm-Message-State: APjAAAUV7HXLAtmNhnOtVljmsFr7Z4zbkkFJ5EQsvtyD/N/jgKma2aCb
        ++x0UALW+alvlgZrqdI1C/fimw==
X-Google-Smtp-Source: APXvYqy30obyGgj4Ob6e1fIE+j/iQawI9EjPsp4eRg4ErWCrQv/NITI8BVWWy3/DmbtmMb5bkFZgRA==
X-Received: by 2002:a05:6402:1549:: with SMTP id p9mr2126480edx.221.1569324953703;
        Tue, 24 Sep 2019 04:35:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w21sm313594eda.90.2019.09.24.04.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:35:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3FC7A1022A6; Tue, 24 Sep 2019 14:35:54 +0300 (+03)
Date:   Tue, 24 Sep 2019 14:35:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/4] mm, page_owner: keep owner info when freeing the
 page
Message-ID: <20190924113554.azr3w3blo4h4ask2@box>
References: <20190820131828.22684-1-vbabka@suse.cz>
 <20190820131828.22684-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131828.22684-4-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:18:27PM +0200, Vlastimil Babka wrote:
> For debugging purposes it might be useful to keep the owner info even after
> page has been freed, and include it in e.g. dump_page() when detecting a bad
> page state. For that, change the PAGE_EXT_OWNER flag meaning to "page owner
> info has been set at least once" and add new PAGE_EXT_OWNER_ACTIVE for tracking
> whether page is supposed to be currently tracked allocated or free.

Why not PAGE_EXT_OWNER_ALLOCED if it means "allocated"? Active is somewhat
loaded term for a page.

-- 
 Kirill A. Shutemov
