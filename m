Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA77DD1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfHAOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 10:00:05 -0400
Received: from foss.arm.com ([217.140.110.172]:36554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbfHAOAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:00:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1DFF337;
        Thu,  1 Aug 2019 07:00:04 -0700 (PDT)
Received: from [10.37.12.201] (unknown [10.37.12.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5B53F71F;
        Thu,  1 Aug 2019 07:00:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] i2c: Revert incorrect conversion to use generic
 helper
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, lkp@intel.com,
        mika.westerberg@linux.intel.com, wsa@the-dreams.de
References: <20190801061042.GA1132@kroah.com>
 <20190801102026.27312-1-suzuki.poulose@arm.com>
 <20190801135451.GA26585@kroah.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <09633766-0156-ffb5-3821-3b57e1448599@arm.com>
Date:   Thu, 1 Aug 2019 15:03:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190801135451.GA26585@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 02:54 PM, Greg KH wrote:
> On Thu, Aug 01, 2019 at 11:20:24AM +0100, Suzuki K Poulose wrote:
>> The patch "drivers: Introduce device lookup variants by ACPI_COMPANION device"
>> converted an incorrect instance in i2c driver to a new helper. Revert this
>> change.
>>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Fixes: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")
> 
> I'll go add this...

Thanks Greg ! Sorry, I thought the commit ids may change in linus's and
thus I referred to the "commit subject"

Cheers


