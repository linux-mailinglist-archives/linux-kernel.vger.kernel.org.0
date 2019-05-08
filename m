Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51B6178FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfEHMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 08:02:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:22852 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfEHMCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:02:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 05:01:59 -0700
X-ExtLoop1: 1
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2019 05:01:57 -0700
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20190401141611.10087-1-suwan.kim027@gmail.com>
 <20190507160219.GB2427@localhost.localdomain>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <0529be1d-57d6-18b8-6f62-49f4b3931e1a@linux.intel.com>
Date:   Wed, 8 May 2019 15:04:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190507160219.GB2427@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.5.2019 19.02, Suwan Kim wrote:
> On Mon, Apr 01, 2019 at 11:16:11PM +0900, Suwan Kim wrote:
>> Patch "USB: HCD: support giveback of URB in tasklet context"[1]
>> introduced giveback of urb in tasklet context. [1] This patch was
>> applied to ehci but not xhci. [2] This patch significantly reduces
>> the hard irq time of xhci. Especially for uvc driver, the hard irq
>> including the uvc completion function runs quite long but applying
>> this patch reduces the hard irq time of xhci.
>>
> 
> I sent this patch a month ago but got no answer.
> Is there any feedback for this?
> Please let me know if there are any faults or it needs more tests.
> 

I'll add this to a internal tree first, and let it sit there for a few
weeks, trying to catch possible bugs this change could expose.

-Mathias

