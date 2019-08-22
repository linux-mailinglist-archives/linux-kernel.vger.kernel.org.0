Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D27999A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfHVQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 12:56:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41494 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfHVQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:56:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so3999219pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eweOfVjppggMglsWecUUmpbBhbZhOjeQJ6zyvaRS7vw=;
        b=dpygPjwyk7QMVjozljViHC6MGXQIxMCHIQz4oSQPj/C9HCm8YTiEMsNXxbtFfBsFmk
         6AVJ4juJ/GfcdfjFAJkql26zbcTtr6cxo0N0Xtr8ERp+IzHNecylMQR6Ob2i1L2vdGdO
         UpF1VP4BlFBbeLkr/6vcy3qyhwsUMmYHHtincGx8DkCljU8GpBii1NL6O3wM6RgF90wE
         Xqpu1kz+V7WOQ7CNFSXUnSXLChHwmZJ9WhHcjHJ2Bnfdmepp5giXwjfqxfNbsXtHB/Mp
         TjOHg9f4v9ESkpPTwO0z2Hi/9+q+0ZiA5TmEZMzW8kHQ3ubPaICLsjazdOA2pSzH4djT
         ko5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eweOfVjppggMglsWecUUmpbBhbZhOjeQJ6zyvaRS7vw=;
        b=e4Gano/9VVZH0OyVe/tos1ZTV8cUd2wvNbrkkvpJpfTWCe5m7F/4eDvEsC3PhGKNTv
         Miifwas0jm7Z+OtIDtStq2er/HYQ4Kh74UeiaOEBNk8pfH32CqX/v7woAAmsm3kjjQqG
         wy5Dhx6ivMKmiYztsPHE3GLQLQAYPl7SztflvI2yqkA3n88E8ijj5CxEc5GYM5h6Qwwo
         ozCK8w5uQ0WLmkAtd0gtYWb46I2H9aoKziPNpfscB/GnG60GA5dTa/xYeRuiVfLXDYwk
         dGoizJPsLqC6/npW2HtcCcFMuZ3+76jR5JKfRHgxXDclbyA4yJoP1iF1DgBQA0wTWdsp
         sxcA==
X-Gm-Message-State: APjAAAWfapcoNNVKA55RQxWX1cghohEyo4DbZv8Ki/Wvx9zNe9Ca/yY5
        yiPK5OQqmmsU5i5S7Jg6LBT3tQ==
X-Google-Smtp-Source: APXvYqw6DKKTLRQKWV9Kn1ksRJuddPhUPuY6A+AZ3UOtuSLwyTpcKmHrY1qwbjg1lglL3lONimwtyA==
X-Received: by 2002:a62:f208:: with SMTP id m8mr172500pfh.108.1566493007379;
        Thu, 22 Aug 2019 09:56:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id i9sm25002251pgg.38.2019.08.22.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 09:56:46 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:56:41 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform fixes for v5.3-rc6
Message-ID: <20190822165641.GA17062@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-fixes-for-v5.3-rc6

for you to fetch changes up to 9cdde85804833af77c6afbf7c53f0d959c42eb9f:

  platform/chrome: cros_ec_ishtp: fix crash during suspend (2019-07-29 13:1=
8:45 +0200)

----------------------------------------------------------------
chrome-platform fixes for v5.3-rc6

Fixes:
1. platform/chrome: cros_ec_ishtp: fix crash during suspend
   - Fixes a kernel crash during suspend/resume of cros_ec_ishtp

----------------------------------------------------------------
Hyungwoo Yang (1):
      platform/chrome: cros_ec_ishtp: fix crash during suspend

 drivers/platform/chrome/cros_ec_ishtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXV7JSQAKCRBzbaomhzOw
wmsMAP9l7zNyHT3RklLRY2MDx/u351aEXliRaffATK0+3bQFJwEAzyl1XaP/okMa
CkShDhtnGnVYE6szX5GZXGQw5B0sYwU=
=YMFb
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
