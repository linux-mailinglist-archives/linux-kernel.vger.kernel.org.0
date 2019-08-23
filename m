Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787769AE38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392833AbfHWLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 07:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbfHWLhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:37:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F066D20673;
        Fri, 23 Aug 2019 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566560240;
        bh=vTu4N+FWywT7DusqHwzG38gOKUROnQ/PN6+3q9xkgX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ev0hZVFbPDhQM8fUZYmyg+dSIGhpks6fapR6ZQAhS71StNX3QDt4qKN/IVK3VaQwP
         Lp/jcy99LXDRvunR5miwqPGxSNxH2XIlBRSPaD7YaJ3T+jyfNqJGqX6wMCD2X/8m+d
         6AbvLaC1cxZSjBgIeD47vslRuZF7MgXt6SguW8pM=
Date:   Fri, 23 Aug 2019 12:37:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
Message-ID: <20190823113715.n3lc73vtc4ea2ln4@willie-the-truck>
References: <1566509603.5576.10.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566509603.5576.10.camel@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 05:33:23PM -0400, Qian Cai wrote:
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> 
> Booting an arm64 ThunderX2 server with page_alloc.shuffle=1 [1] +
> CONFIG_PROVE_LOCKING=y results in hanging.

Hmm, but the config you link to above has:

# CONFIG_PROVE_LOCKING is not set

so I'm confused. Also, which tree is this?

Will
