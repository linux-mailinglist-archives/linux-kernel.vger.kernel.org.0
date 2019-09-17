Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68132B5827
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 00:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfIQWl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 18:41:59 -0400
Received: from pc-246-229-214-201.cm.vtr.net ([201.214.229.246]:46348 "EHLO
        mail.test.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbfIQWl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:41:58 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 18:41:57 EDT
Received: by mail.test.com (Postfix, from userid 1001)
        id 044E81387; Tue, 17 Sep 2019 17:35:24 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.test.com (Postfix) with ESMTP id 006B1F38;
        Tue, 17 Sep 2019 17:35:24 -0500 (CDT)
Date:   Tue, 17 Sep 2019 17:35:24 -0500 (CDT)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@lameter.cl
To:     David Rientjes <rientjes@google.com>
cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix -Wunused-function compiler warnings
In-Reply-To: <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909171734490.9525@lameter.cl>
References: <1568752232-5094-1-git-send-email-cai@lca.pw> <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, David Rientjes wrote:

> On Tue, 17 Sep 2019, Qian Cai wrote:
>
> > tid_to_cpu() and tid_to_event() are only used in note_cmpxchg_failure()
> > when SLUB_DEBUG_CMPXCHG=y, so when SLUB_DEBUG_CMPXCHG=n by default,
> > Clang will complain that those unused functions.
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
>
> Acked-by: David Rientjes <rientjes@google.com>

Ditto

