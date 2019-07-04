Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469925F0F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 03:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGDBXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 21:23:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfGDBXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:23:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 32C64764528F2CFDDA99;
        Thu,  4 Jul 2019 09:23:18 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 09:23:16 +0800
Subject: Re: [PATCH -next] integrity: Remove set but not used variable 'acl'
To:     David Howells <dhowells@redhat.com>
References: <20190703025518.6379-1-yuehaibing@huawei.com>
 <15691.1562162261@warthog.procyon.org.uk>
CC:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <be6aaeb1-13ab-50bc-81a6-c461d3748820@huawei.com>
Date:   Thu, 4 Jul 2019 09:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <15691.1562162261@warthog.procyon.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/3 21:57, David Howells wrote:
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> security/integrity/digsig.c: In function 'integrity_init_keyring':
>> security/integrity/digsig.c:99:18: warning:
>>  variable 'acl' set but not used [-Wunused-but-set-variable]
>>
>> It seems 'acl' is needed in __integrity_init_keyring
> 
> I've folded this fix in, thanks.

Thanks, also I write a wrong patch title.

> 
> David
> 
> .
> 

