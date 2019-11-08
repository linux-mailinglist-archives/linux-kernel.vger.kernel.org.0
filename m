Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43955F4D08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfKHNVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 08:21:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfKHNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tabpc2Pbf+88UZiqIixPeHV+s5ZHqeZW0dPD0BZm4uc=; b=KGZtXhI8SKLiEG51W9F/02Z8d
        vN3z1ovQSQJ6hb0IakIewjBK1DB+pwTpHpcabwGxGm6NoAyYnBeVQW4aykL424bxr4MH1ELDmVgn8
        V0kxLsnCf3exoXAiNkP2TH32twqDTJNLG28YDRwRNB7hRD8FRzCPDX9hxuZ9Uaq7Nfw+agQINp53R
        YiYkhqGCEQgzQTRAvcChLo6o0NCQgYF+WXBS5sm/VtoGIsngsFc9NvsNMFeXCJlzpVl2266hv0YD9
        QQ4yLEYm2o+WE67uB0J/MfOh0jeB2JBt1RjlD+tyaW7678XigQgwjVH1K+5bcqTj9+BOFi1FT/Dg/
        uMsksPcQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4CZ-0003ZR-Ai; Fri, 08 Nov 2019 13:21:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D69C306BB6;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3C5CF2027BF46; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131553.027892369@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:15:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 0/7] scheduler patches
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here's the critical scheduler fix (#1) and the rest of the patches that
resulted from staring at the code.

