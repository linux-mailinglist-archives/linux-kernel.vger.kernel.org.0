Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9356C1042D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfKTSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:06:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfKTSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:06:01 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXUMT-0005AA-OC; Wed, 20 Nov 2019 19:05:53 +0100
Date:   Wed, 20 Nov 2019 19:05:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     mingo@kernel.org, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/4] x86/mm, pat: Convert pat tree to generic interval
 tree
In-Reply-To: <20191021231924.25373-2-dave@stgolabs.net>
Message-ID: <alpine.DEB.2.21.1911201901270.29534@nanos.tec.linutronix.de>
References: <20191021231924.25373-1-dave@stgolabs.net> <20191021231924.25373-2-dave@stgolabs.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Davidlohr Bueso wrote:
>  int rbt_memtype_check_insert(struct memtype *new,
>  			     enum page_cache_mode *ret_type)
>  {
>  	int err = 0;
>  
>  	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
> -						new->type, ret_type);
> -
> -	if (!err) {
> -		if (ret_type)
> -			new->type = *ret_type;
> -
> -		new->subtree_max_end = new->end;
> -		memtype_rb_insert(&memtype_rbroot, new);
> -	}
> +					new->type, ret_type);
> +	if (err)
> +		goto done;

Please return err here. That goto is pointless.

> +
> +	if (ret_type)
> +		new->type = *ret_type;
> +	memtype_interval_insert(new, &memtype_rbroot);
> +done:
>  	return err;
>  }

Other than that.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

