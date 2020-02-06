Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81060153CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 02:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBFBnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 20:43:55 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38577 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFBnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:43:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so2955110oii.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 17:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSnhPc5sm1WKX1AxY5ecWiqStcBUxMiXywxGfVIJb3s=;
        b=hASTENvQqDefynTK3/vPCP/JkgvLwj9TJiEC2KANfBjieXUCLbbJfgFb70CSl/h83z
         iyWGWjOz4tmmSIm397EoWDsVhES3vq0zkHC5G5EGe5VJjXCqr7AkD86ECgwEo/5q0UTF
         L5koUiwcvP4A3K4/dOMmYL+zCNVKb1K3ADX8bfLwh5rd5G+4ohXyQU8ov/3BhHpEr21D
         sibOcthDDa1c/SkgDfSJbmDZaiBTSmGhm3++rP6osHO4gOPP5OhPfHvZUU+4eOIsrJjD
         WQeP9qF/Sw4MIVCx+iXVf1QlAvw0Hy07hLYY9cmunHVp6AMkyt/cih1uWc8NwQDRhEeZ
         zhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSnhPc5sm1WKX1AxY5ecWiqStcBUxMiXywxGfVIJb3s=;
        b=bhNASgsWl8AUZakMPF+SRIT6LBCDeiKVbXCx6NnmbfCPa+IZL/KnjpcxDcPqpFt4Pv
         tMLHkC3iKtCGWK9kY6O/V5dQOTCKpnYErsfPJ9J8p12hS0eOAu+3nlDSXtKDQnroBwUr
         fKi1IpAuKnIUSsnh8e98elB5b/XsVmkcO4JDcbsnxzmlOsjts6gpxt/DlNaIR+gWtsI9
         EDR3I+xZUA/B67Yn0epFif4zpChhl1Hv4urBTN8ejgeDQR4x7s7HwYrxOBpBGKyGyzvj
         UqqD7X94pM0JodsEwbOvP/pOIJxKBLMRjFwwL4GxGL07AI9LC5MKfqYaJfwn2ErdhM2m
         sapQ==
X-Gm-Message-State: APjAAAUSBSnrT1qLWzmnNT4p4PXJSXRygy9aGNQQDagcPY+kobFcI5VQ
        1wYZ7zvupiorWwquN1H5wh6QJ69uGrorFjZ5/u0Z0g==
X-Google-Smtp-Source: APXvYqz+vL5vVc3c3EqGorwKWyApF85gPLUz0qAt0tCjSSmjl8jJi5+mOSnq4Lof7/Jvq/soGG7yZ4hZZPC28aas1Qs=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr5503972oig.103.1580953434139;
 Wed, 05 Feb 2020 17:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-4-almasrymina@google.com> <cd457f80-2624-f524-36ce-f11b56b30f8a@oracle.com>
In-Reply-To: <cd457f80-2624-f524-36ce-f11b56b30f8a@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 5 Feb 2020 17:43:43 -0800
Message-ID: <CAHS8izONQEGMHJVR3cpgbn+LbYZ9eYa4jNkOwkCYwpGBHXHm8Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] hugetlb: disable region_add file_region coalescing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 3:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/3/20 3:22 PM, Mina Almasry wrote:
> > A follow up patch in this series adds hugetlb cgroup uncharge info the
> > file_region entries in resv->regions. The cgroup uncharge info may
> > differ for different regions, so they can no longer be coalesced at
> > region_add time. So, disable region coalescing in region_add in this
> > patch.
> >
> > Behavior change:
> >
> > Say a resv_map exists like this [0->1], [2->3], and [5->6].
> >
> > Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> >
> > Old code would generate resv->regions: [0->5], [5->6].
> > New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> > [5->6].
> >
> > Special care needs to be taken to handle the resv->adds_in_progress
> > variable correctly. In the past, only 1 region would be added for every
> > region_chg and region_add call. But now, each call may add multiple
> > regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> > or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> > region_chg calls add_reservation_in_range() to count the number of regions
> > needed and allocates those, and that info is passed to region_add and
> > region_abort to decrement adds_in_progress correctly.
> >
> > We've also modified the assumption that region_add after region_chg
> > never fails. region_chg now pre-allocates at least 1 region for
> > region_add. If region_add needs more regions than region_chg has
> > allocated for it, then it may fail.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> This is the same as the previous version.  My late comment was that we
> need to rethink the disabling of region coalescing.  This is especially
> important for private mappings where there will be one region for huge
> page.  I know that you are working on this issue.  Please remove my
> Reviewed-by: when sending out the next version.
>

Yes to address that there is a new patch in the series, which
re-enables the coalescing when the hugetlb cgroup uncharge info is the
same. I guess it could be squashed with this one but I thought it was
better to implement that patch on top of the patch that enabled shared
accounting, because that is the patch that sets hugetlb cgroup info on
the file region entries.

Let me know what you think.

> Thanks,
> --
> Mike Kravetz
