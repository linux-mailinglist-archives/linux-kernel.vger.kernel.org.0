Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C119C9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfHZHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:01:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:51733 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbfHZHBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 00:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="209259842"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2019 00:01:40 -0700
Received: from [10.226.39.22] (ekotax-mobl.gar.corp.intel.com [10.226.39.22])
        by linux.intel.com (Postfix) with ESMTP id BB1BC580444;
        Mon, 26 Aug 2019 00:01:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Philipp Zabel <p.zabel@pengutronix.de>, robh@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <42039170811f798b8edc66bf85166aefe7dbc903.1566531960.git.eswara.kota@linux.intel.com>
 <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <1566549822.3023.2.camel@pengutronix.de>
 <15c538d7-1045-1a8c-4c8b-194a1de17a16@linux.intel.com>
 <1566554987.3023.8.camel@pengutronix.de>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <ccb18776-c9b4-e5e6-36aa-b1054f45e196@linux.intel.com>
Date:   Mon, 26 Aug 2019 15:01:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1566554987.3023.8.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/23/2019 6:09 PM, Philipp Zabel wrote:
> On Fri, 2019-08-23 at 17:47 +0800, Dilip Kota wrote:
> [...]
>> Thanks for pointing it out.
>> Reset is not supported on LGM platform.
>> I will update the reset_device() definition to "return -EOPNOTSUPP"
> In that case you can just drop intel_reset_device() completely,
> the core checks whether ops->reset is set before trying to call it.

Agree, will do the same.

Regards,
Dilip

>
> regards
> Philipp
