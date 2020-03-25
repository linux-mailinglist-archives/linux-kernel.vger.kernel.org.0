Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA3192FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgCYRta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 13:49:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0eVq4oJ1vlTkxZBuPQihBCIZvhQk/iP6m567vFaX8KA=; b=cPYN1CHouqwpjHeGqGnQtzJfTr
        l2X1bfE8eWQIhLEA3HVfpKcukkH3yi5fNMap7L0qj2aNk3YiMP1C+h73yX+yKzxrN5NXIJAQ1+6J2
        NINptjPEevMLMU+bik9Shf+F+wcW4toHqZ5HjVYNBC5rIKnH6gnReirgq6sSoICnCMKVz5hvNB1WT
        TxaJU0kJ5UevGLn04qkL6cahPFkY/Tybc8xrqt7wdVH+YB1/1zJV2sjon6Onl3IhLT6ytL/WHA/BS
        wRWVqpdyryahtKuFb6D6DbeHsEdPpwRYaoDpQ/LqAiG9qQlXimAxVcQJfjuoQMZx6XNECXsgNX1ZL
        k3GjvlUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA9Z-0000Ae-E5; Wed, 25 Mar 2020 17:49:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D3813023D1;
        Wed, 25 Mar 2020 18:49:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 394DE20206085; Wed, 25 Mar 2020 18:49:19 +0100 (CET)
Date:   Wed, 25 Mar 2020 18:49:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 00/17] Add static_call()
Message-ID: <20200325174919.GJ20713@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324135603.483964896@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


To clafiry, quilt ate the From: Josh on patches 5,6,7 and 9.
