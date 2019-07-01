Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6B16C55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEGUiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 16:38:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40362 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEGUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:38:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id w6so16295187otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pfRHejW3cZFOE77y3IUUX4go4AGbYiRoY6juBt94WE=;
        b=n2cLf9QvpatFw6Fx6Im50C3lqxaAWG43jr2hC2ev1xZpfJ6J8FUzxhXEUavTl94SZm
         SVHlKHKIcM/ZhfovCw4MijKPgzW/E+HLz4qZ175x7tfNV+dQC05A0tETwYssL7clan9W
         UsEpcZNB+TJeQSbZEqorEcfiOUdbu+Sy8m9YAZ3S+el0grhl2bD78JddE66O4Q+1avuY
         KR225hZ12kjGn4PRHpeZLqKoFnuS+tJCq4z76VyCpIv4O/vr+Au5mfwKYyPGTxiEapDr
         R3GKFkX289EisuP8nBoU3VOoPxvd3l0FVJ+ulJz6IltOlc4nobKQXXstnEsx5ZFdmsTb
         rEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pfRHejW3cZFOE77y3IUUX4go4AGbYiRoY6juBt94WE=;
        b=ac+so5/TQEfdKrbGxUgLeXPDlmbnK21scngybYsGKmr/deAnkQl6hi9loxMCPUv4s0
         jhSkojyOmEzfmcee7JPV0yQkOlK5nzq7iWSPlsW+R24j+WQgQFDgh8j/5XW4/+ND58pP
         aETIwrp1DXxOOhixDZQDE3amThqcjUGIL++ElBIixs/DZegITBnbyTz3WK4VDVA/oi84
         wrUdVY53hJ5lyTy6BIO4VDxs9NnSVL2rKFt3X6uBhe8RgrxHZQhTAx+mueO8nUIw4mYm
         FIrsOVBZJ5zSAgueuZvZ8R6QIx6+gTOIUpw7boqFFNNAnCybSABst5vvQivPuw7DvUR1
         6K1A==
X-Gm-Message-State: APjAAAWx1hl9bCLSvde+hrrvLaDrIoOh450M7etdghN9JVjd4cUA9izA
        PKHEUZfLtmjLxCWxYLA1Shu+9wSAfVDyDJ/g6HrvuA==
X-Google-Smtp-Source: APXvYqyoyS46mGkeS8xfe2+s5llXVwHTTrq4TjXi1ZN6I2Su0aHjvxJMNj2Psjrwn9yCamOWlD6+DD7mFrLZ6kZfD1Q=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr21322434oti.229.1557261534468;
 Tue, 07 May 2019 13:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-2-david@redhat.com>
In-Reply-To: <20190507183804.5512-2-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 13:38:43 -0700
Message-ID: <CAPcyv4jCtOYLCtAhRPhGrHZKyvHZmE8i1aGsRRBWk+G0v4EGAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 11:38 AM David Hildenbrand <david@redhat.com> wrote:
>
> By converting start and size to page granularity, we actually ignore
> unaligned parts within a page instead of properly bailing out with an
> error.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
