Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1057B1701FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBZPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:10:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44959 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBZPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:10:10 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so1961665vsj.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YwH333YB+c5WkNcA+ALefDNi+G9uKbYvmmOr7YCboTE=;
        b=UVJiUfAM4+zL4FNaj6BWYdjJGVhdYrZfxgPsMy4YFA55x/zCRNyODDutNTxqY0nTIg
         9nolSHFWRVM7Xz0TSM5heUPkXwtIU1E+AP8FJpKxBYfkPHs41xNr5dn1R+q3q7SIqTNZ
         l+dV/+msKw16rgXj4sEXcry9wQHS2ghleCeww1vAE+i3Y39i1nZ4sdf+2f9o7bkPD6sz
         2r5o3NvdSJRw9Dnd/YoopW/vlFsbXcVY64fkCd5eyffDT4+Y8G2ziT7TO04UC4It3Wql
         ByluCAQ7A++4rKUYkyhEeTBwre6uDoIbUDShNNwgXpKnMe/tOUdzEFHuZRy7as4Bg06v
         p4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YwH333YB+c5WkNcA+ALefDNi+G9uKbYvmmOr7YCboTE=;
        b=Aw+egU1U9BO9EfQSNA8dLJkWaDDTl3u+aiczZR5D/Hk+CuQNrUjU6pVImlhBasRCXL
         Fohjn6/RogTw1oA49QMqpWeD90ZOeQxz3f/QkfMUDoN/ZHsSGrGh6fpfENxkOKwE4wVy
         C1oH7abxBVT/ETaSQRUo7Rra3GOEVqkvHi+8TX1Vs/RFPBfjbJgSg0COOV51Z2Fq/uh/
         WlHMueO+mWDv7nL/hCxjisWl5OUuNpcmmgQlOw4o7kO7+Raq8Zb2yu3LFwWS8s2MN+qk
         NA0+zxnnfaUXE5XV3UAGj2qKCSck5lONI3gC0HwyUdkB+qbwvI+OiNONw2xJhXFdaX/y
         6j3Q==
X-Gm-Message-State: APjAAAW0YEfLQC+L58pQdipVqKqD1dKKGHBMQJ7yPWS0wZCksQF3DMj7
        2CUYrYA8rLgLzFEPrLY7xw74Ieyg+PTIKFvzxd9zEGOsVEY=
X-Google-Smtp-Source: APXvYqxvSSzNuYDeslmTElbHKRXvxiTarkH7AscU9sikvdlh1m9MEkBDw7Rghi+H5Q5Tqa9p4vzkSjcbG3wuvWpnX5I=
X-Received: by 2002:a67:6746:: with SMTP id b67mr4354659vsc.193.1582729808210;
 Wed, 26 Feb 2020 07:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20200225154834.25108-1-gilad@benyossef.com> <20200225154834.25108-3-gilad@benyossef.com>
 <20200225200244.GB114977@gmail.com>
In-Reply-To: <20200225200244.GB114977@gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 26 Feb 2020 17:09:57 +0200
Message-ID: <CAOtvUMfsDfWskU8HYHfRhwqeN_DZcNZBo9g9MwXbjTcfe3-ocQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: testmgr - sync both RFC4106 IV copies
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:02 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Feb 25, 2020 at 05:48:34PM +0200, Gilad Ben-Yossef wrote:
> > RFC4106 AEAD ciphers the AAD is the concatenation of associated
> > authentication data || IV || plaintext or ciphertext but the
> > random AEAD message generation in testmgr extended tests did
> > not obey this requirements producing messages with undefined
> > behaviours. Fix it by syncing the copies if needed.
> >
> > Since this only relevant for developer only extended tests any
> > additional cycles/run time costs are negligible.
> >
> > This fixes extended AEAD test failures with the ccree driver
> > caused by illegal input.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  crypto/testmgr.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> > index cf565b063cdf..288f349a0cae 100644
> > --- a/crypto/testmgr.c
> > +++ b/crypto/testmgr.c
> > @@ -95,6 +95,11 @@ struct aead_test_suite {
> >       /*
> >        * Set if the algorithm intentionally ignores the last 8 bytes of=
 the
> >        * AAD buffer during decryption.
> >        */
> >       unsigned int esp_aad : 1;
> > +
> > +     /*
> > +      * Set if the algorithm requires the IV to trail the AAD buffer.
> > +      */
> > +     unsigned int iv_aad : 1;
> >  };
>
> What's the difference between esp_aad and iv_aad?  Are you sure we need a=
nother
> flag and not just use the existing flag?

Yes, because we have 3 distinct states -
1. No IV in the AAD buffer - "normal"  AEAD.
2. There is a copy of the IV in the AAD buffer and it is NOT used for
ICV computation purposes - RFC4106 and RFC 4309.
3, There is a copy of the IV in the AAD buffer and it is used for ICV
computation purposes - RFC 4543.

3 states needs at least 2 bits.

> If they're both needed, please document them properly.  You're currently =
setting

I will add a remark explaining this.
I chose to keep the "esp_aad" name, since it was there before, but
possibly this is not a good choice in light of your comments so will
change that too.

> them both on some algorithms, which based on the current comments is a lo=
gical
> contradiction because esp_aad is documented to mean that the last 8 bytes=
 are
> ignored while iv_aad is documented to mean that these bytes must be the I=
V.

I believe it isn't a contradiction after all. Consider -

RFC 4106 needs to have a copy of the IV in the AAD buffer which is
identical to the one being passed via the normal mechanism in the API.
If they are not identical, we have no way to know which copy of the IV
is being used by an implementation as part of the AES-GCM nonce and so
the generated message may be different from the one being used by the
generic implementation. which results in encryption test failing when
compared to the generic implementation  results, even though there is
nothing wrong with the tested implementation and indeed the previous
compassion against the precomputed test vectors passes.
This is what happened with the ccree driver. Note that this has
nothing to do with mutating the message - this is an encryption test
failing.
This is the iv_aad flag, which will need to be true in this case.

On the other hand when testing decryption and mutating the AEAD
message, we need to know not to mutate the IV copy in the AAD buffer,
since it is ignored.
This is the esp_aad flag, which will also needs to be true in this case.

Last but not least, RFC 4543 need a copy of the IV in the AAD buffer
However, this copy DOES get hashed as part of the ICV computation, so
-
We need iv_aad flag to be true to let us know we need to copy the IV.
However, we need esp_aad to be false since it's fine and even
desirable to mutate the IV copy in the AAD buffer.

You are correct though that I can make the 2nd copy of the IV post
mutation dependant on esp_aad not being set, though...


I hope this explains this mess better.
It certainly took me a while to figure out what is going on...


>
> >
> >  struct cipher_test_suite {
> > @@ -2207,6 +2212,10 @@ static void generate_aead_message(struct aead_re=
quest *req,
> >
> >       /* Generate the AAD. */
> >       generate_random_bytes((u8 *)vec->assoc, vec->alen);
> > +     /* For RFC4106 algs, a copy of the IV is part of the AAD */
> > +     if (suite->iv_aad)
> > +             memcpy(((u8 *)vec->assoc + vec->alen - ivsize), vec->iv,
> > +                    ivsize);
>
> What guarantees that vec->alen >=3D ivsize?

You are right, I need to check for that.
However, if it isn't this can't be a legal RFC4106 message and we will
fail encryption .

Thanks!
Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
