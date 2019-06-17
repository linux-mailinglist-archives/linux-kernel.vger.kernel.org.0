Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9027478B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfFQDh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 23:37:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:59456 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfFQDh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:37:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 20:37:56 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2019 20:37:56 -0700
Date:   Sun, 16 Jun 2019 20:28:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190617032826.GB214090@romley-ivt3.sc.intel.com>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <20190616175233.GA10821@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616175233.GA10821@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 07:52:33PM +0200, Borislav Petkov wrote:
> On Sun, Jun 16, 2019 at 10:14:08AM -0700, Fenghua Yu wrote:
> > @@ -617,13 +617,20 @@ static void l3_mon_evt_init(struct rdt_resource *r)
> >  		list_add_tail(&mbm_local_event.list, &r->evt_list);
> >  }
> >  
> > -int rdt_get_mon_l3_config(struct rdt_resource *r)
> > +int __init rdt_get_mon_l3_config(struct rdt_resource *r)
> >  {
> >  	unsigned int cl_size = boot_cpu_data.x86_cache_size;
> > +	u32 eax, ebx, ecx, edx;
> >  	int ret;
> >  
> > -	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> > -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> > +	/*
> > +	 * At this point, CQM LLC and one of L3 occupancy, MBM total, and
> > +	 * MBM local monitoring features must be supported. So sub-leaf
> > +	 * (EAX=0xf, ECX=1) contains needed information for this resource.
> > +	 */
> > +	cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
> > +	r->num_rmid = ecx + 1;
> > +	r->mon_scale = ebx;
> >  
> >  	/*
> >  	 * A reasonable upper limit on the max threshold is the number
> 
> This is simpler than that:
> 
> https://lkml.kernel.org/r/20190614174959.GF198207@romley-ivt3.sc.intel.com
> 
> Why?

After think this code again, ecx and ebx in sub-leaf CPUID.f.1 actually
contains the number of rmid and monitoring scale. The two variables are
always valid if any of L3 occupancy, MBM total, and MBM local monitoring
features is supported. So there is no need to check the features to get
the info.

But seems this patch is not needed according to Thomas?

Should I do the following changes in the next version of patch set?

1. Remove patch #1
2. Change patch #2 to the patch in https://lkml.org/lkml/2019/6/16/274
3. Keep patch #3

Please advice.

Thanks.

-Fenghua


