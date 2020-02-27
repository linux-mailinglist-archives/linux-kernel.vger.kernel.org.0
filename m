Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EDD170CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 01:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgB0AIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 19:08:09 -0500
Received: from foss.arm.com ([217.140.110.172]:43934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgB0AII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:08:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663A61FB;
        Wed, 26 Feb 2020 16:08:08 -0800 (PST)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF9483F73B;
        Wed, 26 Feb 2020 16:08:06 -0800 (PST)
Subject: Re: [PATCH 3/3] mm/vma: Make is_vma_temporary_stack() available for
 general use
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
 <1582692658-3294-4-git-send-email-anshuman.khandual@arm.com>
 <df8b59f9-ccf2-5a40-661e-2bf053b99dac@suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8f65781d-1ef0-8314-2baf-586b57a42e9c@arm.com>
Date:   Thu, 27 Feb 2020 05:38:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <df8b59f9-ccf2-5a40-661e-2bf053b99dac@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/26/2020 07:33 PM, Vlastimil Babka wrote:
> On 2/26/20 5:50 AM, Anshuman Khandual wrote:
>> Currently the declaration and definition for is_vma_temporary_stack() are
>> scattered. Lets make is_vma_temporary_stack() helper available for general
>> use and also drop the declaration from (include/linux/huge_mm.h) which is
>> no longer required. This should not cause any functional change.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> The move made it plainly visible that the is_vma_* name differs from all the
> other vma_is_* names. So this is a good chance to unify it?

Yes, we can unify it while moving. Will change.
