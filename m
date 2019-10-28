Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D754E6EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfJ1JVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 05:21:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbfJ1JVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qMebK0as85jYk8Dl4fltAZ5hOWFb78atrYLGXDLaa1I=; b=y2zx2djc7WstK/jNPFHHSW1Ev
        20gNcGUET1RWMB8lcML5MZdAi2a9UNNQn9YjqkfOriZph3nGb2QXJVj3I0ZVYg/JNmX5gG9VOnNSp
        KwoJLeBdAYqjYHx2ULLqfC7HtstNQcN4nb+LGmBXUdfvK7DZN1Ng9Vf6I3AfGY9hK0ubEn+wi5RF+
        Wy7melNMie8tLtfwuGjlvS5KvuMb0nSI9/RaycuIrCXFX2/bJWc3kPA9en5xwxqjmv8OJYvgH3Ibp
        hEUSny2Ctg03U65Lethayx8S35v2vBIJ4FGQtLhTmtTNX+sXf1IZvM7RgACaYGX/KWSipGGbsf7Fs
        UEo1HpMRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP1Ci-0003Le-Rm; Mon, 28 Oct 2019 09:20:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CCEB306098;
        Mon, 28 Oct 2019 10:19:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A6BB20098AB8; Mon, 28 Oct 2019 10:20:45 +0100 (CET)
Date:   Mon, 28 Oct 2019 10:20:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, walken@google.com, dbueso@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/2] lib/rbtree: set successor's parent unconditionally
Message-ID: <20191028092045.GC4114@hirez.programming.kicks-ass.net>
References: <20191028021442.5450-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028021442.5450-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:14:41AM +0800, Wei Yang wrote:
> Both in Case 2 and 3, we exchange n and s. This mean no matter whether
> child2 is NULL or not, successor's parent should be assigned to node's.
> 
> This patch takes this step out to make it explicit and reduce the
> ambiguity.
> 
> Besides, this step reduces some symbol size like rb_erase().
> 
>    KERN_CONFIG       upstream       patched
>    OPT_FOR_PERF      877            870
>    OPT_FOR_SIZE      635            621
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
