Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD781899BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRKl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:41:57 -0400
Received: from foss.arm.com ([217.140.110.172]:48094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRKl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:41:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 710F51FB;
        Wed, 18 Mar 2020 03:41:56 -0700 (PDT)
Received: from [10.163.1.20] (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286B13F534;
        Wed, 18 Mar 2020 03:41:52 -0700 (PDT)
Subject: Re: [PATCH 4/5] mm/vma: Replace all remaining open encodings with
 vma_set_anonymous()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
 <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
 <20200318102401.GA2126918@kroah.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5abf84d1-7199-b646-a620-fc0e23f1fb29@arm.com>
Date:   Wed, 18 Mar 2020 16:11:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200318102401.GA2126918@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/18/2020 03:54 PM, Greg Kroah-Hartman wrote:
> On Mon, Feb 17, 2020 at 10:33:52AM +0530, Anshuman Khandual wrote:
>> This replaces all remaining open encodings with vma_set_anonymous().
>>
>> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
>> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Allison Randal <allison@lohutok.net>
>> Cc: Richard Fontana <rfontana@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/misc/mic/scif/scif_mmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> The subject line does not match up with the file being modified here :(

Idea here was to primarily focus on the VMA modifying helpers instead,
hence the subject line. But I get your point and agree that it was bit
off the mark. Anyways, had already dropped this patch.
