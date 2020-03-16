Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA4187157
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 18:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgCPRmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 13:42:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731136AbgCPRmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:42:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 318A51FB;
        Mon, 16 Mar 2020 10:42:12 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768B73F67D;
        Mon, 16 Mar 2020 10:42:11 -0700 (PDT)
Date:   Mon, 16 Mar 2020 17:42:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig: allow to change FORCE_MAX_ZONEORDER via
 custom config
Message-ID: <20200316174200.GH3005@mbp>
References: <20200312235037.26072-1-vadym.kochan@plvision.eu>
 <20200313123741.GC3857972@arrakis.emea.arm.com>
 <20200313124558.GA3281@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313124558.GA3281@plvision.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:45:58PM +0200, Vadym Kochan wrote:
> On Fri, Mar 13, 2020 at 12:37:41PM +0000, Catalin Marinas wrote:
> > On Fri, Mar 13, 2020 at 01:50:37AM +0200, Vadym Kochan wrote:
> > > Add missing config option name which allows to change it via custom
> > > config.
> > 
> > Why? What is your use-case?
> 
> I need to allocate buffers bigger than default ZONEORDER, so I tried to
> increase it but it did not work because the config entry has no name.

I try not to make this selectable as we want a single kernel build to
work on all supported hardware. The current values are chosen to allow
huge pages. If you need bigger contiguous allocations, maybe something
like CMA would help.

-- 
Catalin
