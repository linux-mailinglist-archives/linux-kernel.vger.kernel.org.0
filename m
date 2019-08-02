Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC57FB2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfHBNiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 09:38:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17476 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHBNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:38:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d443cea0000>; Fri, 02 Aug 2019 06:38:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 02 Aug 2019 06:38:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 02 Aug 2019 06:38:49 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 2 Aug 2019 13:38:49 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id A848640DF8; Fri,  2 Aug 2019 16:38:46 +0300 (EEST)
Date:   Fri, 2 Aug 2019 16:38:46 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
Message-ID: <20190802133846.GC3883@pdeschrijver-desktop.Nvidia.com>
References: <20190730174020.15878-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190730174020.15878-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564753130; bh=NYPEReOcRkEt8FjbS9Ttl4NUHHl3iyUby0ueHEMmSyQ=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=KtMVOER5BAZ79dnaHAglxnwjYTORHllqJFYpHOTov9xotK+yRUsxg7dCX2IUMAWHI
         p+7Pecyd5NJfdvWVKtlMgr/5yUCy3aWIyB4Tek/9NB2z69i8Mp1oMy1hQMe2fKocqi
         ahjM2fvTQvUWAOYNw8vrnXHui6kvoc5FJsonj60RVip916HYohf0OctXezra/VrRY4
         wdhYfjoYIYD1wnYb+0iMLwoXmoDnX+RAvNptqOyjFHTZYVd4wshwfDlQWfdYlJf60f
         bWlZjRlXxQI3eFjOgy8BX/Vskl3vW9wdYQbAPIeELYEGPwmsdW9Wq3SSeiIsnJ6/4o
         ZZmQN/PDUhCrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:40:19PM +0300, Dmitry Osipenko wrote:
> The PCLK clock is running off SCLK, which is a critical clock that is
> very unlikely to randomly change its rate. It is possible to get a
> lockup if kernel decides to enter LP2 cpuidle from a clk-notifier, which
> happens occasionally in a case of Tegra30 EMC driver that waits for the
> clk-change event in the clk-notify handler, because CCF's 'prepare' mutex
> in kept locked and thus clk_get_rate() wants to sleep with interrupts
> being disabled.
> 

I don't think this is the right solution. Eventually we will want to
scale sclk and pclk because the clock tree power of those is not
insignificant. Maybe register a notifier which updates the PMC timer
values when pclk changes?

Peter.
