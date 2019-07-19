Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAA6E44A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfGSK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 06:29:28 -0400
Received: from foss.arm.com ([217.140.110.172]:41606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSK32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:29:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5850337;
        Fri, 19 Jul 2019 03:29:27 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 080BC3F59C;
        Fri, 19 Jul 2019 03:29:26 -0700 (PDT)
Date:   Fri, 19 Jul 2019 11:29:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: Re: [PATCH 05/11] firmware: arm_scmi: Add receive buffer support for
 notifications
Message-ID: <20190719102924.GB18022@e107155-lin>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
 <20190708154730.16643-6-sudeep.holla@arm.com>
 <CA+-6iNz26xUyrzVSbWA+jwEfj3BC8k8KNCg2SreDK7mfWsbAWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNz26xUyrzVSbWA+jwEfj3BC8k8KNCg2SreDK7mfWsbAWg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:14:55PM -0400, Jim Quinlan wrote:
> Hi Sudeep,
>
> I'm not sure why you are adding code for notifications when this commit-set
> does not support notifications.  Why not save this commit for when you add
> notifications?
>

Right, I missed this patch and sent. Yes we just need Rx channels and not
Rx buffers to implement asynchronous commands. I will drop it from this set.

--
Regards,
Sudeep
