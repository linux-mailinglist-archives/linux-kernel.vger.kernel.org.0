Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA53610C084
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 00:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK0XNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 18:13:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:32316 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfK0XNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:13:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 15:13:40 -0800
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="199340650"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 15:13:39 -0800
Message-ID: <b5826338cd4479b724835ea5469c5a8318e88e2c.camel@linux.intel.com>
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 27 Nov 2019 15:13:39 -0800
In-Reply-To: <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
References: <20191127202453.28087-1-linux@roeck-us.net>
         <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
         <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-27 at 14:42 -0800, Guenter Roeck wrote:
> On 11/27/19 1:24 PM, Alexander Duyck wrote:
> > On Wed, 2019-11-27 at 12:24 -0800, Guenter Roeck wrote:
> > > Since commit 57ea974fb871 ("driver core: Rewrite test_async_driver_probe
> > > to cover serialization and NUMA affinity"), running the test with NUMA
> > > disabled results in warning messages similar to the following.
> > > 
> > > test_async_driver test_async_driver.12: NUMA node mismatch -1 != 0
> > > 
> > > If CONFIG_NUMA=n, dev_to_node(dev) returns -1, and numa_node_id()
> > > returns 0. Both are widely used, so it appears risky to change return
> > > values. Augment the check with IS_ENABLED(CONFIG_NUMA) instead
> > > to fix the problem.
> > > 
> > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >   drivers/base/test/test_async_driver_probe.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
> > > index f4b1d8e54daf..3bb7beb127a9 100644
> > > --- a/drivers/base/test/test_async_driver_probe.c
> > > +++ b/drivers/base/test/test_async_driver_probe.c
> > > @@ -44,7 +44,8 @@ static int test_probe(struct platform_device *pdev)
> > >   	 * performing an async init on that node.
> > >   	 */
> > >   	if (dev->driver->probe_type == PROBE_PREFER_ASYNCHRONOUS) {
> > > -		if (dev_to_node(dev) != numa_node_id()) {
> > > +		if (IS_ENABLED(CONFIG_NUMA) &&
> > > +		    dev_to_node(dev) != numa_node_id()) {
> > >   			dev_warn(dev, "NUMA node mismatch %d != %d\n",
> > >   				 dev_to_node(dev), numa_node_id());
> > >   			atomic_inc(&warnings);
> > 
> > I'm not sure that is really the correct fix. It might be better to test it
> > against NUMA_NO_NODE and then if it is not that make sure that it matches
> > the node ID. Adding the check against NUMA_NO_NODE would resolve the issue
> > for cases where the device might be assigned to multiple NUMA nodes.
> > 
> I think you are suggesting that dev_to_node(dev) might return NUMA_NO_NODE
> even on systems with CONFIG_NUMA enabled. I have no idea if that can happen.
> The code in test_async_probe_init() seems to suggest that the node is set
> to a valid node id for all asynchronous nodes, so I don't immediately see
> how that could be the case. I may be missing something, of course.

Well thinking back to the Nehalem architecture I seem to recall that there
were devices that were connected to a shared IOH that was accessible
across both nodes. I thought that they might have a node ID of
NUMA_NO_NODE since they didn't really belong to either of the two nodes in
the sytem.

It would effectively work out the same as your patch compiler wise since
dev_to_node would be NUMA_NO_NODE in the non-NUMA case so it would compile
out the warning since it would fail the first check, and in the NUMA case
it would add an extra check to make sure that dev_to_node is actually
indicating the device needs a specific node in the NUMA enabled case.

