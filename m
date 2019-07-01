Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9958F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 03:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF1BTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 21:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfF1BS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:18:59 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D777208CB;
        Fri, 28 Jun 2019 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561684738;
        bh=VuRBdbHTmTYQIc2cT3UM6zcEtz1KIv/xAzv14ySlnZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwSvAWcDiuS4sVMsbBqonRBulKOC8yGUFMQBy/bcsZFKnkNdsWdWyqLbuuT6ygCgZ
         TA6Gmx3zByO237MJF9RJ6t2wanIINvh7wNvsvKix+IW68TzbwYTRdI0/xpEdHo8EIm
         q4wEgiBLdUnGDEzQpJ1q/XxDLbOE+oRffJ6w9eXY=
Date:   Fri, 28 Jun 2019 03:18:55 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND v3] sched/isolation: Prefer housekeeping cpu in
 local node
Message-ID: <20190628011854.GB19488@lerouge>
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
 <1561682593-12071-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561682593-12071-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 08:43:13AM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> In real product setup, there will be houseeking cpus in each nodes, it 
> is prefer to do housekeeping from local node, fallback to global online 
> cpumask if failed to find houseeking cpu from local node.
> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
