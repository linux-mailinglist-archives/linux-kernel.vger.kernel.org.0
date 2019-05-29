Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B201F2DF11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfE2OCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 10:02:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:43018 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfE2OCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:02:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:02:42 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 29 May 2019 07:02:41 -0700
From:   Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCHv4 2/4] firmware: add Intel Stratix10 remote system update
 driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528231557.GA28886@kroah.com>
Message-ID: <a68355e1-762b-0a22-7037-c06036717609@linux.intel.com>
Date:   Wed, 29 May 2019 09:15:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528231557.GA28886@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


On 5/28/19 6:15 PM, Greg KH wrote:
> On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> The Intel Remote System Update (RSU) driver exposes interfaces access
>> through the Intel Service Layer to user space via sysfs interface.
>> The RSU interfaces report and control some of the optional RSU features
>> on Intel Stratix 10 SoC.
>>
>> The RSU feature provides a way for customers to update the boot
>> configuration of a Intel Stratix 10 SoC device with significantly reduced
>> risk of corrupting the bitstream storage and bricking the system.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> Reviewed-by: Alan Tull <atull@kernel.org>
> 
> Is Alan reviewing all of these new versions before you post them
> publicly?  If so, great, if not, don't add tags to new versions when you
> change things around...
Yes, Alan reviewed all of these new versions before I submitted for 
upstream.

> 
> thanks,
> 
> greg k-h
> 

Regards,
Richard
