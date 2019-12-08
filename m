Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99F1163D7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 22:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLHVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 16:18:01 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:41458 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLHVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:18:00 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 054C3200ABD;
        Sun,  8 Dec 2019 21:09:39 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id EA06A20AAF; Sun,  8 Dec 2019 21:41:02 +0100 (CET)
Date:   Sun, 8 Dec 2019 21:41:02 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH 01/12] PCMCIA: use dev_err/dev_info instead of printk
Message-ID: <20191208204102.GA239870@light.dominikbrodowski.net>
References: <20191208160947.20694-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208160947.20694-2-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2019 at 05:09:36PM +0100, Simon Geis wrote:
> Fix the checkpatch warning:
> 	WARNING: Prefer netdev_err(netdev, ... then dev_err(dev, ...
> 		then pr_err(...  to printk(KERN_ERR ...
> and
> 	WARNING: printk() should include KERN_<LEVEL> facility level
> 		by using dev_err()/dev_info() according to the message.

Thanks for the patch! The actual diff looks fine, but the commit message
still needs some refinement. Please do not repeat the checkpatch warnings
(removing them from existing files is not a goal in itself!), but
describe the goal of the patch ("Improve the log output by using the
device-aware dev_err()/dev_info() functions. While at it, update one
remaining printk(KERN_ERR ...) call to the preferred pr_err() call.")

> Split the assignment of variable 'sock' in in order to get access to
> struct_info with the 'container_of' function call.

As that merely describes what the code does, it is not needed in the
commit message.

> pr_err is used where no struct pci_dev is available.

If you describe the goal of the patch above, that becomes clear by itself.
So you may want to remove this line as well.

Thanks,
	Dominik
