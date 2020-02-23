Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114B7169AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 00:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBWXhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 18:37:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:65515 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBWXhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:37:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 15:34:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,477,1574150400"; 
   d="scan'208";a="349801062"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230]) ([10.254.212.230])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2020 15:34:48 -0800
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RESEND] iommu: dmar: Fix RCU list debugging warnings
To:     Amol Grover <frextrite@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200223165538.29870-1-frextrite@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d1d7506c-b692-3730-fb01-5af86ab06258@linux.intel.com>
Date:   Mon, 24 Feb 2020 07:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223165538.29870-1-frextrite@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/24 0:55, Amol Grover wrote:
> dmar_drhd_units is traversed using list_for_each_entry_rcu()
> outside of an RCU read side critical section but under the
> protection of dmar_global_lock. Hence add corresponding lockdep
> expression to silence the following false-positive warnings:
> 
> [    1.603975] =============================
> [    1.603976] WARNING: suspicious RCU usage
> [    1.603977] 5.5.4-stable #17 Not tainted
> [    1.603978] -----------------------------
> [    1.603980] drivers/iommu/intel-iommu.c:4769 RCU-list traversed in non-reader section!!
> 
> [    1.603869] =============================
> [    1.603870] WARNING: suspicious RCU usage
> [    1.603872] 5.5.4-stable #17 Not tainted
> [    1.603874] -----------------------------
> [    1.603875] drivers/iommu/dmar.c:293 RCU-list traversed in non-reader section!!
> 
> Tested-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Thanks for the fix.

Cc: stable@vger.kernel.org
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
