Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B8118CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfEBMOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 08:14:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:60991 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfEBMOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:14:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 05:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="154129005"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2019 05:14:44 -0700
Subject: Re: [PATCH v2] xhci: Convert xhci_handshake() to use
 readl_poll_timeout_atomic()
To:     Raul Rangel <rrangel@chromium.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190208014816.21869-1-andrew.smirnov@gmail.com>
 <20190429200541.GA116440@google.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <c102196e-1250-307f-0b2e-d76c62a161a0@linux.intel.com>
Date:   Thu, 2 May 2019 15:17:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429200541.GA116440@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.4.2019 23.05, Raul Rangel wrote:
> On Thu, Feb 07, 2019 at 05:48:16PM -0800, Andrey Smirnov wrote:
>> Xhci_handshake() implements the algorithm already captured by
>> readl_poll_timeout_atomic(). Convert the former to use the latter to
>> avoid repetition.
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Tested-by: Raul E Rangel <rrangel@chromium.org>
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> 
> This fixes a bug on the AMD Stoneyridge platform. usleep(1) sometimes
> takes over 10ms. This means a 5 second timeout can easily take over 15
> seconds which will trigger the watchdog and reboot the system.
> 
> Thanks for the patch.

Adding to queue

-Mathias

