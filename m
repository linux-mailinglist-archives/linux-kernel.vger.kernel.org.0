Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817C4187DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 06:09:02 -0400
Received: from foss.arm.com ([217.140.110.172]:34482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgCQKJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:09:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA591FB;
        Tue, 17 Mar 2020 03:09:01 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97DEA3F52E;
        Tue, 17 Mar 2020 03:09:00 -0700 (PDT)
Date:   Tue, 17 Mar 2020 10:08:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/kernel: Simplify __cpu_up() by bailing out early
Message-ID: <20200317100857.GM3005@mbp>
References: <20200302020340.119588-1-gshan@redhat.com>
 <20200302122135.GB56497@lakrids.cambridge.arm.com>
 <20200317100608.GA8831@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317100608.GA8831@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:06:09AM +0000, Mark Rutland wrote:
> On Mon, Mar 02, 2020 at 12:21:35PM +0000, Mark Rutland wrote:
> > On Mon, Mar 02, 2020 at 01:03:40PM +1100, Gavin Shan wrote:
> > > The function __cpu_up() is invoked to bring up the target CPU through
> > > the backend, PSCI for example. The nested if statements won't be needed
> > > if we bail out early on the following two conditions where the status
> > > won't be checked. The code looks simplified in that case.
> > > 
> > >    * Error returned from the backend (e.g. PSCI)
> > >    * The target CPU has been marked as onlined
> > > 
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > 
> > FWIW, this looks like a nice cleanup to me:
> > 
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> Catalin, are you happy to pick this up?

Yes, it was on my list to pick up already, just haven't got around to it
yet.

-- 
Catalin
