Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D23965F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfHTQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfHTQLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:11:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E0F2087E;
        Tue, 20 Aug 2019 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566317504;
        bh=f2XP5Rom/M/LRlxMiW6d/h0nQTI1cIy/myOvGg1QlW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfYzVVKeU57Kj0re5ESECR2Dr+GY9nCaFU4yIYJePzHxKVZwsT7ZUEduC/ojmItKa
         2I6yPHKvw64qmSuMPA9kLdXetQOaBeYWxln2B5h/qPHL8J0VxiWjrEUbox4AJ1YPQz
         ONfCTHlOFNhMXZJA/6/vJgNbZbSbeXDmLAIhLqVM=
Date:   Tue, 20 Aug 2019 17:11:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Raphael Gault <raphael.gault@arm.com>, raph.gault+kdev@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: perf_event: Add missing header needed for
 smp_processor_id()
Message-ID: <20190820161139.c64thty545i6xa2c@willie-the-truck>
References: <20190820155745.20593-1-raphael.gault@arm.com>
 <20190820160629.GD43412@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820160629.GD43412@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:06:29PM +0100, Mark Rutland wrote:
> On Tue, Aug 20, 2019 at 04:57:45PM +0100, Raphael Gault wrote:
> 
> It would be worth having a body for the commit message like:
> 
> | in perf_event.c we use smp_processor_id(), but we haven't included 
> | <linux/smp.h> where it is defined, and rely on this being pulled in 
> | via a transitive include. Let's make this more robust by including
> | <linux.smp.h> explciitly.
> 
> ... and with that, my Acked-by stands.

Queued for 5.4. with typo fixed above.

Will
