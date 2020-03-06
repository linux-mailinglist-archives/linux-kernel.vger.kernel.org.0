Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE317C873
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 23:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCFWke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 17:40:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:31326 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgCFWke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:40:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 14:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="234943569"
Received: from shenkel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.23.162])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2020 14:40:27 -0800
Date:   Sat, 7 Mar 2020 00:40:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem creation
Message-ID: <20200306224026.GA4095@linux.intel.com>
References: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
 <20200306193127.GJ7472@linux.intel.com>
 <alpine.DEB.2.21.2003062148050.2990@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003062148050.2990@felia>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:50:44PM +0100, Lukas Bulwahn wrote:
> 
> 
> On Fri, 6 Mar 2020, Jarkko Sakkinen wrote:
> 
> > On Thu, Mar 05, 2020 at 09:30:13PM +0100, Lukas Bulwahn wrote:
> > > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> > > renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> > > to trusted-keys/trusted_tpm1.c in security/keys/.
> > > 
> > > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > > 
> > >   warning: no file matches F: security/keys/trusted.c
> > >   warning: no file matches F: include/keys/trusted.h
> > > 
> > > Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> > > files in security/keys/trusted-keys/ are identified as part of
> > > KEYS-TRUSTED.
> > > 
> > > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > ---
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > > Changes to v1:
> > >   - use a global pattern for matching the whole security/keys/trusted-keys/
> > >     directory.
> > > Changes to v2:
> > >   - name the correct directory in the commit message
> > > 
> > > Sumit, please ack.
> > > Jarkko, please pick this patch v3.
> > 
> > Please tell me why you emphasize the moment when a patch that does not
> > fix a critical bug is picked?
> > 
> > Do you have systems that break because the MAINTAINERS file is not
> > updated?
> > 
> > It will end up in v5.7 PR for sure but saying things like that is same
> > as saying that there would be some catastrophically urgent need to still
> > squeeze the patch into v5.6. Unless you actually have something critical
> > in your hand, please stop doing that.
> > 
> 
> Got it. I did not intend to emphasize any urgency; I will not continue 
> to do that for patches of this clean-up type.

Anyway, thank you and I've applied your patch and will include it to my
v5.7 PR.

/Jarkko
