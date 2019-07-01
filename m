Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61511F72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfEBPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 11:46:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52424 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfEBPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:46:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hMDv2-0001VL-TM; Thu, 02 May 2019 15:46:44 +0000
Date:   Thu, 2 May 2019 16:46:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Alloc refcount increments to fail
Message-ID: <20190502154644.GV23075@ZenIV.linux.org.uk>
References: <20190502152621.GB18948@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502152621.GB18948@bombadil.infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 08:26:21AM -0700, Matthew Wilcox wrote:

> +/**
> + * refcount_try_inc - Increment a refcount if it's below INT_MAX
> + * @r: the refcount to increment
> + *
> + * Avoid the counter saturating by declining to increment the counter
> + * if it is more than halfway to saturation.
> + */
> +static inline __must_check bool refcount_try_inc(refcount_t *r)
> +{
> +	if (refcount_read(r) < 0)
> +		return false;
> +	refcount_inc(r);
> +	return true;
> +}

So two of those in parallel with have zero protection, won't they?
