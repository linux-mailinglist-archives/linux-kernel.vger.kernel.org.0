Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5772E12817D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTRfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 12:35:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:14901 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfLTRfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:35:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 09:35:47 -0800
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="390933689"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.83]) ([10.24.14.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Dec 2019 09:35:47 -0800
Subject: Re: [PATCH v2] x86/resctrl: Fix potential memory leak
To:     Shakeel Butt <shakeelb@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20191220164358.177202-1-shakeelb@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4312bfd5-2b31-8f29-03a4-677daf8ee331@intel.com>
Date:   Fri, 20 Dec 2019 09:35:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191220164358.177202-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On 12/20/2019 8:43 AM, Shakeel Butt wrote:
> The set_cache_qos_cfg() is leaking memory when the given level is not
> RDT_RESOURCE_L3 or RDT_RESOURCE_L2. However at the moment, this function
> is called with only valid levels but to make it more robust and future
> proof, we should be handling the error path gracefully.
> 
> Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Changes since v1:
> - Updated the commit message

Thank you.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
