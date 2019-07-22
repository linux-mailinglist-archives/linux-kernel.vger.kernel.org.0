Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3B6FBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGVJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:12:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2372 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726918AbfGVJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:12:55 -0400
X-IronPort-AV: E=Sophos;i="5.64,294,1559491200"; 
   d="scan'208";a="71943901"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Jul 2019 17:12:52 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id EB8CE4CDBF7D;
        Mon, 22 Jul 2019 17:12:53 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 22 Jul 2019 17:12:59 +0800
Subject: Re: [PATCH] x86/irq/64: fix the missing update on comment
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <luto@kernel.org>
References: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1907221051580.1782@nanos.tec.linutronix.de>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <f9333bd0-2a62-7380-8172-facee7a61e11@cn.fujitsu.com>
Date:   Mon, 22 Jul 2019 17:13:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907221051580.1782@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: EB8CE4CDBF7D.AE75A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 4:53 PM, Thomas Gleixner wrote:
> Cao,
> 
> On Fri, 19 Jul 2019, Cao jin wrote:
> 
>> Commit e6401c130931 ("x86/irq/64: Split the IRQ stack into its own pages")
>> missed to update one piece of comment as it did to its peer in Xen, which
>> will confuse people who still need to read comment.
>>
>> A bonus fix to identation in ZO's linker script: spaces -> tab.
> 
> Please don't add 'bonus' changes. A patch which fixes a stale comment has
> nothing to do with a indentation change in an unrelated file.
> 

Kept that in mind. Sorry for the inconvenience.

-- 
Sincerely,
Cao jin


