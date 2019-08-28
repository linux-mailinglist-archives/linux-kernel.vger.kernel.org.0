Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD999FCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1IP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:15:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21798 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbfH1IPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:15:55 -0400
X-IronPort-AV: E=Sophos;i="5.64,440,1559491200"; 
   d="scan'208";a="74441648"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Aug 2019 16:15:53 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id BC9584CE032B;
        Wed, 28 Aug 2019 16:15:52 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 28 Aug 2019 16:16:00 +0800
Subject: Re: [PATCH] x86/cpufeature: explicit comments for duplicate macro
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20190828061100.27032-1-caoj.fnst@cn.fujitsu.com>
 <20190828064231.GB4920@zn.tnic>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <9077662c-aaba-29f1-e6a2-dbaacc0758cc@cn.fujitsu.com>
Date:   Wed, 28 Aug 2019 16:16:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190828064231.GB4920@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: BC9584CE032B.A912F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 2:42 PM, Borislav Petkov wrote:
> On Wed, Aug 28, 2019 at 02:11:00PM +0800, Cao jin wrote:
> 
> For the future:
> 
>> Subject: Re: [PATCH] x86/cpufeature: explicit comments for duplicate macro
> 
> your subject needs to have a verb and start with a capital letter after
> the subsystem/path prefix. In this case, something like this, for
> example:
> 
> Subject: [PATCH] x86/cpufeature: Explain the macro duplication
> 

Kept that in mind. Thanks very much!

-- 
Sincerely,
Cao jin


