Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17D1CF518
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfJHIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 04:36:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfJHIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tGN1dM+IJqKpkPGm9T9mF3g/quE89wDFOxnhZY0uBaY=; b=TBGsKk7/mO27mtoMvA6ku5HsZ
        H4LkkjXEx9Mj/6uk2U19OyTZklRu5GBjrv4XmXfRopr6eoaBcFeVAFWiIFNDHLrEMTbdsa/zsuYAa
        5yeJbPCTSmHTWgdSgnPAPjjfVKWhoA/zX0WLqWRNNOe/gzJSgzp70a1qEiTkSYiSC+pf5d56uDT/l
        34foWmenNABAEXoANXbzN/Go4+fU9JTJPwWxCO3Q29iLmXL6+g86rzNyUk1kcT4nHOsdgYYHf8IRB
        47Jx11zVkY2nSXw3NXnfX6tzxve1QEY3V7G93GLkgI0+DwSxT8xKGdziUYY2ruUe/ob9jTV1Gh4fK
        7WeA18WTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHkz1-0006Fl-K4; Tue, 08 Oct 2019 08:36:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83A1230034F;
        Tue,  8 Oct 2019 10:35:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAC072022BAB2; Tue,  8 Oct 2019 10:36:37 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:36:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] stop_machine: avoid potential race behaviour
Message-ID: <20191008083637.GI2294@hirez.programming.kicks-ass.net>
References: <20191007104536.27276-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007104536.27276-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:45:36AM +0100, Mark Rutland wrote:
> Both multi_cpu_stop() and set_state() access multi_stop_data::state
> racily using plain accesses. These are subject to compiler
> transformations which could break the intended behaviour of the code,
> and this situation is detected by KCSAN on both arm64 and x86 (splats
> below).

I really don't think there is anything the compiler can do wrong here.

That is, I'm thinking I'd like to get this called out as a false-positive.

That said, the patch looks obviously fine and will help with the
validation effort so no real objection there.
