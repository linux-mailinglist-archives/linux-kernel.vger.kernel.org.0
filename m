Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C692E160157
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 02:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBPBZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 20:25:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40132 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgBPBZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 20:25:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so5306898plp.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 17:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LqZnlLjYXByu2d6oczewxnnow4SoLrPRaLAQ85cZs38=;
        b=ek3rwVmXj8vmK4TuGeFA7GZoFc3SKRxyUg3Z2Utr4BYFXjER4M9c9s+39gzUc1NB8k
         1b6/SZzqs107NzNUoJBcA7iGGny1ry6WtZq+L+AB2PnJF8Lj/mKZF1JohFm0Y8aXW0OA
         wGfh1TZZ7MhOkF0cUh3XiBJA3MVKURpjnx1PzlxYCQkwMjCpJ5uvfuAyo4SU66KnkpBt
         r/XyJSTlFKfkLQwKcGZK292JszBSePd4FDonFuwuFE5W0QaeYrlbO5JGjsCaU5bWTVvY
         DTutPkpEy0ocnVJL21xAK+pOpW1lYUfWii6GP7GLgkKleg4WTF2siEg2yODyj9tNkCO0
         k7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LqZnlLjYXByu2d6oczewxnnow4SoLrPRaLAQ85cZs38=;
        b=MHUeqvYLJ4FNz3K+kZhxfKAYSIpBk2IzslMVFcVHazR+LCKTJ4LTcXMF2S3rRgczXz
         vukUU4oVeldfsUHBSdmgWKlM1rwf6zURtPceUL99oSNTwUBZ9V/vmegGwdJNmqvyd559
         dhnwOCkSqRHiKSMiEmTC98kcpdoVcTyFVuD3T3DJhGudzDTgxB2Hrypoo+ofUG1rul3a
         tB4iOBx9lN7YSPv4jdMzxI7iZiieiE/i4F6hlkzFMcyKYhMSSsTqeSAlA6G3Ugg8YfBU
         +/5Y4fPfLBjAZLsJd8GwJzxVB84hYwF5DyGZ6D8Axdb9v1wa3lpBOqcaW2DyYD2Q5bIP
         OtUA==
X-Gm-Message-State: APjAAAVt0Pf57GE6ffN5wM+2ArlWYr/qWKmJL+QnLjSLDMYAku1gywuM
        KhygfymvWNnSzjtnzFOKoMssx+kfVUs=
X-Google-Smtp-Source: APXvYqwHXywkOkQgp2LWEyG9sypU7ULnSQp/BrlHu7Jw6ed6dn29Ne2Z0W8U3orPeg+BG0oyfyZmPQ==
X-Received: by 2002:a17:90a:f012:: with SMTP id bt18mr12302718pjb.8.1581816314194;
        Sat, 15 Feb 2020 17:25:14 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r8sm11390168pjo.22.2020.02.15.17.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 17:25:13 -0800 (PST)
Date:   Sat, 15 Feb 2020 17:25:13 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 4/9] hugetlb: disable region_add file_region
 coalescing
In-Reply-To: <20200211213128.73302-4-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2002151724510.244463@chino.kir.corp.google.com>
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-4-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, Mina Almasry wrote:

> A follow up patch in this series adds hugetlb cgroup uncharge info the
> file_region entries in resv->regions. The cgroup uncharge info may
> differ for different regions, so they can no longer be coalesced at
> region_add time. So, disable region coalescing in region_add in this
> patch.
> 
> Behavior change:
> 
> Say a resv_map exists like this [0->1], [2->3], and [5->6].
> 
> Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> 
> Old code would generate resv->regions: [0->5], [5->6].
> New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> [5->6].
> 
> Special care needs to be taken to handle the resv->adds_in_progress
> variable correctly. In the past, only 1 region would be added for every
> region_chg and region_add call. But now, each call may add multiple
> regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> region_chg calls add_reservation_in_range() to count the number of regions
> needed and allocates those, and that info is passed to region_add and
> region_abort to decrement adds_in_progress correctly.
> 
> We've also modified the assumption that region_add after region_chg
> never fails. region_chg now pre-allocates at least 1 region for
> region_add. If region_add needs more regions than region_chg has
> allocated for it, then it may fail.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: David Rientjes <rientjes@google.com>
