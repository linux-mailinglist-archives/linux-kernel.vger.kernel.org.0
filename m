Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1F9508B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfHSWL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 18:11:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfHSWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:11:57 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzpsV-0005OC-U7; Tue, 20 Aug 2019 00:11:52 +0200
Date:   Tue, 20 Aug 2019 00:11:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:WIP.timers/core 49/68] include/linux/sched/types.h:16:2:
 error: unknown type name 'u64'
In-Reply-To: <alpine.DEB.2.21.1908192323180.4008@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908200008320.4008@nanos.tec.linutronix.de>
References: <201908200518.CGnq3sBO%lkp@intel.com> <alpine.DEB.2.21.1908192323180.4008@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Thomas Gleixner wrote:
> On Tue, 20 Aug 2019, kbuild test robot wrote:
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from <command-line>:0:0:
> 
> Huch? What kind of weird include chain is that?
> 
> > >> include/linux/sched/types.h:16:2: error: unknown type name 'u64'
> >      u64    utime;
> >      ^~~
> >    include/linux/sched/types.h:17:2: error: unknown type name 'u64'
> >      u64    stime;
> >      ^~~
> 
> All (header) files which include that new header have u64 defined.

And building sparc64 allmodconfig does not expose this odd failure
here. The build fails for a reason related to this series, but that's not
caused by that sched/types.h header.

Thanks,

	tglx
