Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051AB14D8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgA3KVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 05:21:11 -0500
Received: from foss.arm.com ([217.140.110.172]:50608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3KVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:21:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FF5131B;
        Thu, 30 Jan 2020 02:21:10 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4927A3F67D;
        Thu, 30 Jan 2020 02:21:09 -0800 (PST)
Date:   Thu, 30 Jan 2020 10:21:04 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V5] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200130102104.GA48466@bogus>
References: <20200130094103.mrz7ween6ukfa4fk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130094103.mrz7ween6ukfa4fk@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:11:03PM +0530, Viresh Kumar wrote:
> On 30-01-20, 10:25, Etienne Carriere wrote:
> > I've made a first port (draft) for adding new transport channels, next
> > to existing mailbox channel, on top of your change.
> > You can find it here: https://github.com/etienne-lms/linux/pull/1.
> >
> > I don't have specific comments on your change but the one below.
> > I think SMT header should move out of mailbox.c, but that may be a bit
> > out of the scope of your change.
>
> If it is guaranteed that someone will end up using those routines
> apart from mailbox.c, then surely it can be done.
>

I thought about it and decided to take up when we add new transport
instead of doing now and having to redo again when we add new transport
mostly SMC/HVC.

> > I would prefer an optional mak_txdone callback:
> >
> >     if (info->desc->ops->mark_txdone)
> >        info->desc->ops->mark_txdone(cinfo, ret);
>
> So you are sure that mark_txdone won't be required in your case? I can
> make it optional then.
>

Yes this can be done. Might even help virtio and keeps Peter happy :)

--
Regards,
Sudeep
