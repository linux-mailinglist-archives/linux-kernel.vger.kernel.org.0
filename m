Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0B6CB28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 10:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389594AbfGRIov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 04:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbfGRIov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:44:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8B67AD22;
        Thu, 18 Jul 2019 08:44:49 +0000 (UTC)
Date:   Thu, 18 Jul 2019 10:44:45 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] x86/mm: Sync also unmappings in vmalloc_sync_one()
Message-ID: <20190718084445.GE13091@suse.de>
References: <20190717071439.14261-1-joro@8bytes.org>
 <20190717071439.14261-3-joro@8bytes.org>
 <28a4c10f-f895-e8ff-d07b-9e4c35aa6342@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a4c10f-f895-e8ff-d07b-9e4c35aa6342@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, Jul 17, 2019 at 02:06:01PM -0700, Dave Hansen wrote:
> On 7/17/19 12:14 AM, Joerg Roedel wrote:
> > -	if (!pmd_present(*pmd))
> > +	if (pmd_present(*pmd) ^ pmd_present(*pmd_k))
> >  		set_pmd(pmd, *pmd_k);
> 
> Wouldn't:
> 
> 	if (pmd_present(*pmd) != pmd_present(*pmd_k))
> 		set_pmd(pmd, *pmd_k);
> 
> be a bit more intuitive?

Yes, right. That is much better, I changed it in the patch.

> But, either way, these look fine.  For the series:
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks!


	Joerg
