Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51CAB262A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfIMThw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 15:37:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59530 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbfIMThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:37:51 -0400
Received: from [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3] (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 00ECF28EF32;
        Fri, 13 Sep 2019 20:37:47 +0100 (BST)
Subject: Re: [PATCH 4/4] coding-style: add explanation about pr_fmt macro
To:     Joe Perches <joe@perches.com>, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com
References: <20190913185746.337429-1-andrealmeid@collabora.com>
 <20190913185746.337429-5-andrealmeid@collabora.com>
 <3028cb117886ccc40f160500bd712f005ff6d5f3.camel@perches.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <660cb3cf-1e19-fb0e-9ca6-89f50d5bfd33@collabora.com>
Date:   Fri, 13 Sep 2019 16:36:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <3028cb117886ccc40f160500bd712f005ff6d5f3.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 4:08 PM, Joe Perches wrote:
> On Fri, 2019-09-13 at 15:57 -0300, André Almeida wrote:
>> The pr_fmt macro is useful to format log messages printed by pr_XXXX()
>> functions. Add text to explain the purpose of it, how to use and an
>> example.
> []
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> []
>> @@ -819,7 +819,15 @@ which you should use to make sure messages are matched to the right device
>>  and driver, and are tagged with the right level:  dev_err(), dev_warn(),
>>  dev_info(), and so forth.  For messages that aren't associated with a
>>  particular device, <linux/printk.h> defines pr_notice(), pr_info(),
>> -pr_warn(), pr_err(), etc.
>> +pr_warn(), pr_err(), etc. It's possible to format pr_XXX() messages using the
>> +macro pr_fmt() to prevent rewriting the style of messages. It should be
>> +defined before including ``include/printk.h``, to avoid compiler warning about
> 
> Please make this '#include <linux/kernel.h>'
> 
> printk.h should normally not be #included.
> 

Thanks for the feedback, changed for v2.

