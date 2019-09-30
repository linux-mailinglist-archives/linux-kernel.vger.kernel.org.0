Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4BC2491
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfI3Pnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 11:43:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34175 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfI3Pno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:43:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so4066973pll.1;
        Mon, 30 Sep 2019 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnaL4pZPqg67oVs9s+KMZ+ww7k0gZJ9omOde+Yyhp8M=;
        b=OZvn7bR46WMQBpMjrx+bSGwpOlhj3TRDe75TmMb8m/KG9JiRrd8FHslg86zyszF8d5
         vYj5YlSsDViNTPWsEDXW1VkQAdDQ1uWzEKEMtJ298qlmWIZ01aFkcF/HkjiZW053uIyh
         VAMZO6jcQIiKZgE7wGrQYYeBV00qyibYGQKuu33b+kGo4VQe1T7ONwZ+Lf6K3W9SOxPv
         icclyMA5PfYHmX5ewTawTI3nP0gxRxMtdQhzP6ryE/HKHKsRjHnHa0C0STBMEC9Y0Q73
         n8MGNNPhDBSG3kB6VKxVXiCKBQsF/E2IbIxl/vMHxLNS7pL0dRmSGlbZplKxelQmp2+I
         PGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnaL4pZPqg67oVs9s+KMZ+ww7k0gZJ9omOde+Yyhp8M=;
        b=bat/uahpB2MmUXFCYoDZpdq2jXJLz4xglCl5MYztohjXJKdXtLadUlvLm9wh33pqjR
         Cc45R79JotsWFWBCPkCLFgUmfbsysjsXy45ZglP1d2qa3vNVYOMFF1FtUKnoPRGyfoSB
         2DKN/oe8Mu6Mys8CDkwU+tvZxykI86jJ4+Mbll3LW9x/pctNw5qF2zFXJSuFtn7yFDwb
         XgI847k15y6jIIJVq34ug+1oq184VVT+kNfx1DpsActQTw9CvDaJ5qwTw51IhsC0XyZM
         T8g302RwerJGdrieHCEdUA7YEDiMUWFDS/Vbzkfxzpf6o+51UT64F7PAyMaUaqyb9rQN
         6lOQ==
X-Gm-Message-State: APjAAAXaukrluO5xyQ2SLfF+zDNXKytJauAD1dn3N8+txmtsQxBBUFj3
        MlOqjV8DCuWgBP4snJOvERcAhxyeJVY=
X-Google-Smtp-Source: APXvYqwnOjMI4Imt9AN0muuluOhYWgKqu+WGknn7E4SioVZRznBw1TXz7SBzYydzBhnIQv+SPkMjqA==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19mr20352580pls.249.1569858222453;
        Mon, 30 Sep 2019 08:43:42 -0700 (PDT)
Received: from Slackware ([103.231.91.38])
        by smtp.gmail.com with ESMTPSA id y7sm13581711pgj.35.2019.09.30.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:43:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 21:13:24 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [GIT PULL] remove dead mutt url and add active mutt url
Message-ID: <20190930154324.GB27688@Slackware>
References: <20190928151300.GA18122@debian>
 <20190930081310.7e3b9c52@lwn.net>
 <20190930152607.GA27688@Slackware>
 <a1d80b29-4cd8-2ffc-1b55-3a806fca1a06@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <a1d80b29-4cd8-2ffc-1b55-3a806fca1a06@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08:28 Mon 30 Sep 2019, Randy Dunlap wrote:
>On 9/30/19 8:26 AM, Bhaskar Chowdhury wrote:
>> On 08:13 Mon 30 Sep 2019, Jonathan Corbet wrote:
>>> On Sat, 28 Sep 2019 20:43:03 +0530
>>> Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>>>
>>>> The following changes since commit 4e4327891fe2a2a4db342985bff4d4c4870=
3c707:
>>>>
>>>> =C2=A0 replace dead mutt url with active one. (2019-09-28 20:11:00 +05=
30)
>>>>
>>>> =C2=A0 are available in the Git repository at:
>>>
>>> Bhaskar, I'm not going to take a pull request for a change like this.=
=C2=A0 If
>>> you would like to make this change (and it seems like a useful change to
>>> make), please send me a patch that is:
>>>
>>> - based on docs-next
>> I have no clue where do I found out "docs-next" Jon. But I have
>> stumbled over these places..
>>
>> https://github.com/torvalds/linux/commit/81a84ad3cb5711cec79f4dd53a4ce02=
6b092c432
>>
>> and this:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rdunlap/linux-docs.git/
>>
>> Now, do you want me to make changes there and sent a patch?? I am
>> absolutely not sure .
>>
>> Kindly shed some light.
>>> - properly changelogged
>>> - demonstrated to build properly with sphinx
>>>
>>> Thanks,
>>>
>>> jon
>>
>> Thanks,
>> Bhaskar
>
>Hi,
>The kernel MAINTAINERS file says:
>
>DOCUMENTATION
>M:	Jonathan Corbet <corbet@lwn.net>
>L:	linux-doc@vger.kernel.org
>S:	Maintained
>F:	Documentation/
>F:	scripts/documentation-file-ref-check
>F:	scripts/kernel-doc
>F:	scripts/sphinx-pre-install
>X:	Documentation/ABI/
>X:	Documentation/firmware-guide/acpi/
>X:	Documentation/devicetree/
>X:	Documentation/i2c/
>X:	Documentation/media/
>X:	Documentation/power/
>X:	Documentation/spi/
>T:	git git://git.lwn.net/linux.git docs-next
>
>that ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
>--=20
>~Randy

Thanks, a bunch Randy...my bad...was lazy and pathetic to not look into
that file.

~Bhaskar

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2SIpYACgkQsjqdtxFL
KRV1TAgAviipKejZClTvQVfKAHPzof9RkXIrJ6CFWUnV+dpQ0K3Eab38b4o8hCZq
fMS1e2ETibQ3pYs4CbqDC1ecmFks3N+JgTsxRywxNem8VbpxijzRuXdPwCw7viP0
BQ5XybxtulTPifMDG9A+lUhRD5/qWmnfHCi109T55nEVEexI2EfHemeLC0btuh5c
qkIiVQ1BhdrAYWPLvE58PaHNWQ8M8ZAdvQzJmL04uKK0mJuIGLPjnrplJSbW49ax
BZCq9Brh5x8EV2+XlW8DkWURGpR/QIZOtgKqL8Y/N1qj7UlrO5qFbUSTOyn8ZAZa
tYv4ESDu2v3IuEfAz4GjEFtE4d3PeQ==
=8F6E
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
