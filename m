Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E236510BCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 22:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfK0VYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 16:24:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:25959 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbfK0VYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:24:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 13:24:03 -0800
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="203209747"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 13:24:03 -0800
Message-ID: <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 27 Nov 2019 13:24:02 -0800
In-Reply-To: <20191127202453.28087-1-linux@roeck-us.net>
References: <20191127202453.28087-1-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-27 at 12:24 -0800, Guenter Roeck wrote:
> Since commit 57ea974fb871 ("driver core: Rewrite test_async_driver_probe
> to cover serialization and NUMA affinity"), running the test with NUMA
> disabled results in warning messages similar to the following.
> 
> test_async_driver test_async_driver.12: NUMA node mismatch -1 != 0
> 
> If CONFIG_NUMA=n, dev_to_node(dev) returns -1, and numa_node_id()
> returns 0. Both are widely used, so it appears risky to change return
> values. Augment the check with IS_ENABLED(CONFIG_NUMA) instead
> to fix the problem.
> 
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/base/test/test_async_driver_probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
> index f4b1d8e54daf..3bb7beb127a9 100644
> --- a/drivers/base/test/test_async_driver_probe.c
> +++ b/drivers/base/test/test_async_driver_probe.c
> @@ -44,7 +44,8 @@ static int test_probe(struct platform_device *pdev)
>  	 * performing an async init on that node.
>  	 */
>  	if (dev->driver->probe_type == PROBE_PREFER_ASYNCHRONOUS) {
> -		if (dev_to_node(dev) != numa_node_id()) {
> +		if (IS_ENABLED(CONFIG_NUMA) &&
> +		    dev_to_node(dev) != numa_node_id()) {
>  			dev_warn(dev, "NUMA node mismatch %d != %d\n",
>  				 dev_to_node(dev), numa_node_id());
>  			atomic_inc(&warnings);

I'm not sure that is really the correct fix. It might be better to test it
against NUMA_NO_NODE and then if it is not that make sure that it matches
the node ID. Adding the check against NUMA_NO_NODE would resolve the issue
for cases where the device might be assigned to multiple NUMA nodes.

