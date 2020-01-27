Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF914A242
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 11:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgA0KtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 05:49:25 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39277 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgA0KtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:49:25 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so42531pjr.4;
        Mon, 27 Jan 2020 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xtm+leoXUJLg/QLQGOWhYGdBnWUC+AmA5nMXgden8Uw=;
        b=Vz5pI7Wg23M2qIwRhor/vfZutBwNSe2Frgo+BLCdCgoKNLBbZwd/z70MSTZxIEpevG
         IQbDwJlXVxsutsJaDPw1xNIFnwWlFxeCYiFz4y3lTVw8m3vOMUkA6vPsysz5V2MOg5yp
         6xhhP0MIhHDtEyldFEkCHicsSROcfecbMFCECsuHiiD6zCej9RC5O9+JVk+uktPi77vf
         tOYibUyLvqUG/ey9h3jw74oB3IV/jXz43c4uxM5MhsIiiPZIDOnImM5qAkiIlgy4iq7Y
         LWsKS6jp8+HGELuhcsarzTYKGju7ypo8lfzCS2LK0XiyTP/Zwxp5khfWullGDLmwcGHe
         /YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xtm+leoXUJLg/QLQGOWhYGdBnWUC+AmA5nMXgden8Uw=;
        b=mQBURL6wS47pWOfe754Ms/HkE9/eAoiAxpU2yjIC0V8r92zgcPrm9h4SFEluCYHK4G
         3tNtrNlnpR+4vmuE+AbjTUYIqCFLTbDiVNPoyK+2E1am5m+6UzJ/8vDrZXSEo3KBSv4d
         0j6D+FqGlV8gBJwwhMqdQ1NvvknX2cdxBbjMU/X/NtaPiBLLV4nMllq016TjM0L62apn
         AT2d4zQuN7MHmuuyAFTFugOw7O0KZZGIV2Gi1O5x1JNBBUaI0bmNZC89P7XQvsEdn6k5
         93Ad5gFb20FXfRiE8TJ69+t1yAtr1cGabeF7cRLyuMYUQBYeRhywXFA3mLc4wUu4TEgn
         qadw==
X-Gm-Message-State: APjAAAV+cZmBrj2JcM8NbgHaIEzePL4B/QAuMMjgs/5xwLO0adNSBT6g
        a3SzqszN03njOIl+fVE49QTj5TFdpt0r0EUEHD8=
X-Google-Smtp-Source: APXvYqwdyDe4ndb1UUPujLtoEA+tSqFFx3x0PsewrJWiAaT61DTtEW2t1q0boz+qCcyGxOxlU4aceiClvXB6eWkerI0=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr13780980pjb.30.1580122164762;
 Mon, 27 Jan 2020 02:49:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579890793.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jan 2020 12:49:16 +0200
Message-ID: <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:59 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> Hi,
>
> Tiger Lake platform supports 8 sub-states/low power modes of S0ix. Add
> debugfs entries to pmc_core driver to access low power mode registers
> and residencies.
>
> Patch 1: Add debugfs entry to access sub-state residencies
> Patch 2: Add debugfs entry for low power mode status registers
> Patch 3: Refactor the driver by removing redundant code
> Patch 4: Remove slp_s0 attributes from tgl_reg_map
> Patch 5: Add an additional parameter to pmc_core_lpm_display_map()
> Patch 6: Dump low power status registers on an S0ix.y failure
> Patch 7: Add debugfs support to access live status registers

It doesn't apply to our for-next branch.

>
> Gayatri Kammela (7):
>   platform/x86: intel_pmc_core: Add debugfs entry to access sub-state
>     residencies
>   platform/x86: intel_pmc_core: Add debugfs entry for low power mode
>     status registers
>   platform/x86: intel_pmc_core: Refactor the driver by removing
>     redundant code
>   platform/x86: intel_pmc_core: Remove slp_s0 attributes from
>     tgl_reg_map
>   platform/x86: intel_pmc_core: Add an additional parameter to
>     pmc_core_lpm_display()
>   platform/x86: intel_pmc_core: Dump low power status registers on an
>     S0ix.y failure
>   platform/x86: intel_pmc_core: Add debugfs support to access live
>     status registers
>
>  drivers/platform/x86/intel_pmc_core.c | 301 +++++++++++++++++++++++---
>  drivers/platform/x86/intel_pmc_core.h |  28 +++
>  2 files changed, 302 insertions(+), 27 deletions(-)
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
