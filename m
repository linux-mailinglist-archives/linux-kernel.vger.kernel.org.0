Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED19AF19BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 16:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfKFPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 10:18:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:48150 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731929AbfKFPSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:18:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 07:18:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="232906014"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 07:18:22 -0800
Date:   Wed, 6 Nov 2019 07:18:22 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Cross <dcross@google.com>, Peter Shier <pshier@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [KVM] 671ddc700f: kvm-unit-tests.vmx.fail
Message-ID: <20191106151822.GC16249@linux.intel.com>
References: <20191030142358.GB6853@xsang-OptiPlex-9020>
 <CALMp9eQv4Qbx-6r5cxDXcari5jKNx6_tb9rgJa8X43ftVEOSbw@mail.gmail.com>
 <20191106144548.GA32541@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106144548.GA32541@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:45:48PM +0800, Oliver Sang wrote:
> On Wed, Oct 30, 2019 at 09:56:16AM -0700, Jim Mattson wrote:
> > It's unclear to me what the delta is, but I do see that the 'vmx'
> > suite has failed. That is to be expected if you're getting your
> > kvm-unit-tests from the 'master' branch of the kvm-unit-tests repo.
> > You will need commit 591b5b54bba1 ("x86: Skip APIC-access address
> > tests beyond mapped RAM"), which is in the 'next' branch of the
> > kvm-unit-tests repo, but which has not yet made it to the 'master'
> > branch.
> 
> Thanks for information! We will wait for master upgrade to update our test
> binary.

This reminds me, are we still planning on creating "stable" branches for
kvm-unit-tests[*]?  This topic of came up in a discussion at KVM Forum as
well, though I can't remember any of the details.

Paolo?

[*] https://lkml.kernel.org/r/dc5ff4ed-c6dd-74ea-03ae-4f65c5d58073@redhat.com
