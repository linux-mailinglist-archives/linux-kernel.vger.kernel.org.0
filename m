Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E8318B977
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCSOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 10:35:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCSOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:35:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07AFE30E;
        Thu, 19 Mar 2020 07:35:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DFFC3F52E;
        Thu, 19 Mar 2020 07:35:13 -0700 (PDT)
Date:   Thu, 19 Mar 2020 14:35:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: dsu: Allow multiple devices share same IRQ.
Message-ID: <20200319143510.GB4876@lakrids.cambridge.arm.com>
References: <1584491176-31358-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319143250.GA4876@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319143250.GA4876@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 02:32:51PM +0000, Mark Rutland wrote:
> On Tue, Mar 17, 2020 at 05:26:15PM -0700, Tuan Phan wrote:
> > Add IRQF_SHARED flag when register IRQ such that multiple dsu
> > devices can share same IRQ.
> > 
> > Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> 
> I don't think that this makes sense; further I think that this
> highlights that the current driver doesn't support such a configuration
> for other reasons.
> 
> A DSU instance can only be accessed from a CPU associated with it, since
> it's accessed via sysregs. The IRQ handler must run on one of those
> CPUs.
> 
> To handle that, the DSU PMU driver will need to gain an understanding of
> which CPUs are associated with the instance. As it stands the driver
> seems to assume that there's a single DSU instance, and that all CPUs
> are affine to that same instance.

Sorry, I misread dsu_pmu_get_online_cpu_any_but(), multiple instances
are handled already.

> So NAK to this patch, given the above.

Regardless, this NAK stands.

Thanks,
Mark.
