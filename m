Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53F139217
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgAMNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:22:22 -0500
Received: from foss.arm.com ([217.140.110.172]:39426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbgAMNWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:22:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979E713D5;
        Mon, 13 Jan 2020 05:22:17 -0800 (PST)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D1E3F68E;
        Mon, 13 Jan 2020 05:22:16 -0800 (PST)
Date:   Mon, 13 Jan 2020 13:22:14 +0000
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
Message-ID: <20200113132214.GD10914@e105550-lin.cambridge.arm.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <20200109105228.GB10914@e105550-lin.cambridge.arm.com>
 <f973e77b-9c0a-6506-da97-f7a0ea1829fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f973e77b-9c0a-6506-da97-f7a0ea1829fd@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 01:22:02PM +0000, Valentin Schneider wrote:
> On 09/01/2020 10:52, Morten Rasmussen wrote:
> >> AFAIA what matters here is memory controllers, less so LLCs. Cores within
> >> a single die could have private LLCs and separate memory controllers, or
> >> shared LLC and separate memory controllers.
> > 
> > Don't confuse cache boundaries, packages and nodes :-)
> > 
> > core_siblings are cpus in the same package and doesn't say anything
> > about cache boundaries. It is not given that there is sched_domain that
> > matches the core_sibling span.
> > 
> > The MC sched_domain is supposed to match the LLC span which might
> > different for core_siblings. So the about example should be valid for a
> > NUMA-in-package system with one package containing two nodes.
> > 
> 
> Right, the point I was trying to make is that node boundaries can be pretty
> much anything, so nodes can span over LLCs, or LLCs can span over nodes,
> which is why we need checks such as the one in arch_topology() that lets us
> build up a usable domain hierarchy (which cares about LLCs, at least at some
> level).

Indeed. The topology masks can't always be used as is to define the
sched_domain hierarchy.
