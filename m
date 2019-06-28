Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A05A19B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1Q7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 12:59:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfF1Q7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:59:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2390A28;
        Fri, 28 Jun 2019 09:59:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6DB73F706;
        Fri, 28 Jun 2019 09:59:17 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:59:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Perf framework : Cluster based counter support
Message-ID: <20190628165915.GB5143@lakrids.cambridge.arm.com>
References: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:23:10PM +0530, Mukesh Ojha wrote:
> Hi All,

Hi Mukesh,

> Is it looks considerable to add cluster based event support to add in
> current perf event framework and later in userspace perf to support
> such events ?

Could you elaborate on what you mean by "cluster based event"?

I assume you mean something like events for a cluster-affine shared
resource like some level of cache?

If so, there's a standard pattern for supporting such system/uncore
PMUs, see drivers/perf/qcom_l2_pmu.c and friends for examples.

Thanks,
Mark.
