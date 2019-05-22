Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3724269FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 20:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfEVSna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 14:43:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39184 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:43:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id f1so2464447lfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=UtYsw0lzHTTcLundfIKj0zmP6B15VGhRB9rdt5RUcJasNFeBKmkcMTFKZF5DKGzh3i
         ANqv1GISjL/OjWrbUxhqcRRm1nNVTE/HMpbKBQ9suXO9pPNv6lGuj72Ii4rv7pykfF9H
         bthwuWNWrwvkg8x3Og9uXTIkoC8u44ykborqCvjmTI6KDCsf7IxXs03qE44na5svteaZ
         L0bRf5BG+9W9jwzRhMuyTVZyw1kgpSkg/CduieF9XAUX70gXl6ouI5FajOotokHvH457
         Z70dIu0mqEUX4jMiWOGWvv7ej7DVxKVr1I9uedd5njjkbaQTrP7fpGOLSgI3TjX8cHGJ
         +RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Fgdn/e4VOTa17xLyAMM1UibUkXrQ2YhljdUF38ONjZxgdu3dL/3vHOTYVp9UdCJ6X+
         I1Tl82tK9RiOPn6YpFIAASwsKn1qU2SojVRBWZjIgMBhzxfyYGaioKSD0Pjv+q9TpxnP
         vLW7n6xs9Vh9K0+ZixbCaZ7PQuN+oPUGQlxwPIbCp9DXEwbUdDQaOeDEjX+8baIyacWB
         m1cD3GwwgSST7e22P374IuUcyYjvnldzZEvOoLx5l3QK/gHi4dma/0qfXZi/7tGa47pS
         Y9jXCbR8j5jpjqSw2AkOdtgPqRKgkFMVhAdRCcYqoIvcsjBylmVlc+ebW2eWMjkFLAwL
         Japg==
X-Gm-Message-State: APjAAAW1NGiJkDH03a62Nq9m54sPHbknQ69VnGnN0h5hKC3QV4ztQARk
        UuRG2P/J0VCHTGtsjtq91yoGLNp53J1QOYtIt0M=
X-Google-Smtp-Source: APXvYqzbSds1yzEUBeeHbfaz+hRJ1r348tVcoJkRocdxNr05vvkV7Nzrdu5QPGU0zIAGX4U2cA+ranjKrI1VilO4jv0=
X-Received: by 2002:a19:c312:: with SMTP id t18mr23368752lff.165.1558550608081;
 Wed, 22 May 2019 11:43:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:b057:0:0:0:0:0 with HTTP; Wed, 22 May 2019 11:43:27
 -0700 (PDT)
From:   Richard Bello <ms5746566@gmail.com>
Date:   Wed, 22 May 2019 18:43:27 +0000
Message-ID: <CAK-5K+WyBbOZ4NvmPQXB5bNaPJPP+gcsOyKjBn+fp9MfvCocRw@mail.gmail.com>
Subject: =?UTF-8?Q?Buenas_tardes=2C_por_favor=2C_=C2=BFrecibi=C3=B3_mi_mensaje_ante?=
        =?UTF-8?Q?rior=3F_Hola?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


