Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355FCEB110
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 14:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJaNV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 09:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaNV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:21:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E2120873;
        Thu, 31 Oct 2019 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572528118;
        bh=d5GVMjWHdmBFZQb6CC+/OkfJlqVkbsbDGygJpji33EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1F4El6uIQCICKKWR3TZaZm298EiHiseD2Ube8CF+PE4N7oXJUc2gfXYTSJgb7xqG+
         XtVptZjlKFgl0xmyYacSujyU4ytTEWZjUBY+RbWqDAFVfned0Flk2JBXnutvZ4Nkb5
         xsB2bPLmCy/Now10Gw/PMcpfp60/QxcPdSxX6I9g=
Date:   Thu, 31 Oct 2019 13:21:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Doug Berger <opendmb@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        John Garry <john.garry@huawei.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: apply ARM64_ERRATUM_845719 workaround for
 Brahma-B53 core
Message-ID: <20191031132151.GC27196@willie-the-truck>
References: <20191029191623.17839-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029191623.17839-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:16:19PM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The Broadcom Brahma-B53 core is susceptible to the issue described by
> ARM64_ERRATUM_845719 so this commit enables the workaround to be applied
> when executing on that core.
> 
> Since there are now multiple entries to match, we must convert the
> existing ARM64_ERRATUM_845719 into an erratum list.

Looks fine to me, but I have to ask: are you sure you don't want to select
any of ARM64_ERRATUM_{826319, 827319, 824069, 819472, 843419} ?

Also, please can you update Documentation/arm64/silicon-errata.rst ?

Will
