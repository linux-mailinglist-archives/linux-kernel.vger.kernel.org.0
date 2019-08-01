Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF45D7E388
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfHATtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 15:49:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:13758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388609AbfHATtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:49:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 12:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="180805181"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2019 12:49:48 -0700
Date:   Thu, 1 Aug 2019 12:49:48 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        jing.lin@intel.com, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
References: <20190801194348.GA6059@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801194348.GA6059@avx2>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:43:48PM +0300, Alexey Dobriyan wrote:
> > +static inline void movdir64b(void *dst, const void *src)
> > +{
> > +	/* movdir64b [rdx], rax */
> > +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > +			: "=m" (*(char *)dst)
>                                ^^^^^^^^^^
> 
> > +			: "d" (src), "a" (dst));
> > +}
> 
> Probably needs fake 64-byte type, so that compiler knows what is dirty.

Would that be something like this?

static inline void movdir64b(void *dst, const void *src)
{
	struct dstbytes {
		char pad[64];
	};

	/* movdir64b [rdx], rax */
	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
		     : "=m" (*(struct dstbytes *)dst)
		     : "d" (src), "a" (dst));
}

Or did you have something else in mind?

-Tony
