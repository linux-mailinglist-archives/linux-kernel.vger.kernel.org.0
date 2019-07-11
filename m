Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D435B65627
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfGKLwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 07:52:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54792 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfGKLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+zmPH9U5IychW+kVlhsevpCm2yKlQwXOJhtXRQKjYmg=; b=zNz5ShyYwVrNEZmJN1fXT1Q+5
        BbteDiufYtY/TJBO72CmIMZ/34jGb6Rdwsaeppb6YotFG68+bcYKo/3ZEpG8RDUnw/br1++sb46C/
        Q0wTzkDJgmrw/fpjwcHmE7nw1DNuvXTbrnK9XkDK/McRg20xvChnCy9JTQ0Oad/kH3GnhZInaqaM0
        fNW0FfyM8nuiUqatO6C50xAzPpRLnXtuNM9Qc3MmaD0ynFqHpb1mRV/81EGZNabn5dU6FByyURwRk
        AAbGvYJrEmw3mZDzXgqX21l0j4o3l+9d60uH05lup4837A9mvxD/6Gssaah8AKwOtjGXJ3qFHP8DB
        cBcIKPKjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlXc3-0003MA-RS; Thu, 11 Jul 2019 11:51:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DFB1220213041; Thu, 11 Jul 2019 13:51:44 +0200 (CEST)
Message-Id: <20190711114054.406765395@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Jul 2019 13:40:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v3 0/6] Tracing vs CR2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the latest (and hopefully final) set of tracing vs CR2 patches.

They are basically the same as v2, with only minor edits and tags collected
from the last review.

Please consider.

