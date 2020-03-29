Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0AB196C90
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgC2Kk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 06:40:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39410 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgC2Kk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:40:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id i20so14741555ljn.6;
        Sun, 29 Mar 2020 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cLd4jAW1CkiWfOdvU5YJozN1+eqFB+wBsib3kn53+6s=;
        b=dm0ClfSTfp5auucokso1ShyuPYJmEmuB0gC5oXfHLt2rim5iTVMnaV3ST7SW3AvSF2
         os/JHItuTfKDWk+aMV+XwZgFlvO9td0Oq5mzDSq2wkdAuqgkl3rgYV4MDmluakyNMMll
         0QhyESMiwMhHObq187yOIvpSKXNClv+KktCC85f0KR6B8m2MjtJpO82/twM4rRMO1IAO
         xcNqZEj9GyVNpsdHwtnmCOPJADHU9Mux2LR7+EIOmaJ1+Klbl2Ug3GJXAH0u8ehCbenp
         oZiax0Zi5rDkzNIyxNvmzx9BR2roduGe/I7E04UXs578igYjrLbolxezGEWItZi4Dxs+
         ntrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=cLd4jAW1CkiWfOdvU5YJozN1+eqFB+wBsib3kn53+6s=;
        b=Q1Kr+NR12qnqow2iQ3ojxR/V626zajsuVfiOHiYhKjBVBGUJNDV0fMBCxRG7KN/kzO
         7ardr/1HU6hX41QbzXXl6g6PqDo8xe7ampCu58LB68mbx7d5jmBEDeCXcNtmt2tdzydJ
         1zkblcvVSQABHGyxfFMnrpZY+RuNhBBg96Zo7OY5K8ZxoAh0gZnOFhKHZwRjGy3pOfYi
         qeLMGxN3zTb0gziqnEfdfOi8S9goGGUqCzxxhiuV4d9T21MDuSETagQwPhOKox/aDf85
         UBI07A0VDoT8zqgz1xEh7lxXiYgAngtujDrs6sJ9D3cm5e76jOpdWKuLjPBMSNiuMQZq
         szOg==
X-Gm-Message-State: AGi0Pubqtapuhh0RJzH68peuMyYMlbwUazw6fdqeOCUe+yammIkSx6wE
        6OG31aHrh7oteS1XI3A+pnU=
X-Google-Smtp-Source: APiQypJ2UR9ZPg/MS3H9/fw9Gka6zO3w8P5ly+EDlgQ6gkwx3ZkJirsEqeRB+HxBsqzsvB41V4fYoQ==
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr3036925ljj.105.1585478425309;
        Sun, 29 Mar 2020 03:40:25 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id e4sm54430lfn.80.2020.03.29.03.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 03:40:24 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>, kishon@ti.com,
        robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        jckuo@nvidia.com, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH V1 0/8] Tegra XUSB charger detect support
In-Reply-To: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
Date:   Sun, 29 Mar 2020 13:40:20 +0300
Message-ID: <87pncve963.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nagarjuna Kristam <nkristam@nvidia.com> writes:

> This patch series adds charger detect support on XUSB hardware used in
> Tegra210 and Tegra186 SoCs.
>
> This patchset is composed with :
>  - dt bindings of XUSB Pad Controller
>  - Tegra XUSB device mode driver to add vbus_draw support=20
>  - Tegra PHY driver for charger detect support
>
> Tests done:
>  - Connect USB cable from ubuntu host to micro-B port of DUT to detect
>    SDP_TYPE charger
>  - Connect USB cable from external powered USB hub(which inturn connects
>    to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
>  - Connect USB cable from USB charger to micro-B port of DUT to detect
>    DCP_TYPE charger.
> DUT: Jetson-tx1, Jetson tx2.
>
> Nagarjuna Kristam (8):
>   dt-bindings: phy: tegra-xusb: Add charger-detect property
>   usb: gadget: tegra-xudc: Add vbus_draw support
>   phy: tegra: xusb: Add support for UTMI pad power control
>   phy: tegra: xusb: Add USB2 pad power control support for Tegra210
>   phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
>   phy: tegra: xusb: Add support for charger detect
>   phy: tegra: xusb: Enable charger detect for Tegra186
>   phy: tegra: xusb: Enable charger detect for Tegra210

this doesn't apply cleanly. Could you resend after -rc1 is tagged?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6AexQACgkQzL64meEa
mQb9iBAAxsX46m3Wb6n/G0SmCS87nlApHiAUph+Y4vsHrBEEbBreJ6oaRfetkkXi
WR/jDBxFbY6ZlmTVsS30bLx6m/X1wIhcd2oHrH5D17c5uRP/vPAQx+3hYBu5jHmi
V3Qi2CnULKp3RzKZnBO53PSMosIJvHWyycl9bX8D4NQ6bggDkKtAqverxld1aNOo
9UcxkeJc+xujlpLB64L8JRAPFbde3ZpI8pwT9H5ZYqaT1Zv/wVvj2MEBhUxYTppl
xP9A0mJlNXxv2ASJ7rXtDu/tqpXSHGK7YxiTi/NhiWOl0sWeHhHJPQkpK/AfUN9W
EB5/1o4T0Z5RrmmYLqvTPfO8pZjI8JWiClRA5ZEi4GdNCIotGdMybmOiCVV70Elt
OqhudkdhWM/XjK9vk1xrPrYjfF3EMqZVF+HFxOGCJEbQoBjV2TAwBBAIZBLDC7zV
E5DUTkhZq9P22nq2s3b4lvRq72Ubr6w4v5yCTCvVJcGbjJUVP77QJthDkmR2Drnk
f/rQoTribuTT1WqaOyw0y2GTwe1meO900OJ8tSmx4Ydiia7qhErQms6eyDnPZkaC
SGiZM8uGVUPI8HE3bgxKb4sMfqTfN5JEFxMKLxmrB++CP7gMASVZZhUVA1S/abfY
f/wDWgw9fNu96pxC5FBlAiN6juqXspYbTDGZguBgnzg2fnpFJzA=
=9c+2
-----END PGP SIGNATURE-----
--=-=-=--
