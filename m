Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D818C843
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCTHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 03:34:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38191 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgCTHeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:34:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id z12so4165200qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C6YhhHeccU9Mplya57aCZ0zu3hccKv0+lu/NMMye7aU=;
        b=IHoSYerE0NjORsoFN1pj3/hfaNeUMVskyOfgKYQRAaXViccuLJe8srypa9vCqRlZbI
         KcMNY/1b0aCfUJr/GOrzlHiMfleCFaHP/SN3vge+eL+MabyLbP/Uzc+QBOp4+KFKMHea
         FoTreq8I84DKRrFEjR2ZlouUVTZRWScXYaSVJldXLT4/GT0jkleX/XGZWqdjpzJ5UvBj
         tNazr1NmE6PCKS6eTwA5Jom0ZZlGriv8AzefaF6meaUqvmY8acf0jYbDFbMauUd86cfB
         KO0GmqS2mnkTcdq9m5iK9xYUfO/0Y9a9l5lLmvv99/1gzh1ZarrbTI4lGXz4ajRUzJr1
         72fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C6YhhHeccU9Mplya57aCZ0zu3hccKv0+lu/NMMye7aU=;
        b=bWZBALjeFMyv4B+BbH0lTYcXU34ZZ7Z06IBe7rZmw6t75VCqD+AfrLtkY03P3HqzQp
         gw0vz0uVvziH4NYjXyLH/kk3WQjGVKNEQihA5k8yk5NLu8eLOZfCVFueEsKQ6jKuR7gy
         G81y3Coo1uVPs6A4M1yx3+43Gfh+q5k0ypWMpVD+gzmkzUf/bznOdLCFOhqdRjGIppNr
         DOo03ekEQyOhgXr9y7E0FPeJpy/CRPl0D6EOLHInAamrJsFEuGI9sbH6rdvo0OrBLGXN
         Y9G26yHuRYMLsaFML+bam0KtHBKJ6k7ifmAgbhFQIfHz+qJsbCifCcZ9/8+H3NGKQVIi
         YRCA==
X-Gm-Message-State: ANhLgQ1xAlaDix4ZeiONW4DrGspLy+kByN+hmBWn3ZxwQysZx1FHPvJJ
        dF2Uis2kZu7P0+odFc5Ruia0y73d6jBlaeDl1hg=
X-Google-Smtp-Source: ADFU+vuO3ncUFcoeEbtYRW8NnoTD0tMhHs04dbeyO/eyX2ksoQMwBi7FHKSuEMV7ESdjD69XJ/X96nTNBtqWPIZoVdo=
X-Received: by 2002:aed:3346:: with SMTP id u64mr6488332qtd.333.1584689645829;
 Fri, 20 Mar 2020 00:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.21.2003181419090.70237@chino.kir.corp.google.com>
 <CAAmzW4PZr6QiO=6VcM_Nbf4079awHBLULAm+_A_-2mCxrzOO2g@mail.gmail.com> <9a7c94c0-c2b2-d533-316a-4fd42bdf55b1@suse.cz>
In-Reply-To: <9a7c94c0-c2b2-d533-316a-4fd42bdf55b1@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 20 Mar 2020 16:33:54 +0900
Message-ID: <CAAmzW4OC56g-37SghVVsN=4tnxMwfavkK2z31abZnBh5o9J4ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/page_alloc: use ac->high_zoneidx for classzone_idx
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:21, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 3/19/20 9:57 AM, Joonsoo Kim wrote:
> >> Curious: is this only an issue when vm.numa_zonelist_order is set to N=
ode?
> >
> > Do you mean "/proc/sys/vm/numa_zonelist_order"? It looks like it's gone=
 now.
> >
> > Thanks.
>
> Yes it's gone now, but indeed, AFAIU on older kernels with zone order ins=
tead of
> node order, this problem wouldn't manifest.

Yes. In this case, preferred_zone of an allocation is the populated highest=
 zone
among all nodes so classzone_idx will the same.

Thanks.
