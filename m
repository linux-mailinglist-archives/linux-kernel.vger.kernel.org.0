Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35967BC168
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 07:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438307AbfIXFaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 01:30:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405894AbfIXFaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 01:30:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id t14so176825pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 22:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9t/1QDaYljftG+Qxh7nUXOM60s5W73+fkUjjZddw3MY=;
        b=TC4NE/xBTpEN72miM5ncL6IYLZwOasiX7ocNgWHNSeCc5SHPA9f4v6vB3F+vc2n9BF
         KfC4COLk+akFLamP90srv7MkoVhQ+ZGwxYB6aixbZvFs9OVh5v01eO9jUymUN4swAsuI
         YVjf5JeAwf5WBBKBcNTYVuyGr2N/JRsBFr3PXFT+qKFhzVBSL7KcJMSDX4oPnsdm9cyp
         6X04TW8Rb5Z08QsduiHfvFHPHVgX8iymZl3pDEDhkSqj/HkUEgS19/5rwCtl1YDr3bbY
         /R1GiOLIA8h3hrV6x5xjEuFfH1S5SeV2oYJffwh10zr6IAHx8XXiOKWf1jGyNvwna0VK
         7V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9t/1QDaYljftG+Qxh7nUXOM60s5W73+fkUjjZddw3MY=;
        b=uLvtqzcC2wjy0fVMoxP3GoPSHtuNMF3gPs339NeJhSRcu9vwspXeoQkHLXJ6LfDw/u
         Epy5KYragGd4qLlJ7JQyaVg3lUlHglNrOSPVMgYCRCSPB46gM/dSS83cctDgO/z4eq1s
         lM1IUpMrL4RrhmNVCPebz2UfDfabhc3f9LD20uilVuUwjcLAtbSIffch7hFitmaYv2gT
         X1dBqTrVrRK65RxnflLNVWrLuYHBwMdujRaDZ399wxJcajCKcOr3qPM6O3f3HYKTgyLX
         LkQM+Ym5p+ntxI7KxtTnpN6DT19sGWsL4lh6RnTqovVNUt/ZIQ5cPZTZeIUpVRHCSp0J
         GisA==
X-Gm-Message-State: APjAAAVpidCECu0Q9uPh9N7xFdrgRzz/WRTTbfiuQEKFOwqCiAzMFoKt
        hgLxTzpZMSY8FYfpc9nNaD1zb5H6ypQ=
X-Google-Smtp-Source: APXvYqwOpcm5jMfhweXrdD1KjNVMi++Iy9pP5o4HxyoE6UGE4VDHpHfXYoSSL5qz6847et8n7TA3Sg==
X-Received: by 2002:a65:628f:: with SMTP id f15mr1356618pgv.215.1569303017505;
        Mon, 23 Sep 2019 22:30:17 -0700 (PDT)
Received: from Gentoo ([103.231.90.170])
        by smtp.gmail.com with ESMTPSA id h2sm1102061pfq.108.2019.09.23.22.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 22:30:16 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:00:06 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Ben sent 132 patches and Sasa sent 203 patches..woohooo!
Message-ID: <20190924053003.GA29856@Gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

 Is this kind of heaving patching done before?? I can't recollect.

 Thanks,
 Bhaskar

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2JqdYACgkQsjqdtxFL
KRU9TggAy7ubsBlB4yVxxH/FrZ/n/o6vmEPltKRlBmDMHEmpsFX/qkSciGbd+C+5
FdEx5kHURLTam1/MFt+xsQrskncOhY9xR2X+2MOpgcXs5dSk58/LbqYB/Zy+NCZk
IN7GKSUL7WxbDC0osU/QYcvNMRcnrtjUMebmpNvo6gzAzFPoGxLfdBOJMqs5o4gx
lpBG1oVnQzfaiu0tHUiUV22a7J+RQeaVyYkPeij5qsbMpzKRIBGb01buF9qje+cM
+R4rS+tDJypnm4/ooZa81lJZEvScaBTBJ8WyGHC2eg2xADaW/eu7dBmIv3h/1mk3
mZUbfQdbj31l630xH6kqBf269dgZ3Q==
=zyzE
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
