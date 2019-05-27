Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA992B2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 13:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfE0LOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 07:14:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:12544 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfE0LOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:14:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 04:14:17 -0700
X-ExtLoop1: 1
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2019 04:14:15 -0700
Subject: Re: [PATCH] xhci: clear port_remote_wakeup after resume failure
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190524145231.6605-1-nsaenzjulienne@suse.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <eb5d9252-1283-be73-96d6-c24a0fdf1eab@linux.intel.com>
Date:   Mon, 27 May 2019 14:16:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190524145231.6605-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.5.2019 17.52, Nicolas Saenz Julienne wrote:
> This was seen on a Dell Precision 5520 using it's WD15 dock. The dock's
> Ethernet device interfaces with the laptop through one of it's USB3
> ports. While idle, the Ethernet device and HCD are suspended by runtime
> PM, being the only device connected on the bus. Then, both are resumed on
> behalf of the Ethernet device, which has remote wake-up capabilities.
> 
> The Ethernet device was observed to randomly disconnect from the USB
> port shortly after submitting it's remote wake-up request. Probably a
> weird timing issue yet to be investigated. This causes runtime PM to
> busyloop causing some tangible CPU load. The reason is the port gets
> stuck in the middle of a remote wake-up operation, waiting for the
> device to switch to U0. This never happens, leaving "port_remote_wakeup"
> enabled, and automatically triggering a failure on any further suspend
> operation.
> 
> This patch clears "port_remote_wakeup" upon detecting a device with a
> wrong resuming port state (see Table 4-9 in 4.15.2.3). Making sure the
> above mentioned situation doesn't trigger a PM busyloop.
> 

There was a similar case where the USB3 link had transitioned to a
lower power U1 or U2 state after resume, before driver read the state,
leaving port_remote_wakeup flag uncleared.

This was fixed in 5.1 kernel by commit:

6cbcf59 xhci: Fix port resume done detection for SS ports with LPM enable

Can you check if you have it?
It should be in recent stable releases as well.

-Mathias
