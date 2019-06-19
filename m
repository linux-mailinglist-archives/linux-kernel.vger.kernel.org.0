Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CDB4B32D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfFSHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 03:36:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:13919 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfFSHg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:36:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 00:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181577665"
Received: from mcostacx-wtg.ger.corp.intel.com (HELO localhost) ([10.249.47.136])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2019 00:36:53 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: linux-next: manual merge of the drm tree with the kbuild tree
In-Reply-To: <20190619141949.38e661e6@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190619141949.38e661e6@canb.auug.org.au>
Date:   Wed, 19 Jun 2019 10:38:09 +0300
Message-ID: <87imt2m3dq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/i915/Makefile.header-test
>
> between commit:
>
>   e846f0dc57f4 ("kbuild: add support for ensuring headers are self-contained")
>
> from the kbuild tree and commits:
>
>   112ed2d31a46 ("drm/i915: Move GraphicsTechnology files under gt/")
>   d91e657876a9 ("drm/i915: Introduce struct intel_wakeref")
>   aab30b85c97a ("drm/i915: ensure more headers remain self-contained")
>   b375d0ef2589 ("drm/i915: extract intel_vdsc.h from intel_drv.h and i915_drv.h")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

LGTM, thanks.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
