Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5917010EF52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfLBS2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 13:28:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:22634 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfLBS2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:28:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 10:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="293505672"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga001.jf.intel.com with ESMTP; 02 Dec 2019 10:28:51 -0800
Date:   Mon, 2 Dec 2019 10:28:51 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] xen-pcifront: Align address of flags to size of
 unsigned long
Message-ID: <20191202182851.GB22528@agluck-desk2.amr.corp.intel.com>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
 <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
 <e236e8fe-3a81-e17a-2286-228bfde9919a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e236e8fe-3a81-e17a-2286-228bfde9919a@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:02:13AM +0100, J�rgen Gro� wrote:
> On 25.11.19 20:43, Fenghua Yu wrote:
> > The address of "flags" is passed to atomic bitops which require the
> > address is aligned to size of unsigned long.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >   include/xen/interface/io/pciif.h | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/xen/interface/io/pciif.h b/include/xen/interface/io/pciif.h
> > index d9922ae36eb5..639d5fb484a3 100644
> > --- a/include/xen/interface/io/pciif.h
> > +++ b/include/xen/interface/io/pciif.h
> > @@ -103,8 +103,11 @@ struct xen_pcie_aer_op {
> >   	uint32_t devfn;
> >   };
> >   struct xen_pci_sharedinfo {
> > -	/* flags - XEN_PCIF_* */
> > -	uint32_t flags;
> > +	/* flags - XEN_PCIF_*. Force alignment for atomic bit operations. */
> > +	union {
> > +		uint32_t	flags;
> > +		unsigned long	flags_alignment;
> > +	};
> >   	struct xen_pci_op op;
> >   	struct xen_pcie_aer_op aer_op;
> >   };
> > 
> 
> NAK.
> 
> This is an interface definition for communication between Xen dom0 and
> guests via shared memory. It can't be changed.

Bother. There doesn't seem to be anything else in the xen_pci_sharedinfo
structure (or any of its sub-components) that would force the whole thing
to be any more strictly aligned than uint32_t

Oh ... but it looks like this is the only allocation:


        pdev->sh_info =
            (struct xen_pci_sharedinfo *)__get_free_page(GFP_KERNEL);

so "flags" is page aligned.

Fenghua: drop this patch, it isn't needed.

-Tony
