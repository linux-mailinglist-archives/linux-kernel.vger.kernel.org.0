Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84B3162913
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 16:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBRPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 10:10:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60064 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBRPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KdKsxgEfW+4Nd66H7OZcvqV7+g+co1/sXakxfl3LSkQ=; b=Hs3rZMlc04yWB2UJYw8NKHFLtS
        i6fknqa5vLmE5ddFNCrPleN6S3lnFp4W/T/WcTqymMfiEOSSsVAWrP1jKBTLXKN5RHahDhMvBQwE1
        2dhfMhhtpSN+4x5G94HqYuZKEGj3KZcgNcZcgaTE7Vyv+om9rz28zb3W1JdHNL9EwvKNKFnfGe9fr
        6nwiZyNUjPJ2X+E81DOHpQrKMi0MA2HOX+t59ESgXB5ZTz8dCxGRiO0WHkuTl4RE+YB0psoKDUX7R
        +MbX23GdMJR5Hzz/HdxrA57igwEss0d04gMG/fSIpGqp2TPsIiJTGR8Bj5lAykjd3YR4q8weuJXAK
        NNvFaEdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j44VH-0006nl-Ub; Tue, 18 Feb 2020 15:09:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3731E30008D;
        Tue, 18 Feb 2020 16:07:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2217C2B935590; Tue, 18 Feb 2020 16:09:37 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:09:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com, hdanton@sina.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        riel@surriel.com, Morten.Rasmussen@arm.com
Subject: Re: [PATCH] sched/fair: fix statistics for find_idlest_group()
Message-ID: <20200218150937.GD14914@hirez.programming.kicks-ass.net>
References: <20200218144534.4564-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218144534.4564-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:45:34PM +0100, Vincent Guittot wrote:
> sgs->group_weight is not set while gathering statistics in
> update_sg_wakeup_stats(). This means that a group can be classified as
> fully busy with 0 running tasks if utilization is high enough.
> 
> This path is mainly used for fork and exec.
> 
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
