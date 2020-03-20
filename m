Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB14818CD5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 13:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCTMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 08:00:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xjR5yiirukQrF3p6N/cPOU/l/hWPkmvE+dSBfh+HVRA=; b=C+qepNgyPJAq5nt/qF48wsjLjW
        J9eYbdDEJTLBHxfjoWzGIO25LpdPFI8+X7SZFYv7auHhgixIlZMbTBga/75Qil/iLsTJNCdz9Lbeo
        rtoCKT3UYspc1/rV/2DHmyJNMs8IX2OQApGn6bC+1cJ/WpcIC5cWTWKDRbAnpjuc/m1r4n+WFR7rD
        GzDwZ0RNGkPTMfJjoZG+3gMTrtHxV/4QUf2TARRGrUqPFvYgtWb43wjp+UR1U/2RtNxVbMO+5kQmc
        PFhb5Z5UQ4jp/OpRsSsgCTAL4fCtLjW+SLukAnZcJ/TtLy87IfDFlRGLgo+aOKLUavz5rHX9vlrJz
        4dEA0WWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFGK8-0008Gu-B3; Fri, 20 Mar 2020 12:00:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA9523058B4;
        Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7507A2858D58F; Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Message-Id: <20200320115638.737385408@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 12:56:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, will@kernel.org, peterz@infradead.org
Subject: [PATCH 0/4] A bunch of renames
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While going over a lot of code, we ran into a bunch of confusingly named
functions. These 4 patches try and fix some of that.

