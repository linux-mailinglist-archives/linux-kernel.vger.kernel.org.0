Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FA419A221
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 00:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgCaWz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 18:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgCaWz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:55:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA78206DB;
        Tue, 31 Mar 2020 22:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585695355;
        bh=Hgz8pxepgCf9r4NaWuQuFrYbzsS9dEwa9nTPm+PnFJ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mphGjb/gwWL9k4bNSKEo1yguKtZKHSNoMaZ9Ipu6Y9VuB+6N84nNjTrqkqxsULwVL
         OE5vpZ6VQI6XiuBUpl8e4R5IV5DkyUdRFM5JXswMNoIllXKK4Jm8KXkC67adRIWagy
         QzaTnkxonk+XexJDqazhdfu3LEn3khJgVA8Pzz4Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05B7A352279F; Tue, 31 Mar 2020 15:55:55 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:55:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kcsan: Move kcsan_{disable,enable}_current() to
 kcsan-checks.h
Message-ID: <20200331225554.GA28283@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200331193233.15180-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331193233.15180-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:32:32PM +0200, Marco Elver wrote:
> Both affect access checks, and should therefore be in kcsan-checks.h.
> This is in preparation to use these in compiler.h.
> 
> Signed-off-by: Marco Elver <elver@google.com>

The two of these do indeed make data_race() act more like one would
expect, thank you!  I have queued them for further testing and review.

							Thanx, Paul

> ---
>  include/linux/kcsan-checks.h | 16 ++++++++++++++++
>  include/linux/kcsan.h        | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index 101df7f46d89..ef95ddc49182 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -36,6 +36,20 @@
>   */
>  void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
>  
> +/**
> + * kcsan_disable_current - disable KCSAN for the current context
> + *
> + * Supports nesting.
> + */
> +void kcsan_disable_current(void);
> +
> +/**
> + * kcsan_enable_current - re-enable KCSAN for the current context
> + *
> + * Supports nesting.
> + */
> +void kcsan_enable_current(void);
> +
>  /**
>   * kcsan_nestable_atomic_begin - begin nestable atomic region
>   *
> @@ -133,6 +147,8 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
>  static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
>  					int type) { }
>  
> +static inline void kcsan_disable_current(void)		{ }
> +static inline void kcsan_enable_current(void)		{ }
>  static inline void kcsan_nestable_atomic_begin(void)	{ }
>  static inline void kcsan_nestable_atomic_end(void)	{ }
>  static inline void kcsan_flat_atomic_begin(void)	{ }
> diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> index 17ae59e4b685..53340d8789f9 100644
> --- a/include/linux/kcsan.h
> +++ b/include/linux/kcsan.h
> @@ -50,25 +50,9 @@ struct kcsan_ctx {
>   */
>  void kcsan_init(void);
>  
> -/**
> - * kcsan_disable_current - disable KCSAN for the current context
> - *
> - * Supports nesting.
> - */
> -void kcsan_disable_current(void);
> -
> -/**
> - * kcsan_enable_current - re-enable KCSAN for the current context
> - *
> - * Supports nesting.
> - */
> -void kcsan_enable_current(void);
> -
>  #else /* CONFIG_KCSAN */
>  
>  static inline void kcsan_init(void)			{ }
> -static inline void kcsan_disable_current(void)		{ }
> -static inline void kcsan_enable_current(void)		{ }
>  
>  #endif /* CONFIG_KCSAN */
>  
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 
