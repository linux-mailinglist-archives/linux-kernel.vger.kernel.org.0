Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C668169BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 02:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBXB2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 20:28:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:16750 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:28:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 17:28:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="255428790"
Received: from unknown (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2020 17:28:36 -0800
Reply-To: like.xu@intel.com
Subject: Re: [Ask for Help]LBR usage in kernel
To:     =?UTF-8?B?6ZmI5byL5466?= <jasoncyx@163.com>,
        linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org
References: <3dad7270.821a.17062dfcb99.Coremail.jasoncyx@163.com>
From:   "Xu, Like" <like.xu@intel.com>
Organization: Intel OTC
Message-ID: <edadc513-a331-7a5f-01f2-c06217d925a5@intel.com>
Date:   Mon, 24 Feb 2020 09:28:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3dad7270.821a.17062dfcb99.Coremail.jasoncyx@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 弋玺,

On 2020/2/20 21:53, 陈弋玺 wrote:
> Hi experts,
>      We want to try to retreive callchains of some perf events from LBR rather than frame stacks, as the information in frame stacks would be optimized by compiler. After investigating the usage of LBR in kernel, we found that LBR can only operated via Intel PMU,
The default driver to operate LBR on the Linux is the PMU deriver,
which is one of perf feature ofs and I assume you know about its basic usages.

     perf record -b ./workload
     perf record --call-graph lbr ./workload

Other performance monitoring tools like Emon, VTune and other non-opensource
commercial tools in Ring 0 could operate LBR as well.
> that means for now only callchains of hardware events can be retrieved from LBR. Is that correct?
the callchains and the basic branch records in sampling mode.
>   
>      If yes, I wonder if callchains of other perf events(eg. tracepoint, software events) can be retrieved from LBR?
Software events like trace points are not retrieved from LBR,
but you could wrapper them with intentional branch instructions changes.

> Or only callchains of events on PMU can be retrieved from LBR as there are some hardware restrictions?
I won't say its hardware restrictions but intentional behavior.
It's all about your innovative ideas to operate LBR for your purpose.

Thanks,
Like Xu
>
> Thanks for any help you can offer!
>
> Best Regards,
> Yixi Chen

