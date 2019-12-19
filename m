Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421911270EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 23:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLSWvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 17:51:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:27773 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfLSWvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:51:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 14:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="366220427"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2019 14:51:06 -0800
Date:   Thu, 19 Dec 2019 15:02:32 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix potential memory leak
Message-ID: <20191219230232.GA241295@romley-ivt3.sc.intel.com>
References: <20191219223834.233692-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219223834.233692-1-shakeelb@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:38:34PM -0800, Shakeel Butt wrote:
> The set_cache_qos_cfg() is leaking memory when the given level is not
> RDT_RESOURCE_L3 or RDT_RESOURCE_L2. Fix that.
> 
> Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
