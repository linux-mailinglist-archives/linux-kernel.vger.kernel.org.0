Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5B9CC92
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfHZJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 05:27:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfHZJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:27:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so14576889wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwMP8O1PqF7oQCP6dSYDGT5eGytE5jd5sRwg9tyXBcs=;
        b=lZXC95fSZhuofr8vzxP50gISZE9uoWmmAjGdL8wGYajEcRRDKf0ze5WZd4Q1SIbx1Y
         bY3jI3migVIXTOLhjyVvwf3O8b6fJnAWHwq+Rxjs+1LUG5B0qxb24Hr78ZG0NOkjrVUp
         g1OEDaOQi9mC4vLodXXWEs/rPQgb6BjPyIEsxyHn1paFoDsI+YwTWiirolLwIxiIDnzo
         UUWhXlAP5L7q2azfq5lMEVgPpqi4ooVTL7TnIexmzTFM27qLD5aFyuPbdLOg+aMaLj/4
         v2+4Zf914F0HX8dnRqmGR8aNKdIrQ+rZY1kjI4KZQ3+fLBqhzHcULIy8DrRQOktH0N9q
         soSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwMP8O1PqF7oQCP6dSYDGT5eGytE5jd5sRwg9tyXBcs=;
        b=djY/HYGtn5TH7SoxpgiYPnVOKIW91eXjENZZ3a/UXtUtIHD8W5LUGO36CcUWwU/cd3
         Ud5IU16UMUtdtXUq4vPW6DjLohZOx1LGCgoIb6EImXE71iQb7m1OveQJWD+BkK6Jjj9k
         kkvGVaAQGqbwkdYwmhGH+IjjCVFrI/heUP1Cc8u428kVCYQMYlKsdpiWSlKQ8/gqYj5z
         hL93McbkWU+SJa6YH2S70NKjGO7W8aXKPf71eDFlTXUoqpTOas/lLqT2KRwuaWhhqhOy
         hOyt4PghjhcMCMcfUUJhPHTwFScWn5WaZ7lgqhj1l3a2s+37krIKGj6/C/ZWhqxzXNHJ
         YvZw==
X-Gm-Message-State: APjAAAWxM6zXObjmyc9lm4iaUchamQiSjSU1O1AwLT7Z6CGZj2gwd9+V
        9SlooII7K+TkctDpXiOxBPk=
X-Google-Smtp-Source: APXvYqy0XNuLWzHKLsreX6/bsuYr6f1nKWfLR/6493n5xS/cTOcvuocDGKheh7FRZly8+Thr9Wrbxg==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr274311wrq.63.1566811673589;
        Mon, 26 Aug 2019 02:27:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t8sm29136101wra.73.2019.08.26.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:27:53 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:27:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/5] x86/intel: Aggregate microserver naming
Message-ID: <20190826092750.GA56543@gmail.com>
References: <20190822102306.109718810@infradead.org>
 <20190822102411.337145504@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822102411.337145504@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Currently big microservers have _XEON_D while small microservers have
> _X, Make it uniformly: _D.
> 
> for i in `git grep -l "INTEL_FAM6_.*_\(X\|XEON_D\)"`
> do
> 	sed -i -e 's/\(INTEL_FAM6_ATOM_.*\)_X/\1_D/g' \
>                -e 's/\(INTEL_FAM6_.*\)_XEON_D/\1_D/g' ${i}
> done
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: x86@kernel.org
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/events/intel/core.c          |   20 ++++++++++----------
>  arch/x86/events/intel/cstate.c        |   12 ++++++------
>  arch/x86/events/intel/pt.c            |    2 +-
>  arch/x86/events/intel/rapl.c          |    4 ++--
>  arch/x86/events/intel/uncore.c        |    4 ++--
>  arch/x86/events/msr.c                 |    6 +++---
>  arch/x86/include/asm/intel-family.h   |   10 +++++-----
>  arch/x86/kernel/apic/apic.c           |    2 +-
>  arch/x86/kernel/cpu/intel.c           |    4 ++--
>  arch/x86/kernel/cpu/mce/intel.c       |    2 +-
>  arch/x86/kernel/tsc.c                 |    2 +-
>  drivers/cpufreq/intel_pstate.c        |    6 +++---
>  drivers/edac/i10nm_base.c             |    4 ++--
>  drivers/edac/pnd2_edac.c              |    2 +-
>  tools/power/x86/turbostat/turbostat.c |   22 +++++++++++-----------
>  15 files changed, 51 insertions(+), 51 deletions(-)

I've added the additional renames below, accounting for recent changes in 
cpu/common.c.

Thanks,

	Ingo

---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f125bf7ecb6f..b6a9e27755d7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1050,7 +1050,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(ATOM_BONNELL_MID,		NO_SPECULATION),
 
 	VULNWL_INTEL(ATOM_SILVERMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
-	VULNWL_INTEL(ATOM_SILVERMONT_X,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_SILVERMONT_D,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_SILVERMONT_MID,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_AIRMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 	VULNWL_INTEL(XEON_PHI_KNL,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
@@ -1061,7 +1061,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
 
 	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS),
-	VULNWL_INTEL(ATOM_GOLDMONT_X,		NO_MDS | NO_L1TF | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_GOLDMONT_D,		NO_MDS | NO_L1TF | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS),
 
 	/*
