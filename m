Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4474E6BBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfGQLnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 07:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfGQLny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:43:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A238C205ED;
        Wed, 17 Jul 2019 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563363834;
        bh=Ujtx3Yha188ZjWZa6A3epObXGpp/EmAPbG0aCvh0hUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sF4zAqvmS1GOoCXb71KZmXkfYymheU+qLMsE9UIanxBBCZOX3qAu1IIxAwyaNTPrE
         Awwwh5k1BVH9siPw9Vnf45AniBX4Sc25DuCQLCEKcTEcMxsHkfM58nep+vvM0LdEaw
         qNmgpVcNV2rbWgTXOHq3ozGAiVrH0/vigfSGLxwI=
Date:   Wed, 17 Jul 2019 12:43:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, maz@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <20190717114349.vegt6yyu577kynd4@willie-the-truck>
References: <1563359535-2762-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563359535-2762-1-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:32:15AM +0100, Julien Thierry wrote:
> My @arm.com address will stop working in a couple of weeks. Update
> MAINTAINERS and .mailmap files with an address I'll have access to.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

I'll pick this up at -rc1.

Will
