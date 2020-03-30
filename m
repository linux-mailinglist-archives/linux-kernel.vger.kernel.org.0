Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA097198068
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgC3QDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 12:03:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53487 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727048AbgC3QDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:03:32 -0400
Received: (qmail 20357 invoked by uid 500); 30 Mar 2020 12:03:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Mar 2020 12:03:31 -0400
Date:   Mon, 30 Mar 2020 12:03:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     madhuparnabhowmik10@gmail.com
cc:     gregkh@linuxfoundation.org, <hariprasad.kelam@gmail.com>,
        <colin.king@canonical.com>, <tony.olech@elandigitalsystems.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrianov@ispras.ru>
Subject: Re: Possible data-race related bug in u132_hcd module.
In-Reply-To: <20200330115243.11107-1-madhuparnabhowmik10@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003301159170.12110-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 madhuparnabhowmik10@gmail.com wrote:

> Hi,
> 
> This bug is found by  Linux Driver Verification project (linuxtesting.org).
> 
> The bug is related to the parallel execution of u132_probe() function
> and u132_hcd_exit() function in u132_hcd.c. In case the module is
> unloaded when the probe function is executing there can be data race
> as the mutex lock u132_module_lock is not used properly. 

Normally drivers do not have to worry about races between their probe 
and exit routines.  The exit routine should unregister the driver from 
its bus subsystem, and unregistration is supposed to wait until all 
probe and remove functions have finished executing.

> i) Usage of mutex lock only when writing into the u132_exiting
> variable in u132_hcd_exit(). The lock is not used when this variable
> is read in u132_probe().

I'm not familiar with u132_hcd, but the probe routine shouldn't need to 
use and "exiting" variable at all.

> 
> Moreover, this variable does not serve its purpose, as even if
> locking is used while the u132_exiting variable is read in probe(),
> the function may still miss that exit function is executing if it
> acquires the mutex before exit() function does.
> 
> How to fix this?

Are you certain there really is a problem?

> ii) Usage of mutex while adding entries in u132_static_list in probe
> function but not in exit function while unregistering.
> This should be easy to fix by holding the mutex in the exit function as well.

Why does the driver need a static list?

> There can be other synchronization problems related to the usage of
> u132_module_lock in this module, I have only spotted these so far.

You should look at other drivers for comparison.  They don't have to 
face this kind of problem.  u132_hcd should be similar to them.

Alan Stern


