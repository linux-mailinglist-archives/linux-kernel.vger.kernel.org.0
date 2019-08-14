Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8C8D574
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfHNN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:57:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:22737 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfHNN5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:57:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 06:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="178165545"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2019 06:57:42 -0700
Subject: Re: [PATCH] xhci: fix memleak on setup address fails.
To:     Ikjoon Jang <ikjn@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190811082259.48176-1-ikjn@chromium.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <5883d03d-31c4-206a-26c1-ca641dbf845c@linux.intel.com>
Date:   Wed, 14 Aug 2019 16:59:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811082259.48176-1-ikjn@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.8.2019 11.22, Ikjoon Jang wrote:
> Xhci re-enables a slot on transaction error in set_address using
> xhci_disable_slot() + xhci_alloc_dev().
> 
> But in this case, xhci_alloc_dev() creates debugfs entries upon an
> existing device without cleaning up old entries, thus memory leaks.
> 
> So this patch simply moves calling xhci_debugfs_free_dev() from
> xhci_free_dev() to xhci_disable_slot().
> 

Othwerwise this looks good, but xhci_alloc_dev() will call xhci_disable_slot()
in some failure cases before the slot debugfs entry is created.

In these cases xhci_debugfs_remove_slot() will be called without
xhci_debugfs_create_slot() ever being called.

This might not be an issue as xhci_debugfs_remove_slot() checks
if (!dev || !dev->debugfs_private) before doing anything, but should
be checked out.

-Mathias
