Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2D141B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 03:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgASC1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 21:27:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:11560 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgASC1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 21:27:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 18:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="214898484"
Received: from unknown (HELO [10.238.130.152]) ([10.238.130.152])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2020 18:27:47 -0800
Subject: Re: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
References: <874kwu2nih.fsf@nanos.tec.linutronix.de>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <d3282993-714e-69cb-6113-72f6a8854839@linux.intel.com>
Date:   Sun, 19 Jan 2020 10:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <874kwu2nih.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/2020 9:58 PM, Thomas Gleixner wrote:
>> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
>> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> This Signed-off-by chain is invalid.
>
> Thanks,
>
>          tglx

Could I ask how can we handle such co-author situation?

Thanks!

Jing

