Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD5148B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEFLN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 07:13:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:16206 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFLN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:13:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 04:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="155495557"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 04:13:55 -0700
Subject: Re: [PATCH] usb: host: xhci_debugfs: Fix a null pointer dereference
 in xhci_debugfs_create_endpoint()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190504033748.17964-1-baijiaju1990@gmail.com>
 <20190504063340.GA26311@kroah.com>
 <db68433e-d655-217a-4a73-4bb83069addc@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <939faa2c-54a8-1ae9-500c-3e25e1e2c691@linux.intel.com>
Date:   Mon, 6 May 2019 14:16:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <db68433e-d655-217a-4a73-4bb83069addc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.5.2019 10.30, Jia-Ju Bai wrote:
> 
> 
> On 2019/5/4 14:33, Greg KH wrote:
>> On Sat, May 04, 2019 at 11:37:48AM +0800, Jia-Ju Bai wrote:
>>> In xhci_debugfs_create_slot(), kzalloc() can fail and
>>> dev->debugfs_private will be NULL.
>>> In xhci_debugfs_create_endpoint(), dev->debugfs_private is used without
>>> any null-pointer check, and can cause a null pointer dereference.
>>>
>>> To fix this bug, a null-pointer check is added in
>>> xhci_debugfs_create_endpoint().
>>>
>>> This bug is found by a runtime fuzzing tool named FIZZER written by us.
>>>
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> Very rare case, but nice fix.  You should put "potential" in your
>> subject line as this is something that no one should ever hit :)
> 
> Okay, Greg, thanks for this advice :)
> 

Adding patch to queue, and added "potential" to subject line.

-Mathias
