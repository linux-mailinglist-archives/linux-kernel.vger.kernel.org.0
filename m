Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7577E95790
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfHTGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 02:45:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:54610 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfHTGpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:45:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 23:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; 
   d="scan'208";a="262072785"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2019 23:45:27 -0700
Date:   Tue, 20 Aug 2019 14:49:34 +0800
From:   Philip Li <philip.li@intel.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     kbuild test robot <lkp@intel.com>, mark.rutland@arm.com,
        raph.gault+kdev@gmail.com, peterz@infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        kbuild-all@01.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [kbuild-all] [PATCH v3 4/5] arm64: perf: Enable pmu counter
 direct access for perf event on armv8
Message-ID: <20190820064934.GF4479@intel.com>
References: <20190816125934.18509-5-raphael.gault@arm.com>
 <201908182002.KAH4UW2w%lkp@intel.com>
 <a41e1a4b-b082-725a-b24e-9c92f66d174a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41e1a4b-b082-725a-b24e-9c92f66d174a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:59:33AM +0100, Raphael Gault wrote:
> Hi,
> 
> On 8/18/19 1:37 PM, kbuild test robot wrote:
> > Hi Raphael,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.3-rc4 next-20190816]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> This patchset was based on linux-next/master and note linus
thanks for the input, we will look for how to find better base to test.

> 
> Thanks,
> 
> -- 
> Raphael Gault
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
