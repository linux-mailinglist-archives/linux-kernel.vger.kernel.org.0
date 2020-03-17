Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0911890FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCQWFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:05:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34898 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:04:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id k8so22156608oik.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY+guVjbAMZU5uOESZLzfUGHTA73g3d/loWemG4Z+tE=;
        b=DgVudzFUJBGxeDF2iH5mheVO+tEr9voArIx64eJyZEBBg7cRUGb+cj/MjOf9oq3B2R
         QJIL+lhTJMNAQ2ngIH0YwrqRSHxOD/fXTbGSyUUiG2SG3d9V05oxPGTwun4uO4gi4IlX
         WxNQwPnIrSGREpuL3ogprgQmp5jDmU634+TUNER/9IW612bYKA/Y0kZDlnRh7OPIc7fZ
         N3HkePiHhMsx27VQXonJFl9bdxeB0ntQKwRhkKFQ/5Yysl6eRd32am9KSXxFsta5qcIo
         i3a8vj0Uaqxhll7rOfD9Qno75Qopvm5OE8wtwmN62BUdRv/lvuW7wYkuuokxAAcPHEuO
         2jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY+guVjbAMZU5uOESZLzfUGHTA73g3d/loWemG4Z+tE=;
        b=rl+DQ2zYePGnqlg9QgOBwNG5/PHB57bE1QJt8xyTz1ddiIq5zHeUoOiSMfFAU/Figf
         jqe16TixerDpjklFmawnjC6CiXBWYNwHhlB0OrCBzUclchHt3hb91jKFuR3JJip2mWAl
         polSbWdom/JPGwv+wRIbsXVUxsHwBg7Wr+b/fKJUC/mexAlvCYDh2Df5yiZNpney1hxC
         mTZBYCsjy/jCER55lfPd4ehAJyDlVaZjo6AyhWRmBkIvG9ESGh6KIfiIYN3eDUhDF4CP
         LOt6gT7yIvthxPrr6z9Mu1brPvzaHI6a4oZZm/SCxs9Z+3/mdrBOJ3w7dB0ggF4Loa5V
         5sGg==
X-Gm-Message-State: ANhLgQ34jIdJVuuvhMiyCeogAVhc8/PSpEVglqeRCzEp/T3y3HKrpk/k
        Gho2eIESqPZhoHBZzWAIYJbRlnvTNGC9132LL2aDRw==
X-Google-Smtp-Source: ADFU+vsQvOL9wprxrkAHycoZPlNxRbxXsmPicT5n7p0w61/VCYW5GHZo0bAl/D1XuM3Nq16vsV01jj1nZ/5wYharha8=
X-Received: by 2002:aca:4d8:: with SMTP id 207mr838171oie.70.1584482698821;
 Tue, 17 Mar 2020 15:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318762012.2216124.16408566404290491508.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1848cdb9-8c19-d7fe-870c-175bd60bc364@amd.com>
In-Reply-To: <1848cdb9-8c19-d7fe-870c-175bd60bc364@amd.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Mar 2020 15:04:48 -0700
Message-ID: <CAPcyv4goRP8EAfMX8oOANgzgm3Pn=wES42MCDXbP_x__-GW52g@mail.gmail.com>
Subject: Re: [PATCH 4/5] resource: Report parent to walk_iomem_res_desc() callback
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 6:42 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 3/2/20 4:20 PM, Dan Williams wrote:
> > In support of detecting whether a resource might have been been claimed,
> > report the parent to the walk_iomem_res_desc() callback. For example,
> > the ACPI HMAT parser publishes "hmem" platform devices per target range.
> > However, if the HMAT is disabled / missing a fallback driver can attach
> > devices to the raw memory ranges as a fallback if it sees unclaimed /
> > orphan "Soft Reserved" resources in the resource tree.
> >
> > Otherwise, find_next_iomem_res() returns a resource with garbage data
> > from the stack allocation in __walk_iomem_res_desc() for the res->parent
> > field.
>
> Just wondering if we shouldn't just copy the complete resource struct and
> just override the start and end values? That way, if some code in the
> future wants to look at sibling or child values, another change isn't needed.
>
> Just a thought.

Thanks for taking a look. I think it's ok to come update this again if
that need arises.
