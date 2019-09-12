Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7278CB0EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfILM3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 08:29:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58758 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731547AbfILM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:29:44 -0400
X-IronPort-AV: E=Sophos;i="5.64,495,1559491200"; 
   d="scan'208";a="75376775"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Sep 2019 20:29:41 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B7DB44CE14ED;
        Thu, 12 Sep 2019 20:29:32 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 12 Sep 2019 20:29:50 +0800
Subject: Re: [PATCH] mm/memblock: fix typo in memblock doc
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20190911030856.18010-1-caoj.fnst@cn.fujitsu.com>
 <20190911144230.GB6429@linux.ibm.com>
 <59f571f6-785c-7f6e-fd03-5cfc76da27be@cn.fujitsu.com>
 <20190912103535.GB9062@linux.ibm.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <8a9af872-3fb7-a438-a36a-8db6fb660afe@cn.fujitsu.com>
Date:   Thu, 12 Sep 2019 20:29:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912103535.GB9062@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: B7DB44CE14ED.AA08B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/19 6:35 PM, Mike Rapoport wrote:
> On Thu, Sep 12, 2019 at 10:54:09AM +0800, Cao jin wrote:
>> On 9/11/19 10:42 PM, Mike Rapoport wrote:

>>
>> Sure. BTW, do you want convert all the markups too?
>>
>>     :c:type:`foo` -> struct foo
>>     %FOO -> FOO
>>     ``foo`` -> foo
>>     **foo** -> foo
> 
> The documentation toolchain can recognize now foo() as a function and does
> not require the :c:func: prefix for that. AFAIK it only works for
> functions, so please don't change the rest of the markup.
>  

I see. Thanks for the info. Patch on the way.

-- 
Sincerely,
Cao jin


