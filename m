Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD96F14EF63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAaPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 10:18:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAaPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iX0bk0w4E9KN/g4ow6NXYdGUWkHlruz/UqWLFwcA1Zw=; b=DBI3blWs8Nn1cg1BmHyni/eiK
        Me7Mu8CfbuUh4Sqhnx1RTckfm2DKFtdy4NSm3d4u5zQi+acS96L87W0acgUSHohbXUCpsZNGUlN+C
        VyDxJ1LNLVUyYr9kdpKivQpRCX/RHQ/Puh1ZUHVpg+IRtUdTKjGBa5wjXcR2E0Xqzbogh8qtmkeD7
        O2H1bzKbLU6h/5elzUjgTVSgL09Z35D3ECA6+OCZuOgv1afo9EUxVMn7geoNSvqpRv/fB2Ft+z7ny
        TBlY3N4zJeqeIglweIcEv0bCOYH4pmoQdSWiwetXv7tnJyv8kLI97iq2fTFSJlvfCkb2Id0tCSceW
        bm/9OmVOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixY3V-00045S-7s; Fri, 31 Jan 2020 15:18:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E59D93011DD;
        Fri, 31 Jan 2020 16:16:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B0253203A5C79; Fri, 31 Jan 2020 16:17:58 +0100 (CET)
Message-Id: <20200131150703.194229898@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 16:07:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH -v2 0/7] locking: Percpu-rwsem rewrite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the long awaited report of the percpu-rwsem rework (sorry Juri).

IIRC (I really have trouble keeping up momentum on this series) I've addressed
all previous comments by Oleg and Davidlohr and Waiman and hope we can stick
this in tip/locking/core for inclusion in the next merge.

It has been cooked (thoroughly) in PREEMPT_RT, and not found wanting.

Any objections to me stuffing it in so we can all forget about it properly?


