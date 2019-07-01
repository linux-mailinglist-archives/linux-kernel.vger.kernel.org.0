Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B94212C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437609AbfFLJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:39:53 -0400
Received: from foss.arm.com ([217.140.110.172]:48742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437412AbfFLJjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC2C3337;
        Wed, 12 Jun 2019 02:39:52 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AAD53F246;
        Wed, 12 Jun 2019 02:39:52 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:39:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: linux-next: Fixes tag needs some work in the scmi tree
Message-ID: <20190612093945.GA5368@e107155-lin>
References: <20190612072946.15403676@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612072946.15403676@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:29:46AM +1000, Stephen Rothwell wrote:
> Hi Sudeep,
>
> In commit
>
>   e322dcbd75e8 ("dt-bindings: arm: fix the document ID for SCMI protocol documentation")
>
> Fixes tag
>
>   Fixes: fe7be8b297b2 ("dt-bindings: arm: add support for ARM System Control
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line (it is ok for
> that to be a long line).
>

Thanks, will fix accordingly.

--
Regards,
Sudeep
