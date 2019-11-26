Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861B610A5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKZUua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:50:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:30537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZUu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:50:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 12:50:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="260799765"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2019 12:50:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 29016300B64; Tue, 26 Nov 2019 12:50:28 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:50:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Filter MSR writes from luserspace
Message-ID: <20191126205028.GJ84886@tassilo.jf.intel.com>
References: <20191126112234.GA22393@zn.tnic>
 <87zhgie6nl.fsf@linux.intel.com>
 <20191126203336.GF31379@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126203336.GF31379@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:33:36PM +0100, Borislav Petkov wrote:
> On Tue, Nov 26, 2019 at 12:15:10PM -0800, Andi Kleen wrote:
> > This will break a bazillion of tools that rely on programing many of
> > those MSRs from user space.
> 
> Userspace has no deal to poke into random MSRs. End of story.

You'll almost certainly violate Linus' golden rule of application
compatibility and the whole thing will be reverted in the end.

-Andi
