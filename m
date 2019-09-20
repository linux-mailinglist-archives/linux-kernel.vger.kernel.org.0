Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0BB8AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 08:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408241AbfITGF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 02:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408232AbfITGF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:05:26 -0400
Received: from localhost (unknown [145.15.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A179D20882;
        Fri, 20 Sep 2019 06:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568959525;
        bh=X7t/VZSp6LudvbPeX6l74ReA7A/d8L11/pSeOs2po1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oi+BknRY202JsDjyAQXI0SXV4CWWmY1cnDooz/gwqyHNCYimNCZANRM+89t7UTpcp
         uKwuE6Egkbqu/yPTj3mQa63LQCMSCXzzb1v9//VKXBL1UvoMUZ/C9VQIronA6ODsWq
         QKaIUW/AUYezFpHJXtfpDb5IWkfEKhW3NPnbuwJg=
Date:   Fri, 20 Sep 2019 08:04:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nixiaoming <nixiaoming@huawei.com>
Cc:     "penberg@cs.helsinki.fi" <penberg@cs.helsinki.fi>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "textshell@uchuujin.de" <textshell@uchuujin.de>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yangyingliang <yangyingliang@huawei.com>,
        yuehaibing <yuehaibing@huawei.com>,
        Zengweilin <zengweilin@huawei.com>
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
Message-ID: <20190920060454.GB473496@kroah.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
 <20190919092933.GA2684163@kroah.com>
 <E490CD805F7529488761C40FD9D26EF12AE5F4FA@dggemm507-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12AE5F4FA@dggemm507-mbx.china.huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:29:49AM +0000, Nixiaoming wrote:
> On 2019/9/19 17:30, Greg KH wrote:
> > On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
> >> Using kzalloc() to allocate memory in function con_init(), but not
> >> checking the return value, there is a risk of null pointer references
> >> oops.
> >>
> >> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> >
> > We keep having this be "reported" 
> >
> >> ---
> >>  drivers/tty/vt/vt.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> >> index 34aa39d..db83e52 100644
> >> --- a/drivers/tty/vt/vt.c
> >> +++ b/drivers/tty/vt/vt.c
> >> @@ -3357,15 +3357,33 @@ static int __init con_init(void)
> >>  
> >>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> >> +		if (unlikely(!vc)) {
> >> +			pr_warn("%s:failed to allocate memory for the %u vc\n",
> >> +					__func__, currcons);
> >> +			break;
> >> +		}
> >
> > At init, this really can not happen.  Have you see it ever happen?
> 
> I did not actually observe the null pointer here.
> I am confused when I see the code allocated here without check the return value.
> Small memory allocation failures are difficult to occur during system initialization
> But is it not safe enough if the code is not judged?
> Also if the memory allocation failure is not allowed here, is it better to add the __GFP_NOFAIL flags?

See my response to Nicolas, but yes, that would be a good way to handle
this.

thanks,

greg k-h
