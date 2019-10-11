Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72EBAD4197
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfJKNnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:43:39 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34083 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfJKNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:43:39 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIvCf-0005ik-SM; Fri, 11 Oct 2019 14:43:34 +0100
Subject: Re: [PATCH] proc: centralise declaration of cpuinfo_op
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@lists.codethink.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
 <20191009175149.GA28540@infradead.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <5c4ad594-55a3-a9c5-1674-e85665422aa1@codethink.co.uk>
Date:   Fri, 11 Oct 2019 14:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009175149.GA28540@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2019 18:51, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 12:39:30PM +0100, Ben Dooks wrote:
>> When building for arm, cpuinfo_op generates a warning due
>> to no declaration. Since this is used in fs/proc/cpuinfo.c
>> and inconsitently declared across archiectures move the
>> declaration info <linux/seq_file.h>. This means that the
>> cpuinfo_op will have a declaration any place it is used.
>>
>> Removes the following sparse warning:
>>
>> arch/arm/kernel/setup.c:1320:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?
> 
> I like the consolidation, but I don't think seq_file.h is the right
> place.  A procfs or cpu topology related header seems like the better
> choice.

Ok, thanks.

I'll have a look at where else it could go, but I'm not sure if I have
the resources to build /all/ kernels that this would effect.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
