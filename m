Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D65516EF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 20:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgBYTpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 14:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbgBYTpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:45:53 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC38F21744;
        Tue, 25 Feb 2020 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582659953;
        bh=DDL4faS1bxkAcyDrK+M9cSkOpTfz2dh8PxxjcywLw3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DesjlvNrkB46PlbhEDslYDLqwlWjwQRgYh4Z9i4LuW3xyY+rOt1N++hYEiBblykgl
         VO2A+WmcystLoQPSJWXHIucPZOnICL2lVWD7knr8EgyETiGTZtk6JZWQ0qzHk6uQkc
         3XhZZuN4kTH9heJnujqsIg9sHUWKbSOXHTPtC1YQ=
Date:   Tue, 25 Feb 2020 11:45:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: testmgr - use generic algs making test vecs
Message-ID: <20200225194551.GA114977@gmail.com>
References: <20200225154834.25108-1-gilad@benyossef.com>
 <20200225154834.25108-2-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225154834.25108-2-gilad@benyossef.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 05:48:33PM +0200, Gilad Ben-Yossef wrote:
> Use generic algs to produce inauthentic AEAD messages,
> otherwise we are running the risk of using an untested
> code to produce the test messages.
> 
> As this code is only used in developer only extended tests
> any cycles/runtime costs are negligible.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Cc: Eric Biggers <ebiggers@kernel.org>

It's intentional to use the same implementation to generate the inauthentic AEAD
messages, because it allows the inauthentic AEAD input tests to run even if the
generic implementation is unavailable.

> @@ -2337,8 +2338,42 @@ static int test_aead_inauthentic_inputs(struct aead_extra_tests_ctx *ctx)
>  {
>  	unsigned int i;
>  	int err;
> +	struct crypto_aead *tfm = ctx->tfm;
> +	const char *algname = crypto_aead_alg(tfm)->base.cra_name;
> +	const char *driver = ctx->driver;
> +	const char *generic_driver = ctx->test_desc->generic_driver;
> +	char _generic_driver[CRYPTO_MAX_ALG_NAME];
> +	struct crypto_aead *generic_tfm = NULL;
> +	struct aead_request *generic_req = NULL;
> +
> +	if (!generic_driver) {
> +		err = build_generic_driver_name(algname, _generic_driver);
> +		if (err)
> +			return err;
> +		generic_driver = _generic_driver;
> +	}
> +
> +	if (!strcmp(generic_driver, driver) == 0) {
> +		/* Already the generic impl? */
> +
> +		generic_tfm = crypto_alloc_aead(generic_driver, 0, 0);

I think you meant the condition to be 'if (strcmp(generic_driver, driver) != 0)'
and for the comment to be "Not already the generic impl?".

> +		if (IS_ERR(generic_tfm)) {
> +			err = PTR_ERR(generic_tfm);
> +			pr_err("alg: aead: error allocating %s (generic impl of %s): %d\n",
> +			generic_driver, algname, err);
> +			return err;
> +		}

This means the test won't run if the generic implementation is unavailable.
Is there any particular reason to impose that requirement?

You mentioned a concern about the implementation being "untested", but it
actually already passed test_aead() before getting to test_aead_extra().

We could also just move test_aead_inauthentic_inputs() to below
test_aead_vs_generic_impl() so that it runs last.

- Eric
