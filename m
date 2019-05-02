Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935B711B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEBOQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 10:16:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:16:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so2257563edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9aLUsv55ITOjNiKYrvVJTstOAfJJ4bjs1xsqsYJZDQ=;
        b=Wglm0Ja8Is5t6Pe+C39FK43FXDgUihPAL66hPy1y4u5yc2bjsKAODKww+7X5qtMNq5
         PbUXwFDcvRFq0LAgV2XIV24RKvFaLy4+Jk9GJYezxhn5AlNEzzhz8abjwcZNxXD9zlji
         e5nlWFVG4bsIB4/YdkBoDHM6o1TSAyn93KJf3vcwSYLmgFnlgEumav98ILuqSoa4je8o
         AFbnIN4HyiGrHybIdEqKo89zqDoKruqFcQ4OfcjnNLSk5jVrpkfQPrVUs7D0XYOyds57
         zhuWswdfRLeN+sHLVlfRkfc2fNW9damh+qz/C5Exemg6en0dyyKw1qNwtwq2GtQLO5wR
         RaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9aLUsv55ITOjNiKYrvVJTstOAfJJ4bjs1xsqsYJZDQ=;
        b=RURNr533Hj6UYIXUCqITmRgw7atHKZU/C4OJjR2s30zCZr7QZ4178CkbpkY1pmDzcD
         IDYPkA5NnVueSGgYyzcjHi0xudTl5CjjwCvQj6TiYddriYIyddOyXpjhrmCXj3pgSoDp
         jwDq0dgj+adHdGIx23724mzgRZuOLLwuIKXdgPV2Q5gsQNAwdLS1aDS5aPISIUPwmPGs
         7rMKmJR5fjBQEoCH8ZWsZLncI720vvwIgMRBMIC5dXmjMUmwfL+bByPPYA5MS4CQi2Au
         gaunqvJES3B58L4P0OVAe7iITDQh8PA9H9MjrgA9yPldbqblDtpl1424XcxfaCPaBpx6
         gBLQ==
X-Gm-Message-State: APjAAAWiIDbzTgM6VGOduzMNzmpWpoLDEyao97BDmoTkuOzciYySVXs/
        AZXvFv6J7uGe7Myk2cCWQYu0tuaFMp9SCT1lVMXFfIexmDc=
X-Google-Smtp-Source: APXvYqz9Dz0MllP0/JVZaWYqSMxagrbWwyxnqyReg5hTSdZBuyzEtjj571LYBRrDHp5eRfJaAMIOIYRbPk8/bxfuLaY=
X-Received: by 2002:a50:a951:: with SMTP id m17mr2606324edc.79.1556806579550;
 Thu, 02 May 2019 07:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
In-Reply-To: <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 10:16:08 -0400
Message-ID: <CA+CK2bA_5uaEK1vjOwNZC9Ta+T-_yTL9etOUEvOUSrtNEOe8og@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 2:07 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, May 1, 2019 at 4:25 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > On 19-04-17 11:39:00, Dan Williams wrote:
> > > Towards enabling memory hotplug to track partial population of a
> > > section, introduce 'struct mem_section_usage'.
> > >
> > > A pointer to a 'struct mem_section_usage' instance replaces the existing
> > > pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> > > 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> > > house a new 'map_active' bitmap.  The new bitmap enables the memory
> > > hot{plug,remove} implementation to act on incremental sub-divisions of a
> > > section.
> > >
> > > The primary motivation for this functionality is to support platforms
> > > that mix "System RAM" and "Persistent Memory" within a single section,
> > > or multiple PMEM ranges with different mapping lifetimes within a single
> > > section. The section restriction for hotplug has caused an ongoing saga
> > > of hacks and bugs for devm_memremap_pages() users.
> > >
> > > Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> > > from a section, and updates to usemap allocation path, there are no
> > > expected behavior changes.
> > >
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
