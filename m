Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C34188BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCQRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:12:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45222 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgCQRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zNp+SgjRV3fN568WTzo4+3msb5pQvU65QeQGKKSG/50=; b=wA5+rCJaMpnhlVfOUpKEg5Fsma
        yKnel0Jqig81hD7MqpbUYonY9FuICjqG5NlsdZIuP/Xwap+nSAycKV94LYtOIwB916Wd3SQxhh18P
        X2/SD1NcfrDjg4FT1GUNYtv5UTCOlZPzeC62SnjqEtOzrDcR9w78aj8SimrtXuSPPUyyH3Lo05BNf
        83FLlVXMWR4Ir43KfK9EsOpkHHVH4Oq+x4yoK4RVMLaw2MBwziUBySN16dTgwc7GcDp/zFmvPGkZC
        vEOUsGOQlfPTO8Lam72064hDEnZWnbuGcD8cG4THS3P4kAF+kFeEtCxIAwK2DriwyyGL2NwNijg8d
        lv9jvRVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl1-0003jM-4L; Tue, 17 Mar 2020 17:11:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D054930110E;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B67D520B16494; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170234.897520633@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 00/19] objtool: vmlinux.o and noinstr validation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Moar patches. This implements the proposed objtool validation for the

  noinstr -- function attribute
  instr_{begin,end}() -- annotation

Who's purpose is to annotate such code that has constraints on instrumentation
-- such as early exception code. Specifically it makes it very hard to
accidentally add code to such regions.

I've left the whole noinstr naming in place, we'll bike-shed on that later.

This should address all feedback from RFC/v1.


