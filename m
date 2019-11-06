Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E05F1285
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 10:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfKFJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 04:40:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKFJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/YQ9LfHefZM8w/IcM4p+bj0fVJMJxLHGZzxqfEZnLwE=; b=i44IRP3wDyAe84Z1rp5zkOS+4
        /vJhxu4UO8U1F52m8AH0k6cV6GitjIwq0zuzMVt3GH+eGIEJTuFQi9uceN7tK7twwn+lPyRQ4ky6V
        eIHQNc5lyxzRca3fzXKwYzmuX0Iyzo2MC55iA/aUv1Tn6UZScvBSHf3oc+WxrtV1CwxH7nO//4v0r
        xA7/VSFbCMVIXpxqmE9hJzKR6L4aRa+GTwKumN1SIZbE3fC/LL/yvcFKfUeOKGmjx+RYfPQatNAjd
        dKwT0dfdrPM987KmXoIJdl+0qheY4CXPACSazbMHnYOB/eqAEuyK8Z3rZwf3vsoB+A7JSyuCgqY1B
        MgRcLmYrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSHnm-0004AE-KN; Wed, 06 Nov 2019 09:40:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 280B4300692;
        Wed,  6 Nov 2019 10:39:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2881C29ABB5F9; Wed,  6 Nov 2019 10:40:32 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:40:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event
 multiplexing
Message-ID: <20191106094032.GV4131@hirez.programming.kicks-ass.net>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 01:01:40AM +0000, Ganapatrao Prabhakerrao Kulkarni wrote:
> When PMUs are registered, perf core enables event multiplexing
> support by default. There is no provision for PMUs to disable
> event multiplexing, if PMUs want to disable due to unavoidable
> circumstances like hardware errata etc.
> 
> Adding PMU capability flag PERF_PMU_CAP_NO_MUX_EVENTS and support
> to allow PMUs to explicitly disable event multiplexing.

This doesn't make sense, multiplexing relies on nothing that normal
event scheduling doesn't also rely on.

Either you can schedule different sets of events, or you cannot.

NAK.
