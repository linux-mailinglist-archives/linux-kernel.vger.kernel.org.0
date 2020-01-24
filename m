Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFB148CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbgAXR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 12:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbgAXR2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:28:08 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D6A2081E;
        Fri, 24 Jan 2020 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579886887;
        bh=xKeYSTzuiPLpfoVHzYLcCkTA5xYucgBlImpWHbcWV68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRe2habaFvk9T+b2yK7elYh+xguEe1nojGQ77ceriPknPrR2alzAVIxo6UFvRXJj5
         AasbxKpQdE+Eu0RhYNa7kSIeP1dWDdspxGl2v8TW+7sSbvPmH/NbK8/N7pkyu/lzhN
         hXL+RPzQUA6+/vxRHTFJSOG8TF70g9NzgXkaVcN4=
Date:   Sat, 25 Jan 2020 02:28:03 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3] drivers: nvme: target: core: Pass lockdep expression
 to RCU lists
Message-ID: <20200124172803.GA18688@redsun51.ssa.fujisawa.hgst.com>
References: <20200111073815.7659-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111073815.7659-1-frextrite@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 01:08:16PM +0530, Amol Grover wrote:
> ctrl->subsys->namespaces and subsys->namespaces are traversed with
> list_for_each_entry_rcu outside an RCU read-side critical section
> but under the protection of ctrl->subsys->lock and subsys->lock
> respectively.
> 
> Hence, add the corresponding lockdep expression to the list traversal
> primitive to silence false-positive lockdep warnings, and
> harden RCU lists.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Thanks, added for-5.6.
