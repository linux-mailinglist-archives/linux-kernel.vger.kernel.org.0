Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587286C3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 02:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfGRAwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 20:52:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38011 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfGRAwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:52:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so25394914qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 17:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=j18WraFuZIluoyKhD6u2cAa7N3YW50rIzRpqn3W/qyo=;
        b=ku/dsPt2CV4/LzppNoofF/xj17vxxH4Am/eVLliH4v+oBKAhu8qbqE0cbl3nhyfvPf
         DkMSVTBbDUgQEGkZo5l98rjFv6VF4YQW56xJgQdRcBG9J+17qo8Ujm0F8JJnt6WriJZk
         IvZgWTxkCqYoassa2sZadLBXpl6m5N5rTPjitv9dggsP4vOVt+wDCib+XmlcUw5gStui
         tntmFhONphfREnnnqs54XEHJ8MQvqqmfMZNjUCvH39ji/EYdNR36LX+KgAVXJmpv9WAh
         Fsc5qNNUFkPcjOE7kurckOuVdoQhvVvjlmM4A7xL9FgCCsrM2jo84+OT0YU3nS1CfEdm
         kNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=j18WraFuZIluoyKhD6u2cAa7N3YW50rIzRpqn3W/qyo=;
        b=ft1Z26xup+T8Z2tkLDchXI6gbAieZzYlPnfCKytkWpKR08qBTX0x691i/TF5hCam7d
         cxhuJQdCn/R63hkkoPcz+CyG1IT5Srj23jdlrDYPcIw2Hhpe2IFFb9yvN8NlBn3EbB8G
         3pgTjdmJGXD44KgccuJ/LScAM1PerzP5DxJQpsjHInjDHHkCtf0MH9tdxfchml2BWOij
         uRziYyv4EV17J/js+3yvHnmBeJnlCxcKQvmIchKBkKzQW5TRgIaqz1rYsoBKBetfsSsr
         PsLBb9He2rPVbTtc1KetTFEVhf9qZbpI0uSV+/41PP0JeOJnlAfv2m43U8NIUvpsUlA4
         tFQw==
X-Gm-Message-State: APjAAAUL5CicPZgDDwaUR3+m4TZlPbS7Z0ed15FSuPe4rqHFxDeO8wlV
        FRsL3C3XyG2uRSTYoKIuFJD2pQEUO8w=
X-Google-Smtp-Source: APXvYqzWnrReab7SToU+AaYtwoMN2X2d3/rvf+DPDu/2s3OV39Bc03HEeA4XHkRWKImbUBr89GOMNA==
X-Received: by 2002:a0c:8705:: with SMTP id 5mr30105641qvh.32.1563411122629;
        Wed, 17 Jul 2019 17:52:02 -0700 (PDT)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id 123sm10593436qkm.61.2019.07.17.17.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 17:52:02 -0700 (PDT)
Date:   Wed, 17 Jul 2019 20:52:00 -0400
From:   Konrad Rzeszutek Wilk <konrad@kernel.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) for-linus-5.2
Message-ID: <20190718005159.GA19783@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hey Linus,

Please git pull the following branch:

  git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git for-linus-5.2

which has one compiler fix, and a bug-fix in swiotlb_nr_tbl() and swiotlb_max_segment()
to check also for no_iotlb_memory.

Diffstat and changelog below:

drivers/xen/swiotlb-xen.c |  2 +-
 kernel/dma/swiotlb.c      | 30 ++++++++++++++++--------------
 2 files changed, 17 insertions(+), 15 deletions(-)


Arnd Bergmann (1):
      swiotlb: fix phys_addr_t overflow warning

Florian Fainelli (2):
      swiotlb: Group identical cleanup in swiotlb_cleanup()
      swiotlb: Return consistent SWIOTLB segments/nr_tbl


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdL8KvAAoJEFKlDoTx2wm/03YP/2FxnLFTxEAi1qFcD55yuC+v
6yYRmot29jCMA84rWhxEFCnsCPamG++eF+mx9d9HJrMonBWsvtm6FV5cpcsh9B3G
Yqun9DZWWsop97ZVn5XsLdmLo7UCIJnjc+Z10ca91pQaV14CrNvtU7ZiaGGaUTXo
MJ3WLil+sD5P8GrMgnYENA74jcnbEimd37XDtap2AE7lKpcQL1ihTHptAUO0pHne
kuyPnwtzJALa2RNdsouFY4MCuRlmOsL4tIAUEzQE/NT5SmHt47zmf0n6Kk/1i1Le
k7a91/TPxjNWvagwZozBRc4zuVbZgS5xMuUlMjzQHrWaqXYrSTSILZ3ZVnCKmyPK
e8dZJZXtmcRLsSBW6wfE0HYv8SQGVMDTWBCAWjefqXa6uqkfvBaPWpa9r7qtBUZf
B0oAls9LzdDliavybRXJL23nyq7Zjvdauw19L9CCBCMjuAoriEOkg9nZc/13H/w2
XUWqhAjW/64U7wEjVBKkVWtXptTEpEp7T112hgXYxm39/Uk5pZnte2WouQbI1AMo
xRr9G7y2V6pcXApgeUaCTYQmR7m8speRAfnoCy6xIl7skUIdTR6tQasfN3HHKu+q
kAZdGGEKf7rSDthUMOeDN+z17AmX9OqORaBsOdMslo4L4qEtusm001djJoWL9+1U
Z2zSIe/jS6Q9EwfS4EaS
=WIqP
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
