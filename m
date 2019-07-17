Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579BE6C11F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbfGQSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 14:45:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46065 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfGQSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:45:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so26121866otq.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7UHqDmF8opBtyW4k2R9DOYcnvPewTaVGrEEHVnBDOI=;
        b=pKGERV63xKtGcHMecfB9++5NqX4RRPqpXfwrB1LYaGmwWI9xErk2KUs8GsManNErl8
         2jOG2qGjwODrwh7FuSERmM4mpEoUvixORQnIzHoMePnr3m/D4wT5J1mIjMRQPeU+X+71
         Lohytrnp3+OSmeuVRRQ+kN+7ak4aVG3AjdRlgycS9P7xt0iwd/2YlI9d5zrkmsWf1UKQ
         nMPE9pGf/0M23t+Q85VYLbgDD0gwxLFZ0Co0uOCY8oa9UiNZt19tT9Rwd78RkqLJwLyO
         7ScyRAhWwcq05qEulSoQf3h2CkdJORFNZOzPll+QXm9V3QVrbIR6BseNhSGf6eEeOU/t
         K7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7UHqDmF8opBtyW4k2R9DOYcnvPewTaVGrEEHVnBDOI=;
        b=tPVFEuoL7A0mpkhnz9xVJ0tl4WvtIVb3DaN+FlmPwRod+wP9rTzyyzBOSa2kPdp1fL
         BqhvoDU6FCi1RqlEStvrqw4LKQk5FKVcTRFiyYujnqxUKzPLJE2IstnF15G4WBfbsaVo
         CQkUBCE9ZjPDL8WTfvwOPV3GQiD/NGfnh8dUUAUyyP3vnGH1rHwkeoOpWMdjeA5YEp34
         Bgti6a5baoO0f/mKYArQpY6t0RFifiZVzafI6okEdjqYVz9JSKiGgBLAEPEImwY2U1RS
         Uc+X6ldvYdBSD8XDtZ0zxV/mGP1EtN5EQ0WRVUNKCjE/JDS7vd/rpC1xVy4NnEC3hUsW
         9T9A==
X-Gm-Message-State: APjAAAUuF1QUGp6TGAJE3oaeQVdT9L8eT9glNgKpp6EYmym3CDlX9Zha
        Q/g+MYdt/90Ppt40rKUB3hPoJUctqDHW+9ep/axH2g==
X-Google-Smtp-Source: APXvYqy4sNd+44vuqYPh3QAndY5bf6BMKciMXtUL7SOZKPc+qYGwBiIEPN03YW/ziTemzeRtyNF2cYyFBRtb3LrwNgY=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr22177888otn.247.1563389115753;
 Wed, 17 Jul 2019 11:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190717090725.23618-1-osalvador@suse.de> <20190717090725.23618-3-osalvador@suse.de>
In-Reply-To: <20190717090725.23618-3-osalvador@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Jul 2019 11:45:05 -0700
Message-ID: <CAPcyv4gxhjNmy=8e0MiB88LO5oWPmAPL-gnkG-jF5LpKn1E4vA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 2:07 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION granularity.
> We need to adapt the loop that checks whether a zone/node contains only holes,
> and skip the whole range to be removed.
>
> Otherwise, since sub-sections belonging to the range to be removed have not yet
> been deactivated, pfn_valid() will return true on those and we will be left
> with a wrong accounting of spanned_pages, both for the zone and the node.
>
> Fixes: mmotm ("mm/hotplug: prepare shrink_{zone, pgdat}_span for sub-section removal")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
